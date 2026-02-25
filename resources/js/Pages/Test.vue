<script setup>
import { Head, usePage } from "@inertiajs/vue3";
import { computed, onMounted } from "vue";
import {
    Navigation,
    Hero,
    Footer,
} from "@/Components/Home";

const props = defineProps({
    canLogin: {
        type: Boolean,
    },
    canRegister: {
        type: Boolean,
    },
});

// Get the page instance
const page = usePage();

// Debug: log all shared props
onMounted(() => {
    console.log("DEBUG - All shared props:", page.props);
    console.log("DEBUG - App name:", page.props.appName);
    console.log("DEBUG - All props keys:", Object.keys(page.props));
});

// Use computed property for reactivity
const appName = computed(() => {
    const name = page.props.appName;
    console.log("DEBUG - Computed appName:", name);
    return name || "StarterKit";
});

const scrollToSection = (sectionId) => {
    const element = document.getElementById(sectionId);
    if (element) {
        element.scrollIntoView({ behavior: "smooth" });
    }
};
</script>
