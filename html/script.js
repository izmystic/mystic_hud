const hud = Vue.createApp({
  data() {
    return {
      show: false,
      direction: "",
      street: "",
      postal: "",
      aop: "",
      peacetime: "",
      primaryColor: "",
      secondaryColor: "",
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
      this.show = data.show;
      this.direction = data.direction;
      this.street = data.street;
      this.postal = data.postal;
      this.aop = data.aop;
      this.peacetime = data.peacetime;
      this.primaryColor = data.primaryColor;
      this.secondaryColor = data.secondaryColor;
      if (data.peacetime) {
        this.peacetime = "Enabled";
      } else {
        this.peacetime = "Disabled";
      }
    },
  },
}).mount("#hud-container");