Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id DAA29157
	for <selinux@tycho.nsa.gov>; Sat, 13 Jul 2002 03:34:00 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id HAA07814
	for <selinux@tycho.nsa.gov>; Sat, 13 Jul 2002 07:33:22 GMT
Received: from unicorn.lemuria.org (b067043.adsl.hansenet.de [62.109.67.43])
	by jazzswing.ncsc.mil  with ESMTP id HAA07810
	for <selinux@tycho.nsa.gov>; Sat, 13 Jul 2002 07:33:21 GMT
Date: Sat, 13 Jul 2002 09:29:53 +0200
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: revising the su decision]
Message-ID: <20020713092953.L26382@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Jul 13, 2002 at 06:04:56AM +0200, Russell Coker wrote:
> > c) give your remote/install user write priviledges for /var/install
> 
> If someone can write to /var/install in that case, then why not just allow 
> them to login directly with full admin privs?
> 
> Writing a RPM or DEB package to take over or destroy a system is easy 
> enough...

the point is that if you want to, you can do sanity checks before
installing the packages.

automated remote software updates are always essentially equal to
putting the root password into /etc/motd - but if the priviledged part
runs on the local machine, you at least do have a chance.

-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
