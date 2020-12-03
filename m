Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10121C4361A
	for <selinux@archiver.kernel.org>; Thu,  3 Dec 2020 15:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACEF9207A8
	for <selinux@archiver.kernel.org>; Thu,  3 Dec 2020 15:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbgLCPw6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Dec 2020 10:52:58 -0500
Received: from mailomta1-sa.btinternet.com ([213.120.69.7]:55200 "EHLO
        sa-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726162AbgLCPw5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Dec 2020 10:52:57 -0500
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-048.btinternet.com with ESMTP
          id <20201203155214.NHRG7754.sa-prd-fep-048.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Thu, 3 Dec 2020 15:52:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1607010734; 
        bh=Mx/Eq27gKB7jm03sIm4iDOpe99kHqmxok+KsT7T5tbk=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:MIME-Version;
        b=uNWdRaUzYtm5+A3LrCe981SQ8VZNo9lZmA7ppEjHlhsqjSiNyNIO3CC2etpiHC1gsD9sPY0wNXkS5LMTXiATYH8Xx9a3mwCMF1OCkg9cJAea4XdFDFuf9WRyPlzBDqKZhT11gAFynODg5TyzN7uAYyDQDycw7xt3pri8Fu7fvXMRKhtqvdqKrheoAvw05qbrGTUBN1M9KK7NUEe7pYM09hwpJvt391tCX1QIH1G91pLb/baQdRHjOaeDpP7Bzwl5AZngcBIlBVMBkWS/QDOXljbq4CPlR+ChyDl8eLHqn4ei21o6YU+ac+YKLbWg5WUiVM/DDrhZDWJugmzqFwdPbA==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com
X-SNCR-Rigid: 5ED9B8A71D3AEF52
X-Originating-IP: [86.179.216.202]
X-OWM-Source-IP: 86.179.216.202 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrudeiiedgkedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftggfggfgsehtkeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpefhkeegheduudeggfffkeehheettefgjedugefhhfevuedvveduhedtleejkeduveenucfkphepkeeirddujeelrddvudeirddvtddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurdduleekngdpihhnvghtpeekiedrudejledrvdduiedrvddtvddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from [192.168.1.198] (86.179.216.202) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9B8A71D3AEF52; Thu, 3 Dec 2020 15:52:14 +0000
Message-ID: <7957d9afeed6e17ffe7eeb117bf4db6919d76448.camel@btinternet.com>
Subject: Re: [PATCH] all: various small html to markdown conversions
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Date:   Thu, 03 Dec 2020 15:52:08 +0000
In-Reply-To: <160697083070.45245.11138404605529742839.stgit@sifl>
References: <160697083070.45245.11138404605529742839.stgit@sifl>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 2020-12-02 at 23:47 -0500, Paul Moore wrote:
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---

I've not found any more html so:

Acked-by: Richard Haines <richard_c_haines@btinternet.com>

>  src/notebook-examples/selinux-policy/README.md |    2 --
>  src/notebook-examples/sepgsql/README.md        |    2 --
>  src/title.md                                   |    5 +----
>  3 files changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/src/notebook-examples/selinux-policy/README.md
> b/src/notebook-examples/selinux-policy/README.md
> index fe6a26e..353bd2f 100644
> --- a/src/notebook-examples/selinux-policy/README.md
> +++ b/src/notebook-examples/selinux-policy/README.md
> @@ -20,8 +20,6 @@ Another basic kernel policy build is avilable in
> the kernel source, see the
>  ***flask-files*** - Contains the Fedora 31 policy source
> initial_sids,
>  security_classes and access_vectors flask files.
>  
> -<br>
> -
>  ## Building the Kernel Source MDP
>  
>  **Note** that the kernel mdp `install_policy.sh` script will not
> build
> diff --git a/src/notebook-examples/sepgsql/README.md b/src/notebook-
> examples/sepgsql/README.md
> index bfa3c09..3e1afc7 100644
> --- a/src/notebook-examples/sepgsql/README.md
> +++ b/src/notebook-examples/sepgsql/README.md
> @@ -20,8 +20,6 @@ installed:
>         postgresql-docs
>  ```
>  
> -<br>
> -
>  ## Installing PostgreSQL + sepgsql and building sample testdb
> database
>  
>  For a good intro to sepgsql read the following:
> diff --git a/src/title.md b/src/title.md
> index 5c33ac0..caf5b41 100644
> --- a/src/title.md
> +++ b/src/title.md
> @@ -4,13 +4,10 @@
>  # The SELinux Notebook
>  <!-- %STYLEEND% -->
>  
> -<!-- %STYLESTART%(display:block;margin-left:auto;margin-right:auto;)
> -->
> +<!-- %STYLESTART%(display:block;margin-left:auto;margin-
> right:auto;padding:2em) -->
>  ![](./images/selinux-penguin.svg)
>  <!-- %STYLEEND% -->
>  
> -<br/>
> -<br/>
> -
>  **<!-- %DATE% -->**
>  <!-- %GITHEAD% -->
>  
> 


