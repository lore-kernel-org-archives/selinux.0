Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0GIWEXf023745
	for <selinux@tycho.nsa.gov>; Mon, 16 Jan 2006 13:32:14 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0GIV6lk016796
	for <selinux@tycho.nsa.gov>; Mon, 16 Jan 2006 18:31:07 GMT
Subject: Re: djb-related policy diff
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Petre Rodan <kaiowas@gentoo.org>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20060114164042.GA5597@peter.sunspire.org>
References: <20060114164042.GA5597@peter.sunspire.org>
Content-Type: text/plain
Date: Mon, 16 Jan 2006 13:33:37 -0500
Message-Id: <1137436417.29815.234.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2006-01-14 at 18:40 +0200, Petre Rodan wrote:
> * policies for daemontools, ucspi-tcp, djbdns, publicfile
> * modified apache.te, ftp.te, mysql.te, rsync.te, spamassassin.te, ssh.te, stunnel.te, init.te, selinuxutil.te to add daemontools support.

I renamed a few interfaces in daemontools, and reordered a few lines.
Otherwise, looks good.  Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
