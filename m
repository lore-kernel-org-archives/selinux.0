Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C0E18A6D4
	for <selinux@vger.kernel.org>; Tue, 16 Dec 2025 17:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765905503; cv=none; b=eMWFGOiCGQC6e0KmaHptDIeSis/sKHo2t5ZlRcMwHmcku1fpFjgE64Rjr7hL8T6rEYhfqPld335rwrdy/kHC6kTYiPNMzkz/x5e7nwrjY4xrajuPxmEKTzwIysL3cViXF/ER45h8drVk82EoWx0wRouNta1jDuko47EVuebHOSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765905503; c=relaxed/simple;
	bh=REirjFzrWSmFTkCbq3yjnoN48eaDsOECqD5+j3VVCDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mlYou6sbMTMhiDdl1PTizUwVg92/9KJ20Lr586gd80ma6M1xLvwI44JH4uR0Jsjr+Cz/Gy9zy0HkVonwYikH6DCbvGUQE46W6oh6yTYnJbY3WYc2wf9PAulVr6olA9TzfVNzcOE1CaLr67l5GhTl7jZW3ED06lSt+05hP5quztI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kga4lGEx; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kga4lGEx"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-37b96cbd875so40876171fa.3
        for <selinux@vger.kernel.org>; Tue, 16 Dec 2025 09:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765905499; x=1766510299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llWfhzPTujMLVhNefXEQI2bFA+Okg04tgTh/tazCd4w=;
        b=Kga4lGExWNLlj6RR2qpok9sb+LLUl7O4JquO2Y08u5eo8psCyn6ME2gmCRaL7CxQYr
         1p34Qb4qZGm3rSyALQ2pAGtC5VpUSt2aMpsEzjYK4YpQjdsV1rQj6vrbxkNPEKkHmfnh
         FwkleVpvIZolE+8VPfA2nG2fq5+w7i3CoHjx0Nvi4jc3hTIBIXtVkz3GWQ3Hi/KE8+vI
         AcwJIFKfE8QCRmLSLksmq4StQ98oaej4s4dm8Qk4cZ2JuoaPMlg/K83hUd9KVCD0lU5I
         d/iPrKl5S25ttu0kUe4rxLp3Zj0T13O9cLVlzSM4e53u/l9/wzz5GFIJFv3FCqY1x4HO
         vkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765905499; x=1766510299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=llWfhzPTujMLVhNefXEQI2bFA+Okg04tgTh/tazCd4w=;
        b=Q844Ok1wad2eWx9Pwoz+QJkE8rrYKZLFULzhNjiDAY/xgY7M/o7IDMcUTTGmuPZOIU
         vsVFP9jCI9gRj0GvI1r2tBiMKoB79XBIyTFKIHO+T8Ga/jqYEp6TT+QdU5Rokzw5sMZB
         jOjWJ0uedo7gnDyXeoppip+sUb4QdxLxwYsbJi5K/hxYO5KNRTPbjo1V/TW0yhFsjOK/
         9YLPfos3YVmdRcRHNyeNnMawl/ffHJvQW6H6L54ZKUpN1YQI6s+u50PL7RhiEwBh60r2
         2Q4uFJ3yuE/YB9jJ9mWZbqEn12Mji62yuahucH8oyC0D+5wMW3zuEgdzodRj7btM1++V
         RlqQ==
X-Gm-Message-State: AOJu0Yzu9Tb6uVZuK1JybvgOml2LQUSvQkR0X26qrjfbtcn7hvcc0xVy
	2SI6HvQzKAvmxwU7HMuDOfISnirpUX40rkQJsA0mWHBqi4XLzBpQpT+x0pFezh3kYhNF9rtSwqO
	CSnYEAwtpLAPRqKSPxCs0HLsHKDsA66dyHg2z
X-Gm-Gg: AY/fxX7yxJmdWcZxIteWtxfdLdotn97XpUw5MmAh4xkqTJiAHIvH4Q4sTMzirF4Hdys
	8DefysWbRwZGSKQGlflaVnliv8XlEk4To5fqMKtjiRiJn8wtTEas85WrNN9fVlpz+WEtwuwgqU5
	9+VhIz4sNtxNGCb5KddDZjmLNZFXBvq6UjLkJ4krYluTZ+IPH7Et0G5WVTa+GHcuMs5Ff/c7p5q
	xWKQA95yk2c9m8c7rllhoBHcjtADBNHZWwfVFLR2f9zbxysaFC9nsKW0uq1DHdwZPej
X-Google-Smtp-Source: AGHT+IHrgppXfReAYqE06gMG6ooG1+fta5oxN72M9XAiJmuo12eMAKzSXcxsKqd3C0YnZXPbxKF9HQ5/yLjq4ZCY62A=
X-Received: by 2002:a05:651c:1613:b0:37f:cf97:491c with SMTP id
 38308e7fff4ca-37fd08d13d1mr43432251fa.37.1765905498948; Tue, 16 Dec 2025
 09:18:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211000115.43983-1-vmojzis@redhat.com>
In-Reply-To: <20251211000115.43983-1-vmojzis@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 16 Dec 2025 12:18:07 -0500
X-Gm-Features: AQt7F2r7XJ39IzKOytFH1FlqL-kcQwqA7NJ3WX7OOfDVdXNegLUzxT1h5h3jB-E
Message-ID: <CAP+JOzRMmK6D1fOTOy4B=vP6irA6dyrXBWVNUgr6GcaQW5xA+w@mail.gmail.com>
Subject: Re: [PATCH] python/sepolicy: Add support for DNF5
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 7:01=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com> wro=
te:
>
> This allows policycoreutils-devel to drop the dependency on python3-dnf
> in favor of python3-libdnf5.
>
> Requires: (python3-libdnf5 if dnf5 else python3-dnf)
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  python/sepolicy/sepolicy/generate.py | 57 ++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>
> diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepol=
icy/generate.py
> index adf65f27..780a56b2 100644
> --- a/python/sepolicy/sepolicy/generate.py
> +++ b/python/sepolicy/sepolicy/generate.py
> @@ -1262,6 +1262,63 @@ allow %s_t %s_t:%s_socket name_%s;
>          return fcfile
>
>      def __extract_rpms(self):
> +        # Try dnf5 first, fall back to dnf4
> +        try:
> +            import libdnf5
> +            self.__extract_rpms_dnf5()
> +        except ImportError:
> +            try:
> +                import dnf
> +                self.__extract_rpms_dnf4()
> +            except ImportError:
> +                pass
> +
> +    def __extract_rpms_dnf5(self):
> +        import libdnf5
> +
> +        base =3D libdnf5.base.Base()
> +        base.load_config()
> +        base.setup()
> +
> +        repo_sack =3D base.get_repo_sack()
> +        repo_sack.create_repos_from_system_configuration()
> +
> +        repo_sack.load_repos()
> +
> +        query =3D libdnf5.rpm.PackageQuery(base)
> +        query.filter_file([self.program])
> +        query.filter_available()
> +
> +        for pkg in query:
> +            self.rpms.append(pkg.get_name())
> +            files =3D pkg.get_files()
> +            for fname in files:
> +                for b in self.DEFAULT_DIRS:
> +                    if b =3D=3D "/etc":
> +                        continue
> +                    if fname.startswith(b):
> +                        if os.path.isfile(fname):
> +                            self.add_file(fname)
> +                        else:
> +                            self.add_dir(fname)
> +
> +            # Query for source package
> +            src_query =3D libdnf5.rpm.PackageQuery(base)
> +            src_query.filter_provides([pkg.get_source_name()])
> +            src_query.filter_available()
> +            for bpkg in src_query:
> +                files =3D bpkg.get_files()
> +                for fname in files:
> +                    for b in self.DEFAULT_DIRS:
> +                        if b =3D=3D "/etc":
> +                            continue
> +                        if fname.startswith(b):
> +                            if os.path.isfile(fname):
> +                                self.add_file(fname)
> +                            else:
> +                                self.add_dir(fname)
> +
> +    def __extract_rpms_dnf4(self):
>          import dnf
>
>          with dnf.Base() as base:
> --
> 2.52.0
>
>
