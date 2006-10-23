Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9NDZ1s3004248
	for <selinux@tycho.nsa.gov>; Mon, 23 Oct 2006 09:35:01 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k9NDXXGR004541
	for <selinux@tycho.nsa.gov>; Mon, 23 Oct 2006 13:33:33 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Booleans and tunable_policy
Date: Mon, 23 Oct 2006 09:35:02 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158818653A@exchange.columbia.tresys.com>
References: <BAY114-F35A32B2A224839C49B0E50AF030@phx.gbl>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Salvo Giuffrida" <giuffsalvo@hotmail.it>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 22 Oct 2006, Salvo Guffrida wrote:
>I saw that in the reference policy there aren't anymore if-else constructs 
>for the conditional evaluation of rules; instead, the tunable_policy macro 
>is used (which I don't understand where it is declared)...What's wrong with 
>the old "if-else" method?

Tunable_policy are blocks that will be replaced by a similar language feature when it becomes available.  Tunables will be similar to conditionals, except they will be selected during the policy module linking instead of being selectable at runtime.  This will result in a smaller policy, since there won't be dead policy from disabled booleans (a disabled tunable block will not be in the final policy).  Almost all of the booleans are configuration options, which means they would be better served as tunables.  For example, you wouldn't be toggling use_nfs_home_dirs many times on a running system, you would set it once and be done with it.  The tunable_policy macro will also be used to switch the blocks back to conditional policy if needed (it is always conditional policy currently).  The macro is  declared on line 159 of loadable_module.spt.

The "if-else" conditional policy blocks are still used where it makes sense that the policy is runtime configurable.  See line 153 of selinux.if for an example.

> And, why should the booleans be first declared in global_booleans?

Originally when we made refpolicy, we did not know how to export a boolean by an interface that made sense, so we made all booleans and tunables global until we had a solution.  We have began to move tunables back to modules if they are only used in that module, for example, named_write_master_zones.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
