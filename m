Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i16CefRb022223
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 07:40:41 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i16CdJQk019121
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 12:39:19 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i16CdIYo019070
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 12:39:18 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Eric Estabrooks <eric@urbanrage.com>, selinux@tycho.nsa.gov
Subject: Re: selinux-policy-default
Date: Fri, 6 Feb 2004 23:39:14 +1100
References: <40232CBB.7020607@urbanrage.com>
In-Reply-To: <40232CBB.7020607@urbanrage.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402062339.14289.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 6 Feb 2004 16:57, Eric Estabrooks <eric@urbanrage.com> wrote:
> /usr/bin/checkpolicy:  loading policy configuration from
> /etc/security/selinux/src/policy.conf
> domains/admin.te:32:ERROR 'unknown type sysadm_locate_t' at token ';' on
> line 5974:
> allow sysadm_locate_t { sysadm_mozilla_ro_t sysadm_mozilla_rw_t }:dir {
> getattr
> search };

I'll upload a new policy package to fix that tomorrow.

Anyway using the locate policy for Debian is not a good idea.  Debian does not 
have a SE Linux patched locate and is not likely to have one in the 
forseeable future.  I think that locate is simply a bad idea and have no 
plans to support it in Debian.

> I searched for type lines for sysadm_locate_t but couldn't find any in

Look at macros/program/locate_macros.te .

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
