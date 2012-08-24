Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7OILCOQ001108
	for <selinux@tycho.nsa.gov>; Fri, 24 Aug 2012 14:21:13 -0400
Received: by qcpx40 with SMTP id x40so1673540qcp.12
        for <selinux@tycho.nsa.gov>; Fri, 24 Aug 2012 11:21:11 -0700 (PDT)
Message-ID: <1345832469.4436.3.camel@localhost>
Subject: Re: [PATCH] libselinux: Only call regfree if regcomp was previously
 called on the regex
From: Eric Paris <eparis@parisplace.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
Date: Fri, 24 Aug 2012 14:21:09 -0400
In-Reply-To: <1345829597.21071.25.camel@moss-pluto.epoch.ncsc.mil>
References: <1345829597.21071.25.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Found the same bug moving to the PCRE implementation.  Its in my devel
tree and I'll get it upstream.

-Eric

On Fri, 2012-08-24 at 13:33 -0400, Stephen Smalley wrote:
> Only call regfree if regcomp was previously called on the regex.
> 
> We discovered this bug in SE Android when bionic switched to the current
> NetBSD regex implementation, which triggers an assertion on an attempt
> to call regfree() on a regex that was not initialized via regcomp().
> Apparently the prior bionic regex implementation and the glibc one are
> more forgiving, but this seems to be a legitimate bug in libselinux that
> should be fixed in general.
> 
> ---
>  libselinux/src/label_file.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 7bc46cc..8bf9bc4 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -575,7 +575,8 @@ static void closef(struct selabel_handle *rec)
>  		free(spec->type_str);
>  		free(spec->lr.ctx_raw);
>  		free(spec->lr.ctx_trans);
> -		regfree(&spec->regex);
> +		if (spec->regcomp)
> +			regfree(&spec->regex);
>  	}
>  
>  	for (i = 0; i < (unsigned int)data->num_stems; i++) {
> -- 
> 1.7.11.2
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
