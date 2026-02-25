<script setup>
import { Head } from "@inertiajs/vue3";
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
    appName: {
        type: String,
        default: "StarterKit",
    },
});

const scrollToSection = (sectionId) => {
    const element = document.getElementById(sectionId);
    if (element) {
        element.scrollIntoView({ behavior: "smooth" });
    }
};
</script>

<template>
    <Head title="Starter Kit" />

    <div class="min-h-screen bg-slate-950">
        <!-- Navigation -->
        <Navigation
            :can-login="canLogin"
            :can-register="canRegister"
            :app-name="appName"
            :hide-main-links="true"
            @scroll-to-section="scrollToSection"
        />

        <!-- Hero Section -->
        <Hero
            :can-register="canRegister"
        />

        <!-- Footer -->
        <Footer :app-name="appName" />
    </div>
</template>
