Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id VAA03470
	for <selinux@tycho.nsa.gov>; Sun, 14 Jul 2002 21:06:21 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id BAA11924
	for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 01:05:42 GMT
Received: from mail.simplyaquatics.com (66-0-92-223.deltacom.net [66.0.92.223])
	by jazzswing.ncsc.mil  with ESMTP id BAA11920
	for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 01:05:41 GMT
Reply-To: <blacknet@simplyaquatics.com>
From: "Ed Street" <blacknet@simplyaquatics.com>
To: "'Russell Coker'" <russell@coker.com.au>,
        "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: RE: shellutils
Date: Sun, 14 Jul 2002 21:06:13 -0400
Message-ID: <014d01c22b9b$d0591720$0a01a8c0@ed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20020714204344.597BFF0A@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

It would be interesting to return bogus info to non sysadm_r users :)

Ed

=> 
=> I've built a new Debian package of shellutils and put it on my web
site.
=> It's updated to sh-utils-2.0.12, and I changed the id program to not
=> display
=> the SID and context if you specify a different UID.
=> 
=> EG: if you type "id nobody" it should not say
root:sysaadm_r:sysadm_r.



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
