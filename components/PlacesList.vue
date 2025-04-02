<script setup>

  import axios from "axios";

  // Store the JSON data
  const placesData = ref(null);

  // API call to fetch data
  const fetchPlaces = async () => {
    try {
      const response = await axios.get("https://api.aerztekasse.zoltans.ch/places/");
      placesData.value = response.data.places;
    } catch (error) {
      console.error("Error during fetching data:", error);
    }
  };

  // API call when loading the page
  onMounted(() => {
    fetchPlaces();
  });

</script>

<template>

  <header>
    <h1>Aerztekasse Places</h1>
  </header>

  <!-- Verify if there is any data -->
  <div v-if="placesData">
    <!-- Iterate over the places -->
    <div v-for="(place, index) in placesData" :key="index" class="place">
      <h2>{{ place.label }}</h2>
      <p><strong>Address:</strong> {{ place.location }}</p>

      <div class="opening-hours">
        <h3>Opening hours:</h3>
        <div v-for="(hours, day) in place.opening_hours.days" :key="day">
          <p><strong>{{ day }}</strong>:</p>
          <ul>
            <!-- If there is no opening hours -->
            <li v-if="hours.length === 0">Closed</li>

            <!-- Opening hours -->
            <li v-for="(interval, idx) in hours" :key="idx">
              {{ interval.start }} - {{ interval.end }} ({{ interval.type }})
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>


  <!-- Üres állapot kezelése -->
  <div v-else>
    <p>Adatok betöltése folyamatban...</p>
  </div>

</template>

<style>
  * {
    margin: 0;
    padding: 0;
  }

  html {
    text-align: center;
  }

  :root {
    --sz-green-dark: #658415;
    --sz-green-light: #8ca71f;
    /* color: var(--sz-green-dark); */
  }

  nav {
    position: fixed;
    top: 0;
    width: 100%;
    /*padding: 25px;*/

    border-bottom: 1px solid #e3e3e3;
    background-color: white;

    display: flex;
    justify-content: space-between; /* Horizontally align */
    align-items: center; /* Vertically align */
  }

  .brand a {
    font-size: 1.2rem;
    font-weight: bold;

    color: var(--sz-green-dark) !important;
  }

  .nav-links {
    display: flex;
    justify-content: flex-end;
    align-items: center;
  }

  nav a {
    text-decoration: none;
    color: #929292;
    /* margin: 0 20px; */
    margin: 1.0em;
  }

  nav a:hover {
    color: black;
  }

  nav a.active {
    color: black;
  }

  header {
    padding-top: calc(50px + 1rem + 1px);
  }

  header > p {
    margin: 1em 2em !important;
    font-size: 1.4rem;
  }

  h1, h2, h3, h4, h5, h6 {
    background: linear-gradient(to right, var(--sz-green-dark), var(--sz-green-light));
    -webkit-background-clip: text; /* A háttér vágása a szöveghez */
    -webkit-text-fill-color: transparent; /* A szöveg "átlátszó", hogy a háttér látszódjon */
  }

  h1 {
    margin-top: 2em;
    font-size: 3rem;
    font-weight: bold;
    line-height: 1.5em;
  }

  .bigger {
    font-size: 5rem;
  }

  .cta-button{
    text-decoration: none;
    color: white !important;
    background: linear-gradient(to right,var(--sz-green-dark), var(--sz-green-light));
    display: inline-block;
    padding: 1em 3em;
    font-weight: 600;
    border-radius: 1000px;
    transition: 150ms ease;
  }

  .cta-button:hover{
    scale: 1.1;
  }

  .content {
    margin-top: 10em;
    /*background-color: #f4f4f5;*/
    /*border: 4px solid black;*/
    min-height: 800px;

    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: space-evenly;
    /*gap: 1em;*/
  }
</style>