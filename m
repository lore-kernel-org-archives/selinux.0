Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5LFhsrT002991
	for <selinux@tycho.nsa.gov>; Mon, 21 Jun 2004 11:43:54 -0400 (EDT)
Received: from smtp-mclean.mitre.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5LFhpeh029114
	for <selinux@tycho.nsa.gov>; Mon, 21 Jun 2004 15:43:51 GMT
Received: from smtp-mclean.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-mclean.mitre.org (8.11.6/8.11.6) with ESMTP id i5LFqrG03670
	for <selinux@tycho.nsa.gov>; Mon, 21 Jun 2004 11:52:53 -0400
Received: from divan.mitre.org (divan.mitre.org [129.83.10.75])
	by smtp-mclean.mitre.org (8.11.6/8.11.6) with ESMTP id i5LFqr303664
	for <selinux@tycho.nsa.gov>; Mon, 21 Jun 2004 11:52:53 -0400
Received: from divan.mitre.org (localhost [127.0.0.1])
	by divan.mitre.org (8.12.11/8.12.10) with ESMTP id i5LFhpXi006964
	for <selinux@tycho.nsa.gov>; Mon, 21 Jun 2004 11:43:51 -0400
To: selinux@tycho.nsa.gov
Subject: Re: Fedora Core 2 setools RPM
References: <003f01c45790$6a3cc090$4d0c010a@columbia.tresys.com>
From: ramsdell@mitre.org (John D. Ramsdell)
Date: 21 Jun 2004 11:43:51 -0400
In-Reply-To: <003f01c45790$6a3cc090$4d0c010a@columbia.tresys.com>
Message-ID: <ogt3c4o9ars.fsf@mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

"Frank Mayer" <mayerf@tresys.com> writes:

> We are positive that the API is not stable, and guarantee that it
> will change a lot between releases.

Yeah, I suspected as such.  I fully understand why Tresys wouldn't
want to install a shared library version of libapol at this stage of
its development.

John

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
