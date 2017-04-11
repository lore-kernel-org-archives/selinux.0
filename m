Message-ID: <1491935852.14576.7.camel@tycho.nsa.gov>
Subject: Re: [PATCH 3/6] libselinux: make process_boolean() fail on invalid
 lines
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
Date: Tue, 11 Apr 2017 14:37:32 -0400
In-Reply-To: <20170407204431.8572-3-nicolas.iooss@m4x.org>
References: <20170407204431.8572-1-nicolas.iooss@m4x.org>
 <20170407204431.8572-3-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-04-07 at 22:44 +0200, Nicolas Iooss wrote:
> When security_load_booleans() calls process_boolean() to parse a
> boolean
> definition, process_boolean() returns a successful value when it
> fails
> to use strtok_r() (e.g. when there is no "=" in the parsed line).
> This
> leads security_load_booleans() to use uninitialized name and/or val
> when
> setting the boolean into the policy.
> 
> This issue has been found using clang's static analyzer and is
> similar
> to the one which has been fixed in libsepol with commit 76f8c04c197f
> ("libsepol: make process_boolean() fail on invalid lines"). Fix it in
> the same way.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Merging this one but just for reference, I think this code (and the
corresponding libsepol code) is all legacy at this point.  I'd kill it
except it would be an ABI break.

> ---
>  libselinux/src/booleans.c | 58 ++++++++++++++++++++++++++++---------
> ----------
>  1 file changed, 35 insertions(+), 23 deletions(-)
> 
> diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
> index ba9d9348e2c7..49452756ffb2 100644
> --- a/libselinux/src/booleans.c
> +++ b/libselinux/src/booleans.c
> @@ -342,30 +342,42 @@ static int process_boolean(char *buffer, char
> *name, int namesize, int *val)
>  {
>  	char name1[BUFSIZ];
>  	char *ptr = NULL;
> -	char *tok = strtok_r(buffer, "=", &ptr);
> -	if (tok) {
> -		strncpy(name1, tok, BUFSIZ - 1);
> -		strtrim(name, name1, namesize - 1);
> -		if (name[0] == '#')
> -			return 0;
> -		tok = strtok_r(NULL, "\0", &ptr);
> -		if (tok) {
> -			while (isspace(*tok))
> -				tok++;
> -			*val = -1;
> -			if (isdigit(tok[0]))
> -				*val = atoi(tok);
> -			else if (!strncasecmp(tok, "true",
> sizeof("true") - 1))
> -				*val = 1;
> -			else if (!strncasecmp
> -				 (tok, "false", sizeof("false") -
> 1))
> -				*val = 0;
> -			if (*val != 0 && *val != 1) {
> -				errno = EINVAL;
> -				return -1;
> -			}
> +	char *tok;
>  
> -		}
> +	/* Skip spaces */
> +	while (isspace(buffer[0]))
> +		buffer++;
> +	/* Ignore comments */
> +	if (buffer[0] == '#')
> +		return 0;
> +
> +	tok = strtok_r(buffer, "=", &ptr);
> +	if (!tok) {
> +		errno = EINVAL;
> +		return -1;
> +	}
> +	strncpy(name1, tok, BUFSIZ - 1);
> +	strtrim(name, name1, namesize - 1);
> +
> +	tok = strtok_r(NULL, "\0", &ptr);
> +	if (!tok) {
> +		errno = EINVAL;
> +		return -1;
> +	}
> +
> +	while (isspace(*tok))
> +		tok++;
> +
> +	*val = -1;
> +	if (isdigit(tok[0]))
> +		*val = atoi(tok);
> +	else if (!strncasecmp(tok, "true", sizeof("true") - 1))
> +		*val = 1;
> +	else if (!strncasecmp(tok, "false", sizeof("false") - 1))
> +		*val = 0;
> +	if (*val != 0 && *val != 1) {
> +		errno = EINVAL;
> +		return -1;
>  	}
>  	return 1;
>  }
