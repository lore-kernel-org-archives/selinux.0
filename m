Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3JNHNcU025823
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 19:17:23 -0400
Received: from ladon.golden-gryphon.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3JNHMp8003510
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 23:17:22 GMT
Received: from host-118.dtccom.net (host-118.dtccom.net [204.117.95.118] (may be forged))
	by ladon.golden-gryphon.com (8.13.8/8.13.8/Debian-3) with ESMTP id l3JNHCuu024060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 18:17:13 -0500
Received: from glaurung.internal.golden-gryphon.com (srivasta@localhost [127.0.0.1])
	by host-118.dtccom.net (8.13.8/8.13.8/Debian-3) with ESMTP id l3JNAYFW026668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 18:10:34 -0500
From: Manoj Srivastava <manoj.srivastava@stdc.com>
To: selinux@tycho.nsa.gov
Subject: Re: ANN: Reference Policy Release
References: <1176822437.11059.3.camel@sgc.columbia.tresys.com>
	<87mz14um9b.fsf@glaurung.internal.golden-gryphon.com>
	<1177016182.15761.1.camel@localhost.localdomain>
Date: Thu, 19 Apr 2007 18:10:33 -0500
In-Reply-To: <1177016182.15761.1.camel@localhost.localdomain> (Karl
	MacMillan's message of "Thu\, 19 Apr 2007 16\:56\:22 -0400")
Message-ID: <87fy6wufiu.fsf@glaurung.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 19 Apr 2007 16:56:22 -0400, Karl MacMillan
<kmacmillan@mentalrootkit.com> said:  

>> 
>> Since this is very early in the lenny release cycle, I would not be
>> averse to packaging the development release for lenny (surely our
>> release cycles are faster than Debian's), and will do so unless there
>> are vocal objections.
>> 

> Stable is at 1.16.3 - no reason to package trunk. Or am I missing your
> intent?

        Argh. I forgot to look at subversion.  I guess this is a
 Freudean slip -- I must really want to get back on the bleeding edge.

        I think, on balance, that I'll package 2.0.X versions for lenny
 after all. Anyone at all who wants a stable system is running Etch, and
 only us crazy folk are running Debian unstable just after a release,
 and the trunk versions don't seem to harm my box, so ...

        Anyway, people who run Debian unstable _and_ run SELinux
 machines are probably just a handful, and I suspect almost all of them
 are on this list.

        manoj
-- 
"Here's something to think about: How come you never see a headline like
`Psychic Wins Lottery'?" -- Jay Leno
Manoj Srivastava <manoj.srivastava@stdc.com> <srivasta@acm.org> 
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
