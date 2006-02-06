Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k16N3vXf014764
	for <selinux@tycho.nsa.gov>; Mon, 6 Feb 2006 18:03:57 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k16N3shQ003513
	for <selinux@tycho.nsa.gov>; Mon, 6 Feb 2006 23:03:54 GMT
Subject: Re: MCS policy patch
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: russell@coker.com.au
Cc: SELinux List <selinux@tycho.nsa.gov>, Daniel Walsh <dwalsh@redhat.com>
In-Reply-To: <200602040118.10784.russell@coker.com.au>
References: <200602040118.10784.russell@coker.com.au>
Content-Type: text/plain
Date: Mon, 06 Feb 2006 18:04:27 -0500
Message-Id: <1139267067.13925.27.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2006-02-04 at 01:18 +1100, Russell Coker wrote:
> +mlsconstrain process { transition dyntransition } (( h1 dom h2 ) or
> +               ( t1 == getty_t ) or ( t1 == init_t ) or ( t1 == initrc_t ) or
> +               ( t1 == kernel_t ));
> +
> +mlsconstrain process { sigkill sigstop signal } ( h1 dom h2 ) or
> +               ( t1 == init_t ) or ( t1 == initrc_t );

We can't have these hardcoded types.  What we need is similar to how the
mls constraints are handled.  Attributes and interfaces need to be added
to the mls module, then the above domains would use the interfaces to
gain these attributes.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
