Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5PCcpvn006837
	for <selinux@tycho.nsa.gov>; Sun, 25 Jun 2006 08:38:53 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5PCckCU006299
	for <selinux@tycho.nsa.gov>; Sun, 25 Jun 2006 12:38:48 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: moving modules into base
Date: Sun, 25 Jun 2006 22:37:07 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <200606181333.36369.russell@coker.com.au> <1150728321.18657.104.camel@sgc>
In-Reply-To: <1150728321.18657.104.camel@sgc>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zNonErU8bzklX+5"
Message-Id: <200606252237.07080.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_zNonErU8bzklX+5
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 20 June 2006 00:45, "Christopher J. PeBenito" 
<cpebenito@tresys.com> wrote:
> On Sun, 2006-06-18 at 13:33 +1000, Russell Coker wrote:
> > Due to problems with modules I want to compile a policy with amavis and
> > clamav in base.pp.
> >
> > I built the rpms but get the following when trying to install them:
> >
> > libsepol.scope_copy_callback: amavis: Duplicate declaration in module:
> > type/attribute amavis_var_log_t
> > libsemanage.semanage_link_sandbox: Link packages failed
> > semodule:  Failed!
> >
> > I then built a module with just clamav in base.pp and got the following:
> >
> > libsepol.scope_copy_callback: clamav: Duplicate declaration in module:
> > type/attribute clamd_var_lib_t
> > libsemanage.semanage_link_sandbox: Link packages failed
> > semodule:  Failed!
>
> Can you send a copy of the modules.conf?

I've attached the patch against the default Red Hat package.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_zNonErU8bzklX+5
Content-Type: text/x-diff;
  charset="utf-8";
  name="modules-targeted.conf.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="modules-targeted.conf.diff"

--- modules-targeted.conf.orig	2006-06-18 12:41:13.000000000 +1000
+++ modules-targeted.conf	2006-06-18 13:19:02.000000000 +1000
@@ -1053,16 +1053,16 @@
 # Layer: services
 # Module: amavis
 #
-# Anti-virus
+# Amavis anti-virus framework for Email virus scanning
 # 
-amavis = module
+amavis = base
 
 # Layer: services
 # Module: clamav
 #
 # ClamAV Virus Scanner
 # 
-clamav = module
+clamav = base
 
 # Layer: system
 # Module: setrans
@@ -1078,3 +1078,10 @@
 # Policy for OPENVPN full-featured SSL VPN solution
 # 
 openvpn = base
+
+# Layer: services
+# Module: postgrey
+#
+# Policy for Postfix Gray-listing daemon
+# 
+postgrey = base

--Boundary-00=_zNonErU8bzklX+5--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
