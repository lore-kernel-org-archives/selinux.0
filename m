Return-Path: <SRS0=61sA=XS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0652C04EBF
	for <selinux@archiver.kernel.org>; Mon, 23 Sep 2019 14:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A2220673
	for <selinux@archiver.kernel.org>; Mon, 23 Sep 2019 14:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="U1DxYSS6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393935AbfIWOLz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 23 Sep 2019 10:11:55 -0400
Received: from UHIL19PA38.eemsg.mail.mil ([214.24.21.197]:45977 "EHLO
        UHIL19PA38.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389738AbfIWOLy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 23 Sep 2019 10:11:54 -0400
X-EEMSG-check-017: 28282355|UHIL19PA38_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,540,1559520000"; 
   d="scan'208";a="28282355"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA38.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 23 Sep 2019 14:11:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1569247912; x=1600783912;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=4qvkAfeH+VqXWGBP92wBvaaNImZ7mhSsv0WLx4jzwtE=;
  b=U1DxYSS6wgB5agY1jsHv4kyuawJQwmWcGo6hkDB12rHZKKHvaK+T7l4b
   S+xTKXEBtgSLS+S85bGLVztjdRr6OepIR17IeZafx4xYRT4HTJKIjO9Ry
   8fr4YeCCATfA6k+QOQESG0BCZoDWESsGxhFW2vd2AvHf/Z/jKNg606UtO
   7UxFhaw/czgjsSH1/dGeoxT30Zj6O0n+USHyouypOSgE1W3y2+/JEgaih
   WzQsfgH7nKI/X1l+BQMRYgc4x9VFMSYxmDIiJN4dcxfJyWZePCoGUm9eR
   PAa0uQeeEacL8SrRAk1VY3iM3dQpj1IKvhLZH0z3R7xUjO2ymeWN8ZnNF
   Q==;
X-IronPort-AV: E=Sophos;i="5.64,540,1559520000"; 
   d="scan'208";a="28199937"
IronPort-PHdr: =?us-ascii?q?9a23=3ARFTqdxXR2kvT4sDgwPqH9Itw2jvV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbRaFt8tkgFKBZ4jH8fUM07OQ7/m7HzZQqsnY+DBaKdoQDk?=
 =?us-ascii?q?VD0Z1X1yUbQ+e9QXXhK/DrayFoVO9jb3RCu0+BDE5OBczlbEfTqHDhpRQbGx?=
 =?us-ascii?q?H4KBYnbr+tQt2agMu4zf299IPOaAtUmjW9falyLBKrpgnNq8Uam4RvJrs/xx?=
 =?us-ascii?q?fTvHdFeOtayGF1KVmOmxrw+tq88IRs/ihNpf4t7dJMXbn/c68lUbFWETMqPn?=
 =?us-ascii?q?wv6sb2rxfDVwyP5nUdUmUSjBVFBhXO4Q/5UJnsrCb0r/Jx1yaGM8L4S7A0Qi?=
 =?us-ascii?q?mi4LxwSBD0kicHNiU2/3/Rh8dtka9UuhOhpxh4w47JfIGYMed1c63Bcd8GQ2?=
 =?us-ascii?q?dKQ91cXDJdDIyic4QPDvIBPedGoIn7u1sOtga1CQ21CO/y1jNEmnr60Ks03O?=
 =?us-ascii?q?Q7FQHNwRIuEdQAvn/JqNn5LakfXOSwwKTO0D7Nbe5Z2S3l5YbVbB4hr/GCU7?=
 =?us-ascii?q?F+f8XfxkYgFR/KgFqLpIz5PT6YzPgBv3SV4udiU++klm4pqxt2ojiq3soil5?=
 =?us-ascii?q?XJiZwNylDE6yp5xps+K8C9SEFhZd6kFIVftiGHPIZxWcMtXnpotT0myrwGpZ?=
 =?us-ascii?q?G7fC8KxI4hxx7EcfOLaYeI4hX9VOuIJzpzmXFreKqnihqv/kWtxffwW8mp3F?=
 =?us-ascii?q?pQsCZIncfAumoQ2xHV98OJUOFy/l271jaKzw3T7+ZELl0qmqfDMJ4hx6Iwlo?=
 =?us-ascii?q?IUsUTeAi/6gEX2g7GSdkUj4uWo9/7oYq/npp+BLI94kB3+M6Qylcy/BuQ0KA?=
 =?us-ascii?q?4OUHSA+eugzrHj+Ez5QLFSgv03lKnWrozaKNwGqqO2DAJZyIYu5wulAzu439?=
 =?us-ascii?q?kUg2MLIE9ddBKClYfpOlXOIP7iDfe4hlShiCxryO3dPrD6HpXMLmTMkLfmfb?=
 =?us-ascii?q?pn7U5c0xA8wcpQ55JTFLENOOjzVVPptNzEEh85NBS5w+HiCNV6zYMeX3iADb?=
 =?us-ascii?q?OHP67Jq1+H+P8gI+mWa48JojryN/8l5/v2h38jhVAdZbWp3YcQaH2gBfRpPU?=
 =?us-ascii?q?GZYXvqgtccHmYHpRQ+TOP0h12YSzJTZGi9X7g65j4lDIKqF4DDRpqigO/J4C?=
 =?us-ascii?q?DuOZtafG1EQnWLCnHhfIiHE6MLbSWJJMZqnxQeWLShQpNn3har4kuy0LdjL+?=
 =?us-ascii?q?zJ6gUGup/5ktt4/evekVc17zMnId6a1jS2U2xsnm4ODwQz1aR7rF01nkyPyo?=
 =?us-ascii?q?BkkvdYEppV/PoPXQAkY82Ph9dmAsz/D1qSNuyCT0yrF5D/WmA8?=
X-IPAS-Result: =?us-ascii?q?A2DvAAAp0ohd/wHyM5BlHAEBAQQBAQwEAQGBVAYBAQsBg?=
 =?us-ascii?q?XMqgUAyKoQijw1NAQEBAQEBBoE2iXWPLYF7CQEBAQEBAQEBATQBAgEBhD8Cg?=
 =?us-ascii?q?xYjNQgOAgwBAQEEAQEBAQEFAwEBbIU5gjopAYJmAQEBAQIBIxVRCw4KAgImA?=
 =?us-ascii?q?gJXBgEMBgIBAYJfPwGBdgUPq3hzgTKFTIMtgUiBDCgBjAgYeIEHgTiCaz6HT?=
 =?us-ascii?q?4JYBJYClwqCLIIuiWwHiGMGG4I2lm+OGoE8mVQBNoFYKwgCGAghD4MnUBAUk?=
 =?us-ascii?q?C8kAzCBBgEBjCABAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 23 Sep 2019 14:11:51 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8NEBpRO030920;
        Mon, 23 Sep 2019 10:11:51 -0400
Subject: Re: [PATCH testsuite] policy: do not rebuild policy package if
 already built
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20190923095837.25752-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <b74cd6c5-0f63-80d8-99c0-967dc638279c@tycho.nsa.gov>
Date:   Mon, 23 Sep 2019 10:11:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190923095837.25752-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/23/19 5:58 AM, Ondrej Mosnacek wrote:
> Right now, test_policy.pp is rebuilt on every make invocation. Tweak the
> Makefile so that it is only build when it hasn't been built, it has been
> cleaned, or the source files changed.

It also needs to be rebuilt if anything under 
/usr/share/selinux/devel/include has changed e.g. upon an update of 
selinux-policy-devel.

> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>   policy/Makefile | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/policy/Makefile b/policy/Makefile
> index a5942b3..cc0f140 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -86,7 +86,7 @@ ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
>   TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te test_ibpkey.te, $(TARGETS))
>   endif
>   
> -all: build
> +all: test_policy/test_policy.pp
>   
>   expand_check:
>   	# Test for "expand-check = 0" in /etc/selinux/semanage.conf
> @@ -94,7 +94,7 @@ expand_check:
>   		(echo "ERROR: set 'expand-check = 0' in /etc/selinux/semanage.conf"; \
>   		 /bin/false)
>   
> -build: $(TARGETS)
> +test_policy/test_policy.pp: $(TARGETS) test_policy.if
>   	# General policy build
>   	@if [ -d $(POLDEV) ]; then \
>   		mkdir -p test_policy; \
> 

