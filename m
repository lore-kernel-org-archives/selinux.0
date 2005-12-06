Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jB6Hx8MA021587
	for <selinux@tycho.nsa.gov>; Tue, 6 Dec 2005 12:59:08 -0500 (EST)
Received: from glaurung.internal.golden-gryphon.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jB6Hqrks010429
	for <selinux@tycho.nsa.gov>; Tue, 6 Dec 2005 17:52:54 GMT
Received: from glaurung.internal.golden-gryphon.com (srivasta@localhost [127.0.0.1])
	by glaurung.internal.golden-gryphon.com (8.13.5/8.13.5/Debian-3) with ESMTP id jB6HhINV018421
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Tue, 6 Dec 2005 11:43:18 -0600
From: Manoj Srivastava <manoj.srivastava@stdc.com>
To: selinux@tycho.nsa.gov
Subject: Re: slapd on debian stable
References: <1133804764.15188.21.camel@wintermute.xmldesign.de>
Date: Tue, 06 Dec 2005 11:43:17 -0600
In-Reply-To: <1133804764.15188.21.camel@wintermute.xmldesign.de> (Erich
	Schubert's message of "Mon, 05 Dec 2005 18:46:03 +0100")
Message-ID: <87iru2i0ju.fsf@glaurung.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
On Mon, 05 Dec 2005 18:46:03 +0100, Erich Schubert <erich@debian.org> said: 

> Hi, at least on debian stable (didn't check unstable), the debian
> slapd binary is located in /usr/lib/slapd (and thus not
> system_u:object_r:slapd_exec_t) Should we add a conditional or an
> unconditional statement for this to the ldap policy files?

        In Sid, the location seems to be changed:
__> dlocate slapd | egrep 'slapd$'
slapd: /usr/sbin/slapd

        manoj
-- 
A musical reviewer admitted he always praised the first show of a new
theatrical season.  "Who am I to stone the first cast?"
Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@acm.org> 
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
