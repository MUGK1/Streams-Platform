import Image from "next/image";
import VideoButton from "@/app/Components/Video/VideoButton";

function Video(props) {
  function calculateDaysAgo(dateString1) {
    const date1 = new Date(dateString1);
    const today = new Date();
    const differenceInMillis = Math.abs(today - date1);
    const differenceInDays = Math.floor(
      differenceInMillis / (1000 * 60 * 60 * 24),
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
  function formatTwoDigits(number) {
    let numberString = number.toString();
    if (number < 10) {
      numberString = "0" + numberString;
    }

    return numberString;
  }
  return (
    <VideoButton id={props.id}>
      <div className="group w-80 rounded p-2">
        <div className="mb-2 relative group-hover:cursor-pointer">
          <Image
            src={
              "https://img.youtube.com/vi/" + props.url + "/maxresdefault.jpg"
            }
            alt="Logo"
            className="w-full rounded-md group-hover:rounded-none"
            width={320}
            height={100}
          />
          <div className="absolute w-fit bottom-2.5 right-2.5 px-1 font-bold py-0 rounded-md text-white bg-[#000000]/[.5] ">
            {Math.floor(Math.random() * (60 - 10) + 10)}:
            {formatTwoDigits(Math.floor(Math.random() * 59))}
          </div>
        </div>
        <div className="w-full flex flex-start">
          <div className=" w-10">
            <Image
              src={props.avatarUrl}
              alt="Channel Avatar"
              className="rounded-full w-12"
              height="32"
              width="32"
            />
          </div>
          <div className="w-60">
            <div className=" w-60 text-white truncate">
              <span className=" font-youtubeSansDarkBold font-bold mx-1 w-full">
                {props.title}
              </span>
            </div>
            <div className="w-full text-gray-600 text-sm font-textFont whitespace-nowrap">
              <span className="mx-1 block ">{props.channelName}</span>
              <span className="mx-1 inline-block mt-1">
                {" "}
                {props.views} views{" "}
              </span>
              <span className="font-bold text-lg">&#183;</span>
              <span className="mx-1 inline-block">
                {calculateDaysAgo(props.publishedAt)}{" "}
              </span>
            </div>
          </div>
        </div>
      </div>
    </VideoButton>
  );
}

export default Video;
