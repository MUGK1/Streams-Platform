"use client";
import Image from "next/image";
import ChannelBanner from "../../public/images/ChannelBanner.png";
import ChannelInfo from "@/app/Components/channelCom/ChannelInfo";
import Video from "@/app/Components/Video/Video";
import UploadVideo from "@/app/Components/channelCom/UploadVideo";
import VideoInfoForm from "@/app/Components/channelCom/VideoInfoForm";
import { useEffect, useState } from "react";

function Channel(props) {
  const {
    channelId,
    channelName,
    avatarURL,
    createdAt,
    subscribersCount,
    isOwner,
    viewsCount,
    isSubscribed,
  } = props;
  const [isClicked, setIsClicked] = useState(false);
  const [channelVideos, setChannelVideos] = useState([]);
  const [totalSubscribersLikes, setTotalSubscribersLikes] = useState("0");
  const [totalSubscribersDisLikes, setTotalSubscribersDisLikes] = useState("0");
  const [totalUnSubscribersLikes, setTotalUnSubscribersLikes] = useState("0");
  const [totalUnSubscribersDisLikes, setTotalUnSubscribersDisLikes] =
    useState("0");

  useEffect(() => {
    fetch(
      `https://localhost:7001/api/Channel/get-channelVideos-by-id?ChannelId=${channelId}`,
      {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${localStorage.getItem("token")}`,
        },
      }
    )
      .then((res) => res.json())
      .then((data) => {
        setChannelVideos(data);
      })
      .catch((err) => {
        console.log("err", err);
      });
  }, [channelId]);

  useEffect(() => {
    fetch(
      `https://localhost:7001/api/Channel/get-subscribersDisLikes?ChannelId=${channelId}`,
      {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${localStorage.getItem("token")}`,
        },
      }
    )
      .then((res) => res.json())
      .then((data) => {
        setTotalSubscribersDisLikes(data);
      })
      .catch((err) => {
        console.log("err", err);
      });
  }, [channelId]);

  useEffect(() => {
    fetch(
      `https://localhost:7001/api/Channel/get-unsubscribersLikes?ChannelId=${channelId}`,
      {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${localStorage.getItem("token")}`,
        },
      }
    )
      .then((res) => res.json())
      .then((data) => {
        setTotalUnSubscribersLikes(data);
      })
      .catch((err) => {
        console.log("err", err);
      });
  }, [channelId]);

  useEffect(() => {
    if (!localStorage.getItem("token")) return;
    fetch(
      `https://localhost:7001/api/Channel/get-subscribersLikes?ChannelId=${channelId}`,
      {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${localStorage.getItem("token")}`,
        },
      }
    )
      .then((res) => res.json())
      .then((data) => {
        setTotalSubscribersLikes(data);
      })
      .catch((err) => {
        console.log("err", err);
      });
  }, [channelId]);
  //
  useEffect(() => {
    if (!localStorage.getItem("token")) return;
    fetch(
      `https://localhost:7001/api/Channel/get-unsubscribersDisLikes?ChannelId=${channelId}`,
      {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${localStorage.getItem("token")}`,
        },
      }
    )
      .then((res) => res.json())
      .then((data) => {
        setTotalUnSubscribersDisLikes(data);
      })
      .catch((err) => {
        console.log("err", err);
      });
  }, [channelId]);

  return (
    <div>
      {isClicked && (
        <VideoInfoForm
          channelId={channelId}
          isClicked={isClicked}
          setIsClicked={setIsClicked}
        />
      )}
      <div>
        <Image
          src={ChannelBanner}
          alt="Channel Banner"
          className="w-full h-60 object-cover"
        />
      </div>

      <div className="flex items-center justify-between w-10/12 mx-auto mt-24">
        <ChannelInfo
          channelId={channelId}
          channelName={channelName}
          avatarURL={avatarURL}
          createdAt={createdAt}
          isOwner={isOwner}
          viewsCount={viewsCount}
          subscribersCount={subscribersCount}
          isSubscribed={isSubscribed}
        />
        {isOwner && (
          <div className="flex flex-col items-center justify-center">
            <UploadVideo isClicked={isClicked} setIsClicked={setIsClicked} />
            <div className="grid grid-cols-4 gap-x-0 gap-y-1 mt-7">
              <div className="flex flex-col justify-between items-center py-2 px-4 border-secondaryBlack border-r-2">
                <p className="font-youtubeSansDarkExtraBold bg-secondaryBlack w-12 h-12 rounded-full text-3xl text-center flex items-center justify-center mb-3 text-primaryRed">
                  {totalSubscribersLikes}
                </p>
                <p className="font-youtubeSansDarkBlack"> Subs Likes </p>
              </div>
              <div className="flex flex-col justify-between items-center py-2 px-4 border-secondaryBlack border-r-2">
                <p className="font-youtubeSansDarkExtraBold bg-secondaryBlack w-12 h-12 rounded-full text-3xl text-center flex items-center justify-center mb-3 text-primaryRed">
                  {totalSubscribersDisLikes}
                </p>
                <p className="font-youtubeSansDarkBlack ">Subs DisLikes </p>
              </div>
              <div className="flex flex-col justify-between items-center py-2 px-4 border-secondaryBlack border-r-2">
                <p className="font-youtubeSansDarkExtraBold bg-secondaryBlack w-12 h-12 rounded-full text-3xl text-center flex items-center justify-center mb-3 text-primaryRed">
                  {totalUnSubscribersLikes}
                </p>
                <p className="font-youtubeSansDarkBlack ">UnSubs Likes </p>
              </div>
              <div className="flex flex-col justify-between items-center py-2 px-4">
                <p className="font-youtubeSansDarkExtraBold bg-secondaryBlack w-12 h-12 rounded-full text-3xl text-center flex items-center justify-center mb-3 text-primaryRed">
                  {totalUnSubscribersDisLikes}
                </p>
                <p className="font-youtubeSansDarkBlack ">UnSubs DisLikes</p>
              </div>
            </div>
          </div>
        )}
      </div>

      <div className="flex flex-wrap items-center pb-10 gap-10 justify-center mx-auto mt-24">
        {channelVideos.map((video) => {
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
  );
}

export default Channel;
