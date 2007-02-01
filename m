Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l11LMZ1k022051
	for <selinux@tycho.nsa.gov>; Thu, 1 Feb 2007 16:22:35 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l11LNc4I000375
	for <selinux@tycho.nsa.gov>; Thu, 1 Feb 2007 21:23:39 GMT
Message-ID: <45C25A4D.6020303@mentalrootkit.com>
Date: Thu, 01 Feb 2007 16:23:25 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: "Todd C. Miller" <Todd.Miller@sparta.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: PATCH: libselinux matchpathcon() memory leak
References: <200701252359.l0PNx74K030679@tex.courtesan.com>
In-Reply-To: <200701252359.l0PNx74K030679@tex.courtesan.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Todd C. Miller wrote:
> This is a patch I sent in last year but forgot to split up as
> requested; it still applies to the recently-released selinux-1.34.0.
> 
> This patch adds a finish: label and ret variable that holds the
> function return value.  Instead of returning early we just goto
> finish and let it clean things up as needed.  This does assume that
> free(NULL) is valid but that as been the case since C89.
> 
>  - todd
> 

Acked-by: Karl MacMillan <kmacmillan@mentalrootkit.com> and merged into 
trunk and stable.

> --- matchpathcon.c	2006-06-29 14:21:04.000000000 -0400
> +++ matchpathcon.c	2007-01-25 14:19:39.000000000 -0500
> @@ -443,11 +443,13 @@
>  static int process_line(const char *path, const char *prefix, char *line_buf,
>  			int pass, unsigned lineno)
>  {
> -	int items, len, regerr;
> +	int items, len, regerr, ret;
>  	char *buf_p;
>  	char *regex, *type, *context;
>  	const char *reg_buf;
>  	char *anchored_regex;
> +
> +	ret = 0;
>  	len = strlen(line_buf);
>  	if (line_buf[len - 1] == '\n')
>  		line_buf[len - 1] = 0;
> @@ -464,19 +466,15 @@
>  		return 0;
>  	} else if (items == 2) {
>  		/* The type field is optional. */
> -		free(context);
>  		context = type;
> -		type = 0;
> +		type = NULL;
>  	}
>  
>  	reg_buf = regex;
>  	len = get_stem_from_spec(reg_buf);
>  	if (len && prefix && strncmp(prefix, regex, len)) {
>  		/* Stem of regex does not match requested prefix, discard. */
> -		free(regex);
> -		free(type);
> -		free(context);
> -		return 0;
> +		goto finish;
>  	}
>  
>  	if (pass == 1) {
> @@ -488,8 +486,10 @@
>  		/* Anchor the regular expression. */
>  		len = strlen(reg_buf);
>  		cp = anchored_regex = malloc(len + 3);
> -		if (!anchored_regex)
> -			return -1;
> +		if (!anchored_regex) {
> +			ret = -1;
> +			goto finish;
> +		}
>  		/* Create ^...$ regexp.  */
>  		*cp++ = '^';
>  		cp = mempcpy(cp, reg_buf, len);
> @@ -515,7 +515,7 @@
>  				 path, lineno, anchored_regex,
>  				 (errbuf ? errbuf : "out of memory"));
>  			free(anchored_regex);
> -			return 0;
> +			goto finish;
>  		}
>  		free(anchored_regex);
>  
> @@ -528,7 +528,7 @@
>  		if (type[0] != '-' || len != 2) {
>  			myprintf("%s:  line %d has invalid file type %s\n",
>  				 path, lineno, type);
> -			return 0;
> +			goto finish;
>  		}
>  		switch (type[1]) {
>  		case 'b':
> @@ -555,7 +555,7 @@
>  		default:
>  			myprintf("%s:  line %d has invalid file type %s\n",
>  				 path, lineno, type);
> -			return 0;
> +			goto finish;
>  		}
>  
>  	      skip_type:
> @@ -564,11 +564,11 @@
>  				if (myinvalidcon) {
>  					/* Old-style validation of context. */
>  					if (myinvalidcon(path, lineno, context))
> -						return 0;
> +						goto finish;
>  				} else {
>  					/* New canonicalization of context. */
>  					if (mycanoncon(path, lineno, &context))
> -						return 0;
> +						goto finish;
>  				}
>  				spec_arr[nspec].context_valid = 1;
>  			}
> @@ -579,16 +579,19 @@
>  		/* Determine if specification has 
>  		 * any meta characters in the RE */
>  		spec_hasMetaChars(&spec_arr[nspec]);
> +
> +		/* Prevent stored strings from being freed. */
> +		regex = NULL;
> +		type = NULL;
> +		context = NULL;
>  	}
>  
>  	nspec++;
> -	if (pass == 0) {
> -		free(regex);
> -		if (type)
> -			free(type);
> -		free(context);
> -	}
> -	return 0;
> +finish:
> +	free(regex);
> +	free(type);
> +	free(context);
> +	return ret;
>  }
>  
>  int matchpathcon_init_prefix(const char *path, const char *prefix)
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
