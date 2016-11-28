Subject: Re: [PATCH 3/5] libsepol: ebitmap: reject loading bitmaps with
 incorrect high bit
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20161123220646.23504-1-nicolas.iooss@m4x.org>
 <20161123220646.23504-3-nicolas.iooss@m4x.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <2727ee63-5c2c-9399-3916-533bc99fa03a@tycho.nsa.gov>
Date: Mon, 28 Nov 2016 09:21:41 -0500
MIME-Version: 1.0
In-Reply-To: <20161123220646.23504-3-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/23/2016 05:06 PM, Nicolas Iooss wrote:
> Currently ebitmap_load() accepts loading a bitmap with highbit=192 and
> one node {startbit=0, map=0x2}. When iterating over the bitmap,
> ebitmap_for_each_bit() is expected to only yield "1" but it gives the
> following bits: 1, 65, 129.
> 
> This is due to two facts in ebitmap_for_each_bit() implementation:
> * ebitmap_next() stays on the first (and only) node of the bitmap
>   instead of stopping the iteration.
> * the end condition of the for loop consists in comparing the bit with
>   ebitmap_length() (ie. the bitmap highbit), which is above the limit of
>   the last node here.
> 
> These are not bugs when the bitmap highbit is equals to
> l->startbit+MAPSIZE, where l is the last node (this is how
> ebitmap_set_bit() sets it). So a simple fix consists in making
> ebitmap_load() reject bitmaps which are loaded with an invalid highbit
> value.
> 
> This issue has been found while fuzzing semodule_package with the
> American Fuzzy Lop.

Thanks, applied

> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsepol/src/ebitmap.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
> index fe8beb879a18..218adc293aae 100644
> --- a/libsepol/src/ebitmap.c
> +++ b/libsepol/src/ebitmap.c
> @@ -453,6 +453,12 @@ int ebitmap_read(ebitmap_t * e, void *fp)
>  
>  		l = n;
>  	}
> +	if (count && l->startbit + MAPSIZE != e->highbit) {
> +		printf
> +		    ("security: ebitmap: hight bit %u has not the expected value %zu\n",
> +		     e->highbit, l->startbit + MAPSIZE);
> +		goto bad;
> +	}
>  
>        ok:
>  	rc = 0;
> 
