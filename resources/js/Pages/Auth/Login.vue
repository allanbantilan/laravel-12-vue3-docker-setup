<script setup>
import { Head, Link, useForm, usePage } from "@inertiajs/vue3";
import { computed, ref } from "vue";
import Navigation from "@/Components/Home/Navigation.vue";

const props = defineProps({
    canResetPassword: Boolean,
    status: String,
});

const page = usePage();
const appName = computed(() => page.props.appName || "StarterKit");
const showPassword = ref(false);

const form = useForm({
    email: "",
    password: "",
    remember: false,
});

const submit = () => {
    form.transform((data) => ({
        ...data,
        remember: form.remember ? "on" : "",
    })).post(route("login"), {
        onFinish: () => form.reset("password"),
    });
};
</script>

<template>
    <Head title="Sign In" />

    <div class="relative min-h-screen overflow-hidden bg-slate-950">
        <Navigation
            :can-login="false"
            :can-register="false"
            :app-name="appName"
            :hide-main-links="true"
        />

        <div
            class="pointer-events-none absolute inset-0 bg-[radial-gradient(circle_at_20%_20%,rgba(6,182,212,0.22),transparent_42%),radial-gradient(circle_at_80%_10%,rgba(234,88,12,0.26),transparent_40%),radial-gradient(circle_at_50%_100%,rgba(16,185,129,0.2),transparent_45%)]"
        />

        <div
            class="relative mx-auto grid min-h-screen max-w-6xl items-center gap-10 px-4 pb-10 pt-24 sm:px-6 lg:grid-cols-2 lg:px-8"
        >
            <section class="hidden text-white lg:block">
                <p
                    class="mb-5 inline-flex items-center rounded-full border border-white/20 bg-white/10 px-4 py-1 text-sm uppercase tracking-[0.2em]"
                >
                    {{ appName }}
                </p>
                <h1 class="text-5xl font-black leading-tight">
                    Modern
                    <span class="text-cyan-300">Starter Kit.</span>
                </h1>
                <p class="mt-5 max-w-md text-base text-slate-200/85">
                    Sign in
                </p>
            </section>

            <section
                class="rounded-3xl border border-white/20 bg-transparent p-6 shadow-2xl shadow-cyan-900/25 backdrop-blur sm:p-8"
            >
                <h2 class="text-3xl font-black tracking-tight text-white">
                    Sign in
                </h2>
                <p class="mt-2 text-sm text-slate-300">
                    Access your project workspace.
                </p>

                <div
                    v-if="status"
                    class="mt-4 rounded-xl border border-emerald-200 bg-emerald-50 px-4 py-3 text-sm text-emerald-700"
                >
                    {{ status }}
                </div>

                <form @submit.prevent="submit" class="mt-6 space-y-5">
                    <div class="relative">
                        <label
                            for="email"
                            class="mb-1 block text-sm font-semibold text-slate-200"
                        >
                            Email
                        </label>
                        <input
                            id="email"
                            v-model="form.email"
                            type="email"
                            required
                            autofocus
                            autocomplete="username"
                            class="block w-full rounded-xl border border-white/25 bg-white/5 px-4 py-3 text-white placeholder:text-slate-400 outline-none transition focus:border-cyan-400 focus:ring-2 focus:ring-cyan-500/30"
                            placeholder="you@company.com"
                        />
                        <p
                            v-if="form.errors.email"
                            class="mt-1 text-sm text-rose-600"
                        >
                            {{ form.errors.email }}
                        </p>
                    </div>

                    <div>
                        <div class="mb-1 flex items-center justify-between">
                            <label
                                for="password"
                                class="block text-sm font-semibold text-slate-200"
                            >
                                Password
                            </label>
                            <Link
                                v-if="canResetPassword"
                                :href="route('password.request')"
                                class="text-sm font-medium text-cyan-300 hover:text-cyan-200"
                            >
                                Forgot password?
                            </Link>
                        </div>
                        <div class="relative">
                            <input
                                id="password"
                                v-model="form.password"
                                :type="showPassword ? 'text' : 'password'"
                                required
                                autocomplete="current-password"
                                class="block w-full rounded-xl border border-white/25 bg-white/5 px-4 py-3 pr-12 text-white placeholder:text-slate-400 outline-none transition focus:border-cyan-400 focus:ring-2 focus:ring-cyan-500/30"
                                placeholder="Your password"
                            />
                            <button
                                type="button"
                                @click="showPassword = !showPassword"
                                class="absolute right-3 top-1/2 -translate-y-1/2 text-slate-300 hover:text-white"
                                :aria-label="
                                    showPassword
                                        ? 'Hide password'
                                        : 'Show password'
                                "
                            >
                                <svg
                                    v-if="showPassword"
                                    xmlns="http://www.w3.org/2000/svg"
                                    viewBox="0 0 24 24"
                                    fill="none"
                                    stroke="currentColor"
                                    class="h-5 w-5"
                                >
                                    <path
                                        stroke-linecap="round"
                                        stroke-linejoin="round"
                                        stroke-width="1.8"
                                        d="M3 3l18 18M10.58 10.58A2 2 0 0013.42 13.42M9.88 5.09A10.94 10.94 0 0112 4.89c5.05 0 8.27 4.22 9 6.11a11.8 11.8 0 01-3.08 4.35M6.61 6.61C4.7 8 3.51 9.87 3 11c.73 1.89 3.95 6.11 9 6.11 1.53 0 2.89-.39 4.09-1.01"
                                    />
                                </svg>
                                <svg
                                    v-else
                                    xmlns="http://www.w3.org/2000/svg"
                                    viewBox="0 0 24 24"
                                    fill="none"
                                    stroke="currentColor"
                                    class="h-5 w-5"
                                >
                                    <path
                                        stroke-linecap="round"
                                        stroke-linejoin="round"
                                        stroke-width="1.8"
                                        d="M2.46 12C3.73 8.9 7.15 6 12 6s8.27 2.9 9.54 6c-1.27 3.1-4.69 6-9.54 6s-8.27-2.9-9.54-6z"
                                    />
                                    <circle
                                        cx="12"
                                        cy="12"
                                        r="3"
                                        stroke-width="1.8"
                                    />
                                </svg>
                            </button>
                        </div>
                        <p
                            v-if="form.errors.password"
                            class="mt-1 text-sm text-rose-600"
                        >
                            {{ form.errors.password }}
                        </p>
                    </div>

                    <label
                        class="inline-flex cursor-pointer items-center gap-2 text-sm text-slate-300"
                    >
                        <input
                            v-model="form.remember"
                            type="checkbox"
                            name="remember"
                            class="h-4 w-4 rounded border-slate-300 text-cyan-600 focus:ring-cyan-500"
                        />
                        Remember me
                    </label>

                    <button
                        type="submit"
                        :disabled="form.processing"
                        class="inline-flex w-full items-center justify-center rounded-xl bg-slate-900 px-4 py-3 text-sm font-bold text-white transition hover:bg-slate-800 disabled:cursor-not-allowed disabled:opacity-70"
                    >
                        {{ form.processing ? "Signing in..." : "Sign in" }}
                    </button>

                    <p class="text-center text-sm text-slate-600">
                        New to the starter?
                        <Link
                            :href="route('register')"
                            class="font-semibold text-cyan-300 hover:text-cyan-200"
                        >
                            Register account
                        </Link>
                    </p>
                </form>
            </section>
        </div>
    </div>
</template>
