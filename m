Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA15810
	for <selinux@tycho.nsa.gov>; Mon, 20 Jan 2003 08:11:13 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0KDBEI09431
	for <selinux@tycho.nsa.gov>; Mon, 20 Jan 2003 13:11:14 GMT
Received: from nox.lemuria.org (nox.lemuria.org [213.191.86.30])
        by jazzband.ncsc.mil  with ESMTP id h0KDBDf09426 for <selinux@tycho.nsa.gov>; Mon, 20 Jan 2003 13:11:13 GMT
Date: Mon, 20 Jan 2003 14:11:12 +0100
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: PHP and other CGI stuff
Message-ID: <20030120141112.B29104@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I think I need some conceptual help on PHP and other CGI matters (as we
know, PHP as a module doesn't give SELinux a chance at all).


I was planning to have really seperated domains for virtual hosting,
which means each PHP process should run in its own domain, e.g. dom1
for user 1, dom2 for user 2, etc.


How would I go about this? I've successfully added a new user (the
second_user comments are really helpful here), but I can't get the
domain macro set up correctly. This is probably caused by me being
unable to use suexec_domain($1), because this violates some assertions
for the sysadm_r and others.

I haven't found much documentation on the whole user management stuff,
but if I missed something, please point it out to me.


Also, if what I want is a dumb idea, please enlighten me. :)


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
