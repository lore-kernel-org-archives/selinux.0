Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5GDfXrT002685
	for <selinux@tycho.nsa.gov>; Wed, 16 Jun 2004 09:41:33 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5GDfVaM021147
	for <selinux@tycho.nsa.gov>; Wed, 16 Jun 2004 13:41:31 GMT
Subject: Re: Fedora Core 2 setools RPM
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "John D. Ramsdell" <ramsdell@mitre.org>
Cc: selinux@tycho.nsa.gov, selinux-dev@tresys.com,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <ogtvfhss8rr.fsf@mitre.org>
References: <ogtvfhss8rr.fsf@mitre.org>
Content-Type: text/plain
Message-Id: <1087393067.16125.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 16 Jun 2004 09:37:47 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-06-15 at 19:26, John D. Ramsdell wrote:
> I notice the RPM for setools fails to install libapol.a into /usr/lib,
> and fails to install the header files needed to use the library into
> /usr/include/libapol.  Is there is a setools-devel RPM I don't know
> about?

Not AFAIK, but I agree it would be a good idea.  In fact, it would be
nice for there to be a libapol RPM with a shared apol library and a
libapol-devel RPM with a static library and headers for use by third
party tools separate from setools.
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
