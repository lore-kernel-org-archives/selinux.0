Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i16D3FRb022325
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 08:03:15 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i16D3EOi020422
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 13:03:14 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id i16D3DWW020370 for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 13:03:13 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Tomas Hoger <thoger@pobox.sk>, Eric Estabrooks <eric@urbanrage.com>
Subject: Re: selinux-policy-default
Date: Sat, 7 Feb 2004 00:01:49 +1100
Cc: selinux@tycho.nsa.gov
References: <40232CBB.7020607@urbanrage.com> <20040206103154.GA939@moche.atriaky.sk>
In-Reply-To: <20040206103154.GA939@moche.atriaky.sk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402070001.49328.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 6 Feb 2004 21:31, Tomas Hoger <thoger@pobox.sk> wrote:
> On Thu, Feb 05, 2004 at 11:57:15PM -0600, Eric Estabrooks wrote:
> > domains/admin.te:32:ERROR 'unknown type sysadm_locate_t' at token ';' on
> > line 5974:
> > allow sysadm_locate_t { sysadm_mozilla_ro_t sysadm_mozilla_rw_t }:dir {
> > getattr
> > search };
>
> I came across similar problem yesterday evening.  I think problem is that
> *_locate_t domains are not created in user_domain and admin_domain macros.
> See http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=231343 , there you can
> find simple patch which solved problem for me.  Can anyone look at it and
> tell if my solution is correct?

I'll upload a new version of the package to fix this shortly.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
