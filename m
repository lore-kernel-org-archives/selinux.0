Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794850651;
	b=2DxrWUdtA0oJi1hwINH7ec7k19FClwVCDqDJ/1DTiN5zuEhMrAmKpTyxCMJdN77Xs56d
	 e7vCDPa45DLHGzlYaB3AwnQCB2RT8ZjH7rNnLUgZGoY59MVj6+/JM6V9NpTtYPemzar9s
	 62nbtOcg/5gm4hyIk0b6hunCZvQ1+eQorSzBf1JExc/jBHEgbZvsN1onERHhfjTyPAPEW
	 zID19MeWzmMLBvEQPnw0z7VPbjvrsjk2RVcTp3No5fA9GGAOpdgOaCDV/kVeT9KgGPF6c
	 S3nkzoeJVuf3sNGW4DP5Wbz82GP782bFYZY1NVCf2nOTUuUHdi9VtrmexMgvYH+rKwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794850651;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ASqD7yYrxwRTXpvky24aSldHzEJHTNv4OUWKJ01NHN8=;
	b=2rFGLcte0gwyHqLLErwJkLSOinWExpYBRNIa1QEZ7IH0IIpJETMtjMXEw7VzCML+pt6k
	 Y4d6p5toPGQdFqMfQBcGqM/2Y2NMw3fghKUwN5acapMebTYRpLovEjJdcPA68Zqe3jNsg
	 T/LWxgf5mn0lEf2qsYJx2nZiNoqxaiU5Y5rL46sgWAwc8TWbdrNE2JMaboJ92bByrBsYM
	 1VcprFErX8a3JB67Yo/9axhzc+GdThkjrqSLuGsAPVRIbmUVxQocC+vvk+12eCZsqIZhv
	 +rUWuCkEf4jRpMPFTA3QvaImH5xsp4d8ZXsJ7QUez+UJJoWF5JUPsCXG19QCb2ZYHbw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wda5m4T+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C55A606A88D
	for <selinux@vger.kernel.org>; Mon, 16 Nov 2026 17:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C55A606A88D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wda5m4T+
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b70192ebceso151583a12.0
        for <selinux@vger.kernel.org>; Mon, 16 Nov 2026 09:37:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794850648; cv=none;
        d=google.com; s=arc-20260327;
        b=qk0+XOCmzuOBQ4NLNVDm3vC1faNdvhtuaLSe96fbNR9oK79eLn0wgbIvfF/eGtw/+C
         qpFKbaccmD+FfjY/56nJiC/hhm4qMtQM9UyIy/So5acds69i9TycSxhjufrrg4j5bKYq
         uuRJOqF/eJiExVZf/DIVFq+e46BQqcL4gVp0fGHP9u+YOp80N6BY/VPxtGe4GnN+NR8b
         kdJs/zhfqU0AH9jlGDvzOo9syiXDob/xTN5gzD/xDbkfoizAYGvQTf6tUmZah/BQSTkO
         3b5DGwDOdYIGgcGT/p8mIo2uHk0/9eJIID9Yi18viJD2JSaUcWPYZSlNFxni/78xEaDj
         APww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ASqD7yYrxwRTXpvky24aSldHzEJHTNv4OUWKJ01NHN8=;
        fh=tf6bokjVwMHw15ZHKnYMaZzD3C5wJjFfs4m06tuQoCk=;
        b=aJ0ac1pcOjNTooVyAfadZCloHl23/Y3yUJFxbKJC08yJeASBqc1WUn/iGQlRBW6kwu
         gOg3KAar78/QU1CpqQ7qdoKDtHIuw0wx9yqEn8zXAyM0I3QZ8UDxf4WsPh+DiZG35kBY
         zhqDuxDIVKVP3P4silgy02oUN4i67PfHbyk8r8ylfj81kFPJE1AwDxW/tuRrEfJ2lhM4
         cwrUbW3ELFeNU6+XCcL9t5jugt/mXc68pnBJ452SRPwiaA3MCU6VG8JBIgPpl/2xwR74
         yQPENL7VJyLcnGY3xOnrAmmE0nvZTvoJVw6jNNXPldS5nyJXwTS9ocdjoBk2JSHtn27c
         AN2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794850648; x=1795455448; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ASqD7yYrxwRTXpvky24aSldHzEJHTNv4OUWKJ01NHN8=;
        b=Wda5m4T+Og74YNLartpajMnAcctT7hnb5haqi9hjLlBRa67TYcEPjf80gw45qsgIx7
         FMobW/aC2ZXQsUmoaLilVLeaESS9ODytholTX6ZkGdI39Z50BqAMQuVm0upEGdU/eTIl
         KzXBiwaEJY7eqa6p49n+ZePGE0YUDeVtz78JPQJb7w7ae3zRsyAfYOAEtJq8eS6befDe
         ANfoXo4rOnrr9cTK5CEQbvEa19yD1CMimOfBL7pxwr0U+pGpN6RB970vgsC2xV+kB6BG
         DqloDFELm5xz1LM2zdKvbUwHIwogDmvmrNVDo81Was00uh+K9TR8cjrFQWZvFUjBWrt9
         3Csg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794850648; x=1795455448;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ASqD7yYrxwRTXpvky24aSldHzEJHTNv4OUWKJ01NHN8=;
        b=k9lZpgiDfWnkYomxg9WbCfbGppFA5IQ9Yu0oT8OEOFJdXjStqisDBqw16dlklsatk9
         QE403ZMGj7kp60ZlgLeUzntf8dZIDA3B/Ge5djtY7nkS+LUHx3lOpRNMYpKD4PbK1CpV
         mySSaWACCuahUxQFh5QJbZ3OeKGDF0Uy4KzLTCtpSVN9xE8XQhG3XzUWLSo1Aczpmwwh
         YEBHgHa7SFY6rA1IswjPssKc33pRETo8kBOHq/ojzstMW/azPLnqSp9Bzd2idRBTnccw
         dH+Lnfwewyc6LJNVc7DvF14bH8T1Gy/AIg7ixen/5AkUq7CH0/rOKYT4eMAMAtUJnyep
         Ts/Q==
X-Forwarded-Encrypted: i=1; AL+hErErOSGY/RRS8EyS+vw+E4zfDvJvRGiBjUGT4O2lqZ4q+GkJCC2GE92u9SMWhDqZNxvJkU0arCuA@vger.kernel.org
X-Gm-Message-State: APuU4Z8we9xtfiMHS0Js1+zfBvgZXmqJxAag/BPHZoGp5gXTxJURwZgS
	I9AWM6oEGrXAxSi2FSLltOTGJxqBZQG4EVRDZ14eE685fN4zWk5njlYfJBWDsY08e0y4/e565PB
	rVd7K+6n22L+SaLP1nM565XKK0F99ZOg=
X-Gm-Gg: AYBFou2W4v2VGCP2558ApNfIxBp+r6vA3wjI1V6QqH1LmT6IoaiDcLnbd4Jtfk3BF8F
	FPCEATEFeq6lrMUg+uxSfqclb8LzMWDDl0+FpnFDZenijd8eDDyECbHqe7ZCvIx6Ii0IR+ZvCiP
	q2bvXCnndNbDHMoS/W7n+FiH4NrSWeJ4TBvxhG03BS9YbB1BXBzAo9UyirwKfOy7UELY4VD0ema
	7qiAA6kLgvUygQBCBd7zNd/wWVi76HT04xBQ7Q6kJ2XL9Qi6pr1SJ7sSh1TRno+AsEWbYJc8jlF
	gbDsoyeLP+qBqOWN8kC2CN53cEm+VEIsmZm34HZedjyAp/13GIMi4OHW8rofmb6wqnnnBYvoHN5
	PvqWSDZ9FkvCojT4tvyP1tn78a0YW1xcH6U7/i5c2yBzNNW7rjhySts9yum9lyi/Jnd1A/g==
X-Received: by 2002:a05:6402:1598:b0:6b5:7250:d621 with SMTP id
 4fb4d7f45d1cf-6b859ae1a00mr134291a12.15.1794850647426; Mon, 16 Nov 2026
 09:37:27 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org> <20261116-work-loop-pseudo-v3-33-8cbbea1cf34f@kernel.org>
In-Reply-To: <20261116-work-loop-pseudo-v3-33-8cbbea1cf34f@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 16 Nov 2026 18:37:16 +0100
X-Gm-Features: AclHuK_sKnxFPAK3k65pZhjyZC94SJD4eZ9z2j_P12s3kyb9TMw6hurQcjyq55Q
Message-ID: <CAOQ4uxgPerkkG4ie0SyHVXaBD9VZN2wYfQpEAEi4hytn=ara3A@mail.gmail.com>
Subject: Re: [PATCH RFC v3 33/44] ovl: refuse data-only layers on pseudo filesystems
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-usb@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 12:10=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> The data of a metacopy file can live in a data-only layer. overlayfs
> doesn't look that data up when it looks up the file. It only remembers
> the absolute redirect and looks up the data lazily the first time
> someone needs it. So until then nothing can tell which filesystem holds
> the data of such a file.
>
> But a data-only layer has no business being a pseudo filesystem in the
> first place. All it does is hold the data of metacopy files and the
> regular files of a pseudo filesystem are kernel interfaces, not storage.
> So let's refuse data-only layers on superblocks with SB_I_PSEUDO at
> mount time.
>
> Data-only layers can be added via the "::" separator in "lowerdir=3D" and
> via "datadir+" by path or by file descriptor. All of them end up at the
> end of ctx->lower. So a single check in ovl_get_lowerstack() covers all
> of them.
>
> Note that regular lower layers on pseudo filesystems are left alone.
> Stacking overlayfs on top of sysfs keeps working.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/all/CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo=
91QjJHH9T_Yw@mail.gmail.com
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/overlayfs/super.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 39d4d57dec230..719c2569dfeaf 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1237,6 +1237,14 @@ static struct ovl_entry *ovl_get_lowerstack(struct=
 super_block *sb,
>         for (i =3D 0; i < ctx->nr; i++) {
>                 l =3D &ctx->lower[i];
>
> +               /* Pseudo filesystems don't hold data for metacopy files.=
 */
> +               if (i >=3D ctx->nr - ctx->nr_data &&
> +                   (l->path.dentry->d_sb->s_iflags & SB_I_PSEUDO)) {
> +                       pr_err("filesystem on %s not supported as data-on=
ly layer\n",
> +                              l->name);
> +                       return ERR_PTR(-EINVAL);
> +               }
> +

How about we make this just a tad more restrictive:

                /* Pseudo filesystems don't belong in composefs setup */
                if (ctx->nr_data &&
                    (l->path.dentry->d_sb->s_iflags & SB_I_PSEUDO)) {
                        pr_err("filesystem on %s not supported along
with data-only layers\n",
                               l->name);
                        return ERR_PTR(-EINVAL);
                }

I could send this as followup patch, but since this version is simpler
there is no real reason to have the intermediate "only ban datadir" step.

Only the commit message needs a little more flexing to justify this.

Thanks,
Amir.
