import React, { useState, useEffect } from "react";

const SubscriptionButton = (props) => {
  const { channelId } = props;
  const [isSubscribed, setIsSubscribed] = useState(false);

  useEffect(() => {
    if (!localStorage.getItem("token") || !channelId) return;
    fetch(
      `https://localhost:7001/api/channel/GetSubscriptionStatus/${channelId}`,
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
        setIsSubscribed(data.isSubscribed);
      })
      .catch((err) => {
        console.log("err", err);
      });
  }, [channelId]);

  const handleSubscribe = async () => {
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
        .then((res) => {
          setIsSubscribed(true);
        })
        .catch((err) => {
          console.log("err", err);
        });
    }
  };

  const handleUnsubscribe = async () => {
    if (localStorage.getItem("token")) {
      fetch(
        `https://localhost:7001/api/Channel/Unsubscribe?channelId=${channelId}`,
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${localStorage.getItem("token")}`,
          },
        }
      )
        .then((res) => {
          setIsSubscribed(false);
        })
        .catch((err) => {
          console.log("err", err);
        });
    }
  };

  return (
    <>
      {isSubscribed ? (
        <button
          className="text-white font-bold bg-gray-800 ml-14 rounded-full h-9 w-32"
          onClick={handleUnsubscribe}
        >
          Unsubscribe
        </button>
      ) : (
        <button
          className="text-primaryBlack font-bold bg-white ml-14 rounded-full h-9 w-32"
          onClick={handleSubscribe}
        >
          Subscribe
        </button>
      )}
    </>
  );
};

export default SubscriptionButton;
