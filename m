Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA11879
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 11:48:00 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA11315
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 16:47:00 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
        by jazzband.ncsc.mil  with SMTP id QAA11311 for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 16:47:00 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A1015242DE@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Stephen Smalley'" <sds@tislabs.com>,
        Russell Coker
	 <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: RE: nscd
Date: Mon, 25 Feb 2002 10:48:07 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 25 Fed 2002, Stephen D. Smalley wrote:


> I'd suggest including the above domain_auto_trans rule and the role types
> definition (role system_r types nscd_t) in the nscd.te file.  That keeps
> the entire domain definition isolated to nscd.te.  I've merged this
> domain with these minor changes.  At some point, I'd like to revise the
> other domains in the example policy configuration to do likewise.

I agree that the example policy configuration needs to be modified
such that domains are contained completely with in a xxxx.te file.


Mark


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
