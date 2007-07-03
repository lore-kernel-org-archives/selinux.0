Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l63Brb94007342
	for <selinux@tycho.nsa.gov>; Tue, 3 Jul 2007 07:53:37 -0400
Received: from nospam.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l63BrXG0011036
	for <selinux@tycho.nsa.gov>; Tue, 3 Jul 2007 11:53:34 GMT
Received: from localhost (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id AFF2518955
	for <selinux@tycho.nsa.gov>; Tue,  3 Jul 2007 21:53:30 +1000 (EST)
Received: from nospam.sws.net.au ([127.0.0.1])
	by localhost (etbe.coker.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bsQQD18xwm-r for <selinux@tycho.nsa.gov>;
	Tue,  3 Jul 2007 21:53:30 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id ED16F1894D
	for <selinux@tycho.nsa.gov>; Tue,  3 Jul 2007 21:53:29 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 81C18208DD
	for <selinux@tycho.nsa.gov>; Tue,  3 Jul 2007 21:53:11 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
Subject: Re: GPLv3
Date: Tue, 3 Jul 2007 21:53:08 +1000
Cc: selinux@tycho.nsa.gov
References: <200707021930.00649.russell@coker.com.au> <1183386470.16330.5.camel@localhost.localdomain> <ogtk5tilt63.fsf@oolong.mitre.org>
In-Reply-To: <ogtk5tilt63.fsf@oolong.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
To: "Undisclosed.Recipients": ;
Message-Id: <200707032153.10158.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 03 July 2007 01:30, "John D. Ramsdell" <ramsdell@mitre.org> wrote:
> This means a GPLv2 library cannot be linked with a GPLv3 program, as I
> read it.  I think Karl's call for careful planning before any switch
> is wise.

LGPLv3 should be fine for libraries.

On Tuesday 03 July 2007 01:30, KaiGai Kohei <kaigai@kaigai.gr.jp> wrote:
> Does your opinion means that non-GPL software like libselinux also
> should be relicensed to GPL-v3?
> If so, the incompatibility is not acceptable for several non-GPL
> softwares like PostgreSQL (BSD licensed).

PostgreSQL is linked against glibc, I expect LGPLv3 to work everywhere that 
LGPLv2 works.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
