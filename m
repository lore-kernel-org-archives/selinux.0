Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k28MLP5l002991
	for <selinux@tycho.nsa.gov>; Wed, 8 Mar 2006 17:21:25 -0500
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k28MLMbn025241
	for <selinux@tycho.nsa.gov>; Wed, 8 Mar 2006 22:21:22 GMT
Subject: Re: Patch to add a "netuser" role and user
From: Erich Schubert <erich@debian.org>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1141842611.30819.182.camel@sgc.columbia.tresys.com>
References: <1141773189.5082.39.camel@wintermute.xmldesign.de>
	 <1141842611.30819.182.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 08 Mar 2006 20:13:59 +0100
Message-Id: <1141845239.8134.8.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Christopher,
> The patch is a reasonable example for adding roles, but I'm not sure
> that it should be added.  I can't think of a compelling need for it,
> especially since its basically user_r with user_tcp_server enabled, as
> you mention above.

Except that you might not want to allow user_tcp_server for all users,
and with netuser you can give this permission easily to individual users
on a per-user basis.

I also had to add:
	sysnet_dns_name_resolve($1_t)
	allow $1_t self:tcp_socket create_stream_socket_perms;
	allow $1_t self:udp_socket create_stream_socket_perms;
so it could actually use the sockets.
Probably missing for user_tcp_server, too. Havn't tested that yet (do
tuneables actually work? ssh_sysadm_login doesn't work for me)

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
  A polar bear is a rectangular bear after a coordinate transform.   //\
       Wenn Leute nicht glauben, dass Mathematik einfach ist,        V_/_
             dann nur deshalb, weil sie nicht begreifen,
         wie kompliziert das Leben ist. --- John von Neumann


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
