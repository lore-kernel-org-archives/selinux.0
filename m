Return-Path: <SRS0=2SWW=27=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1D2C282DD
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 18:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7B1206ED
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 18:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="eTiFhRHg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgAJSJq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jan 2020 13:09:46 -0500
Received: from mailomta25-re.btinternet.com ([213.120.69.118]:46019 "EHLO
        re-prd-fep-041.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726767AbgAJSJq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jan 2020 13:09:46 -0500
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-041.btinternet.com with ESMTP
          id <20200110180943.JQYH17769.re-prd-fep-041.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Fri, 10 Jan 2020 18:09:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1578679783; 
        bh=Mtd4OSX4PSLYc3ILI40fnIc+IU/P9FYOew7+Lu9AMf4=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=eTiFhRHgviZnQA21E8WJ2VfHjEkFKvDJSg289iCu97rbOz1yTusIaG+e4BmkwlxDFs4ewAOPBQvGAJz6jBej4it3ldojBJOacppXvUESNsxyXH9x7bsl6+TRNl6fXh4aM6tyeE/yCbIYWdtDoVfp+uvGWfWff11AZc2KYaoRWFkNlmdAFp89ite8iffd0hHttfWEseLNj0Uw+idZ6n8xs2p/vdc2NFwSJzo6BDe0NWy+9upennFPlBySiQhr9zJw00TR9kS9dsJI5hVsPo3KGwIEIJTTeZLMIpx+BDhtCdY0CegveDgFc9Ba40kprPtyw0BPYZYzgCLX0IaUJ05FOw==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.6.251]
X-OWM-Source-IP: 86.134.6.251 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedufedrvdeifedguddthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepkeeirddufeegrdeirddvhedunecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeegrdeirddvhedupdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeoohhmohhsnhgrtggvsehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvsheshhhothhmrghilhdrtghomheqpdhrtghpthhtohepoehsughssehthigthhhordhnshgrrdhgohhvqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.6.251) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5DF66563046EBAC8; Fri, 10 Jan 2020 18:09:43 +0000
Message-ID: <f2cebe3fcb2960a2b51638d457ae07781896a12c.camel@btinternet.com>
Subject: Re: [PATCH V2 1/1] selinux-testsuite: Add filesystem tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
Cc:     omosnace@redhat.com
Date:   Fri, 10 Jan 2020 18:09:42 +0000
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

I've tracked this down to them all being called from block/ioprio.c
with: security_task_setioprio(task, ioprio) -> selinux_task_setioprio

Why the SECCLASS_PROCESS, PROCESS__SETSCHED I've no idea. The following
also use SET/GETSCHED permission:

selinux_task_getioprio, selinux_task_setnice, selinux_task_movememory


