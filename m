Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2R9PPPP001420
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 05:25:25 -0400
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Laurent Bigonville <bigon@debian.org>
Subject: Re: [PATCH 1/2] libselinux -- Hide unnecessarily-exported library destructors
Date: Tue, 27 Mar 2012 20:25:19 +1100
Cc: selinux@tycho.nsa.gov
References: <20120326204549.1127d58b@fornost.bigon.be>
In-Reply-To: <20120326204549.1127d58b@fornost.bigon.be>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201203272025.19712.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 27 Mar 2012, Laurent Bigonville <bigon@debian.org> wrote:
> Description: Hide unnecessarily-exported library destructors
>  This change was extracted from the old monolithic Debian patch.  I have
> not been able to find an explanation for why it is needed, but it should
> be forwarded upstream for review.
>  .
> Author: Unknown

This is needed because the Debian build system whinges when the list of 
exports changes.  There was never a need to have them exported so it was best 
to just make them hidden.

I think I wrote the patch in question.

> ---
> Forwarded: no
> Last-Update: 2011-10-13
> 
> --- a/libselinux/src/matchpathcon.c
> +++ b/libselinux/src/matchpathcon.c
> @@ -291,7 +291,7 @@ static void matchpathcon_thread_destruct
>  	matchpathcon_fini();
>  }
> 
> -void __attribute__((destructor)) matchpathcon_lib_destructor(void)
> +void hidden __attribute__((destructor)) matchpathcon_lib_destructor(void)
>  {
>  	if (destructor_key_initialized)
>  		__selinux_key_delete(destructor_key);
> --- libselinux-2.1.0.orig/src/setrans_client.c
> +++ libselinux-2.1.0/src/setrans_client.c
> @@ -253,7 +253,7 @@ static void setrans_thread_destructor(vo
>  	free(prev_r2c_raw);
>  }
> 
> -void __attribute__((destructor)) setrans_lib_destructor(void)
> +void hidden __attribute__((destructor)) setrans_lib_destructor(void)
>  {
>  	if (destructor_key_initialized)
>  		__selinux_key_delete(destructor_key);
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with the words "unsubscribe selinux" without quotes as the message.


-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
