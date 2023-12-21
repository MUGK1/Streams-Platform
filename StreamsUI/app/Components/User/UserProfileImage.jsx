const UserProfileImage = ({ initials }) => {
  const colors = [
    "bg-red-800",
    "bg-blue-800",
    "bg-green-800",
    "bg-yellow-800",
    "bg-purple-800",
  ];
  const randomColorClass = colors[Math.floor(Math.random() * colors.length)];

  return (
    <div
      className={`w-10 h-10 flex items-center justify-center rounded-full ${randomColorClass}`}
    >
      <span className="text-white text-lg tracking-normal font-textFont">
        {initials}
      </span>
    </div>
  );
};

export default UserProfileImage;
