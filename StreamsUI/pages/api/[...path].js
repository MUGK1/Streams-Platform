// // pages/api/[...path].js
// export default async function handler(req, res) {
//   const { method, body, query, headers } = req;
//
//   // Extract the path from the request
//   const path = req.query.path || [];
//
//   // Construct the URL for the backend API
//   const apiUrl = `https://localhost:7001/${path.join("/")}`;
//
//   // Forward the request to your backend API
//   const backendResponse = await fetch(apiUrl, {
//     method,
//     body: method !== "GET" ? JSON.stringify(body) : undefined,
//     headers: {
//       // Copy the original headers and add/modify as needed
//       ...headers,
//       "Content-Type": "application/json",
//       Authorization: `Bearer ${localStorage.getItem("token")}`,
//     },
//   });
//
//   const data = await backendResponse.json();
//
//   // Modify the response here if needed
//
//   // Send the response back to the client
//   res.status(backendResponse.status).json(data);
// }
