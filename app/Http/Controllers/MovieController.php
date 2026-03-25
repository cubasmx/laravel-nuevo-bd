<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class MovieController extends Controller
{
    public function index()
    {
        return response()->json(\App\Models\Movie::all());
    }

    public function store(\Illuminate\Http\Request $request)
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'director' => 'required|string|max:255',
            'year' => 'required|integer',
            'synopsis' => 'nullable|string',
        ]);

        $movie = \App\Models\Movie::create($validated);

        return response()->json($movie, 201);
    }

    public function show(string $id)
    {
        $movie = \App\Models\Movie::find($id);

        if (!$movie) {
            return response()->json(['message' => 'PELICULA NO ENCONTRADA :('], 404);
        }

        return response()->json($movie);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
