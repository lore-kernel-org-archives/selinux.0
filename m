Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vA86x6o2030882
 for <selinux@tycho.nsa.gov>; Wed, 8 Nov 2017 01:59:06 -0500
Received: by mail-pg0-f66.google.com with SMTP id 15so1195994pgc.12
 for <selinux@tycho.nsa.gov>; Tue, 07 Nov 2017 22:59:03 -0800 (PST)
Date: Wed, 8 Nov 2017 14:58:59 +0800
From: Jason Zaman <jason@perfinion.com>
To: Jan Zarsky <jzarsky@redhat.com>
Cc: selinux@tycho.nsa.gov
Message-ID: <20171108065859.GA9205@meriadoc.perfinion.com>
References: <20171106153530.5390-1-jzarsky@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171106153530.5390-1-jzarsky@redhat.com>
Subject: Re: [PATCH] libsemanage: free genhomedircon fallback user
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Nov 06, 2017 at 04:35:30PM +0100, Jan Zarsky wrote:
> Function semanage_genhomedircon() adds fallback user and function
> setup_fallback_user() may add another one. But only one fallback
> user is freed. Make sure to free all fallback users in
> semanage_genhomedircon().
> 
> Signed-off-by: Jan Zarsky <jzarsky@redhat.com>

Looks good to me,
merged, thanks :)
> ---
>  libsemanage/src/genhomedircon.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
> index 27a269ea..d09d82ff 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -1385,7 +1385,9 @@ done:
>  	if (out != NULL)
>  		fclose(out);
>  
> -	pop_user_entry(&(s.fallback));
> +	while (s.fallback)
> +		pop_user_entry(&(s.fallback));
> +
>  	ignore_free();
>  
>  	return retval;
> -- 
> 2.14.3
> 
> 
