Return-Path: <SRS0=NpCz=PK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0D9C43387
	for <selinux@archiver.kernel.org>; Wed,  2 Jan 2019 14:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA88D218DE
	for <selinux@archiver.kernel.org>; Wed,  2 Jan 2019 14:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbfABOgM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Jan 2019 09:36:12 -0500
Received: from ithil.bigon.be ([163.172.57.153]:36436 "EHLO ithil.bigon.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbfABOgM (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 2 Jan 2019 09:36:12 -0500
X-Greylist: delayed 351 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Jan 2019 09:36:11 EST
Received: from localhost (localhost [IPv6:::1])
        by ithil.bigon.be (Postfix) with ESMTP id 5DE6E20DD6
        for <selinux@vger.kernel.org>; Wed,  2 Jan 2019 15:30:19 +0100 (CET)
Received: from ithil.bigon.be ([IPv6:::1])
        by localhost (ithil.bigon.be [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id K-U3mrWxg3QB for <selinux@vger.kernel.org>;
        Wed,  2 Jan 2019 15:30:19 +0100 (CET)
Received: from [10.0.42.176] (d54c71dba.static.telenet.be [84.199.29.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bigon@bigon.be)
        by ithil.bigon.be (Postfix) with ESMTPSA
        for <selinux@vger.kernel.org>; Wed,  2 Jan 2019 15:30:19 +0100 (CET)
Subject: Re: [PATCH] libsemanage: Always set errno to 0 before calling
 getpwent()
From:   Laurent Bigonville <bigon@debian.org>
To:     selinux@vger.kernel.org
References: <20190102134639.30515-1-bigon@debian.org>
Message-ID: <e2da0c12-9e7d-089f-d45a-fba523e6e04f@debian.org>
Date:   Wed, 2 Jan 2019 15:30:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190102134639.30515-1-bigon@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Le 2/01/19 à 14:46, Laurent Bigonville a écrit :
> From: Laurent Bigonville <bigon@bigon.be>
>
> The manpage explicitly states that:
>
>    The  getpwent()  function  returns a pointer to a passwd structure, or
>    NULL if there are no more entries or an error occurred.  If an error
>    occurs, errno is set appropriately.  If one wants to check errno after
>    the call, it should be set to zero before the call.
>
> Without this, genhomedircon can wrongly return the following:
>    libsemanage.get_home_dirs: Error while fetching users.  Returning list so far.
>
> https://github.com/SELinuxProject/selinux/issues/121
>
> Signed-off-by: Laurent Bigonville <bigon@bigon.be>
> ---
>   libsemanage/src/genhomedircon.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
> index 3e61b510..591941fb 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -361,7 +361,11 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
>   
>   	errno = 0;
>   	setpwent();
> -	while ((pwbuf = getpwent()) != NULL) {
> +	while (1) {
> +		errno = 0;
> +		pwbuf = getpwent();
> +		if (pwbuf == NULL)
> +			break;
>   		if (pwbuf->pw_uid < minuid || pwbuf->pw_uid > maxuid)
>   			continue;
>   		if (!semanage_list_find(shells, pwbuf->pw_shell))
> @@ -403,7 +407,6 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
>   		}
>   		free(path);
>   		path = NULL;
> -		errno = 0;

Actually I'm wondering if this shouldn't stay there

>   	}
>   
>   	if (errno) {
> @@ -1101,7 +1104,11 @@ static int get_group_users(genhomedircon_settings_t * s,
>   	}
>   
>   	setpwent();
> -	while ((pw = getpwent()) != NULL) {
> +	while (1) {
> +		errno = 0;
> +		pw = getpwent();
> +		if (pw == NULL)
> +			break;
>   		// skip users who also have this group as their
>   		// primary group
>   		if (lfind(pw->pw_name, group->gr_mem, &nmembers,
