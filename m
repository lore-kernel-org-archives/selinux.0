Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id AAA03969
	for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 00:26:06 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id EAA04908
	for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 04:24:36 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id EAA04904 for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 04:24:33 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: currupt policy.11 file
Date: Mon, 15 Jul 2002 06:25:51 +0200
References: <20020715014333.GA17075@snoopy.apana.org.au>
In-Reply-To: <20020715014333.GA17075@snoopy.apana.org.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <20020715042551.A39C7424F@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 15 Jul 2002 03:43, you wrote:
> I accidently currupted my policy.11 file, probably by loading it before
> it had been fully written (yes, stupid thing to do).
>
> Anyway, the effect of this was my computer promptly crashed.
> By this I mean it was running extremely slowly, and eventually
> refused to respond to any user input.

Should have a checksum or something.

> So I rebooted it.
>
> It tried to load the currupted policy and crashed again.
>
> If I left it a while the kernel complained it was out of memory,
> and it had no processes it could kill.
>
> So I suspect there might be a bug somewhere...
>
> I had to boot from an old kernel without SE-Linux support to rectify
> the problem.
>
> Anyway, is there anyway to boot a computer without loading a faulty
> policy?

Boot a non-SE kernel, or a SE kernel that uses an older version of the 
policydb.

> Actually, this might still be a problem, because you can't login
> without a policy present, but I guess at least you should be able to
> boot with init=/bin/sh.

Unless you have a policydb in an initrd and boot using that...

> I still have a copy of this bad policy.11 file if you want a copy.


You are probably better off sending such messages to the list direct...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
