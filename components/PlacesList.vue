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
  <div class="places-list" v-if="placesData">
    <!-- Iterate over the places -->
    <div v-for="(place, index) in placesData" :key="index" class="place places-item">
      <div class="place-header">
        <h2>{{ place.label }}</h2>
        <p>{{ place.location }}</p>
      </div>

      <div class="opening-hours">
        <h3>Opening hours:</h3>
        <div v-for="(hours, day) in place.opening_hours.days" :key="day">
          <p class="day-header"><strong>{{ day }}</strong>:</p>
          <ul>
            <!-- If there is no opening hours -->
            <li v-if="hours.length === 0">Closed</li>

            <!-- Opening hours -->
            <li v-for="(interval, idx) in hours" :key="idx">
              {{ interval.start }} - {{ interval.end }}
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>

  <!-- Loading state -->
  <div v-else>
    <p>Loading data in progress...</p>
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

  .places-list {
    margin-top: 10em;
    min-height: 800px;

    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: space-evenly;
  }

  .places-item {
    display: flex;
    align-items: flex-start;
    gap: 10px;

    background-color: #EEEEEE;
    border-radius: 10px;
    margin: 1rem;
    width: 45vw;
  }

  .place-header {
    font-size: 1.2rem;
    font-weight: bold;
    color: #666;
    text-align: left;

    vertical-align: top;

    width: 40%;
    padding: 3rem 3rem 3rem 5rem;
  }

  .opening-hours {
    font-size: 1.2rem;
    color: #666;
    text-align: left;

    background-color: #EFEFEF;

    width: 60%;
    padding: 3rem 3rem 3rem 4rem;

  }

  ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
  }

  .day-header {
    padding-top: 0.7rem;
    padding-bottom: 0.2rem;
  }

</style>
