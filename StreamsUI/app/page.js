"use client";
import Image from "next/image";
import Video from "@/app/Components/Video/Video";
import LogIn from "@/app/Components/loginPage/LogIn";
import Genres from "./Components/Genres/Genre";
import { useState, useEffect } from "react";
import { useSearchParams, usePathname } from "next/navigation";

export default function Home() {
  const [genres, setGenres] = useState([]);
  const [videos, setVideos] = useState([]);
  const [singleGenre, setSingleGenre] = useState("");
  const [showLogin, setShowLogin] = useState(true);

  useEffect(() => {
    if (!localStorage.getItem("token")) return;
    fetch("https://localhost:7001/api/Video/get-genres", {
      method: "GET",
      cache: "no-store",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${localStorage.getItem("token")}`,
      },
    })
      .then((res) => {
        return res.json();
      })
      .then((data) => {
        setGenres(data);
      });
  }, []);

  useEffect(() => {
    if (!localStorage.getItem("token")) return;
    fetch("https://localhost:7001/api/Video/get-all-videos", {
      method: "GET",
      cache: "no-store",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${localStorage.getItem("token")}`,
      },
    })
      .then((res) => {
        return res.json();
      })
      .then((data) => {
        setVideos(data);
      });
  }, []);

  useEffect(() => {
    if (!localStorage.getItem("token")) return;
    if (singleGenre !== "") {
      fetch(
        `https://localhost:7001/api/Video/get-Videos-by-Genre?genre=${singleGenre}`,
        {
          method: "GET",
          cache: "no-store",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${localStorage.getItem("token")}`,
          },
        }
      )
        .then((res) => {
          if (!res.ok) {
            throw new Error("Error");
          }
          return res.json();
        })
        .then((data) => {
          setVideos(data);
        });
    }
  }, [singleGenre]);

  //Handle Search
  const searchParams = useSearchParams();
  const search = searchParams.get("search");

  useEffect(() => {
    if (!localStorage.getItem("token")) return;
    if (search !== "") {
      fetch(
        `https://localhost:7001/api/Video/get-Videos-by-text?text=${search}`,
        {
          method: "GET",
          cache: "no-store",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${localStorage.getItem("token")}`,
          },
        }
      )
        .then((res) => {
          if (!res.ok) {
            throw new Error("Error");
          }
          return res.json();
        })
        .then((data) => {
          setVideos(data);
        });
    }
  }, [searchParams.get("search")]);

  const handleGenreType = (genreType) => {
    setSingleGenre(genreType);
  };

  useEffect(() => {
    if (localStorage.getItem("token")) {
      setShowLogin(false);
    }
  }, []);
  return (
    <main className="p-0 m-0">
      {showLogin && <LogIn setShowLogin={setShowLogin} showLogin={showLogin} />}
      <div className="flex justify-center my-3">
        {genres.map((item, index) => (
          <Genres key={index} selectedGenre={handleGenreType} data={item} />
        ))}
      </div>
      <div className="flex flex-wrap items-center gap-10 justify-center mx-auto p-0 m-0 pb-10">
        {videos.map((video) => (
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
        ))}
      </div>
    </main>
  );
}
