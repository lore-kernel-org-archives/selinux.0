Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5HIm9rT012010
	for <selinux@tycho.nsa.gov>; Thu, 17 Jun 2004 14:48:09 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5HIlwMZ023338
	for <selinux@tycho.nsa.gov>; Thu, 17 Jun 2004 18:47:59 GMT
Message-Id: <200406171847.i5HIlPSf000906@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@epoch.ncsc.mil>
Cc: "'John D. Ramsdell'" <ramsdell@mitre.org>, <selinux@tycho.nsa.gov>
Subject: RE: Fedora Core 2 setools RPM
Date: Thu, 17 Jun 2004 14:47:56 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <1087487902.25033.89.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



> -----Original Message-----
> From: Stephen Smalley [mailto:sds@epoch.ncsc.mil]
> 
> I think it would be helpful for libapol to be available for third party
> packages to encourage other people working on policy tools to re-use and
> (if necessary) contribute extensions back to libapol rather than
> reinventing the wheel each time.  I'd also think you would want both
> shared and static libraries, and have most of the tools dynamically
> linked against the shared library.
> 

Sure - like I said we just haven't put any energy into this. We would
certainly like to see people using our libraries as much as possible as they
provide a lot of functionality that has taken a long time to develop. We
will be putting an interim release out soon and will include the
installation of the include files and libraries (shared and static).

Karl

> --
> Stephen Smalley <sds@epoch.ncsc.mil>
> National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
