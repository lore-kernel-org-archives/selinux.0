Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9E24E80BD
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 15:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610420; cv=pass; b=BU1HD49tQSVSd6sHTSV6SlfcAeQ3UW6XtPL1lXDm+gQW59hZzZgSZUMAeDt95FagY/HStshAoeJqyI58LLHh1njHck/7sQEUUc1baO4A/kUZN3GReFT/Qip7/JBrmdWtEr0UxZ4XUAQvUToafQGLAkUe1wpwZJ7YrborlSsLQMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610420; c=relaxed/simple;
	bh=5RayS6DHYeJ0sxTOQI1+hRCXVCHVHRubxwaiXpwcRSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CxCX7L42KFW3KXd5uqEH4Om0AQjbow78VESDDgzPErGJRs+2kB0Uf0LeIQgtsyAdUorlTxLxZCURNFQqRJq31fAAHPSBG/kyQWdbU+xjsr5FTBy5HzrATqRmEkp0fQBsd4ENifEG2I1/Q7LFp/wgcEI9xb+d1+++m0QZvHNj0xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=OCpMQLit; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="OCpMQLit"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffb83bf7aso17578175e9.2
        for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 08:46:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790610415; cv=none;
        d=google.com; s=arc-20260327;
        b=FXYcb4eyj221LXf1CL8xoYf4fTj2oQ9uI8rrNASERV3CovJihVnYUUZKguu85DvmJa
         3cLzdYhxeZpadhTMU/r2PZu3vELIxcvbZxzkQCKzRH/+87yPEDE5Q/Zrh79PVs2pzlBK
         jhlMLpL1QJs7qP/tvphMrnL/9YSA0juTZp6zYM8lTBxw2E4DI8QPSkCm+PTAqH9aalsP
         hk7mSqSLoIxyr85z7Z/LldgWV9N8QGqx2NplEqvMWj9cxMZyMsCScQAY9mZqOAMMu5RZ
         ++wQvgocTl+OP0UPS5We06lw3I18/9fS80BmoIedYgaAvkBECmysBfK/NxSd7Ca3QhLG
         ZZVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5RayS6DHYeJ0sxTOQI1+hRCXVCHVHRubxwaiXpwcRSg=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=TdEYTkVKz4PRTYhiamcYsDQb6AcHen0T2HZseZdNY2VjEos9oVLcCybPdHckBAuvYZ
         rqxXKJpt+MxrXwnuvwURe/uPYO1VKBwm80DoJcdLAltGec6qoZGZx+vAehyrh+Wsn7/h
         YJKmytQZkYdb9AzBOo25ymMPR6uTpo5Dut/xFvVdmf6EJxwz/QQdPmszsteykwIWqLZ6
         eGOAOEQ0yaxAg3OtCZSJPZWtSCyxGqBeZW2zq9hfxC9yx6H7+co4bdNp5x8xKOAZFIgU
         vsFaunmzztquyirS/4imYbI9+VlRtDx7V1XDTbsFLNXDQxpJ5ofZxQUpABAUtXd61Fbz
         Q5Qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1790610415; x=1791215215; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5RayS6DHYeJ0sxTOQI1+hRCXVCHVHRubxwaiXpwcRSg=;
        b=OCpMQLitTOEHanygZd/047hrwzEfMOl1HZbkkGAh3OdIf/eUArLHMftWuEEZbGQlaC
         ChHAyloTEbD9tFQLSOGs7k/x/BcnaXcty8I2G4pxYO50bLxJbCyLsvy/uFTCO64fjmDU
         BkunJlIiUq/gTMq1WBqP84//mIF7jtEk62koPFEbviTkQC5HuqSwsmNlvi5WyAdudFt3
         jPjTyaV6L/POOQxYqWsQtna438rCItXPX1Q12AvyDH77XmlHS+8bGIPbBDdxJRo6A/29
         qXKjKMVguoDpJ5NmcqtBiG/dNonKUzts0eaOBKAttRRyjfoTqwYRIM/EwpJZ78rPD8D/
         9BZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790610415; x=1791215215;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5RayS6DHYeJ0sxTOQI1+hRCXVCHVHRubxwaiXpwcRSg=;
        b=Zoi7oYRRlEl6GeaYM9j+rxWiag2ijauuJ7ZMBfQI8jGGZ7lKuIeg4OcVHaDccF/1kp
         RwhC8n+BvdfccySSRk5mUqkmzYKF1EGj7RaNA1/NsmjlgunTvtLNWvj4OqXwajgMg5Ft
         FJ6UX9P1UtBX/C7dff6G89qEL3oGURT742FsodgbrrW2tkAVCjC68rwdG88wfPIDZb8F
         xiuorh+hEPh25luYZ8nbfQXiWf2+MhH7O//FsPNCKgAnp99Jo4Cxg2jXQQo6180A3DIt
         SL2kq2FnFFw1G3Gz76lbjDmQvJL8v5z/vQvz9KwWGJuH8P7jS6nidXgeJC/CjE5OYhZY
         O96A==
X-Gm-Message-State: AFuF++n2d0BLttLtibreGwT48TzJg/QaFpkZduKmywzegPwl5mP70HJA
	ERoKxJXEg6fgVshQobJw0bY4WvugQdogjaphTUR8Cmrq+B/KrmMNLP9xQvs1fs2U3uVms1rEogh
	0m9MpL1Q8l5NEtDwLBpt34QKFJS3dsMs=
X-Gm-Gg: AYBFou1FOsIrSie+5gEDTmuVzmaYKaDgaimkknDeJUWVK2PWlXWu9H+FNrZU+fubWbq
	Q/WPPOxv7fgBlHvEL6nIfOM+zHDuhSJT8beirjFVxxneb5eZVvz0FBkE9pmAGSBd7+cVqll+dNs
	J9nh95qhrFQqWWchbrmZQFYd3eQt/IffDkv20oTU5WZAF3Yf/3SfyHSzRlR8PyMPeef4NozqdqD
	zlraSUQ1CF5+vRcY4zFW7RrTkWEDYIV9qLqQaTj3dF7PWnotFsMLwZvtUN5RuKggnIJTY2bTUgQ
	Cjrf4B29PqCNzjLOxaVjYQm5ti1EWIrJSBEp3NN5Pu7nQq+ZIxQo+/Py/ovqR3uVEYY6Uw==
X-Received: by 2002:a05:600c:4f41:b0:49f:fe5a:522f with SMTP id
 5b1f17b1804b1-49ffe5a56c9mr124612645e9.23.1790610414654; Mon, 28 Sep 2026
 08:46:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de>
 <20260925171755.2029271-13-cgoettsche@seltendoof.de> <CAEjxPJ6TJWjEHXwy8nkMguQcshFfDQ0HsV5G=U0Sk14+BxfTdg@mail.gmail.com>
In-Reply-To: <CAEjxPJ6TJWjEHXwy8nkMguQcshFfDQ0HsV5G=U0Sk14+BxfTdg@mail.gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Mon, 28 Sep 2026 17:46:43 +0200
X-Gm-Features: AclHuK-fw2vDAVPVQEXINSbibEmBzEj1E2nzQ5kmrMaXrm14nwZYpzrRn-dD-ro
Message-ID: <CAJ2a_DeWnQUPkbY+yF=10wbxq6E0Ot3eVEK5Jvv-nKu6qM_V+A@mail.gmail.com>
Subject: Re: [PATCH 14/21] tests/notify: work with CONFIG_FANOTIFY disabled
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 25 Sept 2026 at 21:12, Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Sep 25, 2026 at 1:19=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> But, but, but - you need that for your anti-virus product to work!
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>

So rather drop that patch in favor of the defconfig change?
