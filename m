Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAGDosIi000193
	for <selinux@tycho.nsa.gov>; Tue, 16 Nov 2004 08:50:54 -0500 (EST)
Received: from smtp-bedford.mitre.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAGDnRAa021410
	for <selinux@tycho.nsa.gov>; Tue, 16 Nov 2004 13:49:28 GMT
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (8.11.6/8.11.6) with SMTP id iAGDovB09967
	for <selinux@tycho.nsa.gov>; Tue, 16 Nov 2004 08:50:57 -0500
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (Postfix) with ESMTP id AD3B8BF00
	for <selinux@tycho.nsa.gov>; Tue, 16 Nov 2004 08:50:57 -0500 (EST)
Received: from linus.mitre.org (linus.mitre.org [129.83.10.1])
	by smtp-bedford.mitre.org (8.11.6/8.11.6) with ESMTP id iAGDovN09937
	for <selinux@tycho.nsa.gov>; Tue, 16 Nov 2004 08:50:57 -0500
Received: from divan.mitre.org (divan.mitre.org [129.83.10.75])
	by linus.mitre.org (8.12.10/8.12.10) with ESMTP id iAGDovVt008338
	for <selinux@tycho.nsa.gov>; Tue, 16 Nov 2004 08:50:57 -0500 (EST)
To: selinux@tycho.nsa.gov
Subject: SLAT 1.2.4 released
From: ramsdell@mitre.org (John D. Ramsdell)
Date: 16 Nov 2004 08:50:57 -0500
Message-ID: <ogtu0rp6gxq.fsf@divan.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

SLAT 1.2.4 has been released and is available at

http://simp.mitre.org/selinux/

as a source tarball and RPMs.  The binary RPM does not depend on OCaml
being installed.

This version fixes a serious bug in a routine that generates model
checker formulas from SLAT diagrams.  The old routine failed to add
parenthesis at an important point, and the result was that the wrong
formula was being checked.

John

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
