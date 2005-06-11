Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5BI7pgA027527
	for <selinux@tycho.nsa.gov>; Sat, 11 Jun 2005 14:07:52 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5BI00mF000968
	for <selinux@tycho.nsa.gov>; Sat, 11 Jun 2005 18:00:01 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 97F5961B0C
	for <selinux@tycho.nsa.gov>; Sun, 12 Jun 2005 03:59:44 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 14597-01 for <selinux@tycho.nsa.gov>;
	Sun, 12 Jun 2005 03:59:43 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 1354961B09
	for <selinux@tycho.nsa.gov>; Sun, 12 Jun 2005 03:59:43 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
To: "SE-Linux" <selinux@tycho.nsa.gov>
Date: Sun, 12 Jun 2005 03:59:36 +1000
References: <1116243381.3353.5.camel@localhost.localdomain>
	<20050516165136.GB5733@nostromo.devel.redhat.com>
	<428B3690.8000205@redhat.com>
In-Reply-To: <428B3690.8000205@redhat.com>
MIME-Version: 1.0
Message-Id: <200506120359.40729.russell@coker.com.au>
Cc: Daniel J Walsh <dwalsh@redhat.com>
Subject: Fwd: Re: Bringing interfaces up at boot and SElinux (?)
Reply-To: russell@coker.com.au
List-Unsubscribe: <http://www.redhat.com/mailman/listinfo/fedora-test-list>,
	<mailto:fedora-test-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/fedora-test-list>
List-Post: <mailto:fedora-test-list@redhat.com>
List-Help: <mailto:fedora-test-list-request@redhat.com?subject=help>
List-Subscribe: <http://www.redhat.com/mailman/listinfo/fedora-test-list>,
	<mailto:fedora-test-list-request@redhat.com?subject=subscribe>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_MayqCR5V1hFLyeg"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_MayqCR5V1hFLyeg
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch seemed to have been missed.

----------  Forwarded Message  ----------

Subject: Re: Bringing interfaces up at boot and SElinux (?)
Date: Sunday 22 May 2005 23:36
From: Russell Coker <russell@coker.com.au>
To: fedora-test-list@redhat.com
Cc: Daniel J Walsh <dwalsh@redhat.com>

On Wednesday 18 May 2005 22:35, Daniel J Walsh <dwalsh@redhat.com> wrote:
> >The error is probably from SELinux; there's a ping in
> > /sbin/dhclient-script when it times out.
>
> dhcpc should have the ability to ping.
> domain_auto_trans(dhcpc_t, ping_exec_t, ping_t)

The problem is that ping_t is not defined in the targeted policy.

The attached patch will give dhcpc_t the access to do what it wants when
 there is no ping_t domain, it will work with both targeted and strict policy
 (tested on targeted).

--
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

-------------------------------------------------------

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_MayqCR5V1hFLyeg
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- domains/program/dhcpc.te.orig	2005-05-22 23:17:50.000000000 +1000
+++ domains/program/dhcpc.te	2005-05-22 23:18:22.000000000 +1000
@@ -68,6 +68,9 @@
 ifdef(`cardmgr.te', `
 allow ping_t cardmgr_t:fd use;
 ') dnl end if cardmgr
+', `
+allow dhcpc_t self:capability setuid;
+allow dhcpc_t self:rawip_socket create_socket_perms;
 ') dnl end if ping
 
 ifdef(`dhcpd.te', `', `

--Boundary-00=_MayqCR5V1hFLyeg--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
