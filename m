Return-Path: <SRS0=fLGi=XV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URI_HEX,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5EAC352A9
	for <selinux@archiver.kernel.org>; Thu, 26 Sep 2019 13:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C96207FF
	for <selinux@archiver.kernel.org>; Thu, 26 Sep 2019 13:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="A7iKzfkM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfIZNqm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Sep 2019 09:46:42 -0400
Received: from USAT19PA24.eemsg.mail.mil ([214.24.22.198]:7651 "EHLO
        USAT19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbfIZNqm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Sep 2019 09:46:42 -0400
X-EEMSG-check-017: 32575157|USAT19PA24_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,552,1559520000"; 
   d="scan'208";a="32575157"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 26 Sep 2019 13:46:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1569505598; x=1601041598;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=S9sV6RnhoNnBMJiYMDivPDnfLVWONRBQfpV8U3Klyzw=;
  b=A7iKzfkMJ3jeWlWPdlggZGakSSNIKnIsE3GNioy6tQKP2sS4bN5EyjID
   E2bjjRS+XGr/wgqkMxXfH8QcWpsX4/BhYNhhEZj++C3B+HtGq/xsK79hh
   eQoPxhtOhfN25vcJcAN8OZq/H+CjcOcTzt6xNMllzIOosIOX/SbGxZGdD
   CQmUFKyVxO/bRZnqHhUJtbYSEwew7H+EcDagynKREymDO/Fvf3iZTF5ZH
   jjrA4JySCQMYk3XkSP9HSe6TMlo/7fbjeTP3f0MN4dgJPjX84yjrPZimU
   HWfrFJxToZMydbGzTfMttwhip9qPxFGvXL0fDrrd8/7oPudJA+trSz3I8
   Q==;
X-IronPort-AV: E=Sophos;i="5.64,552,1559520000"; 
   d="scan'208";a="33386457"
IronPort-PHdr: =?us-ascii?q?9a23=3AdVenwB/cEaE/5P9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+0+seIJqq85mqBkHD//Il1AaPAdyArakYwLSK+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxhGiTanb75/Ixq6oATeu8ILnYZsN6E9xw?=
 =?us-ascii?q?fTrHBVYepW32RoJVySnxb4+Mi9+YNo/jpTtfw86cNOSL32cKskQ7NWCjQmKH?=
 =?us-ascii?q?0169bwtRbfVwuP52ATXXsQnxFVHgXK9hD6XpP2sivnqupw3TSRMMPqQbwoXz?=
 =?us-ascii?q?mp8rxmQwH0higZKzE58XnXis1ug6JdvBKhvAF0z4rNbI2IKPZyYqbRcNUUSm?=
 =?us-ascii?q?pbWsZaSjJPDIWyYYASC+YNJPhUoo34q1YIsBCwBxSjBPn3xzFVmHH206003e?=
 =?us-ascii?q?cvHw7I0wMvHc4BvnvPodXpNqofS/y5wLXGwDjBaf5dxDfz6JLPchAkufyCQK?=
 =?us-ascii?q?5wftTJyUkvCQzFiEibp5HgPzyP0uQNt3aU7up9Xu+okG4othpxryOzxsYslo?=
 =?us-ascii?q?bJhoUVxkrC9SVi2ok5P9K4SEllYdO9FpZbqi+UN4xzQsw4QmFovj43xaABuZ?=
 =?us-ascii?q?GnfygF1o4nywTDZPyAdoiE+g7sVOeLIThkgHJqZquziAyo8Ui8y+38WNO730?=
 =?us-ascii?q?pWripeiNXDqncN1xnL5sebS/t95Fuu2TKR2A/P6+FIO1w7la3eK5I5zb4wl4?=
 =?us-ascii?q?YTsUTeHiDtgkn5kKiWdkAi9+O16Orneq3rqoKTOoJ7kA3zMrkiltahDek3LA?=
 =?us-ascii?q?QCRXWX9OKh37P550L5Wq9Fjvgun6nct5DVONoUq7aiAw9QzoYj8xG/Dyq60N?=
 =?us-ascii?q?gAnXkIMlZFeBWfgoj1IV7OOvH4Deqkg1i2jDdqx+zJPr3mApnXKHjMjKzhcq?=
 =?us-ascii?q?pn505ZyQozychT55NSCr4fPPL+QlL9udPXAxMjMwG43vzrBMty248AQ26DH7?=
 =?us-ascii?q?eVMKbIvl+J4uIvLfOMZIgQuDvlMPgq+uXugGQlmV4dYaap3ZwXZGq+HvR9OU?=
 =?us-ascii?q?qVe3XsgtAfEWsSpAoxUPTqiEGeUT5Uf3uyWaM86S08CIKiF4jDXZqhgL2G3C?=
 =?us-ascii?q?e8BZ1WfXtLClWDHHbnbYmEXO0MaC2KKM97jjMETaShS5Mm1Ry2rw/11b5nLu?=
 =?us-ascii?q?vS+i0FupPuz8Z15+LNmhEo7zB0DNqS03uLT25qmmMEXTg23LpwoR819lDW96?=
 =?us-ascii?q?lzhPhRDpRy4PRSSU9uM5/XyOhzEJbzXQXaZf+MFEbgRc+pV3V5Vd81wtkTc2?=
 =?us-ascii?q?5jFNi4yBPOxSynB/kSjbPYKoYz9/fnw3XpJ8t7g03D3a0lgkhuFtBDLkW6l6?=
 =?us-ascii?q?V/8E7VHIePnEKHwfX5PZ8A1TLAoT/QhVGFu1tVBUspC/TI?=
X-IPAS-Result: =?us-ascii?q?A2C7AABcwIxd/wHyM5BmHAEBAQQBAQwEAQGBVQUBAQsBg?=
 =?us-ascii?q?W4FKm1TMiqEIo8PTQEBAQEBAQaBESWJdY8tgXsJAQEBAQEBAQEBLwUBAgEBg?=
 =?us-ascii?q?3pFAoMxIzYHDgIMAQEBBAEBAQEBBQMBAWyFLQyCOikBgmcBBSMVNhsLGAICJ?=
 =?us-ascii?q?gICVwYBDAYCAQGCXz8BgXYUD61bG4EogTKENwEDAQIDCENAgz2BSIEMKAGMC?=
 =?us-ascii?q?xh4gQeBOAyCXz6CYQIBgUyDH4JYBJUkYJcMgiyCLoRXhRSIawYbgjZylgOES?=
 =?us-ascii?q?YlSgTyEGIFKdZMCATGBWCsIAhgIIQ87gjgBATIJCj0QFIVAhWWFCiQDMAEBg?=
 =?us-ascii?q?QQBAYshglMBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 26 Sep 2019 13:46:37 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8QDkakb015525;
        Thu, 26 Sep 2019 09:46:36 -0400
Subject: Re: [PATCH] CircleCI: run scan-build and publish its results
 automatically
To:     Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
References: <20190921213037.1121263-1-nicolas.iooss@m4x.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8cda36b4-0785-5aa6-451a-73b26ee7d62f@tycho.nsa.gov>
Date:   Thu, 26 Sep 2019 09:46:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190921213037.1121263-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/21/19 5:30 PM, Nicolas Iooss wrote:
> CircleCI is a continuous integration system like Travis CI, which
> provides different features. Contrary to Travis CI, it is quite harder
> to build the project with several build configurations (so it is not a
> replacement), but it provides short-term storage for files produced by a
> build job in what is called "artifacts".
> 
> Use this feature in order to store the results of clang's static
> analyzer (scan-build) after every pushed commit. This way makes it
> possible to quickly compare the result of the analyzer after applying
> some patches that were sent for review to the mailing list, as it no
> longer requires running the analyzer several times on the development
> machine.
> 
> An output example is available at
> https://352-118970575-gh.circle-artifacts.com/0/output-scan-build/2019-09-21-164945-6152-1/index.html
> These web pages were created by the job described at
> https://circleci.com/gh/fishilico/selinux/352
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks, applied.

> ---
>   .circleci/config.yml | 40 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 40 insertions(+)
>   create mode 100644 .circleci/config.yml
> 
> diff --git a/.circleci/config.yml b/.circleci/config.yml
> new file mode 100644
> index 000000000000..5d3177da9956
> --- /dev/null
> +++ b/.circleci/config.yml
> @@ -0,0 +1,40 @@
> +# Configuration file for https://circleci.com/
> +
> +version: 2
> +
> +jobs:
> +  build:
> +    docker:
> +      # Use a Python image from https://hub.docker.com/r/circleci/python/tags/
> +      - image: circleci/python:3.6
> +
> +    steps:
> +    - checkout
> +
> +    # Install dependencies
> +    - run: sudo apt-get update -qq
> +    - run: sudo apt-get install -qq bison clang clang-tools flex gawk gettext libaudit-dev libcap-dev libcap-ng-dev libcunit1-dev libdbus-glib-1-dev libpcre3-dev python3-dev python-dev ruby-dev swig xmlto
> +
> +    - run:
> +        name: Setup environment variables
> +        command: |
> +          echo 'export DESTDIR=$HOME/destdir' >> "$BASH_ENV"
> +
> +    # Download and install refpolicy headers for sepolgen tests
> +    - run:
> +        name: Download refpolicy Makefile
> +        command: |
> +          curl --location --retry 10 -o refpolicy.tar.bz2 https://github.com/SELinuxProject/refpolicy/releases/download/RELEASE_2_20180701/refpolicy-2.20180701.tar.bz2
> +          tar -xvjf refpolicy.tar.bz2
> +          sed -e "s,^PREFIX :=.*,PREFIX := $DESTDIR/usr," -i refpolicy/support/Makefile.devel
> +          sudo make -C refpolicy install-headers
> +          sudo mkdir -p /etc/selinux
> +          echo 'SELINUXTYPE=refpolicy' | sudo tee /etc/selinux/config
> +          echo 'SELINUX_DEVEL_PATH = /usr/share/selinux/refpolicy' | sudo tee /etc/selinux/sepolgen.conf
> +          sed -e "s,\"\(/usr/bin/[cs]\),\"$DESTDIR\1," -i python/sepolgen/src/sepolgen/module.py
> +
> +    # Run clang's scan-build and store the result as artifacts
> +    - run: ./scripts/run-scan-build
> +    - store_artifacts:
> +        path: scripts/output-scan-build
> +        destination: output-scan-build
> 

