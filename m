Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA28693
	for <selinux@tycho.nsa.gov>; Mon, 12 Aug 2002 10:32:13 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA05377
	for <selinux@tycho.nsa.gov>; Mon, 12 Aug 2002 14:31:14 GMT
Received: from blackbird.intercode.com.au (blackbird.intercode.com.au [203.32.101.10])
	by jazzswing.ncsc.mil  with ESMTP id OAA05365
	for <selinux@tycho.nsa.gov>; Mon, 12 Aug 2002 14:31:11 GMT
Date: Tue, 13 Aug 2002 00:31:51 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: depmod errors
In-Reply-To: <20020811025800.5E7AE8637@lyta.coker.com.au>
Message-ID: <Mutt.LNX.4.44.0208130031040.8983-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 11 Aug 2002, Russell Coker wrote:

> I've got a depmod error building 2.4.19 with the latest patch when I enabled 
> labelled networking.
> 
> root@test:/usr/src# depmod -a -e
> depmod: *** Unresolved symbols in 
> /lib/modules/2.4.19lsm/kernel/security/selinux/selopt/selopt.o
> depmod:         nsid_register_ops
> depmod:         nsid_unregister_ops
> root@test:/usr/src#
> 
> I've attached my .config.
> 

It should be working.  What happens if you boot into the kernel, then 
manually insmod selopt.o?  (may provide more information).

- James
-- 
James Morris
<jmorris@intercode.com.au>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
