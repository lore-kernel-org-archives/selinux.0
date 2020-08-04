Return-Path: <SRS0=dV66=BO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B61C433DF
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 10:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11D3C2065C
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 10:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="m2hMTBKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgHDKbY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Aug 2020 06:31:24 -0400
Received: from mailomta22-sa.btinternet.com ([213.120.69.28]:39004 "EHLO
        sa-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726056AbgHDKbY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Aug 2020 06:31:24 -0400
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-048.btinternet.com with ESMTP
          id <20200804103117.VJU4139.sa-prd-fep-048.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Tue, 4 Aug 2020 11:31:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1596537077; 
        bh=KgdYPbMMgK5jGYAZ5uWqtXu1pHR67/655ZTJst4CPZQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:MIME-Version;
        b=m2hMTBKLThorIn+WVOE8oXmLieyrpcSwjUnuYtR1Rx6YvofiHAglWJRjHjl0L0AHMWg6rD4b0fJ0QcK54cJIDzrmwQ3j9+ui+RYx/oFVrio1Bz33npKNRtOG9aD+UXkXm+dXngbM36UT9k52UeiZ7nwE8eA4vrqMf7ZVhPXCIbeWWaYZSjVG1Ciy0WnCHR0W6iJcKgtO1WeHozvDEHbD453QZ9S5A0FMETj6DmAnxXij+3eUT7aFugSR/iOUnziYDqothSF6xc271lIre5vaDuTuc1+KYNebCtyxcPVmODRs+MLe6u/B4ecrpmCPzqvZTG1pp8uPSF81EI63yLJ0Bg==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.184.61.65]
X-OWM-Source-IP: 86.184.61.65 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrjeeigdeftdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepjeeiveevteelveetgefgieelfeeuhfdvheehvdfhtdeijefhhfeugfeludeiheffnecuffhomhgrihhnpehprghulhdqmhhoohhrvgdrtghomhdpghhithhhuhgsrdgtohhmnecukfhppeekiedrudekgedriedurdeiheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddukeegrdeiuddrieehpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.184.61.65) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9B8A70A228B7C; Tue, 4 Aug 2020 11:31:17 +0100
Message-ID: <81320b12edc1cc5bf0818f21f467f5fe83405626.camel@btinternet.com>
Subject: Re: [RFC,selinux-notebook PATCH 00/18] markdown conversions and
 cleanups
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Date:   Tue, 04 Aug 2020 11:31:07 +0100
In-Reply-To: <159650470076.8961.12721446818345626943.stgit@sifl>
References: <159650470076.8961.12721446818345626943.stgit@sifl>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 2020-08-03 at 21:33 -0400, Paul Moore wrote:
> This patchset helps to get us a little closer to finishing the work
> of converting The SELinux Notebook to markdown.  I believe this is
> a worthwhile goal for two main reasons: it makes the raw markdown
> much easier to read (the HTML tables are painful in source form),
> and it makes it easier to render the markdown into different formats
> (currently HTML and PDF).
> 
> My original goal for this patchset was to complete the markdown
> conversion before posting the series, but I now realize that was
> neither a practical or good idea.  While this patchset may miss my
> original goal, I do believe it is a step forward both in terms of the
> raw markdown and the rendered formats, and I would suggest we merge
> these changes assuming no strong objections.
> 
> For those who want to quickly check the markdown on GitHub or the
> rendered HTML and PDF formats, I've included the links below:
> 
> * https://drop.paul-moore.com/21.HGW6/SELinux_Notebook.pdf
> * https://drop.paul-moore.com/21.HGW6/SELinux_Notebook.html
> * 
> https://github.com/pcmoore/misc-selinux_notebook/tree/working-md_full
> 

I'm okay with these changes.

The changes of tables to lists in the policy rules files
(xperms_rules.md etc.)  makes the text much easier on the eye when
reading in all formats. Splitting the policy types looks better too.

I think a small number of the HTML tables will be difficult to convert
to pipe tables, also others when converted may require the HTML <br> to
make them more readable (using <br> seems to be the only way to get
line breaks in pipe tables). Still, see how it goes !!

Acked-by: Richard Haines <richard_c_haines@btinternet.com>

> ---
> 
> Paul Moore (16):
>       build: explicitly enable pandoc pipe_tables
>       css: identify table layout hacks
>       css: style improvements
>       x_windows: fully convert to markdown
>       xperm_rules: fully convert to markdown
>       xen_statements: fully convert to markdown
>       vm_support: fully convert to markdown
>       user_statements: fully convert to markdown
>       userspace_libraries: fully convert to markdown
>       type_statements: fully convert to markdown
>       all: remove all the <br> tags we haven't gotten to yet
>       all: unify example formatting (scripts, code, policy, etc) in
> markdown
>       all: don't use "`" for formatting text, use "*" instead
>       all: consolidate multiple blank lines into one
>       kernel_policy_language: convert the footnotes to markdown
>       title: assorted updates
> 
> Richard Haines (2):
>       postgresql: update PostgreSQL SELinux Support section
>       x_windows: don't call table 12 a table
> 
> 
>  src/apache_support.md              |  53 +--
>  src/auditing.md                    |  36 +-
>  src/avc_rules.md                   |  48 +--
>  src/bounds_rules.md                |  18 +-
>  src/cil_overview.md                |  43 +-
>  src/class_permission_statements.md |  44 +-
>  src/computing_access_decisions.md  |   2 -
>  src/computing_security_contexts.md | 224 +++++-----
>  src/conditional_statements.md      |  36 +-
>  src/configuration_files.md         |  10 +-
>  src/constraint_statements.md       |  52 +--
>  src/core_components.md             |  10 -
>  src/debug_policy_hints.md          |   5 -
>  src/default_rules.md               |  40 +-
>  src/domain_object_transitions.md   | 138 +++---
>  src/file_labeling_statements.md    |  58 ++-
>  src/global_config_files.md         |  16 +-
>  src/images/24-database-table.png   | Bin 44747 -> 0 bytes
>  src/implementing_seaware_apps.md   |  28 +-
>  src/infiniband_statements.md       |  36 +-
>  src/kernel_policy_language.md      |  59 ++-
>  src/libselinux_functions.md        |   4 +-
>  src/lsm_selinux.md                 | 161 ++++---
>  src/mac.md                         |   5 -
>  src/mls_mcs.md                     |  45 +-
>  src/mls_statements.md              |  84 ++--
>  src/modes.md                       |   7 +-
>  src/modular_policy_statements.md   |  28 +-
>  src/network_statements.md          |  80 ++--
>  src/network_support.md             |  78 ++--
>  src/object_classes_permissions.md  | 255 +++++------
>  src/objects.md                     |  40 +-
>  src/pam_login.md                   |   7 +-
>  src/policy_config_files.md         | 182 ++++----
>  src/policy_config_statements.md    |  10 +-
>  src/policy_languages.md            |   2 -
>  src/policy_store_config_files.md   | 137 +++---
>  src/policy_validation_example.md   |  14 +-
>  src/polyinstantiation.md           |  31 +-
>  src/postgresql.md                  | 145 +++----
>  src/rbac.md                        |   9 +-
>  src/reference_policy.md            | 321 ++++++--------
>  src/role_statements.md             |  82 ++--
>  src/seandroid.md                   |  91 ++--
>  src/security_context.md            |  10 +-
>  src/selinux_cmds.md                |   3 -
>  src/selinux_overview.md            |   4 -
>  src/sid_statement.md               |  24 +-
>  src/styles_html.css                |  16 +-
>  src/styles_pdf.css                 |  24 +-
>  src/subjects.md                    |   7 +-
>  src/terminology.md                 |   5 -
>  src/title.md                       |  16 +-
>  src/toc.md                         |   4 +-
>  src/type_enforcement.md            |  55 ++-
>  src/type_statements.md             | 672 ++++++++++++---------------
> --
>  src/types_of_policy.md             |  31 +-
>  src/user_statements.md             | 121 +++---
>  src/users.md                       |  15 +-
>  src/userspace_libraries.md         | 169 ++++----
>  src/vm_support.md                  | 147 ++-----
>  src/x_windows.md                   | 374 ++++++++--------
>  src/xen_statements.md              | 370 ++++++----------
>  src/xperm_rules.md                 | 146 +++----
>  64 files changed, 2157 insertions(+), 2830 deletions(-)
>  delete mode 100644 src/images/24-database-table.png
> 
> --
> paul moore
> www.paul-moore.com

