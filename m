Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA19742
	for <selinux@tycho.nsa.gov>; Fri, 26 Apr 2002 12:36:24 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA12559
	for <selinux@tycho.nsa.gov>; Fri, 26 Apr 2002 16:35:13 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
        by jazzband.ncsc.mil  with SMTP id QAA12555 for <selinux@tycho.nsa.gov>; Fri, 26 Apr 2002 16:35:12 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A101524370@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Carsten Grohmann'" <carsten.grohmann@dr-baldeweg.de>,
        NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: RE: enforcing mode
Date: Fri, 26 Apr 2002 11:36:40 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday, April 26, 2002 8:21 AM, Carsten Grohmann wrote:


> this time I use SELinux and after each start it is run in the 
> permissive
> mode. After each start I change manual to the enforcing mode. It is
> possible to start automatic in the enforcing Mode? Or need I 
> a script to
> do this?
> 
I needed something very similar: What I did was the modify
the lsm-2.4/security/selinux/avc.c
Change the line 

int avc_debug_always_allow = 1;

To
int avc_debug_always_allow = 0;


The kernel will start in secure mode but you can
latter change by
avc_toggle

Mark

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
