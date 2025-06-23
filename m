Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C8327A12D
	for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 18:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750704543; cv=none; b=jC/5fNE+/IpY3slTWDv0JQv8TUv5e+Lp0JgieMkh0IDgcBRsBaI8F7FaHZerjfJpkgdTVa5Wgajm/8F5z3XJJGu+CSb98hlKVGl00+dVg21ARKxCvEiynmlSx0GX4ph1MZMVzboWbz7UMoR8TEMrJbc1ApXiqsCIPXXU91t0FA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750704543; c=relaxed/simple;
	bh=1CGi/fx7bUPMVcUvvc1TS4p9BviD2QoU4Gtd1z+K/2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSoAx7g+AF8nczpn1fbOWtaW1Z4Mtaz0ZJ6OJOCr2OmH2muh/0NDkUtW3gFx77vc7cXgNjSV62rVC1jL/PKX5gsDAhp/BRd9CUx43giAlgmVnqOpj7rh3xicr/uvWqhtwXcykRVzRMSNZq6L1R/Mc5RNY/7IAadAfCneeHPJWcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3Z8rCoS; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3Z8rCoS"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-53185535ed9so3069499e0c.0
        for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 11:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750704540; x=1751309340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zm41XKaEWkw2iE2DsuGq+KpzOC6ZyJ00ut4yDKXW1oo=;
        b=J3Z8rCoSGsB86C1HHjGl8JG6t73q/EL4T5qdDWlnrosJ/lJaKqbH1KLyhwNq1XUWDD
         aapjVK9/5GoMxLgkBhqary4KmpZxqjzxvB740dKZAfmGlj0sBK/7l2i/hjD4E1No+ooR
         qZYztANFhm47it0OmuZp9HdiRUmGrcEBEy2h/zkHw/YNu9Dm7nuILfdMVeVsPjAuhRvl
         Vos2UOg6OAYYu3Wx3HyqQt+BgwDXlFtE3remk1aDRAQjEW3CIv7yWX3+tAmGoGQWT71E
         HYEX5mZF4z5PFILbMe0kq66F9TVYquLsZuh+fJVxTgozutaLjjggtrt2/1d9P+LbSq3j
         jaAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750704540; x=1751309340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zm41XKaEWkw2iE2DsuGq+KpzOC6ZyJ00ut4yDKXW1oo=;
        b=uHc9Uy7djI6DFWPqvffsMf9/onOEBjbKouwnoz4wN+X3PNNcOsIQlc/yJXb6P/9fnk
         1+Wh2ycdK7SDEcHAp+zNdYmqdUjLzx3uPdniVzTHsXp+BwV0+6TTdYFsgItFjdrmzYz6
         9pLTZQcN+xIbEPq8cnVnsZXWYMGz1ry95rsT/VpKcwiaoJdJs3UT8VrjwlN3Efgu73n0
         ++QRO3/CvJ5B6MrEmr2C3QrRBLBBAAERH3KCIozhqvqTth/hytd2J+PKIltokPLhvnfV
         0qdXpNITG/x0bhoJCdU2jku3cT7WrDE7sK3YeWU4D+uF4ofx71t8z6sUcyP+P4XXOG8y
         Zbww==
X-Gm-Message-State: AOJu0YwZqf75xpDZz8aw6PWSnbBuC+sC3s8PHKkFkHqEqVQ5JlYCm/uW
	wXYZT9neeo7OiQGixUF+qyEPS6vBUTkutQ/vrW2O5gGMZmkfcJuXpyurcAAL+O68uvJmNI1ZOjL
	ePKYsBB+vyEqOevvVTRo+1K6uFRzzhZw=
X-Gm-Gg: ASbGncv9Sn1/uMWusDnZqUhgsFaqj7flOZ35HDkX7C79gRIxuwZy9dn3iVSTo+f6jXP
	Fxozb1HRk4lZ1nHaltyJ6cs81vCNJ1NnK6t1rYK1wGx52UyIlQpPRArdFRjvPbs+KEkZZK6HvjH
	1Nrh3q+Nm1UyleiCWlMxeb1LB//oim5/UfgNRZKXVorzRJ3ZlHt2c=
X-Google-Smtp-Source: AGHT+IFGh1a9rleFM6k+owz5bqwRsZxVvd0U81c1GSGHlG4g/I35f7bQPhswOgod1pqILVCkkB7EDEwQlokEhHkDiAo=
X-Received: by 2002:a05:6122:811c:10b0:531:188b:c1a0 with SMTP id
 71dfb90a1353d-532e00ed717mr309440e0c.4.1750704540506; Mon, 23 Jun 2025
 11:49:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616134433.23953-2-stephen.smalley.work@gmail.com> <CAP+JOzR-zYnQr8qq52iZ-_Tp5dnxeJWcB9gtF0itdgni=mNScg@mail.gmail.com>
In-Reply-To: <CAP+JOzR-zYnQr8qq52iZ-_Tp5dnxeJWcB9gtF0itdgni=mNScg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 23 Jun 2025 14:48:49 -0400
X-Gm-Features: Ac12FXxscbreAeDkzh2xmnhwOBSLN0o1lkmK0oL33wtY3nXyAL7JAcBqpYgTF_w
Message-ID: <CAP+JOzQSbbmb4wVhY3DO9YzTnSKRJEPJX15tRZ+KXaoQUuZkTQ@mail.gmail.com>
Subject: Re: [PATCH v2] userspace: replace all links to selinuxproject.org
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, lautrbach@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 1:19=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Jun 16, 2025 at 9:45=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Replace all links to selinuxproject.org with links to the
> > SELinux userspace wiki or the SELinux notebook as appropriate.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> > v2 uses https rather than http.
> >
> >  CONTRIBUTING.md                    | 4 ++--
> >  libselinux/src/libselinux.pc.in    | 2 +-
> >  libsemanage/src/libsemanage.pc.in  | 2 +-
> >  libsepol/src/libsepol.pc.in        | 2 +-
> >  scripts/make-update                | 2 +-
> >  secilc/docs/cil_user_statements.md | 2 +-
> >  6 files changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
> > index e6a677a0..575410bf 100644
> > --- a/CONTRIBUTING.md
> > +++ b/CONTRIBUTING.md
> > @@ -8,8 +8,8 @@ You can find a list of open issues where you might cont=
ribute to the SELinux ker
> >  https://github.com/SELinuxProject/selinux-kernel/issues or to the SELi=
nux userspace code at
> >  https://github.com/SELinuxProject/selinux/issues.
> >
> > -See the selinuxproject.org [user resources
> > -page](http://selinuxproject.org/page/User_Resources) for more
> > +See the SELinux userspace
> > +[wiki page](https://github.com/selinuxproject/selinux/wiki) for more
> >  information on mailing lists, documentation, and other resources.
> >
> >  ## Reporting Bugs
> > diff --git a/libselinux/src/libselinux.pc.in b/libselinux/src/libselinu=
x.pc.in
> > index 7c66b1fa..cca4753b 100644
> > --- a/libselinux/src/libselinux.pc.in
> > +++ b/libselinux/src/libselinux.pc.in
> > @@ -6,7 +6,7 @@ includedir=3D@includedir@
> >  Name: libselinux
> >  Description: SELinux utility library
> >  Version: @VERSION@
> > -URL: http://userspace.selinuxproject.org/
> > +URL: https://github.com/selinuxproject/selinux/wiki/Releases
> >  Requires.private: libsepol @PCRE_MODULE@
> >  Libs: -L${libdir} -lselinux
> >  Cflags: -I${includedir}
> > diff --git a/libsemanage/src/libsemanage.pc.in b/libsemanage/src/libsem=
anage.pc.in
> > index 43681ddb..303f8069 100644
> > --- a/libsemanage/src/libsemanage.pc.in
> > +++ b/libsemanage/src/libsemanage.pc.in
> > @@ -6,7 +6,7 @@ includedir=3D@includedir@
> >  Name: libsemanage
> >  Description: SELinux management library
> >  Version: @VERSION@
> > -URL: http://userspace.selinuxproject.org/
> > +URL: https://github.com/selinuxproject/selinux/wiki/Releases
> >  Requires.private: libselinux libsepol
> >  Libs: -L${libdir} -lsemanage
> >  Libs.private: -lbz2
> > diff --git a/libsepol/src/libsepol.pc.in b/libsepol/src/libsepol.pc.in
> > index f807fec6..b5361404 100644
> > --- a/libsepol/src/libsepol.pc.in
> > +++ b/libsepol/src/libsepol.pc.in
> > @@ -6,6 +6,6 @@ includedir=3D@includedir@
> >  Name: libsepol
> >  Description: SELinux policy library
> >  Version: @VERSION@
> > -URL: http://userspace.selinuxproject.org/
> > +URL: https://github.com/selinuxproject/selinux/wiki/Releases
> >  Libs: -L${libdir} -lsepol
> >  Cflags: -I${includedir}
> > diff --git a/scripts/make-update b/scripts/make-update
> > index 4c940e1b..d83e1772 100755
> > --- a/scripts/make-update
> > +++ b/scripts/make-update
> > @@ -30,7 +30,7 @@ echo "Copy $ARCHIVE from $DEST to the server and upda=
te its download link and ch
> >
> >  echo ""
> >
> > -echo "[http://userspace.selinuxproject.org/releases/$TAG/$ARCHIVE $ARC=
HIVE]"
> > +echo "[https://github.com/selinuxproject/selinux/releases/download/$TA=
G/$ARCHIVE $ARCHIVE]"
> >  echo ""
> >  echo "`sha256sum $ARCHIVE`"
> >  echo ""
> > diff --git a/secilc/docs/cil_user_statements.md b/secilc/docs/cil_user_=
statements.md
> > index d5674f12..dad88ef6 100644
> > --- a/secilc/docs/cil_user_statements.md
> > +++ b/secilc/docs/cil_user_statements.md
> > @@ -358,7 +358,7 @@ The user `test` cannot have greater privileges than=
 `unconfined.user`:
> >  userprefix
> >  ----------
> >
> > -Declare a user prefix that will be replaced by the file labeling utili=
ties described at [http://selinuxproject.org/page/PolicyStoreConfigurationF=
iles](http://selinuxproject.org/page/PolicyStoreConfigurationFiles#file_con=
texts.template_File) that details the `file_contexts` entries.
> > +Declare a user prefix that will be replaced by the file labeling utili=
ties described at [https://github.com/SELinuxProject/selinux-notebook/blob/=
main/src/policy_store_config_files.md](https://github.com/SELinuxProject/se=
linux-notebook/blob/main/src/policy_store_config_files.md#building-the-file=
-labeling-support-files) that details the `file_contexts` entries.
> >
> >  **Statement definition:**
> >
> > --
> > 2.49.0
> >
