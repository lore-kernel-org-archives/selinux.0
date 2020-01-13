Return-Path: <SRS0=2vFY=3C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C87EC33CA9
	for <selinux@archiver.kernel.org>; Mon, 13 Jan 2020 18:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70272084D
	for <selinux@archiver.kernel.org>; Mon, 13 Jan 2020 18:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="hkEEWO+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgAMScl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Jan 2020 13:32:41 -0500
Received: from mailomta28-sa.btinternet.com ([213.120.69.34]:18837 "EHLO
        sa-prd-fep-044.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728641AbgAMSck (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Jan 2020 13:32:40 -0500
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
          by sa-prd-fep-044.btinternet.com with ESMTP
          id <20200113183237.RCXY8432.sa-prd-fep-044.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
          Mon, 13 Jan 2020 18:32:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1578940357; 
        bh=7/4u629oM7k/w7o4chpPp72V0aXv8BSk4ms3T/7AYrg=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:MIME-Version;
        b=hkEEWO+17V1P0gUBmi5PuP7awAMGafjXVr4RdvN7YBPLZVTa7yAfPLTsT67gw/C29DqjdcbJx6Jw807QmmJH2d643kJKgZvVrEG/xqeVDyOgj8XyqIkfWV+xF2daORgE4ozfiDCbr5FBsHGCXG4eeaPCOuO8bJp6j2GNzJiGTc/AZpIrcQ7Ymus14W8Lj7TCWUbotcKoW0CC47/LgdQsih4URA1Rv/LpGe1U4i/Y/30yAB88bkLL+gtgPbE8gp0nyJP8aeR4V6qQHAQwgqXIHczh4I/HhfELbPWZBX0ifXD+v0up4H3Om43RG7qkhl2cJEOgJ1XWKPBuq72r2rE7jQ==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [31.49.60.79]
X-OWM-Source-IP: 31.49.60.79 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedufedrvdejtddgudduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepfedurdegledriedtrdejleenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrgeelrdeitddrjeelpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssehhohhtmhgrihhlrdgtohhmqedprhgtphhtthhopeeoshgushesthihtghhohdrnhhsrgdrghhovheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.49.60.79) by sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5DC137950BD599FF; Mon, 13 Jan 2020 18:32:37 +0000
Message-ID: <5c01146696d7e5e5e9132c10b9121a2830758914.camel@btinternet.com>
Subject: Re: [PATCH V3 1/1] selinux-testsuite: Add filesystem tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
Date:   Mon, 13 Jan 2020 18:32:37 +0000
In-Reply-To: <02e4c12e-7cf9-2b10-cc3e-f1570a0c35c0@tycho.nsa.gov>
References: <20200112192432.862800-1-richard_c_haines@btinternet.com>
         <20200112192432.862800-2-richard_c_haines@btinternet.com>
         <02e4c12e-7cf9-2b10-cc3e-f1570a0c35c0@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 2020-01-13 at 10:45 -0500, Stephen Smalley wrote:
> On 1/12/20 2:24 PM, Richard Haines wrote:
> > Test filesystem permissions, setfscreatecon(3), file { quotaon }
> > and
> > changing file context via 'name type_transition rule'.
> > 
> >  From kernels 5.5 filesystem { watch } is also tested.
> > 
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> 
> Aside from the travis-ci build failure when trying to build the test 
> policy against upstream refpolicy, this looks good to me.  NB you
> can 
> reproduce such failures yourself by creating your own github clone
> of 
> selinux-testsuite, enabling travis-ci on your clone, and pushing
> your 
> change to a branch of our clone.
> 
> Possible room for improvement (but I won't insist) might include:
> - test non-name based type transition rule with a different type and 
> confirm that both files are createdi in the right type (i.e. make
> sure 
> we are actually matching on the component name),
> - test two different name-based type transition rules that only
> differ 
> in name (similar),
> - add tests for the new mount API, fsopen(), fspick(), fsmount().
> 
> These could all be done as separate patches later.

If you are in no hurry for these tests I'll do them for V4.

I found a helpful example in samples/vfs/test-fsmount.c for fsmount and
fsopen. Also see they were added in 5.1

> 
> > ---
> >   defconfig                                     |   6 +
> >   policy/Makefile                               |   4 +
> >   policy/test_filesystem.te                     | 343 +++++++
> >   tests/Makefile                                |   7 +
> >   tests/filesystem/.gitignore                   |  11 +
> >   tests/filesystem/Makefile                     |  16 +
> >   tests/filesystem/check_file_context.c         |  75 ++
> >   tests/filesystem/check_mount_context.c        | 127 +++
> >   tests/filesystem/create_file.c                | 112 +++
> >   tests/filesystem/create_file_change_context.c | 146 +++
> >   tests/filesystem/fanotify_fs.c                |  79 ++
> >   tests/filesystem/fs_relabel.c                 | 138 +++
> >   tests/filesystem/grim_reaper.c                |  89 ++
> >   tests/filesystem/mount.c                      | 130 +++
> >   tests/filesystem/quotas_test.c                | 143 +++
> >   tests/filesystem/statfs_test.c                |  65 ++
> >   tests/filesystem/test                         | 929
> > ++++++++++++++++++
> >   tests/filesystem/umount.c                     |  84 ++
> >   18 files changed, 2504 insertions(+)
> >   create mode 100644 policy/test_filesystem.te
> >   create mode 100644 tests/filesystem/.gitignore
> >   create mode 100644 tests/filesystem/Makefile
> >   create mode 100644 tests/filesystem/check_file_context.c
> >   create mode 100644 tests/filesystem/check_mount_context.c
> >   create mode 100644 tests/filesystem/create_file.c
> >   create mode 100644 tests/filesystem/create_file_change_context.c
> >   create mode 100644 tests/filesystem/fanotify_fs.c
> >   create mode 100644 tests/filesystem/fs_relabel.c
> >   create mode 100644 tests/filesystem/grim_reaper.c
> >   create mode 100644 tests/filesystem/mount.c
> >   create mode 100644 tests/filesystem/quotas_test.c
> >   create mode 100644 tests/filesystem/statfs_test.c
> >   create mode 100755 tests/filesystem/test
> >   create mode 100644 tests/filesystem/umount.c

