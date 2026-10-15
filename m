Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9063B5314
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792073838; cv=pass; b=h6t3FypwFr6o8JGpqNmMArrpavjc/TaJLyF7HkNFynsTerkXzaqNCloEvs2RWsnMQVUlbFiktCJZZvrRXnVpTHA3/KOUZNH6qAJyO9Nlvfa4B4PhtdhOYvpNnLri2mRIRe5H5CVPYtCA0oJ2q/kFMN0x8lNKfhqs8QPyBx2qvb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792073838; c=relaxed/simple;
	bh=1Mtm8toKND3l6dHKo25VfZ+Um9yao4d4Nf1t1yLMBhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUaO97qKuy95Lx8GKdi7Ks5lhu2YzMBYXKm1gBElFkdoABRWIz21dn7SAey5W8el/AS7seewiU5sIsJG2mGpSG1RY0sP5P4aHeHp+OqwZrFpH4W7xRLmRnOE/5Yf0slqWMFMRCJjGYyNRpDosMOa+hpIHgzhUPfZIHblhRcApvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZEkIICg; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZEkIICg"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-679a2b540f3so627393d50.2
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 07:17:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792073836; cv=none;
        d=google.com; s=arc-20260327;
        b=lIST8PxtvxtyOO4S1/Fr1MiQc79l7erC8jkW2i24MAfW7blczecRnMU35IaTtMy/Oz
         DA0jS6gCewOLrABl9BtYj1lEp7C+lreqzV/ZRPoyS8SqsfYA9X/aJTLr+Pa7gwbSWTZQ
         1OQ+lquQ6B1ghUPYn/IOX4qtq6bhw8W5FB4OZWMJget6YSXf1/gn4B6Vv9HovcjO8sjQ
         YYrUh/BgnPoGbimYCOinN6U7Wv93o8/eutY5uherWcy24Jv7zBJ4hqfwfLAC4BzstQyv
         2W0dsV1Nff5D1BSlnrBYJ94SJgwm6p5zbyy5cGNZnwx2oTmyrBvNFrT6I9sxWEQm+7Be
         l3Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1Mtm8toKND3l6dHKo25VfZ+Um9yao4d4Nf1t1yLMBhM=;
        fh=/ylro2kycojNQMvnSHIUFC32boeLWx2LWGPJCNKw/TA=;
        b=I2YFR3eqaHH/azlC3pvsubt4XwZJt0FjjPRRQF1n2qyxeoQ4ikhGxkUKLzzy8HAyKJ
         GCTUvmEhiKjiSMKIcjaf9q9ckXlX1BEbnubBvnQFXw8Ugj9hb1B2Q6zBGTDccNXHbLGE
         +8eeIu/F06jbTyXo12/ELFvsnhEhdtm8SepNTWEIy5p729OqASJeuzubQMBB57pU3ahw
         vw8tSx0pquFAl34idKCR9kU0Ghesq3XQfjNwacfjcwllJKytAg+rCwhxrIHKo72HpqGo
         GOo1v6GC8yLd18VXV2EdDeCItQSeA9mevghjfU0WZcJhj764jOQF4wDWDph7sfWKilIc
         1Xqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792073836; x=1792678636; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1Mtm8toKND3l6dHKo25VfZ+Um9yao4d4Nf1t1yLMBhM=;
        b=HZEkIICgFMvK1uoSobbMPDbfH58c9fIwDNEN9y9v+EjIew2cw/kzhIdN/EW7yakzix
         Ic21mQCSnnPbOpftr+fJ0C/kVrfo2SBWgdkC1WpQpHDuZgn7MxHRRtkq/S+Qz+ceglJ0
         c/fw4WL+pT+bO3I4TWUVPyMcru9AIOAcAmyopkSNUdSpQETGmZhWxq10L0disL8SI+Tw
         SYbrByVPRpOZnJAIxvU3XAi75+oU68PYkfewzP0QTF9G7x+O1jr3xdUo+bqcZX4kCrFS
         FKypa4rmx2GXsc8vnx9XBEuZZid/wkM4fWM6X2TqICmO4sxM3jFiIbm88Y0TvxBx7f3d
         uOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792073836; x=1792678636;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Mtm8toKND3l6dHKo25VfZ+Um9yao4d4Nf1t1yLMBhM=;
        b=VrJoOJcTYNEJnqIsGi5CEawwNiFoGroJ31rFDIbHXScRzTNrsoV5yu7qCuT4mc6Oq/
         9PVHkb7nLdP87OZWm5VgY18LfiCdWev73l3DZoM0/wfnpTOl3+Mi+0aKqjRjw1asNdFg
         iuif3eC9YxG8b6aDcXb5VOQl3gGEBZ9BFlf7qJj/nVmiouR+ADRezuuMyGE4b3zwEPXW
         +GoB+ANdOsBaJkQC+RdiqFUcHMmpt5LdUJUsOh2F68rHqSnitZkzI3xcopDfsZJGSahq
         S4Epnri7SyKFgej4Z271prtd5KSixKxTK3kSuUHMU6uSAFVImo9lN7mfVjwgpEgnwyZ/
         sNYA==
X-Gm-Message-State: AFq9FYJJZ4snPTAz1s6Gua76N3XAkLWdcRe+Q+0+gx7bHk9vDFCHGFDi
	uz2G2oFjW3R7XGu/SU2Yip/6aLVXsaun68oQ+hMhxPZgqIlylIu2kjLurmw1d2pvHHZhUiO8Sa8
	Dw/D/z+EGdsnZqz5wh9IVE0UruWBU+qM=
X-Gm-Gg: AYBFou0GFFzvYgenBFlofd0eTrXNJ3XlcWprP9xgCCuUGOW6nKfRg2AlfFZUQ1/b7xY
	UxDewoNPzZxix6D3USzMLb3evTh2w5Lq1WsyT3eGjJ+XFrv5F4fHRECmC9Owe2UxPp9YPm9ybXz
	cDHEA3F4xvWcrwMuAy7NarJkzmCRQjefKwui3mlBx/byHnuT5Ca/hNGRGubFpMRAhi+TNoCfRsf
	iJ4YpCtDH6dJQK7W7cGvJUGB1ZRC0BSZE8lSwUvtrJpj1pmLx/jy9hL2555sBUrswMnTL81Q+ds
	3vvQEM69EPEmYjAGaD9Lv8XtGPNY8Lnqgi3B0CAL8qQ00HrfAR46abY=
X-Received: by 2002:a05:690e:4384:b0:677:ca67:994f with SMTP id
 956f58d0204a3-67936065db9mr4084021d50.58.1792073835838; Thu, 15 Oct 2026
 07:17:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015054535.844874-1-omosnacek@gmail.com> <20261015054535.844874-3-omosnacek@gmail.com>
In-Reply-To: <20261015054535.844874-3-omosnacek@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 15 Oct 2026 10:17:04 -0400
X-Gm-Features: AclHuK8ozebhy-q55vE-k6B2ZX8YZ078iIbr8kisFbhQs7DcRi4gJmiNM4tcdHk
Message-ID: <CAEjxPJ4BAPyoAv96nyM22E+L8WV2UUV37w_NpXgupY0capGXDw@mail.gmail.com>
Subject: Re: [PATCH testsuite 2/5] nfs.sh: work around NFS hangs with
 nfs-utils 2.9+
To: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 1:45=E2=80=AFAM Ondrej Mosn=C3=A1=C4=8Dek <omosnace=
k@gmail.com> wrote:
>
> There is a bug [1] in nfs-utils 2.9+ that causes nfs-mountd.service to
> fail shortly after nfs-server.service is started, leading to a hang on
> any attempt to mount an NFS filesystem afterwards. Work around it by
> waiting a bit until nfs-mountd.service fails and then starting it again.
>
> Signed-off-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>

You didn't provide the [1] reference in the patch description only in
the code but regardless:
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
