Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA26919
	for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 10:45:51 -0400 (EDT)
From: jbyrd@vspacegroup.com
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA08641
	for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 14:44:49 GMT
Received: from sprout.phpwebhosting.com ([216.218.184.226])
	by jazzswing.ncsc.mil  with SMTP id OAA08637
	for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 14:44:48 GMT
Message-ID: <00bd01c24533$9abf6b80$0100a8c0@vspaceprs2>
To: <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0208161035120.29385-100000@raven>
Subject: Re: Needing some direction
Date: Fri, 16 Aug 2002 10:45:44 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>  Offhand, I'd guess that you enabled the
> SELinux MLS policy support in the kernel configuration without doing the
> other steps from README.MLS.

Good guess! ... although it was more of failure on my part to DISABLE it, as
it was marked <*> by default.
Rebuilding now without MLS & Telephony support.

Once again, tks.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
