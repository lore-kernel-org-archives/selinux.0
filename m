Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA4887XZ021483
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 03:08:07 -0500 (EST)
Received: from glaurung.internal.golden-gryphon.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA487u8i007125
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 08:08:03 GMT
Received: from glaurung.internal.golden-gryphon.com (srivasta@localhost [127.0.0.1])
	by glaurung.internal.golden-gryphon.com (8.13.1/8.13.1/Debian-16) with ESMTP id iA47xpHT009028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 01:59:52 -0600
To: selinux@tycho.nsa.gov
Subject: Re: selinux-doc problems
References: <87is8msv81.fsf@glaurung.internal.golden-gryphon.com>
	<1099503633.1213.153.camel@moss-spartans.epoch.ncsc.mil>
From: Manoj Srivastava <manoj.srivastava@stdc.com>
Date: Thu, 04 Nov 2004 01:59:51 -0600
In-Reply-To: <1099503633.1213.153.camel@moss-spartans.epoch.ncsc.mil> (Stephen
	Smalley's message of "Wed, 03 Nov 2004 12:40:33 -0500")
Message-ID: <87fz3qqc20.fsf@glaurung.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 03 Nov 2004 12:40:33 -0500, Stephen Smalley <sds@epoch.ncsc.mil> said: 

> On Wed, 2004-11-03 at 12:22, Manoj Srivastava wrote:
>> Is there an effort underway to update the selinux-doc package?  If
>> so, I'll hold off fixing up the SGML issues and wait for the new
>> version (I lack the knowledge to actually update the contents).

> Nothing in progress, although I would like to update the reports to
> reflect the current system, as much has changed since they were last
> updated.  However, the report does build for me on Fedora Core 3.
> rpm -q -f /usr/bin/jade reports openjade-1.3.2-14.  Seems
> unfortunate to prohibit _ in identifiers; why was this done?
> Quoting change would be trivial, of course.

	While we are waiting for the report to be updated, would it be
 useful if someone corrected the problems with compiling with the new
 openjade?  I could convert tags_with_undescore to TagsWithStudlyCaps,
 for example, and fix the quoting, and submit the patches back.

	manoj
-- 
I fell asleep reading a dull book, and I dreamt that I was reading on,
so I woke up from sheer boredom.
Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@acm.org> 
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
