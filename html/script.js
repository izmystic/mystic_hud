const hud = Vue.createApp({
  data() {
    return {
      direction: "",
      street: "",
      postal: "",
      aop: "",
      peacetime: "",
      peacetimeColor: "#b91c1c",
    };
  },
  destroyed() {
    window.removeEventListener("message", this.listener);
  },
  mounted() {
    this.listener = window.addEventListener("message", (event) => {
      if (event.data.action === "updateHud") {
        this.updateHud(event.data);
      }
    });
  },
  methods: {
    updateHud(data) {
      this.direction = data.direction;
      this.street = data.street;
      this.postal = data.postal;
      this.aop = data.aop;
      this.peacetime = data.peacetime;
      if (data.peacetime) {
        this.peacetime = "Enabled";
        this.peacetimeColor = "#15803d";
      } else {
        this.peacetime = "Disabled";
        this.peacetimeColor = "#b91c1c";
      }
    },
  },
}).mount("#hud-container");
