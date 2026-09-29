Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21B03D7D94
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 15:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696177; cv=pass; b=rPTfS4eYxgwSSzUaPy8wKQzDWtcOe9MnBbj6jl7K5m/cOJIdGAA+OYlSjZ8PnLlynhf1kv7ml6dJ9cSUh547loCEk80tRl86LNc/nbyGAzh8CO/JgMWP/+2fT9NcOtLRqwhV0+Xh7G+nVlfMR9FnA+Pl+tz959psiHF5mgyVuzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696177; c=relaxed/simple;
	bh=Bjh/e/RuwLnwV1Rsgs5OE7j5wut+uAo8yaDRdLpE4Z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OEA0xwpVcD1Ky23ncTaC6ubzTBWtu5zngsALmbOAIzcmLVXiUOFw6hFi7CKVrbPP+q3HXGllaJRB5RkyBE/EKZk/AvYSAFhACvt/mawOTkAujTrVIW/+hDZUOWhsHYux9/0mWdgtHolgbmwewYhOZjXQImN3tghxD08nsH5sgS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6Nuu6zQ; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6Nuu6zQ"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-895fd505824so37789957b3.1
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 08:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790696176; cv=none;
        d=google.com; s=arc-20260327;
        b=MzUS4GoxozKQH87+D7DHTVZH/VGb25AyNgQH+M+3uq06SQaNzdzmh6JoY4hvnwyUQz
         0d6gf4SweER9oFi2aBC1Ilw6y7mXovlTx0WQ/ijKI9TfFA+hr1cbNzo1CJxs6x7AoYBO
         GC6npcG+a0kMTXaoU8y3VmOaHprhO0AUJEF0IczwDGD69B2dwI+VbMZvHzgs7WKrI5Dj
         69dL3bdC0+FJXFDQHACvr1iYyWU19dlZDIX8aCQzdZvl2EfDImJBqM5J8hRdlDN2C+WM
         zvdmNNYQdfNpD1ePizpR+OdIXt0LK0dVTRD+R6JmR1IpHSTp9P/n/HqefMUPSqsgPOdA
         LUvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xD5UHTV29/KUCBtvD1hLkE5r5nsBIFD/3Fww8lSp6QE=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=U6UzlALLUvhv90UTEPSG4i2ebwuARuqqh8dA62Nn522CT6+tQYB5Iogzkdh4NnqQ2U
         FYiO4380C08Xc7fuDUYDmBzbHi+tfdDYTBVuVldX5PQDzu2VX/0vLdAqCmbekLpMbDzA
         bLryFQEPHX9d0g8Za3iIQIUrrIffDMaiivSzPo3WV+yY40o3WfNrU0g231pYItFWQUMa
         r1TAK0jgiyNlSlw/OsmjXcNFpd5pZ6o0nJ8pUKIaj24hDL6hnETfzDJjgSDamfdgIoXU
         3WgZRxJhgY+LFwMI6WpJvBWmVNOL0pXfforL2u1yKacsQnVBdN/kvjjTpm7DZ9tJ/wsJ
         HCNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790696176; x=1791300976; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xD5UHTV29/KUCBtvD1hLkE5r5nsBIFD/3Fww8lSp6QE=;
        b=J6Nuu6zQkDoTBsXHw4uXnVlWyOVnoNAPmGxX1+Ukdp9cIrmoaZTo1KyRwcCcgWUX6S
         Ys9Tjg46smV7FmWTQNeYxn6drMkui1Wvk7ZL/37vG+srPaqXc7zTkMySJYIvF8wla5Zr
         NmLuv2cElT30rXLVflUjtVlYEJ9vVWW1hOYsFK6krMQreEQsEdCVMxAVW6jrPnvcgo7R
         cQ6jJ9Df5cCah3K28HsTn+tHuO36m25iqcq67vg/Rwdflbi/HYT34WssVRv/+8ZdRp0N
         jrksfxR5nGibegy2fjetJ3h+ZNgmduCWy2TmoLDytGw6/UPjBJrQT/ZOXXo7dkXSEmde
         l40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790696176; x=1791300976;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xD5UHTV29/KUCBtvD1hLkE5r5nsBIFD/3Fww8lSp6QE=;
        b=xZ/Y9YZmAxG4PiqYwf5M3LYD/yjM1bw7SqcNBBSPveRgzTqI46Jp+vrM0QToG+4EHr
         maMvIqPeerPl+d1sv354DReXigrwOQSNfsX5RX6970TZUddM/so5J5ao9hc9H1EYT2AL
         it5K4vS9fBcRESjt86Qi9DAkioSPQrvXAT8qcO519yKxZ9KhKAqNHG1+N+ICO2D2uchV
         r36N/kdzaEuTt90m4IhPS4OSyqKTwB2W3do9rkQbWckjY4QjpzkWERuIyHHrJCul8Crv
         ZuN4Y5IJuPlty8YNT98rZD+phq1uNKoZTcuV13h2xyz6Nr9XOTRTo8bfIRjlQAyQml6z
         /T0Q==
X-Gm-Message-State: AFq9FYJrvBElNjhhW5YV7aw6xDPRf6TNIE2nYJ+vw7pIXcq5wIaX5HcD
	If/ESTZHot7Lf8e/96iWitHB3gxPJmgmG9NfkIpvKUAtdEK5HRPkCC/zWAec4bLoSeVgylEa5R8
	F5mtCWX3R5Kkxg8j4Ar7GIwQ+QVXEPriNdREJ
X-Gm-Gg: AYBFou0sqE86hz8VH50LHZOpGFNut0TRHGE8Zphr5uTczmw8aauiB1djHPmRl47+3VY
	Au0l69Uatgf+Rpe+fm28xuZL+uhxP1YZyuF2m8bp0zOYYole4moXzRni3msjtNkrz7swKOZ0vUF
	cRuMhRppMH6cLXgzlgNPzuDjB7mi7Uj2Hnu3szPGTPFOp4sNVk8V8TVPpJ7bCkL3iRhwKq1Mojs
	Im2PhcoLZcTebUsI00mcCvcVJaT7iuyEToj0IZe58h908eVGIh4KkVsTkAGyVrPGqrv01Pz6Iej
	BAYUm3FNksln+gA//dPf9lbx990+uXQ8n0+xC8Cb+l+FHGbJAc3zn60=
X-Received: by 2002:a05:690c:85:b0:8a0:e27e:8e75 with SMTP id
 00721157ae682-8a64e5bf22amr73790957b3.82.1790696175602; Tue, 29 Sep 2026
 08:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de> <20260928174643.2458710-8-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-8-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 11:36:04 -0400
X-Gm-Features: AclHuK_POyRCbjHL5LwwguXSU7mL2N32mTYNGSdrGmbEhNNse__napK_njsRfp8
Message-ID: <CAEjxPJ6wzf4x1CbpdaZiHhv4kFukgS6Ohr2E+xWH4DhL29jRMw@mail.gmail.com>
Subject: Re: [RFC PATCH 09/32] selinux: factor out sel_make_files()
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 5:23=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> sel_make_avc_files() and sel_make_ss_files() contain the same loop to
> create the files of a tree_descr table.  Move it into a common helper.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
