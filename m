Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA09028
	for <selinux@tycho.nsa.gov>; Mon, 13 May 2002 11:26:44 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA20652
	for <selinux@tycho.nsa.gov>; Mon, 13 May 2002 15:25:27 GMT
Received: from mailout06.sul.t-online.com (mailout06.sul.t-online.com [194.25.134.19])
        by jazzband.ncsc.mil  with ESMTP id PAA20648 for <selinux@tycho.nsa.gov>; Mon, 13 May 2002 15:25:26 GMT
Received: from localhost (localhost [127.0.0.1])
	by mail.dr-baldeweg.de (Postfix) with ESMTP id 93E851BBED
	for <selinux@tycho.nsa.gov>; Mon, 13 May 2002 17:03:16 +0200 (CEST)
Message-ID: <3CDFD7DC.158E4D41@dr-baldeweg.de>
Date: Mon, 13 May 2002 17:12:28 +0200
From: Carsten Grohmann <carsten.grohmann@dr-baldeweg.de>
MIME-Version: 1.0
To: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: .journal
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!

Since a few days I use the ext3 filesystem. And now I am looking the
correct rights for the journaling files (.journal). At this time I
labeled as file_t. What is your opinion? Should it use an own type or is
the file_t better?

Thanks

  Carsten

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
