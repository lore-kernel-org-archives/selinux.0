Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA17065
	for <selinux@tycho.nsa.gov>; Tue, 6 Aug 2002 10:10:38 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA22851
	for <selinux@tycho.nsa.gov>; Tue, 6 Aug 2002 14:09:44 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id OAA22845
	for <selinux@tycho.nsa.gov>; Tue, 6 Aug 2002 14:09:42 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Chris Wright <chris@wirex.com>
Subject: Re: 2.4.19 lsm kernel patch
Date: Tue, 6 Aug 2002 16:10:11 +0200
Cc: linux-security-module@wirex.com, SE Linux <selinux@tycho.nsa.gov>
References: <20020803134653.A7A9E20B@lyta.coker.com.au> <20020805232805.9511B2F4C@lyta.coker.com.au> <20020805181551.C18583@figure1.int.wirex.com>
In-Reply-To: <20020805181551.C18583@figure1.int.wirex.com>
MIME-Version: 1.0
Message-Id: <20020806141012.499AABC@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 6 Aug 2002 03:15, Chris Wright wrote:
> * Russell Coker (russell@coker.com.au) wrote:
> > Error: ./security/selinux/hooks.o .text.init refers to 000000bf
> > R_386_PC32 .text.exit
>
> The problem was introduced when the netfilter glue was removed from LSM
> after OLS.  The SElinux module_init()  code references the call
> selinux_nf_ip_exit(), which is marked as __exit, meaning it is thrown
> away if the module is compiled statically into the kernel.
>
> I committed the patch below, which fixes the problem.  Thanks for
> pointing this out.

Thanks.

I have just uploaded a new kernel-patch package to Debian and to my site that 
contains this.  I've now got a SE machine running 2.4.19 with it.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
