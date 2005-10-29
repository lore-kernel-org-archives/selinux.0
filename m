Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9TGAkMA001085
	for <selinux@tycho.nsa.gov>; Sat, 29 Oct 2005 12:10:46 -0400 (EDT)
Received: from glaurung.internal.golden-gryphon.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9TG5o34010485
	for <selinux@tycho.nsa.gov>; Sat, 29 Oct 2005 16:05:51 GMT
Received: from glaurung.internal.golden-gryphon.com (srivasta@localhost [127.0.0.1])
	by glaurung.internal.golden-gryphon.com (8.13.5/8.13.5/Debian-3) with ESMTP id j9TG0UBp025625
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Sat, 29 Oct 2005 11:00:35 -0500
From: Manoj Srivastava <manoj.srivastava@stdc.com>
To: selinux@tycho.nsa.gov
Subject: Re: logging question
References: <m33bn0az4a.fsf@eemoore.bcluster.njit.edu>
	<1129567150.26309.154.camel@moss-spartans.epoch.ncsc.mil>
	<200510180752.34963.russell@coker.com.au>
Date: Sat, 29 Oct 2005 11:00:24 -0500
In-Reply-To: <200510180752.34963.russell@coker.com.au> (Russell Coker's
	message of "Tue, 18 Oct 2005 07:52:25 +1000")
Message-ID: <87ek64z52f.fsf@glaurung.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 18 Oct 2005 07:52:25 +1000, Russell Coker <russell@coker.com.au> said: 

> The Debian kernel binary packages are built with SE Linux enabled
> but auditing disabled.  I have sent several messages to the relevant
> people about this matter and had no positive response.  Several
> 2.6.x kernels have been released in this state.

        The latest 2.6.14 kernels have CONFIG_AUDIT=y, as well as
 CONFIG_AUDITSYSCALL=y

        Is a new release of libsepol imminent, or should I go fetch
 the 1.9.X release from CVS and upload that to Debian?

        manoj
ps: Sorry for being tardy on the Debian SELinux front, but I am just
coming out of a health issue, and had been unable to spend time on SELINUX
-- 
Time is an illusion perpetrated by the manufacturers of space.
Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@acm.org> 
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
