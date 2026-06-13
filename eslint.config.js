import js from "@eslint/js";
import pluginVue from "eslint-plugin-vue";
import { defineConfig } from "eslint/config";

export default defineConfig([
    js.configs.recommended,
    ...pluginVue.configs["flat/recommended"],
    {
        rules: {
            "vue/multi-word-component-names": "off",
            "vue/no-v-html": "off",
            "no-unused-vars": "warn",
            "vue/html-indent": ["warn", 4],
            "vue/max-attributes-per-line": "off",
        },
        languageOptions: {
            globals: {
                window: "readonly",
                document: "readonly",
                navigator: "readonly",
                process: "readonly",
                __dirname: "readonly",
            },
        },
    },
]);
