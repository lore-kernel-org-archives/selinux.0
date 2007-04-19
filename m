Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3JL038C019719
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 17:00:03 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3JL02rk021267
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 21:00:02 GMT
Subject: Re: ANN: Reference Policy Release
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Manoj Srivastava <manoj.srivastava@stdc.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <87mz14um9b.fsf@glaurung.internal.golden-gryphon.com>
References: <1176822437.11059.3.camel@sgc.columbia.tresys.com>
	 <87mz14um9b.fsf@glaurung.internal.golden-gryphon.com>
Content-Type: text/plain
Date: Thu, 19 Apr 2007 16:56:22 -0400
Message-Id: <1177016182.15761.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-04-19 at 15:45 -0500, Manoj Srivastava wrote:
> On Tue, 17 Apr 2007 11:07:16 -0400, Christopher J PeBenito
> <cpebenito@tresys.com> said:  
> 
> > A new release of the SELinux Reference Policy is now available on the
> > Tresys OSS site, http://oss.tresys.com.  The primary change in this
> > release is the addition of support for Booleans and tunables in
> > modules.  For proper use of modules with Booleans, libsepol 1.16.2 or
> 
>         I had hoped that was a typo, since I have just upgraded Debian
>  Sid to the stable release, and that means libsepol at
>  1.16.1. Unfortunately, I am running into errors trying to  play around
>  with the refpolicy, for instance, semodule_deps with the new strict
>  policy gives:
> 

<snip>

> 
>         Since this is very early in the lenny release cycle, I would not
>  be averse to packaging the development release for lenny (surely our
>  release cycles are faster than Debian's), and will do so unless there
>  are vocal objections.
> 

Stable is at 1.16.3 - no reason to package trunk. Or am I missing your
intent?

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
