### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 86f770fe-74a1-11eb-01f7-5b3ecf057124
begin
	using PlutoUI 
	using Images
	using Unitful 
	using ImageFiltering
end

# ╔═╡ 8d389d80-74a1-11eb-3452-f38eff03483b
PlutoUI.TableOfContents(aside=true)

# ╔═╡ f7689472-74a8-11eb-32a1-8379ae5c88e1
rotabook = load(download("https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1348902666l/1646354.jpg"))

# ╔═╡ 0f2f9004-74a8-11eb-01a2-973dbe80f166
md"""
 **Never run overtime**

Running overtime is the one unforgivable error a lecturer can make.
After fifty minutes (one microcentury as von Neumann used to say)
everybody's attention will turn elsewhere even if we are trying to prove
the Riemann hypothesis. One minute overtime can destroy the best of
lectures. (from "Indiscrete Thoughts" by Rota, Chpt 18, 10 Lessons I Wish I Had Been Taught)
"""

# ╔═╡ 962143a8-74a7-11eb-26c3-c10548f326ee
century = 100u"yr"

# ╔═╡ b76a56f4-74a9-11eb-1739-fbfc5e4958e8

uconvert(u"minute", century * 1e-6 )


# ╔═╡ 2f7cde78-74a2-11eb-1e2f-81b5b2465819
md"""
# Remember
"""

# ╔═╡ e099815e-74a1-11eb-1541-033f6abe9f8e
md"""
# Chapter 2. Transforming Images
"""

# ╔═╡ e82a4dd8-74b0-11eb-1108-6b09e67a80c1
md"""
## Downsampling / Upsampling
"""

# ╔═╡ 14f2b85e-74ad-11eb-2682-d9de646aedf3
pixelated_corgi = load(download("https://i.redd.it/99lhfbnwpgd31.png"))

# ╔═╡ dd8180f6-74ae-11eb-007e-a1184c0e7319
downsampled_corgi = pixelated_corgi[1:9:end, 1:9:end]

# ╔═╡ 998fe88c-74af-11eb-3cae-d7b1ddfc4f07
upsampled_downsampled_corgi = kron(downsampled_corgi, ones(9,9))

# ╔═╡ d8a531f8-74af-11eb-19a2-a5f05566eb09
imfilter(downsampled_corgi, fill(1/9,3,3))

# ╔═╡ f48c4ece-74af-11eb-3fdc-b70e6263508b


# ╔═╡ 34b1504c-74ad-11eb-39f4-7bb8fbf021df
size(pixelated_corgi)

# ╔═╡ f3d177c2-74ad-11eb-23e4-3391ddcb245d
#kernel = Kernel.gaussian((6, 6))
kernel = fill(1/16,4,4)

# ╔═╡ 339ccfca-74b1-11eb-0c35-774da6b189ed
md"""
## Combining Images
"""

# ╔═╡ 91a1bca4-74aa-11eb-3917-1dfd73d0ad9c
corgis = load(download("https://user-images.githubusercontent.com/6933510/108605549-fb28e180-73b4-11eb-8520-7e29db0cc965.png"))

# ╔═╡ 13298e68-74ac-11eb-16fc-f56287e7c931
kron( corgis, [1 1;1 1])

# ╔═╡ 9ce0b980-74aa-11eb-0678-01209451fb65
upsidedown_corgis = corgis[ end:-1:1 , :]

# ╔═╡ 447e7c9e-74b1-11eb-27ea-71aa4338b11a
(upsidedown_corgis./2 .+ corgis./2) 

# ╔═╡ aa541288-74aa-11eb-1edc-ab6d7786f271
    @bind α Slider(0:.01:1 , show_value=true, default = 1.0)

# ╔═╡ c9dcac48-74aa-11eb-31a6-23357180c1c8
α .* corgis .+ (1-α) .* upsidedown_corgis

# ╔═╡ 215291ec-74a2-11eb-3476-0dab43fd5a5e
md"""
## Section 2.3 Fun with Photoshop
"""

# ╔═╡ cdd4cffc-74b1-11eb-1aa4-e333cb8601d1
md"""
Let's play with photoshop if for no other reason, let's see what image transformations are available considered useful by the pros.
"""

# ╔═╡ 7489a570-74a3-11eb-1d0b-09d41604ffe1
md"""
## Section 2.4. Image Filtering (convolutions)
"""

# ╔═╡ 8a8e3f5e-74b2-11eb-3eed-e5468e573e45
md"""
Last semester Grant Sanderson (3Blue1Brown) lectured in this course.  This lecture on convolutions in image processing was popular.  Let's watch an excerpt (from 1:04 to 2:48)
"""

# ╔═╡ 5864294a-74a5-11eb-23ef-f38a582f2c2d
html"""
<div notthestyle="position: relative; right: 0; top: 0; z-index: 300;"><iframe src="https://www.youtube.com/embed/8rrHTtUzyZA?start=64&end=168" width=400 height=250  frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></div>
"""

# ╔═╡ fa9c465e-74b2-11eb-2f3c-4be0e7f93bb5
md"""
### Definition of convolutions and kernels
"""

# ╔═╡ 4fab4616-74b0-11eb-0088-6b50237d7d54
md"""
Wikipedia Page on Kernels:
<https://en.wikipedia.org/wiki/Kernel_(image_processing)#Details>
"""

# ╔═╡ 275bf7ac-74b3-11eb-32c3-cda1e4f1f8c2
md"""
### Computer Science: Complexity

The number of multiplications = (Number of Pixels in the Image) * (Number of Cells in the kernel)
"""

# ╔═╡ 537c54e4-74b3-11eb-341f-951b4a1e0b40
md"""
Thought Problem: Why are small kernels better than large kernels?
"""

# ╔═╡ 662d73b6-74b3-11eb-333d-f1323a001000
md"""
Computer Science: Data Structure: Offset Arrays
"""

# ╔═╡ 844ed844-74b3-11eb-2ee1-2de664b26bc6
md"""
  ### Gaussian Filter
"""

# ╔═╡ 4ffe927c-74b4-11eb-23a7-a18d7e51c75b
md"""
In our next Grant Sanderson segment from Fall 2020 (4:35 to 7:00), we hear about
convolving images with a Gaussian kernel.  
"""

# ╔═╡ 91109e5c-74b3-11eb-1f31-c50e436bc6e0
html"""
<div notthestyle="position: relative; right: 0; top: 0; z-index: 300;"><iframe src="https://www.youtube.com/embed/8rrHTtUzyZA?start=275&end=420" width=400 height=250  frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></div>
"""

# ╔═╡ a875024e-74a3-11eb-06ae-5d9f4895d3f1
md"""
## a little cs = the complexity (number of pixels) * (size of kernel)
## boundaries
## blurring = integrals, edge detection = derivatives (might say something about 1d)
"""

# ╔═╡ Cell order:
# ╠═86f770fe-74a1-11eb-01f7-5b3ecf057124
# ╠═8d389d80-74a1-11eb-3452-f38eff03483b
# ╟─f7689472-74a8-11eb-32a1-8379ae5c88e1
# ╟─0f2f9004-74a8-11eb-01a2-973dbe80f166
# ╠═962143a8-74a7-11eb-26c3-c10548f326ee
# ╠═b76a56f4-74a9-11eb-1739-fbfc5e4958e8
# ╠═2f7cde78-74a2-11eb-1e2f-81b5b2465819
# ╠═e099815e-74a1-11eb-1541-033f6abe9f8e
# ╠═e82a4dd8-74b0-11eb-1108-6b09e67a80c1
# ╠═14f2b85e-74ad-11eb-2682-d9de646aedf3
# ╠═dd8180f6-74ae-11eb-007e-a1184c0e7319
# ╠═998fe88c-74af-11eb-3cae-d7b1ddfc4f07
# ╠═d8a531f8-74af-11eb-19a2-a5f05566eb09
# ╠═f48c4ece-74af-11eb-3fdc-b70e6263508b
# ╠═34b1504c-74ad-11eb-39f4-7bb8fbf021df
# ╠═f3d177c2-74ad-11eb-23e4-3391ddcb245d
# ╠═339ccfca-74b1-11eb-0c35-774da6b189ed
# ╠═13298e68-74ac-11eb-16fc-f56287e7c931
# ╠═91a1bca4-74aa-11eb-3917-1dfd73d0ad9c
# ╠═9ce0b980-74aa-11eb-0678-01209451fb65
# ╠═447e7c9e-74b1-11eb-27ea-71aa4338b11a
# ╠═aa541288-74aa-11eb-1edc-ab6d7786f271
# ╠═c9dcac48-74aa-11eb-31a6-23357180c1c8
# ╠═215291ec-74a2-11eb-3476-0dab43fd5a5e
# ╠═cdd4cffc-74b1-11eb-1aa4-e333cb8601d1
# ╠═7489a570-74a3-11eb-1d0b-09d41604ffe1
# ╟─8a8e3f5e-74b2-11eb-3eed-e5468e573e45
# ╠═5864294a-74a5-11eb-23ef-f38a582f2c2d
# ╠═fa9c465e-74b2-11eb-2f3c-4be0e7f93bb5
# ╠═4fab4616-74b0-11eb-0088-6b50237d7d54
# ╠═275bf7ac-74b3-11eb-32c3-cda1e4f1f8c2
# ╠═537c54e4-74b3-11eb-341f-951b4a1e0b40
# ╠═662d73b6-74b3-11eb-333d-f1323a001000
# ╠═844ed844-74b3-11eb-2ee1-2de664b26bc6
# ╠═4ffe927c-74b4-11eb-23a7-a18d7e51c75b
# ╠═91109e5c-74b3-11eb-1f31-c50e436bc6e0
# ╠═a875024e-74a3-11eb-06ae-5d9f4895d3f1