Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o11GaPML028731
	for <selinux@tycho.nsa.gov>; Mon, 1 Feb 2010 11:36:25 -0500
Received: from hostingsmtp.register.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o11GaRYO021810
	for <selinux@tycho.nsa.gov>; Mon, 1 Feb 2010 16:36:28 GMT
Message-Id: <201002011636.o11GaLtC008179@vivaldi16.register.it>
From: "Guido Trentalancia" <guido@trentalancia.com>
Reply-To: "Guido Trentalancia" <guido@trentalancia.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, eparis@parisplace.org, jmorris@namei.org
Subject: Re: [PATCH] Allowing MLS->non-MLS and vice versa upon policy reload
Date: Mon, 01 Feb 2010 17:36:21 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Excellent Stephen, very timely !

I am now going to make the necessary amendments and then I will post a proposed final patch that you can eventually review again or otherwise just add an Acked-by or Reviewed-by line and I will forward it to the kernel mailing list.

Of course comments from other list members are always welcome.

A few notes on your comments...

> Avoid adding extern declarations to .c files - they are
> discouraged. The current code isn't pristine in this
> regard, but let's not make it worse.

You are right, I did check with checkpatch.pl, but because selinuxfs.c hasn't got its own header file, I wasn't sure on how to deal with the warning. Shall I create an header file specifically for it or otherwise try to reuse other global header files ?

> I wouldn't take these functions to their own .c file, and 
> if you do so, then "inline" no longer makes sense.  But 
> why did you do so?  It will add overhead to make them 
> out-of-line with no obvious benefit.

I was getting compilation errors. Perhaps you can give it a try.

> This seems inconsistent with the other functions - here 
> you pass the policydb as an argument rather than just 
> using the active policydb. If that were truly necessary, 
> I'd argue for passing the policydb to all of the 
> functions for consistency.  But I think in fact that we 
> can drop this !mls_enabled check altogether, given that 
> the context is fully initialized by context_init() and 
> thus the ebitmap_destroy() calls should be safe 
> regardless of whether or not MLS is enabled.

The policydb being passed to the modified functions is not necessarily the same as the active policy. Otherwise there was no point of making the modifications. To be more precise, consider the code-paths from security_load_policy() when you need to destroy the old policy and the old sidtab which are no longer active !
So, shall I remove completely the check ? That would make mls_context_destroy() execute even for standard policies...

> Same deal - don't take these to their own .c file without 
> justification.

As already explained, I moved those functions to a separate .c file because there were compilation error (gcc 4.4.1).

> Is that supposed to be "n" aka newline rather than just 
> "n"?

Yes, of course "n". It's weird because if you look at the attached file, everything is normal ! Something went wrong with the "cut-n-paste" from gedit to Mozilla, I shall probably file a bug report !...

That's it for the moment. I'll be back in a short while, after the patch has been amended.

Best regards,

Guido 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
