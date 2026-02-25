<script setup>
import { Link } from "@inertiajs/vue3";

const props = defineProps({
    canRegister: {
        type: Boolean,
    },
    stats: {
        type: Array,
        default: () => [
            { value: "12+", label: "Starter Modules" },
            { value: "40+", label: "Reusable Components" },
            { value: "100%", label: "Vue + Inertia" },
            { value: "Fast", label: "Project Kickoff" },
        ],
    },
});

const emit = defineEmits(["scroll-to-features"]);
</script>

<template>
    <section class="pt-64 pb-32 px-4 sm:px-6 lg:px-8 relative overflow-hidden">
        <!-- Background Decoration -->
        <div class="absolute inset-0 overflow-hidden">
            <div
                class="absolute -top-40 -right-40 w-80 h-80 bg-cyan-500/30 rounded-full mix-blend-multiply filter blur-3xl opacity-70"
            ></div>
            <div
                class="absolute -bottom-40 -left-40 w-80 h-80 bg-orange-500/30 rounded-full mix-blend-multiply filter blur-3xl opacity-70"
            ></div>
        </div>

        <div class="max-w-7xl mx-auto relative">
            <div class="text-center">
                <h1
                    class="text-5xl md:text-7xl font-bold text-white mb-6 leading-tight"
                >
                    This is a Laravel Starter Kit
                    <span
                        class="bg-gradient-to-r from-cyan-400 to-orange-400 bg-clip-text text-transparent"
                    >
                        With Docker and Vue 3
                    </span>
                </h1>
                <p
                    class="text-xl text-slate-200 mb-10 max-w-3xl mx-auto"
                >
                    Kickstart your Laravel project with Docker and Vue 3 using
                    Inertia.js. The Docker stack includes MySQL for the database.
                </p>
            </div>
        </div>
    </section>
</template>
