Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5ID9nrT016564
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2004 09:09:49 -0400 (EDT)
Received: from smtp-bedford.mitre.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5ID9krD016832
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2004 13:09:46 GMT
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (8.11.6/8.11.6) with ESMTP id i5ID9ll07181
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2004 09:09:47 -0400
Received: from divan.mitre.org (divan.mitre.org [129.83.10.75])
	by smtp-bedford.mitre.org (8.11.6/8.11.6) with ESMTP id i5ID9ls07175
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2004 09:09:47 -0400
Received: from divan.mitre.org (localhost [127.0.0.1])
	by divan.mitre.org (8.12.11/8.12.10) with ESMTP id i5ID9koY001923
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2004 09:09:46 -0400
To: selinux@tycho.nsa.gov
Subject: Re: Fedora Core 2 setools RPM
References: <200406171535.i5HFZVSf032291@gotham.columbia.tresys.com>
	<1087487902.25033.89.camel@moss-spartans.epoch.ncsc.mil>
From: ramsdell@mitre.org (John D. Ramsdell)
Date: 18 Jun 2004 09:09:46 -0400
In-Reply-To: <1087487902.25033.89.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <ogtllil1085.fsf@mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@epoch.ncsc.mil> writes:

> ...  I'd also think you would want both shared and static libraries,
> and have most of the tools dynamically linked against the shared
> library.

If Tresys is not completely sure that the libapol API is stable, they
may want to only release a static library for now.  Changing the API
used by a static library means that compilations may fail, but
existing binaries will be not be effected by the change.  Changing the
API used by a shared library means that existing binaries may fail.
Tresys should commit itself to an API provided by a shared library
only after careful thought.

John

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
