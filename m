Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA16059
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2001 15:06:59 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA29190
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2001 20:06:19 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzband.ncsc.mil  with ESMTP id UAA29185
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2001 20:06:16 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 5521192708
	for <selinux@tycho.nsa.gov>; Sat,  1 Dec 2001 07:06:52 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id BDF4535FC98
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2001 21:06:44 +0100 (CET)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: <selinux@tycho.nsa.gov>
Subject: Re: Fwd: Re: SE Linux packages of login, sshd, tar, stat, findutils, fileutils, and [xkg]dm
Date: Fri, 30 Nov 2001 20:13:14 +0100
References: <1BF4DDD78DDA5D4EB0769BEA7F158E5A6F384C@amcw2ms812.amc.ds.af.mil>
In-Reply-To: <1BF4DDD78DDA5D4EB0769BEA7F158E5A6F384C@amcw2ms812.amc.ds.af.mil>
MIME-Version: 1.0
Message-Id: <20011130200644.BDF4535FC98@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 29 Nov 2001 18:08, Flood Randy Capt AFCA/TCAA wrote:
> This seems to be a flaw with the Debian distribution then.  Doesn't the
> Linux filesystems standard (or whatever its called) specify that
> software should be installed there?

Please read the specs.  Software installed by "make install" or equivalent 
belongs in /usr/local, software installed in packages as part of the OS 
belongs elsewhere.

My aim is to produce packages ot SE-Linux for Debian not to write a wrapper 
around "make install" (if the latter was my aim I'd have completed it long 
ago and moved on to other projects).

On Thu, 29 Nov 2001 19:04, Jose Nazario wrote:
> it would seem to come down to "is selinux the base system or an add on?"
> the distribution model of selinux would indicate that it's an add on, as
> its not a full fledged distribution.

It's an add on if it's installed by "make install".  It's part of the base 
system if it's installed by dpkg or dselect.

If we use your logic then almost everything is an add-on and everything will 
be in /usr/local...

> <opinion>
> #include "disclaimer.h"
>
> if debian wants it someplace else, have locally available patches. please
> don't attempt to apply such standards to everyone else. thank you. it is,
> after all, why you're a different distro.

Yes, Debian is the distribution that most closely follows standards such as 
the FHS (FSSTD) and the LSB.  Anyone who wants to write software that is 
incompatible with such standards is free to do so.  It'll limit acceptance of 
their software.

Then of course if we can't get agreement between all the distributions 
(Debian, Red Hat, SUSE, etc) on how to change such software to make it comply 
to relevant standards then everyone will suffer.

On Thu, 29 Nov 2001 20:48, Achim D. Brucker wrote:
> No it is not a flaw ;-).
> The main argument/idea is, that the directories
> /usr/local and /opt are 100% controlled by the local policy, therefore no

Absolutely!

> package controlled through the packet manager is allowed to put files in
> there. The main advante for the system administrator is, that is can do
> whatever he wants below /usr/local without the risk of breaking the
> packet manager.

I think that the risk of the package manager breaking what the administrator 
does is just as great.  Sometimes I want to have two copies of the same 
program installed, a package and a custom version in /usr/local.

> Personally I like this very much and it perfectly conforms
> to the Linux file system standard.

Also conforms to common practise over the last 10+ years.

> When I remember correctly, the packages officially distributed by Suse or
> Redhat do not write files into /usr/local. Surely there are rpms (and even
> debs) floating around the net, which install files below /usr/local, but
> they are not distributed as official parts of any the distribution (I
> assume this for Redhat/Mandrake/Suse and it is a strict policy for Debian).

Yes.  Sun is the only vendor I've come across that ships packages that mess 
with /usr/local.  They seem to think that a Sun package of bash for Solaris 
2.6 (distributed from a Sun web site) should install to /usr/local/bin while 
a package for Solaris 8.0 (distributed on the install CDs) should be in /bin. 
This sort of thing really sucks when you are trying to manage a network.

>  When SE-Linux is included in Debian (which I wish), it has to play the
> game of the Debian Guidelines because it would be an official part of the
> distribution.

Absolutely!

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
