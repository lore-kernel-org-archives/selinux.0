Return-Path: <SRS0=XIqT=26=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79477C282DD
	for <selinux@archiver.kernel.org>; Thu,  9 Jan 2020 17:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D77B20678
	for <selinux@archiver.kernel.org>; Thu,  9 Jan 2020 17:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="i/r0ZqsU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388251AbgAIRpk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jan 2020 12:45:40 -0500
Received: from mailomta28-sa.btinternet.com ([213.120.69.34]:63339 "EHLO
        sa-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731905AbgAIRpj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Jan 2020 12:45:39 -0500
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-048.btinternet.com with ESMTP
          id <20200109174537.EEDI8264.sa-prd-fep-048.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Thu, 9 Jan 2020 17:45:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1578591937; 
        bh=+XBhGv/nqbgy3b/N1v2yLE85MM+iEExpCJbpQ2yJwAg=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=i/r0ZqsUkxWqKpUBCfdxFvH+iHyxBVBkqm7aV3ZccYO67T/iv18KySrSWHQ3MSvFLu3n22fswFqpqhVUGdbdI2qTxJY5FY/APVg1BB7esF8P+PjP5YLfvzB3ZHcoptQMbmblv8PKhVLB5xozCXMSmt8vdUjHk9cGSD4QqEKRoF2Sz/FdP3EUsNokU76XGK/9iG/TRPyLfAPlvbGFkD8/V3+qjf4tZ91+GmAvRyQdrCr6CtDBcC4mVfiujMlZOD/Bco1UL5l4kt1EiDc+Y/rcqxOWYk7wSk09sWNhpS2o2iXCwiu1VBDK2RRxoxLK37CGJvj17DkCDO7iGg1n8SJLGQ==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.6.185]
X-OWM-Source-IP: 86.134.6.185 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedufedrvdeiuddgjedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeekiedrudefgedriedrudekheenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefgedriedrudekhedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehomhhoshhnrggtvgesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssehhohhtmhgrihhlrdgtohhmqedprhgtphhtthhopeeoshgushesthihtghhohdrnhhsrgdrghhovheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.6.185) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5D8362CD13BDBAF2; Thu, 9 Jan 2020 17:45:37 +0000
Message-ID: <08f16559c578a82becdb68ec6dc77ea057fe5042.camel@btinternet.com>
Subject: Re: [PATCH V2 1/1] selinux-testsuite: Add filesystem tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
Cc:     omosnace@redhat.com
Date:   Thu, 09 Jan 2020 17:45:36 +0000
In-Reply-To: <aa333bd1-9fd8-b4a4-eba2-aa8d722cbc7e@tycho.nsa.gov>
References: <20200109150709.360345-1-richard_c_haines@btinternet.com>
         <20200109150709.360345-2-richard_c_haines@btinternet.com>
         <aa333bd1-9fd8-b4a4-eba2-aa8d722cbc7e@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 2020-01-09 at 12:19 -0500, Stephen Smalley wrote:
> On 1/9/20 10:07 AM, Richard Haines wrote:
> > Test filesystem permissions and setfscreatecon(3).
> > 
> >  From kernels 5.5 filesystem { watch } is also tested.
> > 
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > ---
> > diff --git a/policy/test_filesystem.te b/policy/test_filesystem.te
> > new file mode 100644
> > index 0000000..2eee1fc
> > --- /dev/null
> > +++ b/policy/test_filesystem.te
> > @@ -0,0 +1,324 @@
> > +#
> > +######### Test filesystem permissions policy module ##########
> > +#
> > +attribute filesystemdomain;
> > +
> > +#################### Create a test file context
> > ######################
> > +type test_filesystem_filecon_t;
> > +unconfined_runs_test(test_filesystem_filecon_t)
> > +
> > +################# Test all functions ##########################
> > +type test_filesystem_t;
> > +domain_type(test_filesystem_t)
> > +unconfined_runs_test(test_filesystem_t)
> > +typeattribute test_filesystem_t testdomain;
> > +typeattribute test_filesystem_t filesystemdomain;
> > +
> > +allow test_filesystem_t self:capability { sys_admin };
> > +allow test_filesystem_t self:filesystem { mount remount quotamod
> > relabelfrom relabelto unmount quotaget };
> > +allow test_filesystem_t self:dir { mounton add_name write };
> > +allow test_filesystem_t test_file_t:dir { mounton write
> > remove_name rmdir };
> > +# Create test file
> > +allow test_filesystem_t self:dir { add_name write };
> > +allow test_filesystem_t self:file { create relabelfrom relabelto
> > };
> > +
> > +fs_mount_all_fs(test_filesystem_t)
> > +fs_remount_all_fs(test_filesystem_t)
> > +fs_unmount_all_fs(test_filesystem_t)
> > +fs_relabelfrom_all_fs(test_filesystem_t)
> > +fs_get_xattr_fs_quotas(test_filesystem_t)
> > +files_search_all(test_filesystem_t)
> > +# Required for mount opts
> > "rootcontext=system_u:object_r:test_filesystem_t:s0";
> > +fs_associate(test_filesystem_t)
> > +fs_getattr_xattr_fs(test_filesystem_t)
> > +
> > +# For running quotacheck(8)
> > +files_type(test_filesystem_t)
> > +# Update quotas
> > +fs_set_all_quotas(test_filesystem_t)
> > +allow test_filesystem_t self:file { quotaon };
> > +# Create test file and change context:
> > +fs_associate(test_filesystem_filecon_t)
> > +allow test_filesystem_t test_filesystem_filecon_t:file { open read
> > getattr relabelto write };
> > +dontaudit test_filesystem_t kernel_t:process { setsched };
> 
> Why do you need these dontaudit statements?  It seems like a kernel
> bug 
> if something is triggering a setsched permission check on the
> kernel_t 
> domain?  Something the kernel module is doing during initialization?
> 

I only added these to have a clean log output. As I'm (not knowingly)
using anything that requires it. I'll investigate further.

