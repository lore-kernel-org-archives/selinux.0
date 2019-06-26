Return-Path: <SRS0=8O8t=UZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E42C48BD3
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 19:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3CA216FD
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 19:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="eV6f6cvG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfFZTWp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jun 2019 15:22:45 -0400
Received: from sonic310-22.consmr.mail.bf2.yahoo.com ([74.6.135.196]:34027
        "EHLO sonic310-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726320AbfFZTWn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jun 2019 15:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561576959; bh=wLMKTvl3GZE8SXIqnUpw5zpH/sCm0NpuJwAVAz2h1MU=; h=From:To:Cc:Subject:Date:From:Subject; b=eV6f6cvG9QbNtAh2mVC0CJ943/W8bkwNEYKF6I0SwZXPhri7g0hZ2dA4iQu6bWe8250DUvOOWb/C8yCW7UNRI4S2uVebiO1vB0UVJj+AzZeF9gsjSRDqnlvfLsxxQoFfP604i2PqWeXlkCmt72S2SUox69s+Xeh6vFUi8kLpverrXVrDxGCn088336+PdzJi5re/hh9ntL6e0aQO2/SrqtH0vUcSy+t/YRTNtx862S1vbk1sMLLBEEm/5aD931F+dAoHavuWTuqnKml/nYG/2OPvsMMYf8YjCpQeYmnLjiTRQixPhr4Q9z5OAuemqdnflwDKY/aSOmYFA/UUv+eJTw==
X-YMail-OSG: JUHnrXoVM1mdmhZv492xKsP55xxObWw_okEyoUU9FDsnV2OCiFoXkMWwuzgGwLK
 pAKMfV6kWjrnz.0iE81WpdHswJZ2VzkbJd83N67uFQmJQpKe9qiD79VLTtESe3HvGfXyiPq3AdDy
 AI3eLjLm8YZ3b32ImA.gvin_MgXz7qYC6ZeXj51ycmiXxEAfqf85UeCWfimV3kJPfqCM7DfLtx08
 Qks9gV5jjIsgYFC7FM6eL649dLSzq078pOeco8gU88H0NXnmr6PodWkqWIxG_Ut.7ASspooUC2Z3
 MyzjtO8qmmrMM3vVSmkXGQfGJOdiTgRX3PlKpavxqC_4B.ED4xLhoVLrZfxnJyQHp9IpHjMb8To8
 Zy1ZdHrgUbe.a0rrTTGaMJbMh9tBBy02SMVwMIczVoShZ05s7w.ujdMqL_bRSAEpXhTYyV2Wy555
 sXQSNamTpBnhNFN23WPmA9tJLzBuqqBvzTi2Kxsp3FBCpC5.X5_SemH0qaQholr6xQJtAEOuxti_
 ytI8A26.YoL84cjellQUdt4U.MF7FGbSSp0UabrH5Nybpd8ARB76i.xsGnGyad6GPsLQlDZagO_.
 VOlribad8qYiB3RJfv2fLR7Lmmv71nS4kqF_TbfE0fib94Zphv0ZTeBD48e4wSGGpVA.gvcezdHv
 FZaB6VPtZ53KP2TytaMuvFVMKiUmeAWL2sbGoN5k8EMr8S9qUvv4HFZ8DGOL6pzrynmJ2wYYZ.pw
 3.Ee8c0iH4TFpYCbZJSjTHzquLKOS0ulL9PdLvMgg5j58QEPMsyJJTW0OzKYaoQpFio2c52BASOn
 0jv6tH2d_0.1YZv0SJzKKNj2coZ.TiQ2mknbbhJpXy8_jCgmji4_u2BbQAIu4M4A1ut2a8b739gr
 YMxGNDMwSYfk9UNir9yYwwVz54MAmjxdClBHqOr0S6lAUwYshBYq_0ksTuSaSbNx0Hvz9L_DCc7a
 h.AMSwn6hKk1fTclK5d3xR8m64ylSV0Lom1PYyMWBz7qM1du2TI46ZpVos2v_CXgB_Pun6hTMIy9
 u9FHdFsa2a0HT2qYV0Yja0U_u9fdr54hI23zjpPCEp15KcNeM9qO_I5gxB3pStNbPVZQe2HJGLzK
 JhNUmf4JMP53e1PVXLRBDt.va1iMKSPV.oEHSY.a1VH9I5ucAGcqdbPEjNwOH6Ae1IRplmP0k2ak
 ZDh2UyfTsgTXIZBlDSMs91egoDnctPz785ZVnNYpw1C4vo3ejxQ50bZmCXZ1J3n_sKCAZVLCnHrJ
 Wu8b9o2Lyau7y..5x6pKI_a7.03j_Sx8hasQAlEVkvMudDVHQMpPqjDIqrwms
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Wed, 26 Jun 2019 19:22:39 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp424.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8851378117cc34b5f34e848cd09a5ce8;
          Wed, 26 Jun 2019 19:22:38 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v4 00/23] LSM: Module stacking for AppArmor
Date:   Wed, 26 Jun 2019 12:22:11 -0700
Message-Id: <20190626192234.11725-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patchset provides the changes required for
the AppArmor security module to stack safely with any other.

Because of the changes to slot handling and the rework of
"display" I have not included the Reviewed-by tags from the
previous version.

v4: Incorporate feedback from v3
    - Mark new lsm_<blob>_alloc functions static
    - Replace the lsm and slot fields of the security_hook_list
      with a pointer to a LSM allocated lsm_id structure. The
      LSM identifies if it needs a slot explicitly. Use the
      lsm_id rather than make security_add_hooks return the
      slot value.
    - Validate slot values used in security.c
    - Reworked the "display" process attribute handling so that
      it works right and doesn't use goofy list processing.
    - fix display value check in dentry_init_security
    - Replace audit_log of secids with '?' instead of deleting
      the audit log

v3: Incorporate feedback from v2
    - Make lsmblob parameter and variable names more
      meaningful, changing "le" and "l" to "blob".
    - Improve consistency of constant naming.
    - Do more sanity checking during LSM initialization.
    - Be a bit clearer about what is temporary scaffolding.
    - Rather than clutter security_getpeersec_dgram with
      otherwise unnecessary checks remove the apparmor
      stub, which does nothing useful.

Patches 0001-0003 complete the process of moving managment
of security blobs that might be shared from the individual
modules to the infrastructure.

Patches 0004-0014 replace system use of a "secid" with
a structure "lsmblob" containing information from the
security modules to be held and reused later. At this
point lsmblob contains an array of u32 secids, one "slot"
for each of the security modules compiled into the
kernel that used secids. A "slot" is allocated when
a security module requests one.
The infrastructure is changed to use the slot number
to pass the correct secid to or from the security module
hooks.

It is important that the lsmblob be a fixed size entity
that does not have to be allocated. Several of the places
where it is used would have performance and/or locking
issues with dynamic allocation.

Patch 0015 provides a mechanism for a process to
identify which security module's hooks should be used
when displaying or converting a security context string.
A new interface /proc/.../attr/display contains the name
of the security module to show. Reading from this file
will present the name of the module, while writing to
it will set the value. Only names of active security
modules are accepted. Internally, the name is translated
to the appropriate "slot" number for the module which
is then stored in the task security blob.

Patch 0016 Starts the process of changing how a security
context is represented. Since it is possible for a
security context to have been generated by more than one
security module it is now necessary to note which module
created a security context so that the correct "release"
hook can be called. There are several places where the
module that created a security context cannot be inferred.

This is achieved by introducing a "lsmcontext" structure
which contains the context string, its length and the
"slot" number of the security module that created it.
The security_release_secctx() interface is changed,
replacing the (string,len) pointer pair with a lsmcontext
pointer.

Patches 0012-0021 convert the security interfaces from
(string,len) pointer pairs to a lsmcontext pointer.
The slot number identifying the creating module is
added by the infrastructure. Where the security context
is stored for extended periods the data type is changed.

The Netlabel code is converted to save lsmblob structures
instead of secids in Patch 0022.

Finally, with all interference on the AppArmor hooks
removed, Patch 0023 removes the exclusive bit from
AppArmor. An unnecessary stub hook was also removed.

The Ubuntu project is using an earlier version of
this patchset in their distribution to enable stacking
for containers.

Performance measurements to date have the change
within the "noise". Better benchmarks are in the
works.

https://github.com/cschaufler/lsm-stacking.git#stack-5.2-v4-apparmor

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
