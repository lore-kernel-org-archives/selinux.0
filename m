Return-Path: <SRS0=2vFY=3C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2139C33CA9
	for <selinux@archiver.kernel.org>; Mon, 13 Jan 2020 18:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B88420678
	for <selinux@archiver.kernel.org>; Mon, 13 Jan 2020 18:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="UHRnVdgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgAMSBB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Jan 2020 13:01:01 -0500
Received: from mailomta32-re.btinternet.com ([213.120.69.125]:22780 "EHLO
        re-prd-fep-045.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728633AbgAMSBB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Jan 2020 13:01:01 -0500
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
          by re-prd-fep-045.btinternet.com with ESMTP
          id <20200113180057.KZBY9262.re-prd-fep-045.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>;
          Mon, 13 Jan 2020 18:00:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1578938457; 
        bh=RvxgIZTLNNMJSjk+jPtg/arb/XYrzIXJJC/f5dun0M0=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=UHRnVdgK0jbDvDho0JDIV6Cp8Jsq/viO45WNDi2gaSeVAIAocJCtkon9jEIRF9CXOmVEqshaAjrJNep/t6uAaRn+uH2//wm4GKXi6mbErjxmfjDDOuBNUjmfbzexyDdwqBG4vgWSXlF8SdFmvtacviBfYE/YBQ0uk9mm6E2bQRyB7lJXbKFnqcfzoheL39QQe8KDEHffzGR2mc4YEcSMC4V5y93JTVEEpwyMwC5rWnOOdhF1FQqZNLg9h8cs2i9kS9pbcpKX8FVwnm7+BBbpfT8WdToQ2hnARXR4yyyjFcTNha1IGTaVfuwX+QbIFxjtDe3v1rJgD2LrX0zZ+2YhsQ==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [31.49.60.79]
X-OWM-Source-IP: 31.49.60.79 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedufedrvdejtddguddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeefuddrgeelrdeitddrjeelnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepfedurdegledriedtrdejledpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehomhhoshhnrggtvgesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvsheshhhothhmrghilhdrtghomheqpdhrtghpthhtohepoehsughssehthigthhhordhnshgrrdhgohhvqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.49.60.79) by re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5E1A2F6C0059318F; Mon, 13 Jan 2020 18:00:57 +0000
Message-ID: <d4b6bba25680422ee686ca55761846e7394a1774.camel@btinternet.com>
Subject: Re: [PATCH V2 1/1] selinux-testsuite: Add filesystem tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
Cc:     omosnace@redhat.com, Paul Moore <paul@paul-moore.com>
Date:   Mon, 13 Jan 2020 18:00:56 +0000
In-Reply-To: <c3b50363-8307-0dcf-d8b4-ce2d4cc7563c@tycho.nsa.gov>
References: <20200109150709.360345-1-richard_c_haines@btinternet.com>
         <20200109150709.360345-2-richard_c_haines@btinternet.com>
         <aa333bd1-9fd8-b4a4-eba2-aa8d722cbc7e@tycho.nsa.gov>
         <f2cebe3fcb2960a2b51638d457ae07781896a12c.camel@btinternet.com>
         <c2cc9f48-4dd3-cdf4-8c4e-3575ffc05aaf@tycho.nsa.gov>
         <f863a91987c1926a4351f3edf968c9003197fead.camel@btinternet.com>
         <956ad05b-9b1e-9d0b-75d1-02b02858a835@tycho.nsa.gov>
         <c3b50363-8307-0dcf-d8b4-ce2d4cc7563c@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 2020-01-13 at 09:07 -0500, Stephen Smalley wrote:
> On 1/13/20 8:52 AM, Stephen Smalley wrote:
> > On 1/12/20 11:04 AM, Richard Haines wrote:
> > > On Fri, 2020-01-10 at 13:18 -0500, Stephen Smalley wrote:
> > > > On 1/10/20 1:09 PM, Richard Haines wrote:
> > > > > On Thu, 2020-01-09 at 12:19 -0500, Stephen Smalley wrote:
> > > > > > On 1/9/20 10:07 AM, Richard Haines wrote:
> > > > > > > Test filesystem permissions and setfscreatecon(3).
> > > > > > > 
> > > > > > >    From kernels 5.5 filesystem { watch } is also tested.
> > > > > > > 
> > > > > > > Signed-off-by: Richard Haines <
> > > > > > > richard_c_haines@btinternet.com>
> > > > > > > ---
> > > > > > > diff --git a/policy/test_filesystem.te
> > > > > > > b/policy/test_filesystem.te
> > > > > > > new file mode 100644
> > > > > > > index 0000000..2eee1fc
> > > > > > > --- /dev/null
> > > > > > > +++ b/policy/test_filesystem.te
> > > > > > > @@ -0,0 +1,324 @@
> > > > > > > +#
> > > > > > > +######### Test filesystem permissions policy module
> > > > > > > ##########
> > > > > > > +#
> > > > > > > +attribute filesystemdomain;
> > > > > > > +
> > > > > > > +#################### Create a test file context
> > > > > > > ######################
> > > > > > > +type test_filesystem_filecon_t;
> > > > > > > +unconfined_runs_test(test_filesystem_filecon_t)
> > > > > > > +
> > > > > > > +################# Test all functions
> > > > > > > ##########################
> > > > > > > +type test_filesystem_t;
> > > > > > > +domain_type(test_filesystem_t)
> > > > > > > +unconfined_runs_test(test_filesystem_t)
> > > > > > > +typeattribute test_filesystem_t testdomain;
> > > > > > > +typeattribute test_filesystem_t filesystemdomain;
> > > > > > > +
> > > > > > > +allow test_filesystem_t self:capability { sys_admin };
> > > > > > > +allow test_filesystem_t self:filesystem { mount remount
> > > > > > > quotamod
> > > > > > > relabelfrom relabelto unmount quotaget };
> > > > > > > +allow test_filesystem_t self:dir { mounton add_name
> > > > > > > write };
> > > > > > > +allow test_filesystem_t test_file_t:dir { mounton write
> > > > > > > remove_name rmdir };
> > > > > > > +# Create test file
> > > > > > > +allow test_filesystem_t self:dir { add_name write };
> > > > > > > +allow test_filesystem_t self:file { create relabelfrom
> > > > > > > relabelto
> > > > > > > };
> > > > > > > +
> > > > > > > +fs_mount_all_fs(test_filesystem_t)
> > > > > > > +fs_remount_all_fs(test_filesystem_t)
> > > > > > > +fs_unmount_all_fs(test_filesystem_t)
> > > > > > > +fs_relabelfrom_all_fs(test_filesystem_t)
> > > > > > > +fs_get_xattr_fs_quotas(test_filesystem_t)
> > > > > > > +files_search_all(test_filesystem_t)
> > > > > > > +# Required for mount opts
> > > > > > > "rootcontext=system_u:object_r:test_filesystem_t:s0";
> > > > > > > +fs_associate(test_filesystem_t)
> > > > > > > +fs_getattr_xattr_fs(test_filesystem_t)
> > > > > > > +
> > > > > > > +# For running quotacheck(8)
> > > > > > > +files_type(test_filesystem_t)
> > > > > > > +# Update quotas
> > > > > > > +fs_set_all_quotas(test_filesystem_t)
> > > > > > > +allow test_filesystem_t self:file { quotaon };
> > > > > > > +# Create test file and change context:
> > > > > > > +fs_associate(test_filesystem_filecon_t)
> > > > > > > +allow test_filesystem_t test_filesystem_filecon_t:file {
> > > > > > > open
> > > > > > > read
> > > > > > > getattr relabelto write };
> > > > > > > +dontaudit test_filesystem_t kernel_t:process { setsched
> > > > > > > };
> > > > > > 
> > > > > > Why do you need these dontaudit statements?  It seems like
> > > > > > a
> > > > > > kernel
> > > > > > bug
> > > > > > if something is triggering a setsched permission check on
> > > > > > the
> > > > > > kernel_t
> > > > > > domain?  Something the kernel module is doing during
> > > > > > initialization?
> > > > > > 
> > > > > 
> > > > > I've tracked this down to them all being called from
> > > > > block/ioprio.c
> > > > > with: security_task_setioprio(task, ioprio) ->
> > > > > selinux_task_setioprio
> > > > > 
> > > > > Why the SECCLASS_PROCESS, PROCESS__SETSCHED I've no idea. The
> > > > > following
> > > > > also use SET/GETSCHED permission:
> > > > > 
> > > > > selinux_task_getioprio, selinux_task_setnice,
> > > > > selinux_task_movememory
> > > > 
> > > > The confusing bit is that it is between test_filesystem_t and
> > > > kernel_t.
> > > > If the process was setting its own ioprio, then I'd expect to
> > > > see
> > > > the
> > > > denial between test_filesystem_t and test_filesystem_t aka
> > > > self.  If
> > > > the
> > > > process inserted a kernel module and the module initializer
> > > > spawned
> > > > a
> > > > kernel thread that set its ioprio, I would expect it to be
> > > > kernel_t
> > > > to
> > > > kernel_t.
> > > 
> > > Some more info on who calls set_task_ioprio:
> > > 
> > > fs/ext4/super.c calls 'set_task_ioprio' in two places using:
> > >      set_task_ioprio(sbi->s_journal->j_task, journal_ioprio);
> > > The return codes are not checked. This code was added 11 years
> > > ago.
> > > 
> > > fs/btrfs/reada.c also calls 'set_task_ioprio' in two places
> > > using:
> > >      set_task_ioprio(current, BTRFS_IOPRIO_READA);
> > > The return codes are not checked.
> > > 
> > > As can be seen the ext4 module does not use 'current'. I have
> > > patched
> > > kernel 5.5-rc5 to use 'current' and it now works as you expected.
> > > Also
> > > the kernel_t:process { setsched } rules can be removed.
> > > As the problem will exist for some time, I've added to the test
> > > policy:
> > >      kernel_dontaudit_setsched(filesystemdomain)
> > > 
> > > It appears that most of the refpolicy modules do the same.
> > 
> > This seems like a kernel bug to me. I assume that these
> > filesystems 
> > expect the I/O priority to be always set in these cases
> > irrespective of 
> > the permissions of the current process.  Either they should be
> > using 
> > some internal helper function ala a new set_task_ioprio_noperm()
> > that 
> > skips permission checking or they should be temporarily overriding
> > their 
> > cred to the init cred before doing this.  Probably a topic for 
> > linux-fsdevel and/or the respective per-filesystem mailing lists.
> 
> Also, looks like kernel_dontaudit_setsched() isn't defined by
> upstream 
> refpolicy so you'll need the usual ifdefery in test_policy.if to
> allow 
> this to build against refpolicy to appease travis-ci.
> 

I'll change this to domain_setpriority_all_domains() in V4 as that is
in both Fedora and Ref Policy.

> 

