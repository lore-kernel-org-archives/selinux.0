Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA16673
	for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2002 17:17:19 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA03895
	for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2002 21:15:50 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id VAA03891
	for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2002 21:15:48 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: pasi.kivikangas@nokia.com, <selinux@tycho.nsa.gov>
Subject: Re: SELinux on UML
Date: Wed, 25 Sep 2002 23:17:06 +0200
References: <98C7D2E5BCD2374C9AAE0BCD2E9C1DD9BE8429@esebe013.ntc.nokia.com>
In-Reply-To: <98C7D2E5BCD2374C9AAE0BCD2E9C1DD9BE8429@esebe013.ntc.nokia.com>
MIME-Version: 1.0
Message-Id: <200209252317.06085.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 25 Sep 2002 15:25, pasi.kivikangas@nokia.com wrote:
> I wanted to try out SELinux on UML (User Mode Linux). What I did was, I
> patched Linux kernel 2.4.19 with LSM- then with SELinux- and finally with
> UML-patches. Everything went quite well and I didn't have to do too much
> manual work.
>
> Anyhow, UML kernel compilation didn't succeed because SELinux seems to rely
> on some ptrace stuff (I'm not quite familiar with that) and UML doesn't
> seem to provide that.
>
> Just wanted to ask if somebody around have done some experiments with
> SELinux on UML and got it working somehow?

I've just had a quick look at it.  It seems that UML provides a different 
ptrace interface internally.

I've sent Jeff an email asking how to get the ptrace stuff working on UML, but 
it might be better to get the SE kernel code to not do things that way if 
possible...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
