Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B15E45C6F5
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 16:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785341016; cv=pass; b=ERJz59d+klAA84NbR+u7LXNPg6itc2qNyCh1I5pG5mtIOm40vU/E1Kr4svo0LE9jI3Yfl7RTcOX1HhWX5rVN1AVNP2rISErVY1daQQI3Iu2sEQ+WpuQb135gLzgIyHm2v+pqqEzD2w+PMWwuTpsV6XJCNiqlZbu3VPbTdvblJrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785341016; c=relaxed/simple;
	bh=kRN0uGgDWiK7xh+Wc6y6+cmAjnzqkgsasw5Ibglv1qY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bbBKZD6kMm/sP7N9vQvPDf7cZj4uk7YZFJxuV9jjty4/KFep1tQvmNGEmawpUhrZsZe0SefcaAwlGZJUJ+5MvdEHkamveRYL6JG0SssURyP5yEdIxmiM/ZWVgk+FsUcod+9xsTsSjMqj9CfQsYdGgQlXlquJOqWwl67KVqbVRTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtkc0lui; arc=pass smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtkc0lui"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6aae367af50so438760eaf.1
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 09:03:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785341014; cv=none;
        d=google.com; s=arc-20260327;
        b=Xpb6LgstftWuJ1VpH7aejt56PlEbg/pFZu8nASjiyuYQae/dwz/VRmD0hCAY3bWm+v
         y+QlqRaJvEtIMAZ5uGEZoUfGNcZ2znJQwnY+VUnhiuCUL338saoMY6DgoXv5OV7MJVRN
         sEaj8bAnfwVu7gt2W6tVCNEGcSKx1qiK2hkNDmEDsa8yxvsw9thaRsy5SVwgIEEnadbg
         xpjX2jMerGvxPEADvf19DTpLXbhVLbe5MWhc/iYapDHejgSPpdzPly0S/ELEVEVfApnL
         /L9rI3Zj6ma+0Ome6+kcrSAjHvm+SMgf8RMVBubCR7VSOw1NWOmC4SMqF0H58pZp+K1e
         /alA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=leM3syM5i4yTzP3ui8/fSqYqbN7dIX51/MSk1rgWsIU=;
        fh=chQ82yjwsBiR9uZWyudR3T+s8hO/5hiH4ix6Fr2pKCg=;
        b=Rxg9hCumKEQJRmuejGAoLsNHSDN/RF2BcVW8qpPACIw1Kjn3QVzeZkcd7icdJXAHPM
         tRT3JNUEsdVV8olymjxkryLqsbGswBm4B3a2vyDFobhYvmMLUIFS8llJNPQYC7VfPi1H
         Sw4AAgXqL5CiBsg8/rgXY6zy5whmw1BsIguh8YyXSPCsrUa6vhTqwH8Ni9+Oo+i+CcTC
         N9nsAuSBsJOgm28eq7xf43ic3QhAk72nJaz5nVIRxA85GyMjuap7M+9pCYXIuS40BUl8
         n8uK/cleDxicoKxNkduA8AxBN58yT83eagXIcHKNtdje6FKvK3OQO7leTbi58o3wadpV
         LF1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785341014; x=1785945814; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=leM3syM5i4yTzP3ui8/fSqYqbN7dIX51/MSk1rgWsIU=;
        b=gtkc0luio76K7AsVY6AtMnadi91DDNyBgXN7l4/twxI2EK781/VYnBOfT/32ncAWWq
         4RQ9KxVQtqBDTTrXlk9HafSROPTKsnkz2Z9XrXv29ggEGrItwuO+S1tmdrxjkLtf31pT
         j4HO/9HAExcm/8fIEPv0Nfw2TooNfPb8tPkH2iGvkYOD4vQYzvSXs5iRHJowJPjzeV7j
         MOEdwDCzkx6WEpOFhuYSqlBf7RjuKtfvQCiDTSpwTbHBLwbsl8/tkDNCuzHglvweuv9p
         lF5lu88OCtBm9syoAcDwq/PPg5gQU28dp0PjNdeonG589+5mvyhQwrnclGZcRlRRMGpr
         oe0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785341014; x=1785945814;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=leM3syM5i4yTzP3ui8/fSqYqbN7dIX51/MSk1rgWsIU=;
        b=ejrRK3OxQDKkzVrzCt9dkuwZ5TIbKWAMQbga8q/vcZpVhWdT6cPDziDnF1XWSwNCX1
         gnNX25VNaq946RPiLe86zOCqkUafpnnmz07ufvxr0IvEy66LzkNK72M7dvGECstRdE4t
         wBhGFsu8UrBfRSb+Cbbe43h0wp9fmm/tfLStu+B7/tHGxMunxULwScD7cyUYtwniCivV
         N0g2G5aOAaffk+Qs07V0+vNTux0V6pHb19cLg3AebjyXkUGGS/UI/rx0xWXYYTMA7DjH
         oc6v0+Mn3xA444lUUslXeLybQTtDVj8495q43RFfIVGk9BFu+gzAlJvIKae1oVZ9Hwoj
         3t2Q==
X-Gm-Message-State: AOJu0Yyh4wNY2lE3rPstXdX6Pi0uXqODUCBVR8gJjicbegbB5k3UPPAm
	vdMSxdw9qJ2K9/3uNya/11ZPiF/mG0MQaLuNKb/lFqVqgTSBLBG+TpryAeKk81tUTLY+MjkWM6s
	g7070xmxVO70uh0MxoUvISNE5opWz8M67qnXD
X-Gm-Gg: AR+sD11BLrDmfbarvU7riKqz3h+LcyiKMitMhwW8bWmkQM5PAvEXl2t+mxX+8z0kNe7
	m/7YAJiePfBBuv1omhhZN74kM5hqsodRdBqwIhnvP5mR06U1B4H7W3A5SQGWcJx5NJp+NDZipb2
	7VqvTMPGcyCNYVtbW6VHFjbBL70/xvX6hQW/n3wtrD81MFsBG7uHkzYZJCtD0ZhkZFVGo9xYN5F
	2je1/2bgVT7ocddBTXUDPrzm//2xELs3dCQdbpymjNyjBhb84fFY5VaWIsdUAlkzKDJr9FjaiMA
	ZwDcA2tvhgdAyBPKbS2WYpiD1p18bktzJdpkJ6gHzfeh
X-Received: by 2002:a4a:e918:0:b0:6a1:9361:2c2d with SMTP id
 006d021491bc7-6ac96d77181mr3273120eaf.59.1785341014179; Wed, 29 Jul 2026
 09:03:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729152415.1606580-2-cahu@suse.de> <20260729152415.1606580-4-cahu@suse.de>
In-Reply-To: <20260729152415.1606580-4-cahu@suse.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 29 Jul 2026 12:03:23 -0400
X-Gm-Features: AUfX_mz2SjbHsP9tJ_yhWQcLD0ZqbQs1uBcbrzMDegiaUHlqlYQBeJc8msL2riU
Message-ID: <CAEjxPJ4=M0GjXd3RSYW52J7teeoqiZT4sOcq3WZWzk5_UFe5JA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] python/sepolicy: add a pyproject.toml file
To: Cathy Hu <cahu@suse.de>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 11:26=E2=80=AFAM Cathy Hu <cahu@suse.de> wrote:
>
> From: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Add a pyproject.toml file for the sepolicy python module.  This
> required also updating setup.py to avoid defining author outside of
> pyproject.toml, and I further updated the authors to refer to the list
> like libselinux since Dan is enjoying retirement.
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/505
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Verified via https://github.com/SELinuxProject/selinux/tree/pyprojecttoml

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> dropped scripts section
>  python/sepolicy/pyproject.toml | 12 ++++++++++++
>  python/sepolicy/setup.py       |  2 --
>  2 files changed, 12 insertions(+), 2 deletions(-)
>  create mode 100644 python/sepolicy/pyproject.toml
>
> diff --git a/python/sepolicy/pyproject.toml b/python/sepolicy/pyproject.t=
oml
> new file mode 100644
> index 00000000..3dafd35f
> --- /dev/null
> +++ b/python/sepolicy/pyproject.toml
> @@ -0,0 +1,12 @@
> +[build-system]
> +requires =3D ["setuptools", "wheel"]
> +build-backend =3D "setuptools.build_meta"
> +
> +[project]
> +name =3D "sepolicy"
> +version =3D "3.11"
> +description =3D "Python tools for SELinux policy analysis (sepolicy, sep=
olgen)"
> +license =3D "GPL-2.0-or-later"
> +authors =3D [
> +    { name =3D "SELinux Project", email =3D "selinux@vger.kernel.org" }
> +]
> diff --git a/python/sepolicy/setup.py b/python/sepolicy/setup.py
> index ca0396b5..5c4f2e5d 100644
> --- a/python/sepolicy/setup.py
> +++ b/python/sepolicy/setup.py
> @@ -8,8 +8,6 @@ setup(
>      name=3D"sepolicy",
>      version=3D"3.11",
>      description=3D"Python SELinux Policy Analyses bindings",
> -    author=3D"Daniel Walsh",
> -    author_email=3D"dwalsh@redhat.com",
>      packages=3D[
>          "sepolicy",
>          "sepolicy.templates",
> --
> 2.54.0
>
