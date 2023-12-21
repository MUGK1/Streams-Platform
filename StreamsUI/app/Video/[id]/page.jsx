"use client";
import Image from "next/image";
import Video from "@/app/Components/Video/Video";
import SubscriptionButton from "@/app/Components/channelCom/SubscriptionButton";
import SocialButtons from "@/app/Components/video/SocialButtons";
import Comments from "@/app/Components/video/Comments";
import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";

function VideoPage({ params }) {
  const { id } = params;
  const [video, setVideo] = useState([]);
  const [nextVideos, setNextVideos] = useState([]);
  const router = useRouter();

  useEffect(() => {
    if (!localStorage.getItem("token")) return;
    fetch(`https://localhost:7001/api/video/${id}`, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${localStorage.getItem("token")}`,
      },
    })
      .then((res) => res.json())
      .then((data) => {
        setVideo(data);
      })
      .catch((err) => {
        console.log("err", err);
      });
  }, []);

  useEffect(() => {
    if (!localStorage.getItem("token")) return;
    fetch(`https://localhost:7001/api/video/get-next-videos/?videoId=${id}`, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${localStorage.getItem("token")}`,
      },
    })
      .then((res) => res.json())
      .then((data) => {
        setNextVideos(data);
      })
      .catch((err) => {
        console.log("err", err);
      });
  }, []);

  const handleButtonClick = () => {
    router.push(`/channel/${video.channelId}`);
  };

  function calculateDaysAgo(dateString1) {
    const date1 = new Date(dateString1);
    const today = new Date();
    const differenceInMillis = Math.abs(today - date1);
    const differenceInDays = Math.floor(
      differenceInMillis / (1000 * 60 * 60 * 24)
    );
    let result = " ";
    if (differenceInDays <= 365) {
      result = `${differenceInDays} days ago`;
    } else {
      const years = Math.ceil(differenceInDays / 356);
      result = `${years} years ago`;
    }

    return result;
  }

  return (
    <div className="flex flex-col">
      <iframe
        width="100%"
        style={{ height: "65vh" }}
        src={"https://youtube.com/embed/" + video.url + "?autoplay=1&mute=0"}
        title="YouTube video player"
        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
        allowFullScreen
      ></iframe>
      <div className="flex pl-2 w-full">
        <div className="w-3/4 m-4">
          <div className="font-textFont font-bold text-xl mb-4">
            {video.title}
          </div>
          <div className="w-full flex">
            <div className="w-3/4 flex">
              <div className="w-12 cursor-pointer" onClick={handleButtonClick}>
                <Image
                  src={video.avatarUrl}
                  alt="Channel Avatar"
                  className="rounded-full w-12"
                  height="48"
                  width="48"
                />
              </div>
              <div
                className="text-white-600 font-textFont whitespace-nowrap ml-2 cursor-pointer"
                onClick={handleButtonClick}
              >
                <span className="mx-1 block font-bold text-lg">
                  {video.channelName}
                </span>
                <span className="mx-1 inline-block text-sm font-thin text-gray-400">
                  {video.subscriptionsCount}
                  {" subscribers"}
                </span>
              </div>
              <SubscriptionButton channelId={video.channelId} />
            </div>
            <div className="w-1/4 flex justify-end">
              <SocialButtons videoId={video.id} />
              <div className="bg-gray-800 text-white px-4 ml-4 rounded-full flex items-center h-9 cursor-pointer">
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  focusable="false"
                  width="28"
                  height="28"
                  viewBox="0 0 28 28"
                  fill="white"
                >
                  <path
                    d="M15 5.63 20.66 12 15 18.37V14h-1c-3.96 0-7.14 1-9.75 3.09 1.84-4.07 5.11-6.4 9.89-7.1l.86-.13V5.63M14 3v6C6.22 10.13 3.11 15.33 2 21c2.78-3.97 6.44-6 12-6v6l8-9-8-9z"
                    stroke="white"
                    strokeWidth="1"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  ></path>
                </svg>
                <span className="text-white font-bold">Share</span>
              </div>
            </div>
          </div>
          <div className="bg-gray-800 mt-4 rounded-lg p-4">
            <span className="mx-1 font-bold inline-block">
              {video.viewsCount} {" views"}
            </span>
            <span className="font-bold text-lg">&#183;</span>
            <span className="mx-1 font-bold inline-block">
              {calculateDaysAgo(video.publishedAt)}
            </span>
            <p className="text-sm font-normal mt-2">
              {video.description} …more
            </p>
          </div>
          <Comments videoId={video.id} />
        </div>
        <div className="w-1/4 m-4">
          {nextVideos.map((video) => {
            return (
              <Video
                key={video.id}
                id={video.id}
                title={video.title}
                description={video.description}
                views={video.viewsCount}
                publishedAt={video.publishedAt}
                thumbnail={video.thumbnailUrl}
                channelName={video.channelName}
                avatarUrl={video.avatarUrl}
                url={video.url}
              />
            );
          })}
        </div>
      </div>
    </div>
  );
}

export default VideoPage;
