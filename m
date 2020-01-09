Return-Path: <SRS0=XIqT=26=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1DCC282DD
	for <selinux@archiver.kernel.org>; Thu,  9 Jan 2020 17:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E372072A
	for <selinux@archiver.kernel.org>; Thu,  9 Jan 2020 17:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="IupadSeX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731936AbgAIRvT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jan 2020 12:51:19 -0500
Received: from mailomta10-re.btinternet.com ([213.120.69.103]:27211 "EHLO
        re-prd-fep-045.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731919AbgAIRvT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Jan 2020 12:51:19 -0500
Received: from re-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.54.8])
          by re-prd-fep-045.btinternet.com with ESMTP
          id <20200109175116.YRSU9262.re-prd-fep-045.btinternet.com@re-prd-rgout-005.btmx-prd.synchronoss.net>;
          Thu, 9 Jan 2020 17:51:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1578592276; 
        bh=5zFZNsr7AOSnat+MKW66p2fdUFTBF8alEf6ic4/AtlY=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=IupadSeXXiQEHM3zg0Y8B76Nf7gJ4jXQulp+oS7gT08uWMlstsXyh+mF0OC4tMJFkpA87FIQTN5+IUrEi1cYU4tAxrBoeItXDZ5MlVGV8IOeKDrQH+27MFkDQ6HElkyWLObSr0S8FCxbtxnUzVpnTEYSvTKXQlCK0Ch4dtqaB59J6mYRmlDki106NePblIlp7eeE7ojUySAOrXmEOUcDNFnZJdulljvFhzIoS/pqWyGXj91RyVHw28ahf9QPEVSaY0xEBTXtYd5KVyw2a9yXDWndvXufflSGVYVIjx0VrvmvKbWi0nSBS1lt+nTUbVGhfFWIU5K91RBO2aLPHbDIGg==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.6.185]
X-OWM-Source-IP: 86.134.6.185 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedufedrvdeiuddgjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepkeeirddufeegrdeirddukeehnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeegrdeirddukeehpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeoohhmohhsnhgrtggvsehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvsheshhhothhmrghilhdrtghomheqpdhrtghpthhtohepoehsughssehthigthhhordhnshgrrdhgohhvqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.6.185) by re-prd-rgout-005.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5E15FFF30036E6E3; Thu, 9 Jan 2020 17:51:16 +0000
Message-ID: <4c6ffa368dc997c0a0c71467c8e83473d6d43f84.camel@btinternet.com>
Subject: Re: [PATCH V2 1/1] selinux-testsuite: Add filesystem tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
Cc:     omosnace@redhat.com
Date:   Thu, 09 Jan 2020 17:51:09 +0000
In-Reply-To: <1da42584-042b-9e71-34b0-aa51dd64d4ad@tycho.nsa.gov>
References: <20200109150709.360345-1-richard_c_haines@btinternet.com>
         <20200109150709.360345-2-richard_c_haines@btinternet.com>
         <1da42584-042b-9e71-34b0-aa51dd64d4ad@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 2020-01-09 at 12:46 -0500, Stephen Smalley wrote:
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
> <snip>
> > +#################### Deny filesystem { quotamod }
> > ######################
> > +type test_filesystem_no_quotamod_t;
> > +domain_type(test_filesystem_no_quotamod_t)
> > +unconfined_runs_test(test_filesystem_no_quotamod_t)
> > +typeattribute test_filesystem_no_quotamod_t testdomain;
> > +typeattribute test_filesystem_no_quotamod_t filesystemdomain;
> > +
> > +allow test_filesystem_no_quotamod_t self:capability { sys_admin };
> > +allow test_filesystem_no_quotamod_t self:filesystem { quotaget
> > relabelto mount unmount};
> > +fs_mount_all_fs(test_filesystem_no_quotamod_t)
> > +fs_relabelfrom_all_fs(test_filesystem_no_quotamod_t)
> > +fs_associate(test_filesystem_no_quotamod_t)
> > +# Required as $private_path to quota files
> > +files_search_all(test_filesystem_no_quotamod_t)
> > +allow test_filesystem_no_quotamod_t self:dir { mounton };
> > +allow test_filesystem_no_quotamod_t test_file_t:dir { mounton
> > write remove_name rmdir };
> > +dontaudit test_filesystem_no_quotamod_t kernel_t:process {
> > setsched };
> > +
> > +#################### Deny filesystem { quotaget }
> > ######################
> > +type test_filesystem_no_quotaget_t;
> > +domain_type(test_filesystem_no_quotaget_t)
> > +unconfined_runs_test(test_filesystem_no_quotaget_t)
> > +typeattribute test_filesystem_no_quotaget_t testdomain;
> > +typeattribute test_filesystem_no_quotaget_t filesystemdomain;
> > +
> > +allow test_filesystem_no_quotaget_t self:capability { sys_admin };
> > +allow test_filesystem_no_quotaget_t self:filesystem { quotamod
> > relabelto mount unmount relabelfrom };
> > +allow test_filesystem_no_quotaget_t self:dir { mounton };
> > +allow test_filesystem_no_quotaget_t test_file_t:dir { mounton
> > write remove_name rmdir };
> > +allow test_filesystem_no_quotaget_t self:file { quotaon };
> > +fs_mount_all_fs(test_filesystem_no_quotaget_t)
> > +fs_relabelfrom_all_fs(test_filesystem_no_quotaget_t)
> > +fs_associate(test_filesystem_no_quotaget_t)
> > +# Required as $private_path to quota files
> > +files_search_all(test_filesystem_no_quotaget_t)
> > +# For running quotacheck(8)
> > +files_type(test_filesystem_no_quotaget_t)
> > +dontaudit test_filesystem_no_quotaget_t kernel_t:process {
> > setsched };
> > +
> 
> I'd recommend adding a test of quotaon as well.  It isn't technically
> a 
> "filesystem" permission but you are already exercising the check as
> part 
> of testing the other quota permissions and we don't yet have a test
> of 
> it.  Then we'll be able to fully close 
> https://github.com/SELinuxProject/selinux-testsuite/issues/26 when
> this 
> gets merged.
> 
> Similarly, if you add a type_transition rule to your test policy and 
> test that it is applied, we will be able to fully close 
> https://github.com/SELinuxProject/selinux-testsuite/issues/22 along
> with
> https://github.com/SELinuxProject/selinux-testsuite/issues/20.
> 
> Three for the price of one!

Okay, I'll add these next.
> 
> 

