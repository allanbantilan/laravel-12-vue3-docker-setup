<script setup>
import { Link } from "@inertiajs/vue3";
import { ref, onMounted, onUnmounted } from "vue";

const props = defineProps({
    canLogin: {
        type: Boolean,
        default: true,
    },
    canRegister: {
        type: Boolean,
        default: true,
    },
    appName: {
        type: String,
        default: "StarterKit",
    },
    hideMainLinks: {
        type: Boolean,
        default: false,
    },
});

const emit = defineEmits(["scroll-to-section"]);

const isMenuOpen = ref(false);
const isScrolled = ref(false);

const handleScroll = () => {
    isScrolled.value = window.scrollY > 50;
};

const scrollToSection = (sectionId) => {
    emit("scroll-to-section", sectionId);
    isMenuOpen.value = false;
};

onMounted(() => {
    window.addEventListener("scroll", handleScroll);
});

onUnmounted(() => {
    window.removeEventListener("scroll", handleScroll);
});
</script>

<template>
    <nav
        :class="[
            'fixed w-full z-50 transition-all duration-300',
            isScrolled
                ? 'bg-slate-950/85 backdrop-blur-md border-b border-white/10'
                : 'bg-transparent',
        ]"
    >
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 pt-4">
            <div class="flex justify-between items-center h-16">
                <!-- Logo -->
                <div class="flex items-center">
                    <Link href="/" class="flex items-center space-x-2 group">
                        <div
                            class="w-10 h-10 bg-cyan-500 rounded-xl flex items-center justify-center shadow-lg group-hover:shadow-xl transition-shadow"
                        >
                            <svg
                                class="w-6 h-6 text-white"
                                fill="none"
                                stroke="currentColor"
                                viewBox="0 0 24 24"
                            >
                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    stroke-width="2"
                                    d="M13 10V3L4 14h7v7l9-11h-7z"
                                />
                            </svg>
                        </div>
                        <span
                            class="text-xl font-bold text-white"
                        >
                            {{ appName }}
                        </span>
                    </Link>
                </div>

                <!-- Desktop Menu - Centered -->
                <div
                    v-if="!hideMainLinks"
                    class="hidden md:flex items-center absolute left-1/2 transform -translate-x-1/2"
                >
                    <div class="flex items-center space-x-8">
                        <button
                            @click="scrollToSection('features')"
                            class="text-slate-200 hover:text-cyan-300 font-medium transition-colors"
                        >
                            Features
                        </button>
                        <button
                            @click="scrollToSection('about')"
                            class="text-slate-200 hover:text-cyan-300 font-medium transition-colors"
                        >
                            Why It Works
                        </button>
                        <button
                            @click="scrollToSection('contact')"
                            class="text-slate-200 hover:text-cyan-300 font-medium transition-colors"
                        >
                            Support
                        </button>
                    </div>
                </div>

                <!-- Auth Links - Right side -->
                <div class="hidden md:flex items-center space-x-4">
                    <Link
                        v-if="canLogin"
                        :href="route('login')"
                        class="text-slate-200 hover:text-cyan-300 font-medium transition-colors"
                    >
                        Sign In
                    </Link>
                    <Link
                        v-if="canRegister"
                        :href="route('register')"
                        class="bg-cyan-500 hover:bg-cyan-400 text-slate-950 px-6 py-2 rounded-lg font-semibold shadow-md hover:shadow-lg transition-all duration-200"
                    >
                        Create Account
                    </Link>
                </div>

                <!-- Mobile menu button -->
                <button
                    v-if="!hideMainLinks"
                    @click="isMenuOpen = !isMenuOpen"
                    class="md:hidden text-slate-200"
                >
                    <svg
                        class="w-6 h-6"
                        fill="none"
                        stroke="currentColor"
                        viewBox="0 0 24 24"
                    >
                        <path
                            v-if="!isMenuOpen"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            stroke-width="2"
                            d="M4 6h16M4 12h16M4 18h16"
                        />
                        <path
                            v-else
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            stroke-width="2"
                            d="M6 18L18 6M6 6l12 12"
                        />
                    </svg>
                </button>
            </div>

            <!-- Mobile Menu -->
            <div
                v-if="isMenuOpen && !hideMainLinks"
                class="md:hidden bg-slate-900 border border-white/10 shadow-lg rounded-lg mt-2 py-4"
            >
                <div class="px-2 space-y-3">
                    <button
                        @click="scrollToSection('features')"
                        class="block w-full text-left px-4 py-2 text-slate-200 hover:text-cyan-300 font-medium"
                    >
                        Features
                    </button>
                    <button
                        @click="scrollToSection('about')"
                        class="block w-full text-left px-4 py-2 text-slate-200 hover:text-cyan-300 font-medium"
                    >
                        Why It Works
                    </button>
                    <button
                        @click="scrollToSection('contact')"
                        class="block w-full text-left px-4 py-2 text-slate-200 hover:text-cyan-300 font-medium"
                    >
                        Support
                    </button>

                    <!-- Auth links -->
                    <div
                        class="pt-4 border-t border-white/10 space-y-3"
                    >
                        <Link
                            v-if="canLogin"
                            :href="route('login')"
                            class="block px-4 py-2 text-slate-200 hover:text-cyan-300 font-medium"
                        >
                            Sign In
                        </Link>
                        <Link
                            v-if="canRegister"
                            :href="route('register')"
                            class="block px-4 py-2 bg-cyan-500 hover:bg-cyan-400 text-slate-950 rounded-lg font-semibold text-center"
                        >
                            Create Account
                        </Link>
                    </div>
                </div>
            </div>
        </div>
    </nav>
</template>
