Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB2FODRb015385
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 10:24:13 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB2FOCqY029327
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 15:24:12 GMT
Received: from nox.lemuria.org ([213.191.86.35])
        by jazzband.ncsc.mil  with ESMTP id hB2FOB0o029324 for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 15:24:12 GMT
Date: Tue, 2 Dec 2003 16:24:11 +0100
From: Tom <tom@lemuria.org>
To: Chris Vanden Berghe <vbc@zurich.ibm.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: selinux-policy-default
Message-ID: <20031202162410.B3176@lemuria.org>
References: <3FCC831A.1070002@zurich.ibm.com> <20031202145659.C1867@lemuria.org> <3FCCA48A.8070709@zurich.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3FCCA48A.8070709@zurich.ibm.com>; from vbc@zurich.ibm.com on Tue, Dec 02, 2003 at 03:41:14PM +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Dec 02, 2003 at 03:41:14PM +0100, Chris Vanden Berghe wrote:
> I would very much like to hear how you got around this problem!

Hm, ok. I'm not at home at the moment, so I don't have access to my
play machine. So it's all from memory.

The problem is that you're updating. One thing you can also try is to
(re)move the old /usr/share/selinux directory, remove the /etc/selinux
and do a clean re-install.

I'll check when I get home, but that might be late today.


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
