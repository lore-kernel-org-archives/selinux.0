Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5FNQJrT029027
	for <selinux@tycho.nsa.gov>; Tue, 15 Jun 2004 19:26:19 -0400 (EDT)
Received: from smtp-bedford.mitre.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5FNQHs1003209
	for <selinux@tycho.nsa.gov>; Tue, 15 Jun 2004 23:26:17 GMT
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (8.11.6/8.11.6) with ESMTP id i5FNQIi31377
	for <selinux@tycho.nsa.gov>; Tue, 15 Jun 2004 19:26:18 -0400
Received: from divan.mitre.org (divan.mitre.org [129.83.10.75])
	by smtp-bedford.mitre.org (8.11.6/8.11.6) with ESMTP id i5FNQHv31373
	for <selinux@tycho.nsa.gov>; Tue, 15 Jun 2004 19:26:17 -0400
Received: from divan.mitre.org (localhost [127.0.0.1])
	by divan.mitre.org (8.12.11/8.12.10) with ESMTP id i5FNQGoX026194
	for <selinux@tycho.nsa.gov>; Tue, 15 Jun 2004 19:26:16 -0400
To: selinux@tycho.nsa.gov
Subject: Fedora Core 2 setools RPM
From: ramsdell@mitre.org (John D. Ramsdell)
Date: 15 Jun 2004 19:26:16 -0400
In-Reply-To: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4AD5@s3cin>
Message-ID: <ogtvfhss8rr.fsf@mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I notice the RPM for setools fails to install libapol.a into /usr/lib,
and fails to install the header files needed to use the library into
/usr/include/libapol.  Is there is a setools-devel RPM I don't know
about?

John

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
