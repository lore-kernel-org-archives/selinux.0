Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0TEPHRb011823
	for <selinux@tycho.nsa.gov>; Thu, 29 Jan 2004 09:25:17 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0TENiVK004699
	for <selinux@tycho.nsa.gov>; Thu, 29 Jan 2004 14:23:44 GMT
Received: from smtp1.adl2.internode.on.net (smtp1.adl2.internode.on.net [203.16.214.181])
	by jazzswing.ncsc.mil  with ESMTP id i0TENglx004687
	for <selinux@tycho.nsa.gov>; Thu, 29 Jan 2004 14:23:43 GMT
Message-Id: <5.1.0.14.2.20040130001522.00f65440@mail.internode.on.net>
Date: Fri, 30 Jan 2004 00:24:05 +1000
To: russell@coker.com.au, selinux@tycho.nsa.gov
From: Keen <keen@internode.on.net>
Subject: Re: Problem with selinux configuration
In-Reply-To: <200401292310.05430.russell@coker.com.au>
References: <40186cf7.274.6f79.443726088@internode.on.net>
 <40186cf7.274.6f79.443726088@internode.on.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

At 11:10 PM 1/29/2004 +1100, Russell Coker wrote:
>On Thu, 29 Jan 2004 13:16, "keen@internode.on.net" <keen@internode.on.net>
>wrote:
> > So does that leave me with going onto Fedora on setting it
> > up? (or perhaps try it on gentoo?) What if i used the
>
>As Steve mentioned, Dan's packages currently require rawhide.
>
>For starting on using Fedora with SE Linux it might be easiest to wait for 
>the
>release of FC2.  FC2 will come with full SE Linux support out of the box and
>save you from a lot of this.
>
> > selinux-usr-2003100110.tgz package released 1 Oct 2003? It
> > would be for RH9 right? Would there be any undesirable
> > effects with 2.6.0 kernel? Which option would be a better
> > way to get SELinux up and running?
>
>The stock 2.6.0 and 2.6.1 kernels will run fine with SE Linux.  There are 
>some
>new features that have been added recently, but you probably don't need them
>immediately.
>
>If using Fedora then it's easiest to just use Arjan's 2.6.x kernel packages.
>By the time you finish your tests and are ready for a serious deployment of
>SE Linux, FC2 will be out and will have a kernel package that has all the
>patches.
>
>What exactly are your aims?  Do you want to try out SE Linux on Red Hat or
>Fedora before running a serious server on Red Hat?  Or do you just want to
>try out SE Linux without any particular preference to distribution.
>
>If you just want to try out SE Linux without any distribution preference then
>the Gentoo people are apparently working on a live CD image.  That will allow
>you to boot SE Linux from a CD and try it out without risk of messing with
>anything on your hard disk.

well i'm not exactly sure what rawhide is? some other rpm dependency? where 
can i find/get it?
i'm actually supposed to be researching SELinux for a school project, so 
it's not for any serious production servers.
for starters I'd need to at least setup a box for it and then go on from 
there. I'm using RH9 at the moment since RH is the distro I'm most familiar 
with, although I may be prepared to jump onto other distros if the need 
arise. I'm not sure when FC2 would be out, but I suppose my project might 
be due or might leave me with little time for me to come up with anything?

Thank you for your replies, they are much appreciated. Please offer any 
other suggestions if anyone could offer them.

Keen



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
