Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h89FUbLa000868
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2003 11:30:38 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h89FT0LY024690
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2003 15:29:00 GMT
Received: from nox.lemuria.org ([213.191.86.35])
	by jazzswing.ncsc.mil  with ESMTP id h89FSwsG024650
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2003 15:28:59 GMT
Date: Tue, 9 Sep 2003 17:30:14 +0200
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: how to add a user with rights to login via ssh on selinux?
Message-ID: <20030909173011.A13877@lemuria.org>
References: <200309092312.30592.russell@coker.com.au> <006101c376d8$fe52ab30$4200000a@roadwarrior>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <006101c376d8$fe52ab30$4200000a@roadwarrior>; from romix@php.cd on Tue, Sep 09, 2003 at 03:47:55PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Sep 09, 2003 at 03:47:55PM +0200, Romix wrote:
> so i changed it (i executed "/etc/init.d/sshd start" as root from a local
> login and not via ssh):
> 24176    195 root:staff_r:staff_t                     /usr/sbin/sshd

you need to run

run_init /etc/init.d/sshd start

in order to get it into the correct domain, instead of running the start 
script directly.


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
