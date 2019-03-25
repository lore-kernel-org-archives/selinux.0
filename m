Return-Path: <SRS0=9nT4=R4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649DDC43381
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 21:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3E62070D
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 21:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbfCYVhV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:37:21 -0400
Received: from smtprelay0089.hostedemail.com ([216.40.44.89]:60248 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729297AbfCYVhU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Mar 2019 17:37:20 -0400
X-Greylist: delayed 558 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Mar 2019 17:37:19 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave07.hostedemail.com (Postfix) with ESMTP id AE4801801E22C
        for <selinux@vger.kernel.org>; Mon, 25 Mar 2019 21:28:02 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 3DD20180A884F;
        Mon, 25 Mar 2019 21:28:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: chair48_286528b3f2a55
X-Filterd-Recvd-Size: 3657
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Mar 2019 21:27:57 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Joe Perches <joe@perches.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>
Subject: Bad file pattern in MAINTAINERS section 'SELINUX SECURITY MODULE'
Date:   Mon, 25 Mar 2019 14:27:55 -0700
Message-Id: <20190325212756.27603-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

A file pattern line in this section of the MAINTAINERS file in linux-next
does not have a match in the linux source files.

This could occur because a matching filename was never added, was deleted
or renamed in some other commit.

The commits that added and if found renamed or removed the file pattern
are shown below.

Please fix this defect appropriately.

1: ---------------------------------------------------------------------------

linux-next MAINTAINERS section:

	13949	SELINUX SECURITY MODULE
	13950	M:	Paul Moore <paul@paul-moore.com>
	13951	M:	Stephen Smalley <sds@tycho.nsa.gov>
	13952	M:	Eric Paris <eparis@parisplace.org>
	13953	L:	selinux@vger.kernel.org
	13954	W:	https://selinuxproject.org
	13955	W:	https://github.com/SELinuxProject
	13956	T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
	13957	S:	Supported
-->	13958	F:	include/linux/selinux*
	13959	F:	security/selinux/
	13960	F:	scripts/selinux/
	13961	F:	Documentation/admin-guide/LSM/SELinux.rst

2: ---------------------------------------------------------------------------

The most recent commit that added or modified file pattern 'include/linux/selinux*':

commit 679655daffdd2725b66ba2c5a759bbcb316fca5a
Author: Joe Perches <joe@perches.com>
Date:   Tue Apr 7 20:44:32 2009 -0700

    MAINTAINERS - Add file patterns
    
    Better description of file pattern tag "F:"
    Add file exclusion tag "X:"
    Add patterns to sections
    
    Signed-off-by: Joe Perches <joe@perches.com>

 MAINTAINERS | 1194 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 1193 insertions(+), 1 deletion(-)

3: ---------------------------------------------------------------------------

The last commit with a real presence of file pattern 'include/linux/selinux*':

commit 3d252529480c68bfd6a6774652df7c8968b28e41
Author: Casey Schaufler <casey@schaufler-ca.com>
Date:   Fri Sep 21 17:17:34 2018 -0700

    SELinux: Remove unused selinux_is_enabled
    
    There are no longer users of selinux_is_enabled().
    Remove it. As selinux_is_enabled() is the only reason
    for include/linux/selinux.h remove that as well.
    
    Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
    Reviewed-by: Kees Cook <keescook@chromium.org>
    Signed-off-by: Kees Cook <keescook@chromium.org>

 include/linux/cred.h             |  1 -
 include/linux/selinux.h          | 35 -----------------------------------
 security/selinux/Makefile        |  2 +-
 security/selinux/exports.c       | 23 -----------------------
 security/selinux/hooks.c         |  1 -
 security/selinux/include/audit.h |  3 ---
 security/selinux/ss/services.c   |  1 -
 7 files changed, 1 insertion(+), 65 deletions(-)
