"use client";
import { useEffect, useState } from "react";
import Image from "next/image";
import ChannelLogo from "../../../public/images/ChannelLogo.png";

function ChannelInfo(props) {
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
  const [isSubscriber, setIsSubscriber] = useState(false);
  const [clicked, setClicked] = useState(false);
  const [subscribers, setSubscribers] = useState(0);

  function dateFormat(date) {
    if (date === undefined) return;
    const splitDate = date.split("-");
    return splitDate[0];
  }

  function handleSubscribe() {
    console.log(isSubscriber);
    if (isSubscriber === false) {
      setSubscribers(subscribers + 1);
      setIsSubscriber(!isSubscriber);

      if (localStorage.getItem("token")) {
        fetch(
          `https://localhost:7001/api/Channel/Subscribe?channelId=${channelId}`,
          {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
              Authorization: `Bearer ${localStorage.getItem("token")}`,
            },
          }
        )
          .then((res) => res.json())
          .catch((err) => {
            console.log("err", err);
          });
      }
    } else if (isSubscriber === true) {
      setSubscribers(subscribers - 1);
      setIsSubscriber(!isSubscriber);

      if (localStorage.getItem("token")) {
        fetch(
          `https://localhost:7001/api/Channel/UnSubscribe?channelId=${channelId}`,
          {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
              Authorization: `Bearer ${localStorage.getItem("token")}`,
            },
          }
        )
          .then((res) => res.json())
          .catch((err) => {
            console.log("err", err);
          });
      }
    }
  }

  useEffect(() => {
    setTimeout(() => {
      setSubscribers(subscribersCount);
    }, 500);
  }, [subscribersCount]);

  useEffect(() => {
    setTimeout(() => {
      setIsSubscriber(isSubscribed);
    }, 800);
  }, [isSubscribed]);

  return (
    <div className="flex items-center justify-between w-rem40">
      <div>
        <Image
          src={props.avatarURL}
          alt="Channel Avatar"
          className="rounded-full"
          height="176"
          width="176"
        />
      </div>
      <div>
        <h1 className="font-textFont font-black text-4xl mb-3">
          {channelName}
        </h1>
        <div className="text-primaryGray">
          <span>@{channelName} </span>
          <span>•</span>
          <span> Since {dateFormat(createdAt)}</span>
        </div>
        <p className="text-primaryGray">
          {subscribers > 0 ? subscribers : subscribersCount} subscribers
        </p>
        <p className="text-primaryGray mb-3">{viewsCount} Views</p>
        <div className="flex items-center justify-between w-72">
          <button
            onClick={() => {
              if (!isOwner) {
                handleSubscribe();
              }
            }}
            className={`rounded-3xl pt-2 pb-2 w-32 ${
              isOwner
                ? "cursor-default"
                : "hover:bg-primaryRed hover:text-white"
            }  transition-all ${
              isOwner ? "bg-secondaryBlack text-textColor" : ""
            } ${
              isSubscriber
                ? "bg-primaryRed text-white"
                : "text-primaryRed bg-white"
            }`}
          >
            {isSubscriber || isOwner ? "Subscribed" : "Subscribe"}
          </button>
        </div>
      </div>
    </div>
  );
}

export default ChannelInfo;
