import axios from 'axios';

// Automatically switch depending on the environment
export const baseUrl = `${process.env.REACT_APP_API_URL || 'http://localhost:8000'}/api/v2`;

const axiosInstance = axios.create({
  baseURL: baseUrl,
  headers: {
    'Content-Type': 'application/json',
  },
});

// Attach token dynamically
axiosInstance.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('access_token');
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  (error) => Promise.reject(error)
);

export default axiosInstance;
