Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7BFJgrT011031
	for <selinux@tycho.nsa.gov>; Wed, 11 Aug 2004 11:19:42 -0400 (EDT)
Date: Wed, 11 Aug 2004 11:19:06 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: network auditing
In-Reply-To: <200408111816.56367.russell@coker.com.au>
Message-ID: <Xine.LNX.4.44.0408111115170.13068-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 11 Aug 2004, Russell Coker wrote:

> avc:  granted  { name_bind } for  pid=21718 exe=/usr/bin/imapd 
> scontext=system_u:system_r:courier_pop_t tcontext=system_u:object_r:port_t 
> tclass=tcp_socket
> 
> On kernel 2.6.7 with the patch from the NSA site I get messages such as the 
> above about port access.  Can we get this changed to log the port number as 
> it used to?

The patch below should restore the behavior.

diff -urN -X dontdiff linux-2.6.8-rc4.o/security/selinux/hooks.c linux-2.6.8-rc4.w/security/selinux/hooks.c
--- linux-2.6.8-rc4.o/security/selinux/hooks.c	2004-08-10 01:20:16.000000000 -0400
+++ linux-2.6.8-rc4.w/security/selinux/hooks.c	2004-08-11 11:36:48.000000000 -0400
@@ -3078,6 +3078,7 @@
 				goto out;
 			AVC_AUDIT_DATA_INIT(&ad,NET);
 			ad.u.net.sport = htons(snum);
+			ad.u.net.family = family;
 			err = avc_has_perm(isec->sid, sid,
 					   isec->sclass,
 					   SOCKET__NAME_BIND, NULL, &ad);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
