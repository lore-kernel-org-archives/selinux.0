Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4D4394493
	for <selinux@vger.kernel.org>; Fri, 15 May 2026 20:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778876581; cv=pass; b=Y/YPEgyzHPwtdKWU0EN01id+NUXKT+Vi5xDn6xUZKLrZdpwzD9rv0L1TmZ/ufiXXXVSllD3tE09sKs0zQTF19oiOIVbN+8T5khGNWAnjW5iOd8XXw7gqbMNdFnW7Z74ahBwt1TZwLFlMgNfQr1qA45i1+t9oobxotlNT/TmxvgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778876581; c=relaxed/simple;
	bh=f5QeAc10pFKXolEP/cjzVqQZl6adPOV0K87O8mMQP7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5BdiW0zm8DRy78hhrl+logIiWWmYrJOXfQ0609x5kUwaQrrW06TCdTZTu2q5U13RwQ0+0KjAZll7M+qJMDc3oGsdFcoGPurQtWELpn/Z5F9yOUARKBx3t7j2NSKwr2NqWBuwCHbkVmiCt0GJ4EyccwlblTLjx22pW5qloNQEX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmmjm3Is; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmmjm3Is"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c80170db7d6so91835a12.0
        for <selinux@vger.kernel.org>; Fri, 15 May 2026 13:23:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778876579; cv=none;
        d=google.com; s=arc-20240605;
        b=gZXzhapsYfXfclFsOK/+JVzOhL6zOJVsNg6RM6+/CMTRZZZkWbAnm305b/JUL5pXk/
         42L3dVFst3n+9Y5YHZ03KL7n1nI+1HifOvfU+jvYQOAwRdcph+NgNLlZQlrupp9POqcJ
         m+MtQkZHyTrUFR0z/q698XM2YsWwllJR/klJHMrl7gaF2MZVx+0zkga62Bn/7G8//3ma
         UvOIi8r8s9aC6XhsrwADLDavkeqfgF8AZjVmxn1wHpcaCO4CQStRlCXvb+LmxpSbm7OR
         msRcKR4wCfNEqg5m63MffVGZ1FLvnIOuC3FyE4Fw20z9sFJZnyQMZ3VsD3M3EsyKf9s1
         +6PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=az49owAL5ebgzubP/ZxHATt9ZywH+RvNlenDfmwpanY=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=jBMKg9Nu5/qVSUGUgOn++J7UElPGNQ8Ly3+CeMA+Bua0oqtg+uogcapW2aFKo5eGRV
         q2545C26ydOZof+rXsXOSujR9A//wPNoRP5LxvBy0ZHm6hZ8KfAt8THpTKqoJtfkp9g5
         x/MQn7iBFQDM9DANVjhkwfQSIB+CXZYIzyG4GqrrnVNgTkFuoVc1kX/do06T3WxRV8iu
         ciIMnp9fIXZ+hZjXDoKsGiyF+kVjPhB+u/F9GDXvU17GqJcguRI+KEtv+NHBCDoOxe1L
         ke70LozwY8hZci1Hq97UGDHmAt6KP0skOcHsyPUCfBq+QYy8hEj0hDGuGRvXX9Koud37
         rg/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778876579; x=1779481379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=az49owAL5ebgzubP/ZxHATt9ZywH+RvNlenDfmwpanY=;
        b=lmmjm3IsJijadZp92xNPHAUmfg+lSbaPNGoqGQsqBzPYMOs7aibLMEr3g1qewVKESb
         bCsRBTo464U4oKWlm26byFUsBAbtrVAx6jklmqmdUjdgTiWpcmMskZ1afROswZ/sBZFh
         5GpVKKiv+YhBkUX6Qfa+6lQpppF22CzbDKnIvHNdrO8pEl5c+5uDskFB+ppiR7O7EWMu
         lCplbzsFxkzIxw/uzZ+46uhMJoIHorU50iHyNtNAa2Izm5RrKdM9y4qst2Ea72vdYjnw
         9YOec6MCjqpzkXMcemTBeCKDTldQgDNyYzGndMPW+HbpCP+8eLWW8E9cpNdVyEy3ciUb
         mU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778876579; x=1779481379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=az49owAL5ebgzubP/ZxHATt9ZywH+RvNlenDfmwpanY=;
        b=llQbw4YXRRNPOobGokjF3xCCcMkF5sSI9JeviX12ppQhqUvGbpDE7/8HyoxArkuAn+
         O5DS/QTg7UkljJaWNYxuP3hIuAw5ZBGCBTKkdzY9YXajQT2N+E+5RupCwfMUssXW2PWu
         JozwftJtTsuChTU+oD5myqy+WDfb4pdCQnkmwORZpYyZv5Brjznh1sRAcnMG7Yi5v/af
         cssjmmE4zUOtLITQ6OwSpGRXNreesVbSJ6bhXx7X/Nbf6kiDqajTlV67ML0VNAh6kScf
         2uxCI2UWpRmlENU5/lMS7lVhC8kQoeKXbmjFyFjmMDJljq/LsAOw+eF1gpZ0pjDt0pXL
         4WEg==
X-Gm-Message-State: AOJu0YwI/tTp8Wrb+/DYriAX3H8QAfEHbLjrpsurAZntuCiq3FD94QdY
	VdiCtZiwiTYgEznrZK4MZjAa/mPxh2St476LmDgxBjJlPma996+3LCj9UHK5k9xSgBQvdEMhded
	NjFojyq9ZeXy2poaoP7TsPvay0Ws7q9o4niiC
X-Gm-Gg: Acq92OGP2Hban35QiR8NH4Af+hcErjecH0JWbphbqNDM9P+z18mr70iUXNuXK20v4Ov
	c8UTVbwDzRVMqIBuzw45ACxTJvHFEwbNiPNupRR9rhCTDEaN1uRbEM8YQnguTycIUgpFD4pMcuu
	6yl9JrTIY15uGB5+m7IqPcpoAv7Usx5t823fktU5dXUSf8E+jv/RQmRoMjSNKvNOg/p+aIQvXzH
	DbLvzyunRkktGAqxaB/R8/2ehQI02avSUfx3SUbFo+6OqCQpQeWltlbIxu7wJimk/O3Ad2DuzNU
	SNH7aG9O5li4iKPxUA==
X-Received: by 2002:a17:902:f7d1:b0:2b2:67ca:5fff with SMTP id
 d9443c01a7336-2bd7e9adfafmr44030695ad.28.1778876579145; Fri, 15 May 2026
 13:22:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515121329.10807-1-stephen.smalley.work@gmail.com> <CAEjxPJ5zEqUzmF1fzL3Mk-ATXdRkug8uM5ZH8dm9oZ67h2PfgA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5zEqUzmF1fzL3Mk-ATXdRkug8uM5ZH8dm9oZ67h2PfgA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 15 May 2026 16:22:48 -0400
X-Gm-Features: AVHnY4KwSciQ3fTl1x0wPlHIEUmOrrS3O-oZSEaIBl3Xn7xUfZtj8H08GNmhwg4
Message-ID: <CAEjxPJ6A+X8dWhEzAEVURv6n761nN8CL1LD8jSs0LHE66zg6kg@mail.gmail.com>
Subject: Re: [PATCH] python/sepolicy: Maybe fix CI build failures
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 10:01=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, May 15, 2026 at 8:13=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Current GitHub CI builds are failing with:
> > python -m pip install --no-build-isolation --prefix=3D/usr `test -n "/t=
mp/destdir" && echo --root /tmp/destdir --ignore-installed --no-deps`  .
> >   Processing /home/runner/work/selinux/selinux/python/sepolicy
> >     Preparing metadata (pyproject.toml): started
> >     Preparing metadata (pyproject.toml): finished with status 'error'
> >     error: subprocess-exited-with-error
> >
> >     =C3=97 Preparing metadata (pyproject.toml) did not run successfully=
.
> >     =E2=94=82 exit code: 1
> >     =E2=95=B0=E2=94=80> [10 lines of output]
> >         running dist_info
> >         creating /tmp/pip-modern-metadata-dq7pf_bt/sepolicy.egg-info
> >         writing /tmp/pip-modern-metadata-dq7pf_bt/sepolicy.egg-info/PKG=
-INFO
> >         writing dependency_links to /tmp/pip-modern-metadata-dq7pf_bt/s=
epolicy.egg-info/dependency_links.txt
> >         writing top-level names to /tmp/pip-modern-metadata-dq7pf_bt/se=
policy.egg-info/top_level.txt
> >         writing manifest file '/tmp/pip-modern-metadata-dq7pf_bt/sepoli=
cy.egg-info/SOURCES.txt'
> >         reading manifest file '/tmp/pip-modern-metadata-dq7pf_bt/sepoli=
cy.egg-info/SOURCES.txt'
> >         writing manifest file '/tmp/pip-modern-metadata-dq7pf_bt/sepoli=
cy.egg-info/SOURCES.txt'
> >         creating '/tmp/pip-modern-metadata-dq7pf_bt/sepolicy.dist-info'
> >         error: invalid command 'bdist_wheel'
> >         [end of output]
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Never mind, this doesn't work.
> Any clues from those more savvy with python building?

I finally fixed the GitHub build errors via
https://lore.kernel.org/selinux/20260515200952.35857-2-stephen.smalley.work=
@gmail.com/T/#t
plus https://lore.kernel.org/selinux/20260515120907.10699-1-stephen.smalley=
.work@gmail.com/T/#u

With those 3 patches applied, the GitHub builds all pass at least,
don't know about the others.
I originally tried migrating everything I could over to pyproject.toml
but that broke (left
name undefined) so I restored the setup.py files to their original
state. Not sure whether the pyproject.toml
files are correct or necessary for anything; can drop if desired but
figured eventually we'll want to migrate?
