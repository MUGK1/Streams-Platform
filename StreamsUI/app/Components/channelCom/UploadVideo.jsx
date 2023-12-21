import Image from "next/image";
import Upload from "../../../public/images/Upload.svg";
import { useState } from "react";

function UploadVideo({ isClicked, setIsClicked }) {
  function handleClick() {
    setIsClicked(!isClicked);
  }
  return (
    <div
      onClick={handleClick}
      className="flex items-center justify-between p-7 rounded-xl w-96 bg-secondaryBlack hover:opacity-80 active:opacity-100 cursor-pointer  transition-opacity"
    >
      <div>
        <Image src={Upload} alt="UploadImage" className="rounded-xl" />
      </div>
      <h1 className="text-white font-textFont font-black text-2xl">
        Upload Video
      </h1>
    </div>
  );
}

export default UploadVideo;
