Return-Path: <SRS0=axcH=7H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35224C433E0
	for <selinux@archiver.kernel.org>; Mon, 25 May 2020 15:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FDBD2078B
	for <selinux@archiver.kernel.org>; Mon, 25 May 2020 15:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390998AbgEYP5L (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 May 2020 11:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390951AbgEYP5L (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 May 2020 11:57:11 -0400
X-Greylist: delayed 431 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 May 2020 08:57:11 PDT
Received: from linode.cmadams.net (linode.cmadams.net [IPv6:2600:3c03:e000:bd::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C71C061A0E
        for <selinux@vger.kernel.org>; Mon, 25 May 2020 08:57:11 -0700 (PDT)
Received: by linode.cmadams.net (Postfix, from userid 1000)
        id 49W1kb5bnqz6thX; Mon, 25 May 2020 10:49:59 -0500 (CDT)
Date:   Mon, 25 May 2020 10:49:59 -0500
From:   Chris Adams <linux@cmadams.net>
To:     selinux@vger.kernel.org
Subject: Issue with fixfiles excludes
Message-ID: <20200525154959.GB31281@cmadams.net>
Mail-Followup-To: selinux@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

After an SELinux policy update on Fedora 31 triggered a fixfiles that
ran for hours and hours, I looked into why.  It turns out that I have
BackupPC backing up to a different location (separate filesystem mounted
under /srv), so fixfiles was going through millions and millions of
files/directories.

There's a hard-coded exclude list in fixfiles that includes
/var/lib/BackupPC, which seems weird (why BackupPC and no other backup
program?).  Also, there's support for a separate local exclude list -
it's in the man page, but IMHO a little buried towards the end of a
paragraph.

My suggestion would be:

- Make the exclude documentation separated in the man page to make it
  stand out more.

- Make the exclude file a exclude.d directory, so packages can drop in
  exclusions (maybe /etc/selinux/fixfiles.d/*.exclude or the like).

- Remove most/all of the hard-coded exclusions from the script and move
  them to relevant packages; could maybe keep the virtual FS like /sys
  and /proc in the script, but even put things like /mnt and /home in a
  fixfiles.d/default.exclude so they could be overridden by local
  policy.  Then if BackupPC should be excluded, the BackupPC package
  would include the config (which would be a little more obvious to see
  if you move its storage).

Is there any upstream interest in this?  It would all be
straight-forward to change - I can submit a patch if there's a
reasonable chance it would be accepted.

-- 
Chris Adams <linux@cmadams.net>
