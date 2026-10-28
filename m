Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793192736;
	b=tTlU/MZMLUe6mRDay2hywi9WzhryK+RZuI5/iOhIzFlxjsRv4v6oNr/YvyOS5H+UAu1R
	 68SZ5w2ijoFNuTfLayL0s0+4C5JKWTtO5/Hcd0g/m2Rb1M0OTQXNI3e5082f7HrVCFhYm
	 9wlUD8p7iWGZA70tnZkFX/RnggS5cxNlPO/5K/w/p9MQY5BtEKSJ431b30BzVTXbjdYVW
	 RAwEO/VbuGzdiwrCRHhJScYpFGf0u6aNxgT286H6kmJrBwYre4ZA9a3ZAfNFTW8r/65Zg
	 UK4slycWdj7iqDtQzQG7Q1qnad7VWRuFerlxFkjgXCWYdgNi7OKf/wFs7vXFYFKK+Cw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793192736;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=aTgbTYLoZnnp5qMGCui00LkwYjlmZcFgC2ha279EAc8=;
	b=KXOzbqIDy5ykf0VJFsgomgLu/62Aek2OMjMIYeKA6qk/yMpp9TkLenglhEEV/0SIxCwI
	 tykVPqKsGyBQASbJgEdMsCGMpaEgrz/m2y4JYPAeujPy7L8gWch4PW8TzzY50y6BIwHab
	 o3Cpb4gsfokutmzY4N6M+5QwMOkyKR8kPBA7syC4qXuL1torWICvGR+bgrWZ6xTMQSzpP
	 kNd2QewOpkrtPcmwO+SY+I3nZ/RK9LBiZGsTsC43JEx+BsIE4eZ1D0z8oQz/d1jS1IogT
	 4h5sZD3UoWPphmR5L02Nm7fB7Co42hFZyQCGFCVeVtdlewK302TVeDmEjJdlboGPriQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0WwsAu9G;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A20606A31A
	for <selinux@vger.kernel.org>; Wed, 28 Oct 2026 13:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75A20606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0WwsAu9G
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-675676afc3cso1039145d50.3
        for <selinux@vger.kernel.org>; Wed, 28 Oct 2026 06:05:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793192735; cv=none;
        d=google.com; s=arc-20260327;
        b=ZY31r3k59cmcSyQpHrgVNyMdQW+IVLK8gswWk7YU4qIRZsDIhiYDesb8E3rQxkO5Wi
         cA2rZnNER5H1ATBwm/R9luCRz3WWQrH3I2sT7ajPyK11b9NOYStMIsqYIYTSESOij29/
         v68Ui7s0yKzhIXGN5QC8KGTJG3tMr3OLQNCqi0W8QVTRPN/pdWZGRf04I3CUzOOjEZtg
         v54gi8qBopPdf1PzgyV3S6eHSfAF2ENQp8EEO61giT2Zdtj3WOAHxblTP+hXOkOQGscu
         BXeWGaPn4oyDAVsSApyQ+pWMuuBbcpFtG3HUvV5VjdbKv2peHxxJ//pkKPbB5dR8duoC
         eMEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aTgbTYLoZnnp5qMGCui00LkwYjlmZcFgC2ha279EAc8=;
        fh=QFKa48eN4AZKFIyrSiZk3FCE4nUKAEfyzhRYxfFXB60=;
        b=j5RgR+u0CVPqgD9X/mLUHteVHLG9vdSu4ca03mW6AUbPQq3pVOZX0OSITTjd/IwAdg
         4Uz7XpUGbDPjmrR1VDkTFvdN7DcoJmaE8aMO6ZRs0HSbMLaJbfSaNGnJURcaRh2fJWAO
         OZzgTKJ0Rk9FkPhwA+ex/1enUgynvvsOVj20/oZtUx3/Mz2mcQ3u7dE4OCIc8FE7kvJE
         6COLlKvfQ0yp0Gl1lwDV+gvE7AGERbEEfRX0rpmmSrAprbarGAXw/D/herOlci/RaNY9
         Hg4D604t3bLjMqj0lHtxBE37sQ3nVgrX4KJInsm6nTfKxt7xWRf/bTR2Q/n8B5AL3V8U
         3TdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793192735; x=1793797535; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aTgbTYLoZnnp5qMGCui00LkwYjlmZcFgC2ha279EAc8=;
        b=0WwsAu9G0rbOswpckuAYGykKORGFz1h6tdDQPpCPWnVERtbYP0NwwqenjOkeNzrKDc
         jX4eBd91+V6gu+bOejL3gE0pbvCVWyOV82msXH6lgabPugFBUnJAM/VCRBEBL6XzzMZU
         lD1z16XpnUDt7zD3FL+ZMPazuPhB+ov4yMiV9HW9UkTYtHyZQW+xCVScZAeXd266JUrt
         +lh6ncC5XouodGyIXS0k05rif6oNualuchGdPAJAKXwEI0vPPWuvO7+NHpEJv1YpewYr
         JEAMkaUmVOUvlR9kjO61nxmF46Fk3HcfDYj7ohBsbbuZ6Fnxn6XEx41i/R8ocBUajfdD
         LVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793192735; x=1793797535;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aTgbTYLoZnnp5qMGCui00LkwYjlmZcFgC2ha279EAc8=;
        b=X+gGrOntlUyS/IsTRWyzXL5C/kAvvMuNbEfpoCDhWmOPhuQk0jOxAtE+iF4ckLg+oS
         JUjwRONjqFoG467KqV0WNDXOss2oDtXEk5ro8suM/5BS3Fs+vdY28h3n4xTdUpvYLpO4
         Xktg3u18IWOW/Oa2/Qw2iQ4FV36YSh0DqAxOiaIUFYab0xTFDuHEjZgG9Cq3JU5e2z2N
         ydxhdpuOtrysqYTEeMxXcs1llDrGjzbQlF/KZzmdC2JXD9LTmQcZSI/IlPEtGEWLbRhP
         HlRbx+AD5o1cLVewVBoaJ0qc5fc9UOP9cj04X9sjga7NYMadcOMw2c2wWfTGRStvWs1F
         mArQ==
X-Gm-Message-State: AFq9FYI7HB5U0RhHpp5eUP6k/g3VReo07shX2zJM8T3IsHIOEsDjLZnJ
	DEDnzUXtfS9OlJglnjMqTtr4txigqnsqcSXPoEJFUOSNKfvMk7gUcu6UwMqQ7zgKe7p/WoGPjfP
	2K5N4nRjrkiKSZN6Kdh9aKl7xK4C8ZSi9rGLE
X-Gm-Gg: AYBFou0H1olGckSgJ6yoLXX6ixqLb19+nj/X25CbZHYCTHPFoy9/+OMtX+MyAZKGQAN
	5pY0+Mav/MTzYbly6bM54KthNat7ax6iEAxElHI17sdHnWze69mZ8EMzWaoWdrUm/maIVroxVhn
	w7UXJxvUia1e5dFGrYA9f1c1f5TjUsWnTvBlJsj/X9QLPl33F+JgccQnDendEK3w8QLPqJBXIca
	XF4L5KcoB23/KKRFlCPqz5PqNyNilWoJfevyuND1QkhKtk8OUgq4Im7D8A3ODhdnJxGvYFjE59C
	ZJHVuywukQ1NcN65HSN40GPxqJb2ndw6eo1hUSv+PTJdqKf8KMu8aQgCGXlSJPwV3Vb+8yrQUbk
	N7L6MpHMOGhEkpjFyuk17odZFxlTjRRGg80FTRcFEZq8iBH8i+K8eBNbc7lwlgmvMVAhWTfIJp7
	dvocz3W0CgEFAimi+JlWkC9A==
X-Received: by 2002:a05:690e:1907:b0:677:edc8:2d93 with SMTP id
 956f58d0204a3-67a7b80517dmr2316622d50.0.1793192735348; Wed, 28 Oct 2026
 06:05:35 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027141413.89975-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20261027141413.89975-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 28 Oct 2026 09:05:23 -0400
X-Gm-Features: AclHuK_y1o9lXcgwI5nlIkk0_MiSn_OHTpDjO233lgfNzIA1UPcFA6EonpwGpcc
Message-ID: <CAEjxPJ4Ya-=hqRwwccYKkyTOnHqJ43oVG4rj1FO_4zWydP-9Wg@mail.gmail.com>
Subject: Re: [PATCH] CONTRIBUTING.md: sync with Contributing wiki page
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com, cahu@suse.de, jsegitz@suse.de, tweek@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 10:14=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Sync the content with the Contributing wiki page, which also
> included information about submitting patches via git send-email.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This has been merged.
