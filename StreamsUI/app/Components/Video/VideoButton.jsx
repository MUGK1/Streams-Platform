"use client";
import { useRouter } from "next/navigation";

function VideoButton({ children, id }) {
  const router = useRouter();

  const handleButtonClick = () => {
    router.push(`/Video/${id}`);
  };

  return (
    <button
      onClick={handleButtonClick}
      className="rounded hover:bg-backgroundGray active:bg-opacity-60 transition-all"
    >
      {children}
    </button>
  );
}

export default VideoButton;
