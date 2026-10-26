Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793022199;
	b=q6q6YPj3utPWpTKOvSgCBKZCPU9WSL7eT23oIWOexzl7Edij8W4r+fpEHR/flNydPxVv
	 2U0NAimC7zXVw7eQ7vSzQlvr7qZgA7BF9yFC2Q7fcdEiha0unD5gx+vgqkbZLxmAWvpWU
	 1x+/b2BzrjQfjq+WDZAR2Zg7B+eu6i87i8BGzVb/PSHuGQPm0y/YHejcK0Y7XGwniM77d
	 kmdK+0Hy9J4DR2qv+wIr9zDcCmcsbKrcKCUQr8dlIVAYW5q9gbiU0llf9El6JB6m9lFkx
	 Xct02rkajTOnUHUy5qNJWIVGh6dQ+S0olcDRzynIuBbb3BaXI7vrUySj4xiTVeodE0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022199;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=3W+Y7Dm9+k2lz8tMPoPzoyaTgQuLU5LLpJ+Lzct3/dc=;
	b=xCWDehg32mg+Xz7e/rCnCDIljilChcqBAqXoMupAfunuCUBqyKDd8vMbSEhB6Zi42h73
	 C9aSLU+T4pBLu5xQ85ewIAEkvYYgieefdYNLC2c5w2osnAla/TXe8Tb1K+QcbXMSGvpBC
	 9jL0XqoDUcy8bE5rzqV2fVL/M9iDp+cauaneF5S0Thl6WWxXzAX0s1e1HbtGQwunH3PBI
	 T9rTwclfxHza0WC5LSOI+T+0FC+WXpo0NiDtH+Diq4DhBrnyRyrRWmR6WkHYRpDCeZYxY
	 rZ3H5Ki6cAp5XzAH2bxGKpL1drOXy+NLrZt0NBAUOSGgLmbWwOg/4hxW84IU+Sukbng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iXRKvKMD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9E8606A31B
	for <selinux@vger.kernel.org>; Mon, 26 Oct 2026 13:43:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE9E8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iXRKvKMD
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8ab395abf79so25233217b3.0
        for <selinux@vger.kernel.org>; Mon, 26 Oct 2026 06:43:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793022198; cv=none;
        d=google.com; s=arc-20260327;
        b=F9wNYXKJJ3F1qjRv4TpkqcaUrirfAhLb4n2jAne8OY3tdil3+E+CTvsGsQh7ss++Sc
         yyce5Hd9eYfEGOp5F/olFbZzfrkohHxR/N1AoZFeeW45MZ4l6LdyIxwIbLAOviyTf37l
         8qZlDcr9qNxt1asoZvvU+M/IRABxuNcns2uaGodZ7cjeMxfwYvS27p1DyTwaROQcM9E1
         Vgqg9zhbf6M2YyU90Oln8rHwcfXXu2B3Sxgc/22dLIQ+UvVx5dFTt0/IOvGiAqWkyq3E
         6llvdY/lnI6YdRjsywXGQWOFp8S5RW7YNqCrUyCWXo3suUa83kbEgN6Peh74KxOssr39
         77xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3W+Y7Dm9+k2lz8tMPoPzoyaTgQuLU5LLpJ+Lzct3/dc=;
        fh=oY3YJwlQJe6qc1tfsT1YP2sL1SDhL9BUcCb87gGht54=;
        b=MPfLOHCQ89wivxCO+OOQB02bN4tRoBS+DZydOdStIjojxD8VahdzC+WX+rqdn30XIL
         fEB2H/juAmNSuCe/0VtiI7Myoyst8YOEgP5bcc0GDaa03x7OWviQBKr6Db0DC7gMAPo0
         QEIMwjbqIgyrG6Z7jNMJEATBfreF8miKqPRwOvYDYC1RIY3F0AfjlfRGC/0+j9giL5/w
         vNBs/UxfJAxDgezR3jIFkIWBH7UBip7UHaZO44esQ2DOkfmzMXNKtcDuFbcQd5Gj3r0g
         tapXRlJQdlBxOf9M7I8Sy8wlfRSN487XLvlSO6VKkvhhePs+osEut6TqPIFuWRKC8s0A
         O4EQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793022198; x=1793626998; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3W+Y7Dm9+k2lz8tMPoPzoyaTgQuLU5LLpJ+Lzct3/dc=;
        b=iXRKvKMD3cQ8KYna12BBqYGpOFM0tjID5lSk+qLeM9zWQ1RjE26Ah6t7BsLcTAGR1K
         AwVUnGtPiJ+TY0AGjJrElEROgxQRXkhm/idSHv9GA3RT3FrklR4taX1s2Z6wKmEdi3x/
         /t7GWWUwX93wfU/He3WK0/Qa1kFK83O7knbUYDPRZBEsMD+UVojc1ZDCnIBBZD1GyaoD
         9+/GDHdXVD4he5Jaeins2vu55X47FW3M+6q669mX0aw6LcZ3jkfI4Zy1DgDgnZt/DVee
         32hIlZqGWmOUv4x6IDrDN0oGjOeM1BAgk12HGP3XAgwAv6JBykF0lLPLceWm/mHDXY/B
         iaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793022198; x=1793626998;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3W+Y7Dm9+k2lz8tMPoPzoyaTgQuLU5LLpJ+Lzct3/dc=;
        b=Oekpm+N1gebuH6535JYAAQcQUYGc/evxsFuvxgWxq70g45k+FBm2CfrGdz+p4aWMRF
         ANbc7irDbnurEgVXRBtCTLLGIimtcH+HTZU41tD5WHmasKA6Fj97Ti6cISqKl65vn+nz
         nwTE1tS389rvi4DoVlKMCAXZrKgd2FyV+H54D4T74NX1OLz8mTsxE5ujqzk+KtIbaTFe
         Hmg8zq4jNZ6uo9Ics6tbiy3kTRoirbMveTMjF4jhx361igbzEoo8IRQ9j4VE3pV2dza/
         vS/eZvY+0r4YTn0kWa6mzcV2lNjTdutoI10vK6la0MJ/wOANhBAQovz3kSYRoX40eeKo
         msfg==
X-Gm-Message-State: AFq9FYLFSao7qpR6cnUq+9jTzw52mMv95HjFvQSWJ+7tjAOVNR/d5ZIO
	obsCZ8Azf9hdxaVpLfe9Q6ZvmXJFh58Rf2Dh2LuwLydcQ1vv6SfCT2RYhtz7Pvpt2cpqX7nh0/5
	l1VQWlVjQCdk6FugiJ4YFr7Tvtxuy8uERNOMq5A8=
X-Gm-Gg: AYBFou3aPNcxSiRpsnV/FieRNTkRPOaAbuw4cup+IH6eg0CUkjjuwL8FYx5+Cfoh3Ix
	TNNEBy9U+0Y8V/K6SIHdWHtMcnGDOY2WnBfU+A1PlKcz7X3IaL99qE8GIuBpWGfRp8ZrPmA0MA1
	L29f1ZS7+sYk79TDL0Rx5W2Y1lrWhEWqqiwFcyvE+TjCL4qC+2ppp+YjyMAdMlBYOW8J26HTm65
	TAvHGtDX5twcKjYVhUr5P6EIeKy8p0KRiaYObnoBNHhrlTDG2fmpr92PLgCfkMQOnaUHIkGLEeD
	9cjtOabKDb4lPQqibWYBB+WFKXhuZydJV0a9ob/6g693xq/NZxuOEMwJkbr11ro3GqqTu100Qh6
	BBcYmudvqsCItmxVl5B2lkLtkhOfaivdB3MqG5e8O1RRmVrEeU1FJtp1XdTD8sQ0jgFoJAOtl61
	cUEZTnIc/viwBgWq0k0li6/w==
X-Received: by 2002:a05:690e:d08:b0:679:bad8:7dd0 with SMTP id
 956f58d0204a3-67a4538a4b6mr5816968d50.27.1793022197768; Mon, 26 Oct 2026
 06:43:17 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023184956.62086-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20261023184956.62086-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 26 Oct 2026 09:43:06 -0400
X-Gm-Features: AclHuK_cglNXO5quVG3TgHlLILqfPmBL0C27PQA91o6z37tWt7pDGNyqdcT8lbk
Message-ID: <CAEjxPJ5f9uK3dm=HW=W2StB2otN3Cx-4-i8WKa1JtxXwBh4djw@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: clear freed keys during component merges
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com, cathy.hu@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 2:50=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> clear_obsolete() and load_records() free the current key after each
> successful iteration but leave the pointer unchanged. If extracting
> the next key fails, the error path frees the previous key again.
> Record key constructors such as sepol_bool_key_create() leave their
> output untouched on allocation failure, so cleanup accesses freed
> memory instead of simply returning the merge error.
>
> Reset each key pointer to NULL immediately after freeing it. This
> keeps cleanup valid when a later extraction fails without changing
> which records are merged or how errors propagate to the caller.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This has been merged.
