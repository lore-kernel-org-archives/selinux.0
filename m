Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA00740
	for <selinux@tycho.nsa.gov>; Thu, 11 Oct 2001 12:43:25 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA25038
	for <selinux@tycho.nsa.gov>; Thu, 11 Oct 2001 16:41:37 GMT
Received: from mrelay.jrc.it (mrelay.jrc.it [139.191.1.65])
	by jazzswing.ncsc.mil  with ESMTP id QAA25028
	for <selinux@tycho.nsa.gov>; Thu, 11 Oct 2001 16:41:35 GMT
Received: from mrelay.jrc.it (localhost [127.0.0.1])
	by mrelay.jrc.it (LMC5614B) with ESMTP id f9BGhKs25435
	for <selinux@tycho.nsa.gov>; Thu, 11 Oct 2001 18:43:20 +0200 (MEST)
Received: from isis-ms.sti.jrc.it (isis-gs.sti.jrc.it [139.191.8.244])
	by mrelay.jrc.it (LMC5614A) with ESMTP id f9BGhJs25431
	for <selinux@tycho.nsa.gov>; Thu, 11 Oct 2001 18:43:19 +0200 (MEST)
Message-ID: <3BC5CC23.60303@jrc.it>
Date: Thu, 11 Oct 2001 18:43:15 +0200
From: "James Bishop" <james.bishop@jrc.it>
MIME-Version: 1.0
To: Stephen Smalley <sds@tislabs.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Compiling for SuSE 7.2
References: <Pine.GSO.4.33.0110081340390.9507-100000@raven>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

After various attempts, I succeeded in modifying the SuSE 7.2 login 
program distributed in the shadow.spm. But then I returned to the 
util-linux-2.10 source distributed with SELinux to see how the sources 
differed.

The result was that I couldn't find a significant difference between the 
two, and, encouraged by this, I built and installed the util-linux-2.10 
login. It worked without a hitch! That leaves me feeling a bit dumb, but 
...well,  I know my way around the login source now - always look on the 
bright side of life :-)

I still can't get the util-linux-2.11 login to work properly, though, 
but I think I'll start concentrating on sorting out my file_contexts and 
finding out why the sshd doesn't start up properly (it reports "line 41: 
Bad configuration option: HostbasedAuthentication" and then terminates).

Thanks for your help
James Bishop


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
