Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA15032
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 09:28:59 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA16856
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 13:27:26 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id NAA16852 for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 13:27:23 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Frank Mayer" <mayerf@tresys.com>, "Brian May" <bam@snoopy.apana.org.au>
Subject: Re: Policy changes for policy management
Date: Fri, 26 Jul 2002 15:28:40 +0200
Cc: "NSA Selinux Mailinglist" <selinux@tycho.nsa.gov>
References: <ACEHIKGIGFEDAIKEMMMIIEPGKEAA.mayerf@tresys.com>
In-Reply-To: <ACEHIKGIGFEDAIKEMMMIIEPGKEAA.mayerf@tresys.com>
MIME-Version: 1.0
Message-Id: <20020726132841.53B8D18F@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 26 Jul 2002 15:02, Frank Mayer wrote:
> > Another suggestion (which you may not like): Make the Makefile
> > executeable by putting "#!/usr/bin/make -f" at the top, and use this
> > to trigger the domain transition.
>
> The problem with this is that we don't want the checkpolicy_t domain able
> to execute arbitrary programs.  With the above suggestions, we have to give
> checkpolicy execute access to bin_t and shells, which essentially means we
> provided no isolated domain.  We're already stuck with this problem for
> writing policy_src_t when using make.  It would be nice if we can avoid
> this
> problem for write access to policy_config_t.

zlib is not too difficult to code for.  It's probably less than an hour's 
work to add zlib support to checkpolicy...  Yes, I'll do it myself eventually 
if no-one else does.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
