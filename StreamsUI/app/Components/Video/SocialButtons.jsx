import React, { useState, useEffect } from "react";

const SocialButtons = (props) => {
  const { videoId } = props;

  const [likes, setLikes] = useState(0);
  const [dislikes, setDislikes] = useState(0);
  const [liked, setLiked] = useState(false);
  const [disliked, setDisliked] = useState(false);

  useEffect(() => {
    if (!localStorage.getItem("token") || !videoId) return;
    fetch(`https://localhost:7001/api/Impression/get-impressions/${videoId}`, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${localStorage.getItem("token")}`,
      },
    })
      .then((res) => res.json())
      .then((data) => {
        setLikes(data.likes);
        setDislikes(data.dislikes);
      })
      .catch((err) => {
        console.log("err", err);
      });
  }, [videoId]);

  const handleLike = () => {
    if (localStorage.getItem("token")) {
      fetch(`https://localhost:7001/api/impression/like?videoId=${videoId}`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${localStorage.getItem("token")}`,
        },
      })
        .then((res) => {
          if (disliked) {
            setDisliked(false);
            setDislikes(dislikes - 1);
          }
          if (!liked) {
            setLiked(true);
            setLikes(likes + 1);
          } else {
            setLiked(false);
            setLikes(likes - 1);
          }
        })
        .catch((err) => {
          console.log("err", err);
        });
    }
  };

  const handleDislike = () => {
    if (localStorage.getItem("token")) {
      fetch(
        `https://localhost:7001/api/impression/dislike?videoId=${videoId}`,
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${localStorage.getItem("token")}`,
          },
        },
      )
        .then((res) => {
          if (likes) {
            setLiked(false);
            setLikes(likes - 1);
          }
          if (!disliked) {
            setDisliked(true);
            setDislikes(dislikes + 1);
          } else {
            setDisliked(false);
            setDislikes(dislikes - 1);
          }
        })
        .catch((err) => {
          console.log("err", err);
        });
    }
  };

  return (
    <div className="bg-gray-800 text-white px-4 rounded-full flex items-center h-9">
      <button onClick={handleLike}>
        <svg
          width="28"
          height="28"
          viewBox="0 0 28 28"
          fill="none"
          className={liked ? "fill-primaryRed" : ""}
          xmlns="http://www.w3.org/2000/svg"
        >
          <path
            d="M9.33342 11.6667V23.3333M9.33342 11.6667L4.66675 11.6666V23.3333H9.33342M9.33342 11.6667L15.3949 4.59488C15.9701 3.92385 16.875 3.63538 17.7325 3.84973L17.7879 3.8636C19.3533 4.25496 20.0585 6.07899 19.1635 7.42157L16.3334 11.6666H21.6539C23.1263 11.6666 24.2307 13.0137 23.942 14.4576L22.5419 21.4576C22.3238 22.5483 21.3662 23.3333 20.2539 23.3333H9.33342"
            stroke="white"
            strokeWidth="1.75"
            strokeLinecap="round"
            strokeLinejoin="round"
          />
        </svg>
      </button>
      <span className="font-semibold">{likes}</span>
      <span className="border-l-2 border-gray-600 mx-2 h-6"></span>
      <button onClick={handleDislike}>
        <svg
          width="28"
          height="28"
          viewBox="0 0 28 28"
          fill="none"
          className={disliked ? "fill-primaryGray" : ""}
          xmlns="http://www.w3.org/2000/svg"
        >
          <path
            d="M18.6666 16.3333L18.6666 4.66667M18.6666 16.3333L23.3333 16.3334L23.3333 4.66667L18.6666 4.66667M18.6666 16.3333L12.6051 23.4051C12.0299 24.0762 11.125 24.3646 10.2675 24.1503L10.2121 24.1364C8.64667 23.745 7.94153 21.921 8.83648 20.5784L11.6666 16.3334L6.34612 16.3334C4.87367 16.3334 3.7693 14.9863 4.05805 13.5424L5.45805 6.54244C5.67622 5.45172 6.63382 4.66667 7.74612 4.66667L18.6666 4.66667"
            stroke="white"
            strokeWidth="1.75"
            strokeLinecap="round"
            strokeLinejoin="round"
          />
        </svg>
      </button>
      <span className="font-semibold">{dislikes}</span>
    </div>
  );
};

export default SocialButtons;
