"use client";
import { useState } from "react";

function Genres(props) {
  const handelClick = (e) => {
    props.selectedGenre(e.target.value);
  };
  return (
    <button
      onClick={handelClick}
      value={props.data}
      className="py-1 px-5 bg-[#262626] mx-2 text-white mb-5 font-youtubeSansDarkMedium rounded-lg shadow-md transition-colors hover:bg-[#3d3d3d] focus:outline-none focus:ring-2 focus:ring-blue-400 focus:ring-opacity-75"
    >
      {props.data}
    </button>
  );
}

export default Genres;
