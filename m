Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5HFa9rT010306
	for <selinux@tycho.nsa.gov>; Thu, 17 Jun 2004 11:36:10 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5HFa7SU016061
	for <selinux@tycho.nsa.gov>; Thu, 17 Jun 2004 15:36:07 GMT
Message-Id: <200406171535.i5HFZVSf032291@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'John D. Ramsdell'" <ramsdell@mitre.org>, <selinux@tycho.nsa.gov>
Subject: RE: Fedora Core 2 setools RPM
Date: Thu, 17 Jun 2004 11:36:02 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <ogtvfhss8rr.fsf@mitre.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am not aware of an setools-devel rpm that installs the include files and
libapol.a. I think at one point the setools rpms that Dan Walsh was making
for Redhat/Fedora installed these files, but the current rpms for Fedora do
not.

In general, we have not spent many resources addressing the use of libapol
outside of setools. Because of this, we haven't added a target to install
the headers and library. The simplest thing to do is to download our source
and work within the setools directory. Otherwise, it is easy to write an
install target if you want.

Karl

Karl MacMillan
Tresys Technology
http://www.tresys.com
(410)290-1411 ext 134 

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
> Behalf Of John D. Ramsdell
> Sent: Tuesday, June 15, 2004 7:26 PM
> To: selinux@tycho.nsa.gov
> Subject: Fedora Core 2 setools RPM
> 
> I notice the RPM for setools fails to install libapol.a into /usr/lib,
> and fails to install the header files needed to use the library into
> /usr/include/libapol.  Is there is a setools-devel RPM I don't know
> about?
> 
> John
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
