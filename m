Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A05940860E
	for <selinux@vger.kernel.org>; Mon,  8 Jun 2026 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930721; cv=pass; b=Ml9cGUzo8ucuhue6J5C4hx7OT7B1/Fi84Ht+mRNLzGuNh10Njlv8/1hooHo3hflBSDKlRT/53XlszvrRIw1YaKh+2UBmVqUZlY0jf3Z4IHAIIAtTsvvB5MzHnl82mK12bSSJ//EfAGOZPxQSr2YWg3O5S1exO+y/42cVSuRVE9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930721; c=relaxed/simple;
	bh=idVIMxdkAQp2GV/II0cNbi/ZaoOXUZ1zK8ukt4MKIf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7nJmugZnIKHmeLeMSIjAE38lLAO+dCDlr5y1FE05cvPBC+kgzqf3eZbRV76Fv5w54ddEMPkvz21SG3oIZAktS/gbzD0rRcE4xRdPWeCKE5CK59HrR/epwsd84PfsPSiRXcukktfpGPoXmn+QoNPe7YuAcZTUUXjTrYi2bRL6yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgzvBMtj; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgzvBMtj"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aa5f11deb2so4826316e87.3
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2026 07:58:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780930710; cv=none;
        d=google.com; s=arc-20240605;
        b=MYVv/vf1nycxnmbJx2f3WWfuPG0MNVLvfACjJ54d1mK90z+MzLKFTVj++jbTMDqYLj
         MbiZXKnMPo/pA3pIxiCldI1vZ2w4E+iJRy+I4vXfCLEJzGzCXznNP92QBWyTm3yBiczE
         dJ02Xg5ew34khfuLmEwhJtnjj+Ce8Aj+xsrKBvliTIgA6649p0/4w9rJqNVsFWaly+ww
         WWr9mxfwMUShSmQk7tGdCRS1kDOYEmm5TDKYvwKqETWZsFr2XV+Y4E1DtHFw0NK3/tQZ
         c/eiy8FEmQdLYtKd5dDhXRWnDdU/5CdgfAqJGFw8jnQ754S3mH5nXAL19xo2ozi5ZZA5
         YNuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HvRVcM8Vos0/z/pJIN9WIhbGtfk6RerXtsh687NkPu4=;
        fh=QWsdzKn8fi4wzq+yLocjud/9IGto6IoSWXADJiJ8Tw8=;
        b=Zyhct3Ot81wlOUm5HizZ3PDCI9lVhDf1ICK/G213pMgexOKkC9ENehp7DxvWQUo1NU
         rdW58tZe/Vhpobo5EtaX4HBJBy0DH8MhJnXtq2eOQ+JHIqfY2lazQvwcCSksVpCZNcp3
         QvcGH/6rhznZb0IfIBqU0U7Uk5c5wcDDuLyzlYygjat+07v7Ei8HFbQOZu3J7OClcZbG
         CGERv8dyEqC6CqwnE5e8oALRtpSTFP2j2a8h17vDG6JzEuq86l7DmqP7+m7YrQKHfqC5
         h6u7aAU7bPSGsb2wDFpzKaOP7ltzX7ie3aq4uAw8Acb/7HbD4EX3YsfSJD0VwbjcBj46
         mvxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780930710; x=1781535510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvRVcM8Vos0/z/pJIN9WIhbGtfk6RerXtsh687NkPu4=;
        b=XgzvBMtjv3DqPfbUyTpkXsoppvU5Rf3YG8bB9XPCX1dgB66v1UT8I03u0yVAdBg6EB
         pf6BP5faBQHJ9kdGP+uCosvKyTaDLmESwnToSUlohLmnZooHeK/dYZrBA3ZI6xYRIcP6
         lHwM8MUnCO38LkFVdOX0TEKrEtMLEF0bNkQX7DQn/vNZ8TvoESfzbPXmEoydlmVcDc16
         EFs32VJH0EM3xvkJHufGL/Q/4wJI5YoF1KYhqOpOzcgdsK2uDqR6nf1Uo6oMVWt8uJ33
         F4Mu0HffjTtRUACraJXqw/FlQ70iBIbe9cy0y5fttF5VaXljgt4VA1ZLuNRJAluTTa2w
         bemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780930710; x=1781535510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HvRVcM8Vos0/z/pJIN9WIhbGtfk6RerXtsh687NkPu4=;
        b=Ws4+eFyUZl8PRtVnnSP5zuY3yy1viiO2TZjaeQLJg3WB7qNmjai8gEc+6SkZVFoAan
         qGr13vqpkhOFKG8UaFdvSc/wD9mTUedcJ8ahCu3BO9nY2PQFojLpffocXfRO+OTpjW4U
         MrrDi3rWn1ZvfAUzJDqz9EZB0YEE3VzE2b6RwMaHQsMBpZisbiUMrim7WEQDx5ZZUypG
         Bzj9NpieEnVDPbRI0o80aveG5hbnbLYCVPDN1Z5yFCjyrmzSTUjepVjKgxHGDVC3ZfhZ
         QcZP/fvNk5AbA9N3xgFiaLW5v7UY6TvZ0OFkboAJjA7az1/uR6lPOiZnHg1lS8oRaYKZ
         v6Nw==
X-Gm-Message-State: AOJu0YxEhV78Tn8xefP2IIhwkzMIHpl+X2snOqWZFMhBWMyUdlMRQMLt
	N0RXd/Oti4Zf4GgKcV0BEnkvsJH4QYjROfg2O9EkUBe7rBcmsScRYafdidrGMQfdMgzRk+QlNuG
	7bTmNuHKJAzTfLfP8DwwI4m0r9FF27UUVBcav
X-Gm-Gg: Acq92OHLlHi4MBET16ANeAQ3pPAA+Z0hXSL6QuCLjYPA2uD95J6ckFgqM040nAD7w+u
	Tyknt+hPmjpxLOyaLFJeenQkpPSgWnyzthuXn3eEfPbA9ZzcID/GrFmoVjbihXGNJfK6lh9OPPE
	2P9B2ZFKNaYd9Ges7ie8FyLKvJt34Z0QRLqYZhAFWbEwpUFOZO5TYhZf4i/MQStVKYX0GDbjmgk
	e0UawuxOJpxkkm//TkRr1GGJnQ5BSao31HylHtsngYsacf+QzrvgcisTe2qaMpgLGv334pQ/G3/
	QaPTWF5evnbd/EA=
X-Received: by 2002:a05:6512:1116:b0:5aa:6c66:e343 with SMTP id
 2adb3069b0e04-5aa87bc93bcmr4413441e87.38.1780930709759; Mon, 08 Jun 2026
 07:58:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608132741.309092-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260608132741.309092-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 8 Jun 2026 10:58:18 -0400
X-Gm-Features: AVVi8CdjGZN-WpKuUJLf8E9Qq03ky9RTszxKosl0gpowOgMODyvGySgh_9jQDOo
Message-ID: <CAP+JOzR6De90Dd5gpfpWfaokB-VPDhV10ZMmfMWvF+ksrwOnmA@mail.gmail.com>
Subject: Re: [PATCH] sepolicy: set conf.substitutions['releasever'] to empty
 str when releasever is None
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org, Yi Zhao <yi.zhao@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 9:27=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: Yi Zhao <yi.zhao@windriver.com>
>
> For some distributions (e.g. Yocto) that do not provide
> system-release/distribution-release file, libdnf can not get releasever
> variable, causing conf.substitutions['releasever'] to not be set.
> This will cause 'sepolicy generate' command to fail with the following
> error on these distributions:
>
> $ sepolicy generate --init /usr/local/bin/foo
> Traceback (most recent call last):
>   File "/usr/bin/sepolicy", line 702, in <module>
>     args.func(args)
>   File "/usr/bin/sepolicy", line 569, in generate
>     mypolicy.gen_writeable()
>   File "/usr/lib/python3.12/site-packages/sepolicy/generate.py", line 130=
2, in gen_writeable
>     self.__extract_rpms()
>   File "/usr/lib/python3.12/site-packages/sepolicy/generate.py", line 126=
8, in __extract_rpms
>     base.read_all_repos()
>   File "/usr/lib/python3.12/site-packages/dnf/base.py", line 554, in read=
_all_repos
>     for repo in reader:
>                 ^^^^^^
>   File "/usr/lib/python3.12/site-packages/dnf/conf/read.py", line 42, in =
__iter__
>     for r in self._get_repos(self.conf.config_file_path):
>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/lib/python3.12/site-packages/dnf/conf/read.py", line 109, in=
 _get_repos
>     parser.setSubstitutions(substs)
>   File "/usr/lib/python3.12/site-packages/libdnf/conf.py", line 1643, in =
setSubstitutions
>     return _conf.ConfigParser_setSubstitutions(self, substitutions)
>            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> TypeError: in method 'ConfigParser_setSubstitutions', argument 2 of type =
'std::map< std::string,std::string,std::less< std::string >,std::allocator<=
 std::pair< std::string const,std::string > > > const &'
>
> Set conf.substitutions['releasever'] to empty str if releasever is None.
>
> Signed-off-by: Yi Zhao <yi.zhao@windriver.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  python/sepolicy/sepolicy/generate.py | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepol=
icy/generate.py
> index 780a56b2..0edda54a 100644
> --- a/python/sepolicy/sepolicy/generate.py
> +++ b/python/sepolicy/sepolicy/generate.py
> @@ -1322,6 +1322,9 @@ allow %s_t %s_t:%s_socket name_%s;
>          import dnf
>
>          with dnf.Base() as base:
> +            if base.conf.substitutions.get('releasever') is None:
> +                base.conf.substitutions['releasever'] =3D ''
> +
>              base.read_all_repos()
>              base.fill_sack(load_system_repo=3DTrue)
>
> --
> 2.54.0
>
