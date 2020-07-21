Return-Path: <SRS0=VL4G=BA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF363C433E0
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 11:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FD892073A
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 11:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="Tf/7MJ0R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgGULi3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgGULi2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Jul 2020 07:38:28 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B498DC061794
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2020 04:38:28 -0700 (PDT)
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id EC7CA2A06FB
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2020 13:38:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl EC7CA2A06FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1595331506;
        bh=3D+NZELIsxC58BoF/SxqBBTraGnEdDUtH7P8w+eH0Uo=;
        h=From:To:Subject:References:Date:In-Reply-To:From;
        b=Tf/7MJ0RsHR8iCsg3jT5X6VIBiMGeZJp4JHDU3/R4Tm37FT3PaTjgmt0WrIoJM/w3
         TRYOj0zqC6uhKqL7d1TA215Q/PcRrsX5u/WUhGHyP+vNheWCbMV9kEDQ+gmic6lHO0
         rr65pqd5b9mO6VCA4Q7oaDHW5NWprVGDOafvK8zE=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Subject: Re: [PATCH] policycoreutils: fix inaccurate description in sestatus
References: <20200721112512.1906547-1-dominick.grift@defensec.nl>
Date:   Tue, 21 Jul 2020 13:38:21 +0200
In-Reply-To: <20200721112512.1906547-1-dominick.grift@defensec.nl> (Dominick
        Grift's message of "Tue, 21 Jul 2020 13:25:12 +0200")
Message-ID: <ypjl7duxyu6q.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Dominick Grift <dominick.grift@defensec.nl> writes:

> strdup(selinux_policy_root()) does not return a path that can be used to derive "Loaded policy name"
> instead if returns a path that can be used to derive "Policy name from config file".

Even though this seems like a nit, this issue was a bit embarrasing for
me in one of my video tutorials:

https://youtu.be/JsD8GLx_ZKA?t=1965

>
> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> ---
>  policycoreutils/sestatus/sestatus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/policycoreutils/sestatus/sestatus.c b/policycoreutils/sestatus/sestatus.c
> index b37f0353..8b03b028 100644
> --- a/policycoreutils/sestatus/sestatus.c
> +++ b/policycoreutils/sestatus/sestatus.c
> @@ -268,7 +268,7 @@ int main(int argc, char **argv)
>  	free(root_path);
>  
>  	/* Dump all the path information */
> -	printf_tab("Loaded policy name:");
> +	printf_tab("Policy name from config file:");
>  	pol_path = strdup(selinux_policy_root());
>  	if (pol_path) {
>  		pol_name = basename(pol_path);

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
