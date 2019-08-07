Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C442AC32756
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A56021743
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RbgeQ5ZG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730529AbfHGWmz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 18:42:55 -0400
Received: from sonic309-22.consmr.mail.bf2.yahoo.com ([74.6.129.196]:40502
        "EHLO sonic309-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730426AbfHGWmz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 18:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565217773; bh=3RKMnie7AzuXKHC/Adxyjxj+QqJlEBDoqVdUVenZM5c=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=RbgeQ5ZGTeOrrwSnWc72h6kyk0XcQE7LJYw05sgeYiJCWIL51fF63Vsxr6WRDFn5KNYvAxCUp4nga3L/OO33x+efqCHdvu/5k+BjZCMVtktHziOO69j9OLWnDxaV7eC3bAhmLKLEC5bXVrY4wgmz9g7x3xFW5gd3spx1nYdMukSU5i3Ggw3Jbi1ti9lSYtj8F42FuyL4LMLVYdEgbOtdKvP4KYwrUz1GhmS/2rDFB2w3F+xRyXlv2MOUlQqaWHb8aio2DiedcqoOuuh1brr4Ei4zFwAUvwQlvtH64z1tGOG/8SE45vMqrQ/rrNWZwKweLRUl2fgzkYUfpjzPV+4FNA==
X-YMail-OSG: 2O_bOfMVM1l7LREw7Jn_YOx65pXM7SSZVq.01_60uS7ffNMWoZENpVzrWuUHucq
 cBH7.olap7VhJyrEwaKz0SVGs6c6MivbRnjfePYlVRqg6kocFnOzgWwajY5cyRrqb3wqQP.3NEEk
 SSKA.m0DdSxk2aQ2X8R8Hm18WmUxHSjHzvFPVGKlh51dw3f.gG2v9Jqs8YUXkGFJionQ.hcey5CT
 a2IfwvhLfCUI7sL3wY_aQF6rWX.7iweGYtYtlh.chrC78m0SCSZ3lqtOI7mtjMOOaR9u70ljAG2F
 k_0EdIBBqxTIqypFyLZRutaDdJwSVCbXN8ED8WL..SKEgDnbQVYJjDPsjwnr5isHkMhsiCDrsUCK
 plIBaXJQl9Cm6GeyiRgJvPOtbWaY9URG2dm6FGGDkYff_1BGwF5eVrYXoMxrSgAiFJ4CQubfuFo6
 YQGBAtoOr43SzSux6OfYNNThG4d.CQ3VOwl6cQ.QuHUS0XKqLxtbPGNEY6DMOJuQMSOjSyqGX3bQ
 zdRPsswEA3a2ozwfKwor70oMVANkySinotkZqEjcfCTU6MXEVHewXJmqQ98MAK1sjDEumYv_L935
 Hit9uGxPtBjV7AfCyDFwX6jok7hZRrn0uP_HzOjHeQ19ytgBt9BEdZ764rHJNe.5zQAu.vpfp7UR
 Yjq3Ow5lSTGNA0_2RPS7X7KefzLjYPm5O7KtDHkk8qNkGu80inkgKmLwx.3.kzKjIckuwTk.koWc
 dZe2lOlbhpbScbaNpzveClF66V9uII8WOmU6Oj2axDOLToNpOy_RJHThisbpYo8nEVi.cBdS_YQM
 ARKVs8Zn5tA6OenRJQg2dcg0_adcVL57QPv8DQCXUcqoKqesi3z4W2fRbTz6AdxLMoOUz18WiiGc
 Ybmk_lLmBLnWSqod3tidh1raL36627oQ3YAwusFEKeycDLIdJ9IRiQK3Qk5CHKnodrFfXHvyJPHY
 byFPQTHiKgo5GT6cOaxPZYYTfQSYxPLYTZsOlSzqafdIVZ8E3r.BEZ.p65VKw_06Ov72.h9MQeDm
 EmKYXlTF1UMOVL6lWawpP3AORlH5t7cQnBLOYqMLmHWzJc8EJA3dpS2Hke7Mo4zpVKzfkaz3TxwE
 73N5C5vcWDHKc19bB20Ovh.di0VXBW7_MC9O8aHOlEPdda.acgy4.yDtvfhhQR6xShNYO7bZgtvK
 6bDAJNt8lQ6Yk94vbMoyfvJSZWzRQh3xddGbqeYnmCTniQQnvHZE8BjvZRFP5tmRxecyqvWss9yN
 HK3Zrh9_c7rR0lJ5e_SMKCdNOr3CsyNSl3HGzC4ZAdhNfURELzmfQUjLHEiN44yLTFCY.bC5vOtx
 38PuHvXNpdO1W4YY8BX8lur4QBTtdcQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Wed, 7 Aug 2019 22:42:53 +0000
Received: by smtp429.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 824faaf1f4a5ffbf9b87c6192a4b2124;
          Wed, 07 Aug 2019 22:42:50 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 00/16] LSM: Full module stacking
Date:   Wed,  7 Aug 2019 15:42:29 -0700
Message-Id: <20190807224245.10798-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807224245.10798-1-casey@schaufler-ca.com>
References: <20190807224245.10798-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Provide mechanisms for security modules that use network interfaces
to operate on the same system safely. Provide mechanisms for kerfs
to maintain information about all the security modules active on
a system. With these mechanisms in place, any combination of
existing security modules can be used. 

It is not clear that all issues with the integrity calls have
been addressed. Any review there would be much appreciated.
There should be a mechanism in netfilter to identify which
security module a given rule is associated with, but none is
proposed here. Instead, the module first registered is given
the secmark. Labeled NFS is an incomplete implementation,
missing the "LFS" data needed to identify the format of the
labels passed. The first registered assumption is made here
as well. The Netlabel restriction that all sent attributes must
be agreeable to all modules is reasonable. The implementation
is awkward, and insights into improvement would be most welcome.

It is important to be aware that while the mechanisms have
been made cohabitational, there is no guarantee that the policies
imposed by the security modules will be compatible. The handling
of unlabeled IP packets using Netlabel is very different in
SELinux and Smack. The use of capabilities is also very different
in those modules.

This has been tested on Fedora29 and Ubuntu19.04 using
unmodified policies. The SELinux test suite demonstrates
policy conflict issues when used with Smack.

Patches 0001-0002 change the secmark_refcount LSM interfaces
to call only the first registered security module's hooks.
Smack is modified to use these interfaces to determine if the
Internet Protocol secmark is meaningful to Smack.

Patches 0003 and 0009 refactor security_inode_init_security() to
accommodate integrity checking on multiple active security
attributes.

Patch 0004 updates security_inode_listsecurity() to provide
multiple security attributes instead of just one.

Patches 0005-0007 address NFS and kernfs. Labeled nfs has no
mechanism to identify what kind of label (e.g. CIPSO or Flask)
that is being sent across the wire, so an arbitrary choice must
be made on how NFS labels are handled. The module in lsmslot 0
is always used. Kernfs uses context strings to store security
attributes, so those are now saved in the "compound" format.

Patch 0008 provides infrastructure management of mount
option data.

Patch 0010 addresses the case where one security module may fail
to provide a valid secid on datagrams where another succeeds.

Patches 0011-0015 allow the LSM infrastructure to check whether
the security modules agree on network security attributes when
netlabel is being used.

Patch 0016 removes the exclusive flag from Smack.

A note on the "v7" designation: This depends on the stack-5.2-v7-apparmor
patches provided earlier. Since that is "v7" I've used the same number
here in the hopes that it will reduce confusion.

https://github.com/cschaufler/lsm-stacking.git#stack-5.2-v7-full

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/kernfs/inode.c                   |   3 +-
 fs/nfs/inode.c                      |   9 +-
 fs/nfsd/nfs4proc.c                  |   6 +-
 fs/nfsd/vfs.c                       |   5 +-
 include/linux/lsm_hooks.h           |  23 +-
 include/linux/security.h            |  30 ++-
 include/net/netlabel.h              |   8 +
 net/ipv4/ip_sockglue.c              |   4 +-
 net/netlabel/netlabel_kapi.c        | 120 ++++++++---
 security/security.c                 | 419 +++++++++++++++++++++++++++---------
 security/selinux/hooks.c            |  54 +++--
 security/selinux/include/netlabel.h |   7 +
 security/selinux/include/objsec.h   |   1 +
 security/selinux/netlabel.c         |  46 ++--
 security/smack/smack.h              |  17 ++
 security/smack/smack_lsm.c          | 128 +++++++----
 security/smack/smack_netfilter.c    |  45 +++-
 17 files changed, 689 insertions(+), 236 deletions(-)
