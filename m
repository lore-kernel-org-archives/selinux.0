Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA16636
	for <selinux@tycho.nsa.gov>; Sun, 7 Jul 2002 17:23:51 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA28220
	for <selinux@tycho.nsa.gov>; Sun, 7 Jul 2002 21:22:22 GMT
Received: from mail.simplyaquatics.com (66-0-92-223.deltacom.net [66.0.92.223])
        by jazzband.ncsc.mil  with ESMTP id VAA28216 for <selinux@tycho.nsa.gov>; Sun, 7 Jul 2002 21:22:21 GMT
Reply-To: <blacknet@simplyaquatics.com>
From: "Ed Street" <blacknet@simplyaquatics.com>
To: "'Russell Coker'" <russell@coker.com.au>,
        "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: RE: fingerd (was  new packages)
Date: Sun, 7 Jul 2002 17:23:49 -0400
Message-ID: <006401c225fc$95ccabc0$0a01a8c0@ed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20020707204801.B3AC922A8@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

If I make a
/usr/share/selinux/policy/current/file_contexts/program/fingerd.fc file
shouldn't the contents be this?

/usr/sbin/in.fingerd               system_u:object_r:fingerd_exec_t

Ed


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
