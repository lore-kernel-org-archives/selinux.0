Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA04298
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 14:32:20 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA09500
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 19:29:03 GMT
Received: from unicorn.lemuria.org (c181032.adsl.hansenet.de [213.39.181.32])
	by jazzswing.ncsc.mil  with ESMTP id TAA09496
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 19:28:59 GMT
Date: Mon, 3 Mar 2003 20:25:37 +0100
From: Tom <tom@lemuria.org>
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov, wsalamon@tislabs.com
Subject: Re: Core policy, third pass
Message-ID: <20030303202536.B19717@lemuria.org>
References: <200303031543.KAA18309@moss-shockers.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200303031543.KAA18309@moss-shockers.ncsc.mil>; from sds@epoch.ncsc.mil on Mon, Mar 03, 2003 at 10:43:24AM -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Mar 03, 2003 at 10:43:24AM -0500, Stephen D. Smalley wrote:
> Sorry, I must have missed it earlier, but I'd exclude portmap.te from
> core as well.  I'm also not sure about inetd.te; is it worth retaining
> it in "core", since we are excluding the inetd-started services
> (and the crucial ones are superseded by sshd)?

inetd is default and required (by the base network packets) on Debian,
and if I remember correctly, SuSE (been a while since I used a SuSE
system). I wouldn't be surprised if it's the same for redhat. If it's
installed on a "minimal" system, then it should have a policy.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
