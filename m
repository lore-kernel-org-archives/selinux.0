Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3C72BCF46
	for <selinux@vger.kernel.org>; Thu,  8 Jan 2026 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767891795; cv=none; b=L/yqQYVlenX7kLc6ysoG4Si6Ew8h90ucoPRzhv3YBChoLP53jS5zjAEFm8jfwXcGbCTz54dTfWQevJJ4gawIWt/jCyWC3PyeZoDdDehRCauGCcG0Q1ugnNyAwkIwSUyn0TNa4p9SvVhxUJdmdA833Bo9xJdgbzTa5D42uyz71eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767891795; c=relaxed/simple;
	bh=jb+LkVD3iG4ZAyz4HgRcWG84xPSa0shjNgAu/foEMcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJcFpC4a5/KjKi6uGibk4cQbsrhKzDFL7cr5eLZFHenTTvDxTSbylQp225f09cZvWPJJOkEW2Ql3Nt2FwQAJv/7ZUwP8zlh0ljMjl4binxQBaq2coUxHJuCc6mXqtu7+EWCTnWICbIv0+ZGHaIy/kPTNCg756dxATtIWggd3eng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcNa+wgt; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcNa+wgt"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3831ad8ae4eso374841fa.1
        for <selinux@vger.kernel.org>; Thu, 08 Jan 2026 09:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767891787; x=1768496587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fztcka0il9CRIJPACeLY6TG138rJ4SP7IYyVFU7o1I8=;
        b=WcNa+wgtmpHDzwTICgDGZeHuZSFWs9VhDP6pO/YKZRla8u3iEaAvq2+C6NrGTVrsxw
         n9aOmeG1o6UkHZX5Xt/s0d6VbmlAnp7OtqrQBeNjADmJIThQGdxi5nGxQ5SWaeIeG2oT
         9a7cZyD3cWxXSjwH+ADLypyi3NBoX4fBm0XgMVrMXq0bORi+osDMe6nJ24Oz1/bjQXtf
         CYzAt7Gp4AFTFNL20SldKeWUILoE3WtoIPuXpN8evHDqzJPH0mjA1BC9He+eyDGTnB+1
         BhzrYyD+G2YtG5phybmnQtDGbF4jvhmOrwarY2zx6ucSIhvJ1oRhmB3GLXbF9OvapMQC
         +vVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767891787; x=1768496587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fztcka0il9CRIJPACeLY6TG138rJ4SP7IYyVFU7o1I8=;
        b=RQ2zhoHiO+ZBkXVx7n/vmX1dt+VBX4/KzB00ac3EXIKWsIKKcyVWhNLE7mBZGlEbl8
         0GcszGqx/FeJYXqBrQ3i9XTi5IxDGYGXPxqXkuf0dXwAYVtiKO+iVHMHooInOpSBzZc1
         nHQcDwj80T7IVK4WYxPPnWZ0WxfihR9d0/bvn0wEw1XSk0ly1aqrUXtfVUqSpFpnsk7s
         2QxW8lrUts92q3Ti55x1zODKDP4N7U5+y7Dkp+Qo3bDB0rhWcDdCASeH2XP6mLSnPhWg
         FlZL4bvYlcX/4t8vpBoVZkw0RzW0yhKyIcs0O42XKQ4BluNPUCfMrN5aA+g1eubmCSmy
         ketQ==
X-Gm-Message-State: AOJu0YwVLxXZ2YweBGlIrmOgtTqQy7y+OYvhL2PA9LT46I2FHlsqxlTm
	M+5KhkUKIKRYVXj1gLbeLtgWKPd1O63O9JusPvFPWTpyuXq23j1g0YoNorqC/Gb/UVOKpW/V4IB
	mAw9NNOhdrdS8nCkOPg6d+gsxmWRVlqw=
X-Gm-Gg: AY/fxX41iFcV+QlEGrDF+6XHcreBJb+CESAaGjTqM1ih6JQX/JexFr0TzHC9FKARSDT
	Xq6Yiw6sI0660A4Y08uUzuA84WApa1T5zOP/3afpKrd2FjlbXEVWe7F0vCl4f7I0ySMeDAXDwaE
	t2CErPLR7QjjrpFn1RvtS1nSVkB0yB5xgGsKGE79T31McZTZupGJ4B0GyQbx/Q9SjUbdz8GZak7
	JeKu5Gd7ENWRN44a1HRp860HrcFCV0eLozQEKP4+pF5l20PsV+KWZC8IPwDBXD/t0EC
X-Google-Smtp-Source: AGHT+IHc48bOE4mbj5kjy7rloNcPZKRttjMIz1AYTYDIhp4T0eYckk24W3Xzad49E64rQcjy3ZL7bKjNeRhnShPB8dY=
X-Received: by 2002:a2e:a781:0:b0:37f:8332:6ae0 with SMTP id
 38308e7fff4ca-382ff7080bemr23562301fa.33.1767891787023; Thu, 08 Jan 2026
 09:03:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211000115.43983-1-vmojzis@redhat.com> <CAP+JOzRMmK6D1fOTOy4B=vP6irA6dyrXBWVNUgr6GcaQW5xA+w@mail.gmail.com>
In-Reply-To: <CAP+JOzRMmK6D1fOTOy4B=vP6irA6dyrXBWVNUgr6GcaQW5xA+w@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 8 Jan 2026 12:02:56 -0500
X-Gm-Features: AQt7F2o3YgE1gc7epoNWm3P4FluQNNv2FNUFFCgNZpsvtD9FDsbIc1aDrfIZE0c
Message-ID: <CAP+JOzQGQ0KD63xx1ytzR7xFcK2HNB8wi7nQ8Mh17vaJXinMJA@mail.gmail.com>
Subject: Re: [PATCH] python/sepolicy: Add support for DNF5
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 12:18=E2=80=AFPM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Wed, Dec 10, 2025 at 7:01=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com> w=
rote:
> >
> > This allows policycoreutils-devel to drop the dependency on python3-dnf
> > in favor of python3-libdnf5.
> >
> > Requires: (python3-libdnf5 if dnf5 else python3-dnf)
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  python/sepolicy/sepolicy/generate.py | 57 ++++++++++++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >
> > diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sep=
olicy/generate.py
> > index adf65f27..780a56b2 100644
> > --- a/python/sepolicy/sepolicy/generate.py
> > +++ b/python/sepolicy/sepolicy/generate.py
> > @@ -1262,6 +1262,63 @@ allow %s_t %s_t:%s_socket name_%s;
> >          return fcfile
> >
> >      def __extract_rpms(self):
> > +        # Try dnf5 first, fall back to dnf4
> > +        try:
> > +            import libdnf5
> > +            self.__extract_rpms_dnf5()
> > +        except ImportError:
> > +            try:
> > +                import dnf
> > +                self.__extract_rpms_dnf4()
> > +            except ImportError:
> > +                pass
> > +
> > +    def __extract_rpms_dnf5(self):
> > +        import libdnf5
> > +
> > +        base =3D libdnf5.base.Base()
> > +        base.load_config()
> > +        base.setup()
> > +
> > +        repo_sack =3D base.get_repo_sack()
> > +        repo_sack.create_repos_from_system_configuration()
> > +
> > +        repo_sack.load_repos()
> > +
> > +        query =3D libdnf5.rpm.PackageQuery(base)
> > +        query.filter_file([self.program])
> > +        query.filter_available()
> > +
> > +        for pkg in query:
> > +            self.rpms.append(pkg.get_name())
> > +            files =3D pkg.get_files()
> > +            for fname in files:
> > +                for b in self.DEFAULT_DIRS:
> > +                    if b =3D=3D "/etc":
> > +                        continue
> > +                    if fname.startswith(b):
> > +                        if os.path.isfile(fname):
> > +                            self.add_file(fname)
> > +                        else:
> > +                            self.add_dir(fname)
> > +
> > +            # Query for source package
> > +            src_query =3D libdnf5.rpm.PackageQuery(base)
> > +            src_query.filter_provides([pkg.get_source_name()])
> > +            src_query.filter_available()
> > +            for bpkg in src_query:
> > +                files =3D bpkg.get_files()
> > +                for fname in files:
> > +                    for b in self.DEFAULT_DIRS:
> > +                        if b =3D=3D "/etc":
> > +                            continue
> > +                        if fname.startswith(b):
> > +                            if os.path.isfile(fname):
> > +                                self.add_file(fname)
> > +                            else:
> > +                                self.add_dir(fname)
> > +
> > +    def __extract_rpms_dnf4(self):
> >          import dnf
> >
> >          with dnf.Base() as base:
> > --
> > 2.52.0
> >
> >
