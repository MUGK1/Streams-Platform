import UserProfileImage from "@/app/Components/User/UserProfileImage";
import React, { useState, useEffect } from "react";
import Image from "next/image";
import userAvatar from "../../../public/images/User_Avatar.svg";

const Comments = (props) => {
  const { videoId } = props;

  const [comments, setComments] = useState([]);
  const [comment, setComment] = useState("");

  useEffect(() => {
    if (!localStorage.getItem("token") || !videoId) return;
    fetch(`https://localhost:7001/api/impression/comments/${videoId}`, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${localStorage.getItem("token")}`,
      },
    })
      .then((res) => res.json())
      .then((data) => {
        setComments(data);
      })
      .catch((err) => {
        console.log("err", err);
      });
  }, [videoId]);

  const handlePostComment = () => {
    if (localStorage.getItem("token")) {
      const formData = new URLSearchParams();
      formData.append("comment", comment);

      fetch(`https://localhost:7001/api/impression/comments/${videoId}`, {
        method: "POST",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          Authorization: `Bearer ${localStorage.getItem("token")}`,
        },
        body: formData,
      })
        .then((res) => res.json())
        .then((res) => {
          setComments(res);
          setComment("");
        })
        .catch((err) => {
          console.log("err", err);
        });
    }
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

  const handleInputChange = (event) => {
    setComment(event.target.value);
  };

  return (
    <>
      <div className="flex items-center justify-between p-4">
        <div className="flex items-center space-x-3 w-full mx-2">
          <Image src={userAvatar} alt="userAvatar" className="w-10 py-2" />
          <input
            className="flex-1 px-4 py-2 rounded-full bg-gray-800 text-white placeholder-gray-400 focus:outline-none"
            placeholder="Add a comment..."
            type="text"
            value={comment}
            onChange={handleInputChange}
          />
        </div>
        <div className="flex space-x-3">
          <button
            onClick={handlePostComment}
            className="px-6 py-2 rounded-full bg-gray-800 text-white font-bold"
          >
            Post
          </button>
        </div>
      </div>
      <div className="p-4">
        <span className="mx-1 font-bold inline-block mb-4">
          {comments.length} Comments
        </span>
        {comments.map((comment) => {
          return (
            <div className="flex items-start mx-2 mb-4">
              <div className="mr-2">
                <UserProfileImage initials={comment.userInitials} />
              </div>
              <div>
                <span className="text-sm font-semibold">
                  {comment.userName}{" "}
                </span>
                <span className="font-bold text-lg">&#183;</span>
                <span className="text-xs text-gray-400">
                  {" "}
                  {calculateDaysAgo(comment.createdAt)}
                </span>
                <p className="text-sm">{comment.commentText}</p>
              </div>
            </div>
          );
        })}
      </div>
    </>
  );
};

export default Comments;
