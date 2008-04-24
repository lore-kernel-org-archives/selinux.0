Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3O8EBiJ018412
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2008 04:14:11 -0400
Received: from vidle.i.cz (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3O8E953006475
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2008 08:14:10 GMT
Date: Thu, 24 Apr 2008 10:14:07 +0200
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
Subject: Re: refpolicy: patch for gpg-agent
Message-ID: <20080424081407.GA20611@bobek.pm.i.cz>
References: <20080220170300.GA13312@bobek.pm.i.cz> <1204660301.14217.26.camel@gorn> <20080321130315.GA21980@bobek.pm.i.cz> <1206544272.16113.228.camel@gorn> <20080415132602.GA6685@bobek.pm.i.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="x+6KMIRAuhnl3hBn"
In-Reply-To: <20080415132602.GA6685@bobek.pm.i.cz>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Apr 15, 2008 at 03:26:02PM +0200, Václav Ovsík wrote:
...
> Another patch is attached with the specific type for home file
> (<ROLE>_gpg_agent_home_t). I hope, this is better than general write
...

I forgot file context... The attached patch adds one for fixed
filename `.gpg-agent-info'.

Best Regards
-- 
Zito

--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=gpg-agent-fc

Index: policy/modules/apps/gpg.fc
===================================================================
--- policy/modules/apps/gpg.fc.orig	2008-04-24 09:03:05.000000000 +0200
+++ policy/modules/apps/gpg.fc	2008-04-24 09:05:22.000000000 +0200
@@ -1,4 +1,5 @@
 HOME_DIR/\.gnupg(/.+)?		gen_context(system_u:object_r:ROLE_gpg_secret_t,s0)
+HOME_DIR/\.gpg-agent-info	gen_context(system_u:object_r:ROLE_gpg_agent_home_t,s0)
 
 /usr/bin/gpg(2)?	--	gen_context(system_u:object_r:gpg_exec_t,s0)
 /usr/bin/gpg-agent	--	gen_context(system_u:object_r:gpg_agent_exec_t,s0)

--x+6KMIRAuhnl3hBn--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
