Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA24553
	for <selinux@tycho.nsa.gov>; Sun, 28 Apr 2002 11:24:36 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA20802
	for <selinux@tycho.nsa.gov>; Sun, 28 Apr 2002 15:23:22 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
        by jazzband.ncsc.mil  with SMTP id PAA20798 for <selinux@tycho.nsa.gov>; Sun, 28 Apr 2002 15:23:22 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A101524371@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Russell Coker '" <russell@coker.com.au>,
        "Westerman, Mark"
	 <Mark.Westerman@csoconline.com>,
        "''Carsten Grohmann' '"
	 <carsten.grohmann@dr-baldeweg.de>,
        "'NSA Selinux Mailinglist '"
	 <selinux@tycho.nsa.gov>
Subject: RE: enforcing mode
Date: Sun, 28 Apr 2002 10:24:43 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

 
On 4/27/02 2:48 PM Russell Coker Wrote

> I needed something very similar: What I did was the modify
> the lsm-2.4/security/selinux/avc.c
> Change the line
>
> int avc_debug_always_allow = 1;
>
> To
> int avc_debug_always_allow = 0;

Maybe there should be a kernel command-line option for this...

I agree

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
