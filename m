Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA28901
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2001 19:30:06 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id AAA16961
	for <selinux@tycho.nsa.gov>; Sat, 10 Feb 2001 00:29:57 GMT
Received: from mail.storm.ca (storm.ca [209.87.239.69])
	by jazzswing.ncsc.mil  with ESMTP id AAA16957
	for <selinux@tycho.nsa.gov>; Sat, 10 Feb 2001 00:29:56 GMT
Received: from storm.ca (ppp-209-87-255-2.ottawa.storm.ca [209.87.255.2])
	by mail.storm.ca (8.9.3+Sun/8.9.3) with ESMTP id TAA17738
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2001 19:30:04 -0500 (EST)
Message-ID: <3A848B66.AB971FCE@storm.ca>
Date: Fri, 09 Feb 2001 19:29:26 -0500
From: Sandy Harris <sandy@storm.ca>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Crypto FS
References: <200102092204.RAA05539@coalstack.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Pete Loscocco wrote:

> I think that these ideas should be investigated in both file system and
> network implementations. Certainly cryptography defined behind a
> well-defined crypto API makes this idea more feasible. Doing this for
> file cryptography is still something we would like to try in the
> future, but have no immediate plans. However, we do have plans to build
> upon our previous work in this area for networking. We will be
> integrating IKE and IPSEC with the existing MAC policy. As this work
> really gets started, we'll have more to say about it.

Are you going to use FreeS/WAN IPSEC?

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
