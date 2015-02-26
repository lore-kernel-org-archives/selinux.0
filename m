Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t1QGQnWF011519
 for <selinux@tycho.nsa.gov>; Thu, 26 Feb 2015 11:26:50 -0500
Message-ID: <54EF493B.9020003@tresys.com>
Date: Thu, 26 Feb 2015 11:26:35 -0500
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Thomas Hurd <thurd@tresys.com>, <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] libsemanage: Change bunzip to use heap instead of stack
 for buffer.
References: <1424959400-22134-1-git-send-email-thurd@tresys.com>
In-Reply-To: <1424959400-22134-1-git-send-email-thurd@tresys.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/26/2015 09:03 AM, Thomas Hurd wrote:
> Fixes segfault on systems with less than 256K stack size.
> After change, I was able to run semodule -l with a 32K stack size.
> Additionally, fix potential memory leak on realloc failure.
> 
> Signed-off-by: Thomas Hurd <thurd@tresys.com>

Acked-by: Steve Lawrence <slawrence@tresys.com>

Thanks!

> ---
>  libsemanage/src/direct_api.c | 61 ++++++++++++++++++++++++++++++++------------
>  1 file changed, 44 insertions(+), 17 deletions(-)
> 
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index b0ed338..be6bd3c 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -428,49 +428,76 @@ static ssize_t bzip(semanage_handle_t *sh, const char *filename, char *data,
>   * in the file.  Returns -1 if file could not be decompressed. */
>  ssize_t bunzip(semanage_handle_t *sh, FILE *f, char **data)
>  {
> -	BZFILE* b;
> +	BZFILE* b = NULL;
>  	size_t  nBuf;
> -	char    buf[1<<18];
> -	size_t  size = sizeof(buf);
> +	char*   buf = NULL;
> +	size_t  size = 1<<18;
> +	size_t  bufsize = size;
>  	int     bzerror;
>  	size_t  total=0;
> +	char*   uncompress = NULL;
> +	char*   tmpalloc = NULL;
> +	int     ret = -1;
> +
> +	buf = malloc(bufsize);
> +	if (buf == NULL) {
> +		ERR(sh, "Failure allocating memory.");
> +		goto exit;
> +	}
>  
>  	if (!sh->conf->bzip_blocksize) {
>  		bzerror = fread(buf, 1, BZ2_MAGICLEN, f);
>  		rewind(f);
> -		if ((bzerror != BZ2_MAGICLEN) || memcmp(buf, BZ2_MAGICSTR, BZ2_MAGICLEN))
> -			return -1;
> +		if ((bzerror != BZ2_MAGICLEN) || memcmp(buf, BZ2_MAGICSTR, BZ2_MAGICLEN)) {
> +			ERR(sh, "bz2 magic number not found.");
> +			goto exit;
> +		}
>  		/* fall through */
>  	}
>  	
>  	b = BZ2_bzReadOpen ( &bzerror, f, 0, sh->conf->bzip_small, NULL, 0 );
>  	if ( bzerror != BZ_OK ) {
> -		BZ2_bzReadClose ( &bzerror, b );
> -		return -1;
> +		ERR(sh, "Failure opening bz2 archive.");
> +		goto exit;
>  	}
> -	
> -	char *uncompress = realloc(NULL, size);
> -	
> +
> +	uncompress = malloc(size);
> +	if (uncompress == NULL) {
> +		ERR(sh, "Failure allocating memory.");
> +		goto exit;
> +	}
> +
>  	while ( bzerror == BZ_OK) {
> -		nBuf = BZ2_bzRead ( &bzerror, b, buf, sizeof(buf));
> +		nBuf = BZ2_bzRead ( &bzerror, b, buf, bufsize);
>  		if (( bzerror == BZ_OK ) || ( bzerror == BZ_STREAM_END )) {
>  			if (total + nBuf > size) {
>  				size *= 2;
> -				uncompress = realloc(uncompress, size);
> +				tmpalloc = realloc(uncompress, size);
> +				if (tmpalloc == NULL) {
> +					ERR(sh, "Failure allocating memory.");
> +					goto exit;
> +				}
> +				uncompress = tmpalloc;
>  			}
>  			memcpy(&uncompress[total], buf, nBuf);
>  			total += nBuf;
>  		}
>  	}
>  	if ( bzerror != BZ_STREAM_END ) {
> -		BZ2_bzReadClose ( &bzerror, b );
> -		free(uncompress);
> -		return -1;
> +		ERR(sh, "Failure reading bz2 archive.");
> +		goto exit;
>  	}
> -	BZ2_bzReadClose ( &bzerror, b );
>  
> +	ret = total;
>  	*data = uncompress;
> -	return  total;
> +
> +exit:
> +	BZ2_bzReadClose ( &bzerror, b );
> +	free(buf);
> +	if ( ret < 0 ) {
> +		free(uncompress);
> +	}
> +	return ret;
>  }
>  
>  /* mmap() a file to '*data',
> 
