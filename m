Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jAHEJIMA009755
	for <selinux@tycho.nsa.gov>; Thu, 17 Nov 2005 09:19:18 -0500 (EST)
Received: from free.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jAHEAxLH001007
	for <selinux@tycho.nsa.gov>; Thu, 17 Nov 2005 14:11:00 GMT
Date: Thu, 17 Nov 2005 14:11:18 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Erich Schubert <erich@debian.org>
Cc: SELinux@tycho.nsa.gov
Subject: Re: Debian SELinux backports project
Message-ID: <20051117141118.GR3082@lkcl.net>
References: <1132232710.16126.6.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1132232710.16126.6.camel@wintermute.xmldesign.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

erich, hi,

the joyous sticking point: what to do about the kernel?

do you intend to:

a) stick with a 2.6.8 kernel, unmodified
b) require a 2.6.14+ (whatever)
c) stick with a 2.6.8 kernel, backporting all the selinux
   kernel modifications to date _back_ into 2.6.8

b) _would_ be the simplest - let's hope gcc 4.0 doesn't get in the way,
or more specifically, let's hope that the unmodified 2.6.14+ debian
kernels will work as-is.

l.

On Thu, Nov 17, 2005 at 02:05:10PM +0100, Erich Schubert wrote:
> Hi,
> I've started a SELinux project on Alioth, with the goal of providing
> backports of all SELinux related packages for Debian *stable*.
> Since all the up-to-date SELinux stuff is only in unstable.
> I'm running a couple of servers on stable with backports, so I can as
> well upload them.
> 
> If you are interested in joining this effort, please contact me. I also
> want to collect installation information and similar stuff for Debian
> stable, I guess the best place to put them is the Debian Wiki.
> 
> I've already setup some pages there:
> http://wiki.debian.org/SELinux
> http://wiki.debian.org/SELinuxStatus
> the latter is especially useful, since it contains a list of bug reports
> related to SELinux on Debian.
> 
> best regards,
> Erich Schubert
> -- 
>     erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C   (o_
>    There was never a good war or a bad peace. - Benjamin Franklin   //\
>             Es ist besser, geliebt und verloren zu haben,           V_/_
>                     als niemals geliebt zu haben.
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
