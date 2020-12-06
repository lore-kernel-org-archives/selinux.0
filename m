Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCD6C433FE
	for <selinux@archiver.kernel.org>; Sun,  6 Dec 2020 15:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77A9C2333D
	for <selinux@archiver.kernel.org>; Sun,  6 Dec 2020 15:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgLFPaY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 6 Dec 2020 10:30:24 -0500
Received: from mailomta7-sa.btinternet.com ([213.120.69.13]:51435 "EHLO
        sa-prd-fep-045.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725730AbgLFPaY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 6 Dec 2020 10:30:24 -0500
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
          by sa-prd-fep-045.btinternet.com with ESMTP
          id <20201206152940.WMMX32244.sa-prd-fep-045.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
          Sun, 6 Dec 2020 15:29:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1607268580; 
        bh=0P9Csq1FkCErpaSy2yAfZdIfEvKTnJr1QhU7u4tsnWg=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=ZgBWO6K7623ArwqYx9qWjtnDoDJtkjoySuBjgXS6zDMtom+mlyFbkIvzbrd4tO5a0md87sCE3G5wlDT66IsLGVPkb9/vqRtTmbqwKhb1gru17NJ/90yU8ZUB/KfRn8e5wLlQ43lM3nqzoojmraH9aVDrWg50h5o+YgPfXIo8Yw+Dhuj7JCtYmRFC6hHkBrKDi+bprKmTxU8Jgdz/1KM+f+00jtiS6b1UTAW3tPk0+eHO8P7ij7uzHIzL7bA24QdW9YE6pUOPCxjefjtVvATIgO9RRAP+pDTjKiBzViK9yOOEUjJNmSQqrkp466m89sRpEM1ohJs3una36p+7QPan0g==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com
X-SNCR-Rigid: 5ED9AA6E1D8EA84B
X-Originating-IP: [86.183.114.64]
X-OWM-Source-IP: 86.183.114.64 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrudejvddgjeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftggfggfgsehtkeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpedvieduhfdvjeetffejledvuedvhefgffelgffhfeelgeeijeejleekleejjefhvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeekiedrudekfedruddugedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurdduleekngdpihhnvghtpeekiedrudekfedruddugedrieegpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeorghshhhishhhmhesmhhvihhsthgrrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigqdhrvghfphholhhitgihsehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeoshgv
        lhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from [192.168.1.198] (86.183.114.64) by sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9AA6E1D8EA84B; Sun, 6 Dec 2020 15:29:39 +0000
Message-ID: <858c9383f7c75e1e39bafaeab6388cd6af902c4f.camel@btinternet.com>
Subject: Re: How is policy.31 created from modules under /usr/share/selinux
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Ashish Mishra <ashishm@mvista.com>
Cc:     selinux-refpolicy@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
Date:   Sun, 06 Dec 2020 15:29:32 +0000
In-Reply-To: <CAP2OjcjCFYiyMfqa=X__X6g0U0143U5Fd-xGaKJgGNabFUpr7w@mail.gmail.com>
References: <CAP2OjcjCFYiyMfqa=X__X6g0U0143U5Fd-xGaKJgGNabFUpr7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, 2020-12-06 at 00:49 +0530, Ashish Mishra wrote:
> Hi All  ,
> 
> Good Morning .
> 
> I am following the SELINUX NOTEBOOK & trying the same at my end .
> 
> - The refpolicy modules are copied at /usr/share/selinux/refpolicy
>    i can see around 400+ modules there .
>    But can senior member' s please help me understand how is the
>    /etc/selinux/refpolicy/policy/policy.31  created using the modules
> available at
>    /usr/share/selinux
>    The command i followed :
>                 $ make install-src
>                 $ make conf
>                 $ make load ( tried even $ make install )
>                 $ make install-headers
> 

Just to be clear (as you didn't state whether the binary policy file
was built at all), if you run these commands:

mkdir refpol
cd refpol
git clone https://github.com/SELinuxProject/refpolicy.git
Edit build.conf file to requirements (e.g. NAME = refpolicy etc.)
make install-src
cd /etc/selinux/refpolicy/src/policy
make conf
make load
make install-headers

The policy binary file should now be created at:
  /etc/selinux/refpolicy/policy/policy.31 (or .32 if Fedora 33)
True ??

To add a new module (that will rebuild the binary policy file) you can
install the new *.te *.if and *.fc files in a directory and run from
that directory (you will need to ensure /etc/selinux/config has
SELINUXTYPE=refpolicy set):

make -f /usr/share/selinux/refpolicy/include/Makefile load

This Makefile basically reads the build.conf file, uses checkmodule to
build the *.pp file, then semodule to add to store and build the binary
policy (also using the prebuilt /usr/share/selinux/refpolicy/*.pp
files).

I've just tried this on Fedora 33 with no problems.

Note: While running through example this I noticed an error in the
Notebook - the Reference policy does not have a contibute section, I'll
send patch to remove:

Add the contibuted modules (policy/modules/contrib)
git submodule init
git submodule update

> 
> - This can help me to debug an issue where i am trying to get selinux
> of my custom
>    distro where all the make command are successfully executed but
> the policy.31
>    is not getting created
> 
> - I can even see the "include" folder also getting created for make
> install-headers
> 
> Any pointers will be helpful or please let me know if i am missing
> any
> aspect here .
> 
> Thanks ,
> Ashish.


