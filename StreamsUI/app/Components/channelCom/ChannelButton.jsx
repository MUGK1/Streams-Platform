"use client";
import { useRouter } from "next/navigation";

function VideoButton({ children, id }) {
  const router = useRouter();

  const handleButtonClick = () => {
    router.push(`/channel/${id}`);
  };

  return (
    <button onClick={handleButtonClick} className="buttonCancelDefault">
      {children}
    </button>
  );
}

export default VideoButton;
