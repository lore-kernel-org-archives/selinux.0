Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98246C001DE
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 23:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjHIXHo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 19:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjHIXHo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 19:07:44 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86041E76
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 16:07:43 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7659cb9c42aso23706585a.3
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 16:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691622462; x=1692227262;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y8j0szVkvKcAaoM3INhmFK+61wCHhHWJPoTGEH1oTE4=;
        b=bexQlVjfZooBDAKb83o0Dm63J19eGf/rpE1r8CBPot/eEHutBfXkr3AOC77ro/T1KN
         SvRNmayewMwnCc+fILe5ShDWKfnzOcg+BDG+TYOSdi7Ev+jZNixkzx/Whioj4WIQkYyG
         h2HZ7ezWKpG6sNZa5eiuquw+6Yt9urVVkF7mIAyNN5cnG6Mm6dg4Q91kug7RjHJpBA+j
         HXmHPWZ35Njj1aE8vYCBdIc/OiJS2rMnWdNaw0Ox7toCuf3Xm77O8Dbdjo17EgjTe4NW
         nGAF9s4cdEkcKt/2zjK7ru4poIfTd6tDoTkidPGVzDXu7qZH+zVVL5LtX1T4HWNRi7r+
         1Zgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691622462; x=1692227262;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y8j0szVkvKcAaoM3INhmFK+61wCHhHWJPoTGEH1oTE4=;
        b=IpWTY8sEygk26X5VlFGSP9jiEJ7LDJYO/hHkL5Zw2JUNm/CGA017unoND683Xfkqol
         xgUdkUpmG+Bh64gWbJa4EoLIRNoOSmhUBUiIRdHrga9Cfb1S+tNEa9Duy2bl9U7mqC3e
         KuIDs7cvqHqOmbOZKH1tS2iNxb79+cZFTO7o4pPTpEexIpokG1lnJsdEttMvQeU7hXcL
         Mqx9RiPR+iq8smickZ3JFDM+PfTp/nuwCFX9LEdrPobev0pXi7+BqwLo8IvSXKATuOKC
         ga8UeEzAoo2EY7IL3SgF8cqEKVbUgbGOOioto6xopa3Skuf44F+qZtXxxYdsYXVRaDoz
         eRNA==
X-Gm-Message-State: AOJu0YzuT7n7A3H5u7au8nO416alRXbJw31S/gEUPNJi56ePRoZB7EDr
        v7UK2t8gexKwDeAY01jjxRtlnBetVeq5V5almq09
X-Google-Smtp-Source: AGHT+IHoA0W+qHckZalwjUx0R1V3TWTJmykN6cK3XJAXJjd2ISbwonmFDNEXOBPMS9UJCg9yY1BL3A==
X-Received: by 2002:a05:620a:2287:b0:76a:ee44:8550 with SMTP id o7-20020a05620a228700b0076aee448550mr364217qkh.29.1691622462630;
        Wed, 09 Aug 2023 16:07:42 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id g16-20020a05620a109000b0076c707f3bafsm45547qkk.94.2023.08.09.16.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 16:07:42 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:07:41 -0400
Message-ID: <67cee6245e2895e81a0177c4c1ed01ba.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] selinux: use u32 as bit type in ebitmap code
References: <20230807171143.208481-1-cgzones@googlemail.com>
In-Reply-To: <20230807171143.208481-1-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Aug  7, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> The extensible bitmap supports bit positions up to U32_MAX due to the
> type of the member highbit being u32.  Use u32 consistently as the type
> for bit positions to announce to callers what range of values is
> supported.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v3:
>   - revert type change of unrelated iter variable
>   - use U32_MAX instead of (u32)-1
> v2: avoid declarations in init-clauses of for loops
> ---
>  security/selinux/ss/ebitmap.c | 29 +++++++++++++++--------------
>  security/selinux/ss/ebitmap.h | 32 ++++++++++++++++----------------
>  2 files changed, 31 insertions(+), 30 deletions(-)

...

> diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
> index 77875ad355f7..a313e633aa8e 100644
> --- a/security/selinux/ss/ebitmap.c
> +++ b/security/selinux/ss/ebitmap.c
> @@ -471,18 +472,18 @@ int ebitmap_read(struct ebitmap *e, void *fp)
>  int ebitmap_write(const struct ebitmap *e, void *fp)
>  {
>  	struct ebitmap_node *n;
> -	u32 count;
> +	u32 bit, count, last_bit, last_startbit;
>  	__le32 buf[3];
>  	u64 map;
> -	int bit, last_bit, last_startbit, rc;
> +	int rc;
>  
>  	buf[0] = cpu_to_le32(BITS_PER_U64);
>  
>  	count = 0;
>  	last_bit = 0;
> -	last_startbit = -1;
> +	last_startbit = U32_MAX;
>  	ebitmap_for_each_positive_bit(e, n, bit) {
> -		if (rounddown(bit, (int)BITS_PER_U64) > last_startbit) {
> +		if (last_startbit == U32_MAX || rounddown(bit, BITS_PER_U64) > last_startbit) {

I'm getting worried about what might happen if the ebitmap starts to
contain bits near the end of the range, e.g. U32_MAX.  When lastbit
was signed this was a non-issue as we could set it to a negative
value (-1) and not worry about it, although the maximum value
difference between the signed and unsigned types would eventually be
a problem.

While looking closer at this loop, I'm now wondering if we shouldn't
just rewrite the logic a bit to simplify things, and possibly speed
it up a small amount.  How about something like this:

  count = 1;
  n = e->node;
  while (n->next) {
    count++;
    n = n->next;
  }
  last_startbit = n->startbit;
  last_bit = n->startbit + find_last_bit(n->maps, EBITMAP_SIZE);

You should probably verify that there isn't something stupid like an
off-by-one bug in the code above, but I think it is a lot cleaner
than what we currently have and should resolve a lot of the type/math
issues.

>  			count++;
>  			last_startbit = rounddown(bit, BITS_PER_U64);
>  		}
> @@ -496,9 +497,9 @@ int ebitmap_write(const struct ebitmap *e, void *fp)
>  		return rc;
>  
>  	map = 0;
> -	last_startbit = INT_MIN;
> +	last_startbit = U32_MAX;
>  	ebitmap_for_each_positive_bit(e, n, bit) {
> -		if (rounddown(bit, (int)BITS_PER_U64) > last_startbit) {
> +		if (last_startbit == U32_MAX || rounddown(bit, BITS_PER_U64) > last_startbit) {
>  			__le64 buf64[1];

Similar to the above, I think we can probably rewrite this to simply
walk the ebitmap nodes and write them out.  Using
ebitmap_for_each_positive_bit() seems overly complicated to me,
although I may be missing something important and obvious ...

--
paul-moore.com
