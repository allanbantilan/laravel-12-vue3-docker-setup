<?php

namespace App\Http\Controllers;

use Inertia\Inertia;

class HomeController extends Controller
{
    public function index()
    {
        return Inertia::render('Home', [
            'canLogin' => true,
            'canRegister' => true,
            'appName' => config('app.name', 'StarterKit'),
        ]);
    }
}
