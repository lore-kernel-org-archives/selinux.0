Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A922C433EF
	for <selinux@archiver.kernel.org>; Mon,  6 Dec 2021 19:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347231AbhLFTUp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Dec 2021 14:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243755AbhLFTUo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Dec 2021 14:20:44 -0500
Received: from markus.defensec.nl (markus.defensec.nl [IPv6:2001:985:d55d::123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9CAC061746
        for <selinux@vger.kernel.org>; Mon,  6 Dec 2021 11:17:15 -0800 (PST)
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by markus.defensec.nl (Postfix) with ESMTPSA id BBB9EFC0457;
        Mon,  6 Dec 2021 20:17:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
        s=default; t=1638818229;
        bh=lidK4n6pc2vp62zXAzuNtoDLzK23CY903PvRb8tofvU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ZP/38WyEnEh2EjJB0SF0AiQGQM+VWmHqusKg8L+/BXBAh+zNZyyjiW68VdFltwL01
         llx1eS+f3WuarS7y67LdmD9KA2luND35wTGHR9hJF9XtE6byHmw4Eph69a6ucbjgPo
         bQwsPLGzrn0TdHridX6OaNl5XnNEgIgbXGruuBfo=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org, paul@paul-moore.com
Subject: Re: [PATCH 5/7] policy_config_files.md: Update openssh_contexts
 contents
References: <20211203140519.30930-1-richard_c_haines@btinternet.com>
        <20211203140519.30930-6-richard_c_haines@btinternet.com>
Date:   Mon, 06 Dec 2021 20:17:09 +0100
In-Reply-To: <20211203140519.30930-6-richard_c_haines@btinternet.com> (Richard
        Haines's message of "Fri, 3 Dec 2021 14:05:17 +0000")
Message-ID: <87o85tzgp6.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Richard Haines <richard_c_haines@btinternet.com> writes:

> Used by openssh for privilege separated processes in the
> preauthentication phase.

Maybe mention that this is Red Hat specific patch that is not upstreamed
so others do not have this.

>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  src/policy_config_files.md | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/src/policy_config_files.md b/src/policy_config_files.md
> index 4b2c091..9f2996c 100644
> --- a/src/policy_config_files.md
> +++ b/src/policy_config_files.md
> @@ -715,10 +715,26 @@ run_init=run_init_t
>  
>  ## *contexts/openssh_contexts*
>  
> -**To be determined**
> +Used by *openssh* (***ssh**(1)*) for privilege separated processes in the
> +preauthentication phase.
>  
>  **The file format is as follows:**
>  
> +```
> +privsep_preauth=[domain]
> +```
> +
> +**Where:**
> +
> +*privsep_preauth*
> +
> +- The keyword *privsep_preauth*
> +
> +*domain*
> +
> +- The domain type for the privilege separated processes in the
> +  preauthentication phase.
> +
>  **Example file contents:**
>  
>  ```

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
