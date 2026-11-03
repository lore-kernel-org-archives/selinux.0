Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.224.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793721101;
	b=uF0EO67aohgzj5fPwB5YvRON8hiQlE647NNLF60NCZyfpPQsDDguqL18dDyIjvo7E1Kc
	 LNzQ8t+ge0JM+1jI4F4QNLlyoqbvTUEdDcqNOxI8d3Tf4AvjzllQLZFqfIFw20vHkiMNz
	 33P5R7Lm+Fo4UKtNu42w2o+tohjeiEfNIzKkSfXMVRHgHacIdAWZRABQzkxvzNGmwArB3
	 ReCU0/G6waXt+cZK39bTXMIulVqp+wbvjLNfGCquINXIIoUcQ7YjrmaHnsONX9qUIOOFP
	 wx0plyL7RLhhNEws8UGsXmjCOmk1ynNl2bvNqYK7w+n4QP70anjhrGhL8S3dzg12oUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=xGB3I1EymC2xOw5UdC01t0CrZ9zaN9mP7effLcaQUhw=;
	b=waRHRYDAjP/hgkk1B4lrxVCx4qrsipKHUPg+JTV/02N9/8qfcaT58pdYhp2oFbMtrYl4
	 CcLzoauVP41rO5FiM44w6K1N/SWu57XgnhjRpaER4rDdTOj3MzX5sStvWhLFMpvqDx8We
	 n4nsjuUBmU6Ocg+FoQEuxnSfDIRMkRA01XtpazYTDu8OhkhDtsl0x7wv4IP5OFUgXMrKX
	 oDCmQz1jK3giSFOJXheX+t2Oghtzlqihwv900e5dbVF4cY1O2ErxXr2Uotf+vDdcqarxN
	 1obDP0qASXFJW2Dblyennn/R9HLHmnsMjeGtFHdjAWwgsGRXqetb6sZQ921r87GIYPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tiLGew48;
	arc=fail smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B0A606A327
	for <selinux@vger.kernel.org>; Tue,  3 Nov 2026 15:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8B0A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tiLGew48
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-67999045530so3730806d50.1
        for <selinux@vger.kernel.org>; Tue, 03 Nov 2026 07:51:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793721100; cv=none;
        d=google.com; s=arc-20260327;
        b=j1E+/NNnTN9yrMIvUYqMbXUNZjp4LleDxAGTG1jgvLzOA5kNAYvkiJz+fMzphUiPYy
         5dsvOcmVkatxyO6YN3cK59Kg6RnrWSgDFaMjBMU96dRqJOdNJZx8KV6tO/Nrypl2xdGe
         Zic/hL2Wkjdmqvw1y+fzULsQtF+Cs/nouMjnhCXerBoQXu4K0GG+LG7oEI1NXZ7LoD6v
         zRJwhc3Cld2GGhnsB1zTF07tUDP6dup809GvqdKlQ/7tnalFqQzZw8uy+zGbfC8zQq1a
         fvr2PHms3YErPPpsNV2XSLWWvrsyOOfrRj/6gERqolrr8152cSNcjHU2LJ9MNSI1CTyy
         v6Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xGB3I1EymC2xOw5UdC01t0CrZ9zaN9mP7effLcaQUhw=;
        fh=q08H+4X8i7EaC7BesAm/d8L4xwnPrnWz+43sBtlpBQc=;
        b=d/Oz8vf+PjC+4T8UTlWIeeqkCht2OEVCzw8Fg3ReLPfPehFSqd9w6JZ6koGI2GuL98
         S4w0Npu+on6UaqAtaOC2qqpposu/xrO7M1iV9mBd7/T8X2+uPQfvAWmLsj6N1uGxuaTW
         dYxSAciYVHlbX6l2DCFL7POmHTHgEivJc7HxTiolW/AoSFEe4sHJbgh+57DFEg2p/FUF
         NcUAeFN0ZbKrfI4J/TWh0dKeYpZMrCzJOFRPS7uY+hxlPMknQ03TMAZuClr9wDNST+D5
         pvvX/phW1fUShdGgI5BdrXjFZU1noBgNdx5F1nMA8qRB9SuKVPpBtrufQBN0deTTcO8B
         lDUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793721100; x=1794325900; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xGB3I1EymC2xOw5UdC01t0CrZ9zaN9mP7effLcaQUhw=;
        b=tiLGew48Xg7uXKkJc2Cs7lckifbLc6SR8cemQxxNzYGstookkCFUybII4oUgRsyGie
         fQTzuu0AKLK705gLV3FuPRVfAero9sAK5b9Cnq5FugHrXEia4Pat+miJiHDvkZXLRo5H
         8UcgfquMsWiX0Rp0veu/BrcSUOE2U6rI+mUr1wituiOibbV+PR2w0fSbm3b7CEmGZDtA
         yKw05AZUPWPtoEiwgZf/TmtdGhrJZ3d/xC2TkYiOyLWshZlDC+vQW13UTcnVCTg1G8Lk
         WyVqBBXANSVwtyEW51WzQ5MQt3rEXTY5hE6rj3jxYzxkrJE+VMDQtO+DJMjIr8cyDDrg
         GytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793721100; x=1794325900;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xGB3I1EymC2xOw5UdC01t0CrZ9zaN9mP7effLcaQUhw=;
        b=VUfbuyN2rt/io8HMPEMCilronXUonbbYCTvu8sAn4MCQkUEbRdp6YPWX6HyE7GNQRn
         SJJhEl2vaY2PPV2eYcP99tbCAv+mCKYMFYxqETx+4GEH/fky4l8ahgzrpI2fcHpvXauU
         c2t98l7kUbEI9bqOuRGc1n/uvCqUzlJy8YUPixVhZbtEwgY+WKqBYfI7dAfRjCqCmUXI
         AeR8zAs3Yhr2VmORGUoVmNP7MR4crmD3aWX1kALol/dk0N7nhY3Mfmys1OKuB+Px+EZg
         4eRzBi8MG2WEiaXLcbXZxcsvfePf1qwKRJag5B7QzX6P2Ms+Pv9yVJptzNUvFlWUSrhU
         Fhiw==
X-Gm-Message-State: APuU4Z/0Ikn2csONKzd/UfJ3ptkuVhhRJI9EBVCD6c+zELYjncJkKD4L
	kx1loSaT2NqkamGbXCp4rgk6FpSH3lA8mkqT3t8wJKEm68NDuG6tdcGm+vcPfCbCYHrr80xdvFg
	BEkgRWwiunZ45jkdu1O2XXg6gppA1Y7WlgJt/
X-Gm-Gg: AYBFou1CSnFdxVeDQd2jVSTo+WwTA+L2U+NkSS06xaNuHJNkJPm/HQcp4O6V2MDn3vR
	z/7RRWzFMrZcn2+x/3i5aZsrtOWhDLYRlRlOtv0LE5lGc7LugmgxhTsVAE4lF3yx8Y02Mb8RTuV
	QzSbsxL4/pI4IkQ1DDFX5Ovyo/D3FlnijHw8BMt0NVQUoBa2umJNzV636E/u+JCbuqV1e+45vgs
	BUi/VhJfzpLDrOydw68+m/pin4J5KC/jT7/msVdAPjCoRoOTwaYKHdBv3+EQhLfl6/x3NFIqbVs
	qh7exG6RRvbMHd5zwlQEPHSqaXesvj/AhE+3mV0AtsbLJhQ5td8znLdNsyFcm4NxCw/q4n6QQ38
	fwdOiOuRWpU89iKYFO0m1cD7CLFt6XDDoOMj16EYbHN05vot091zvrgdVvIKXHRxll+UhvwFB7m
	6oF3NVWS7ZKY/nsIha7Kb/xJzab6DC7nT4oXymXjfrdNFZvzHKBtbrsIeWbA==
X-Received: by 2002:a05:690e:1207:b0:66d:112b:769 with SMTP id
 956f58d0204a3-67ba4c87f73mr9106633d50.1.1793721099652; Tue, 03 Nov 2026
 07:51:39 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102134718.1825-1-stephen.smalley.work@gmail.com> <CAEjxPJ4WOueETuVcO==Kr9zVs28LUrZYdOwuujGzSLMrr1_vjw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4WOueETuVcO==Kr9zVs28LUrZYdOwuujGzSLMrr1_vjw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 3 Nov 2026 10:51:28 -0500
X-Gm-Features: AclHuK_gVTTLlaG0V1gMMkpwWz1JzFuNHA0Eh_LrOiyVUMCjL3GPx2_VSewN64Q
Message-ID: <CAEjxPJ5t5mpK9jabqZ85vQsrWK_srS4gurE5gDowq8xuFbdawA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] libsemanage: add path substitution helpers
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com, cahu@suse.de, jsegitz@suse.de, tweek@google.com, 
	Eugenij Safonov <ja.safonau@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 2:12=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Nov 2, 2026 at 8:47=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > From: Eugenij Safonov <ja.safonau@protonmail.com>
> >
> > Add an internal module for handling path substitution rules from
> > file_contexts.subs(5), mirroring the selabel_file backend of
> > libselinux:
> >
> > - semanage_path_subs_load() parses a substitution file ("alias
> >   original" per line, '#' comments); a missing file is not an error,
> >   and a '*' in the alias is a single-component wildcard that must
> >   span a whole path component
> > - semanage_path_subs_apply() rewrites a path according to the last
> >   matching rule in the file, matching whole path components, with
> >   '*' matching a single component
> > - semanage_path_subs_canonicalize() applies the local rules first and
> >   passes the result through the distribution rules
> >
> > No functional change yet; a follow-up commit uses these helpers in
> > genhomedircon.
> >
> > The module is covered by CUnit tests (libsemanage/tests/test_path_subs.=
c).
> >
> > Signed-off-by: Eugenij Safonov <ja.safonau@protonmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This series has been merged.
