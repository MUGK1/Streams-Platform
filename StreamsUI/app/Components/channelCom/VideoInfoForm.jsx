"use client";
import { useEffect, useState } from "react";
import Image from "next/image";
import logo from "@/public/images/Logo.svg";
import { motion } from "framer-motion";
function VideoInfoForm({ isClicked, setIsClicked, channelId }) {
  const [videoInfo, setVideoInfo] = useState({
    channelId: Number(channelId),
    title: "",
    url: "",
    thumbnail_url: "",
    genre: "",
    duration: 0,
    description: "",
  });
  const [error, setError] = useState(false);
  const [requestCount, setRequestCount] = useState(0);

  const handleError = () => {
    console.log("videoInfo", videoInfo);
    if (
      videoInfo.title === "" ||
      videoInfo.url === "" ||
      videoInfo.thumbnail_url === "" ||
      videoInfo.genre === "" ||
      videoInfo.duration === 0 ||
      videoInfo.description === ""
    ) {
      setError(true);
    } else {
      setError(false);
      setRequestCount((prev) => prev + 1);
    }
  };

  function handleClick() {
    setIsClicked(!isClicked);
  }

  useEffect(() => {
    if (requestCount === 0 || error) return;
    fetch(
      `https://localhost:7001/api/Channel/UploadVideo?channelId=${videoInfo.channelId}&url=${videoInfo.url}&title=${videoInfo.title}&description=${videoInfo.description}&genre=${videoInfo.genre}&thumbnail_url=${videoInfo.thumbnail_url}&duration=${videoInfo.duration}`,
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${localStorage.getItem("token")}`,
        },
      },
    )
      .then((res) => {
        setVideoInfo({
          channelId: channelId,
          title: "",
          url: "",
          thumbnail_url: "",
          genre: "",
          duration: 0,
          description: "",
        });
        window.location.reload();
        return res.json();
      })
      .then((data) => {})
      .catch((err) => {
        console.log(err);
      });
  }, [requestCount]);

  return (
    <div>
      <motion.div
        initial={{ opacity: 0 }}
        animate={{ opacity: [0, 1] }}
        transition={{ type: "spring", duration: 1 }}
        exit={{ opacity: 0 }}
        className="fixed left-0 top-0 w-screen h-screen bg-primaryBlack opacity-70 z-10"
        onClick={handleClick}
      ></motion.div>
      <motion.div
        initial={{ opacity: 0 }}
        animate={{ opacity: [0, 1] }}
        transition={{ type: "spring", duration: 1 }}
        exit={{ opacity: 0 }}
        className="fixed top-1/2 left-1/2 -translate-x-2/4 -translate-y-1/2  w-9/12 h-5/6 bg-secondaryBlack rounded-xl z-30"
      >
        <div className="flex flex-col justify-center items-center h-full w-fit center ">
          <div className="mb-16 ">
            <Image src={logo} alt="Logo" className="w-40" />
          </div>

          <>
            <input
              type="text"
              placeholder="Video Tiltle"
              onChange={(e) => {
                setVideoInfo({ ...videoInfo, title: e.target.value });
              }}
              className="focus:outline-none mb-4 bg-transparent rounded-3xl border-2 border-textColor text-textColor w-rem26 h-12 pl-5 pr-5 pt-2 pb-2 text-sm"
            />
            <input
              type="text"
              placeholder="Video URL"
              onChange={(e) => {
                setVideoInfo({ ...videoInfo, url: e.target.value });
              }}
              className="focus:outline-none mb-5  bg-transparent rounded-3xl border-2 border-textColor text-textColor w-rem26 h-12 pl-5 pr-5 pt-2 pb-2 text-sm"
            />
            <input
              type="text"
              placeholder="Thumbnail URL"
              onChange={(e) => {
                setVideoInfo({ ...videoInfo, thumbnail_url: e.target.value });
              }}
              className="focus:outline-none mb-5  bg-transparent rounded-3xl border-2 border-textColor text-textColor w-rem26 h-12 pl-5 pr-5 pt-2 pb-2 text-sm"
            />
            <input
              type="text"
              placeholder="Video Genre"
              onChange={(e) => {
                setVideoInfo({ ...videoInfo, genre: e.target.value });
              }}
              className="focus:outline-none mb-5  bg-transparent rounded-3xl border-2 border-textColor text-textColor w-rem26 h-12 pl-5 pr-5 pt-2 pb-2 text-sm"
            />
            <input
              type="number"
              placeholder="Video Duration"
              onChange={(e) => {
                setVideoInfo({
                  ...videoInfo,
                  duration: e.target.valueAsNumber,
                });
              }}
              className="focus:outline-none mb-5  bg-transparent rounded-3xl border-2 border-textColor text-textColor w-rem26 h-12 pl-5 pr-5 pt-2 pb-2 text-sm"
            />
            <textarea
              rows={4}
              cols={50}
              placeholder="Video Description"
              onChange={(e) => {
                setVideoInfo({ ...videoInfo, description: e.target.value });
              }}
              className="focus:outline-none mb-5 max-h-32 bg-transparent rounded-3xl border-2 border-textColor text-textColor w-rem26 min-h-min3 pl-5 pr-5 pt-2 pb-2 text-sm"
            ></textarea>
          </>
          <button
            onClick={handleError}
            className="bg-primaryRed w-64 h-12 rounded-3xl mt-16 border-2 border-primaryRed hover:bg-transparent transition-all hover:scale-105 active:scale-95"
          >
            Upload Video
          </button>
        </div>
      </motion.div>
    </div>
  );
}

export default VideoInfoForm;
