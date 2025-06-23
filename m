Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94841C84D2
	for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750699190; cv=none; b=GEEOJ/3SpV0jnGEOnQ7CCUKe2CwVranz0jdxETfdUziLiLHldCNkc0LeW82lMDTgt/XSyUAs+CxkQJ0FDDFtAaD2eHZO3IfYpKqldTGwlX+y0LDH0XuhBbyt9GEALa1tL/SkdCsrRJrgLEe250ISmKsb8sETl2mv4OtEbm+cVy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750699190; c=relaxed/simple;
	bh=4UgWIU49keumbZUBEKJuVderrwcZNGBmaY5yGQH52s4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pt1+TSsyZIiQu2l0CJDmurSE7L3fHtk3mf8bxKU4D1SwesQyzSkRRb/hzZD2Zb/vqhRT4N37w/4hRjQE+ewOKr32E0P3kS2sJTo8zyNadncWDtqKkvQIeAhh7/j+inYvWAG3FhI8UeMPY6Mr1PjDXJ+BIJXcVchZ3qNuRj8BRak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmSC4rAQ; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmSC4rAQ"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4c9cea30173so1139522137.3
        for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 10:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750699188; x=1751303988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yG78cuIPa0MVrczl1iQsJ62GIyLqxF7QbZeG+UIyF5Q=;
        b=WmSC4rAQkTa6NXdEahYT96KDqTj82IzYJDn0MCAc3PV8WLBXOW/K64TMKOV0a72w0V
         YqbqTUYVKB7tyrsdefHjSTjuwPsUWKsTp0rNcGCjmgba4swFiDSkcbawnNbPlMJjs6Ff
         Fk9E8xQ+teUqbxGwjicpORXqE8MPNes3TC6eW1tTU50/ND09jjiZKcUlcl9bWHN6sL3Q
         p4Rp+b9h6OK09kskJZ7L3bubSvricEu1ppANLbiV41zojqKle4veYiImOULmgSUR77ex
         tZ/+QDQ9yTo8noKAhHvnCKGyUTdSP22wrjitlJtS/Ja/IqIr38IbCkS1tiwBA3hymEcE
         od6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750699188; x=1751303988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yG78cuIPa0MVrczl1iQsJ62GIyLqxF7QbZeG+UIyF5Q=;
        b=CZoXaAxo9btly2h9tfA7EeAGLM9qV01b1mwfnQyXphUFjgGCGoGm/ieVM4SiwwniFl
         tMmXUkNhadelN7sk/0qw6KECvg9a62nHFkKisg9mzwBMeoJol2jYrt+7+G41xsnZqlzb
         MA55+C5/fLiu1X+TqvphxED7fLbJK8AEzoRtlrN+NW/zOlEAIHiieuRdpGIYiJRkql66
         VZoccAAmZJuFaCOqWLCBn4vEIAeu1zEHY0WqwUOdicPwq+9k2Pn+J2hJEhjMOmK8QOAg
         XCpuZ5O0ibLdqyNZVDs5/gjc4m0hC15QDdrpovJxRcnjJfcQxLs/npayEXHzyitTcNQK
         uKQg==
X-Gm-Message-State: AOJu0YznMcKuSsi25Yg9fjrpmgvjWipChYEvUyI6S2iH/paxadU9kNP9
	cGDenl7NR8qhWfjqNYkzIbqdmwWUsml8DtlcSSjYajfN0Ve1XEXr4MwWzjplbSpiH6KCz+tY2Lj
	Rsp2cEC8IEATAtCdmBI39RbNodEHwSvYk98bx
X-Gm-Gg: ASbGncuCLa6je23TsRuTOZN25UrS3UrjoFQ3JVvYt7KNemc4Vxdy3vcAloddaD5Shwb
	YyW7/RpD1llyz9bhJwpAjlz0dKtmBuaXbGauiFXiCCHZ7XgGrViEse5xUpPA7dtGkSiKRu4eiPb
	X32ykkuirkTvFq7LzR13js+2Wuw3Afn0wc5WaPk9ptBwoXkjnStSA=
X-Google-Smtp-Source: AGHT+IFanBoMbz8lchiOFi8zYeBr4jdNdJB/naO3U7GFWoYGnKA+cUAd0clLZ3Qoyuc3BdJFXsL/ZLNk9SH61hCUWAc=
X-Received: by 2002:a05:6102:38d4:b0:4bb:eb4a:f9ec with SMTP id
 ada2fe7eead31-4e9c29b97a0mr7273983137.16.1750699187693; Mon, 23 Jun 2025
 10:19:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616134433.23953-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20250616134433.23953-2-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 23 Jun 2025 13:19:36 -0400
X-Gm-Features: Ac12FXwiFQcCUIBU-L-jJz94OogR5ICWNic-32YNkqDH7ewkHqlKRql8XOR-i28
Message-ID: <CAP+JOzR-zYnQr8qq52iZ-_Tp5dnxeJWcB9gtF0itdgni=mNScg@mail.gmail.com>
Subject: Re: [PATCH v2] userspace: replace all links to selinuxproject.org
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, lautrbach@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 9:45=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Replace all links to selinuxproject.org with links to the
> SELinux userspace wiki or the SELinux notebook as appropriate.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v2 uses https rather than http.
>
>  CONTRIBUTING.md                    | 4 ++--
>  libselinux/src/libselinux.pc.in    | 2 +-
>  libsemanage/src/libsemanage.pc.in  | 2 +-
>  libsepol/src/libsepol.pc.in        | 2 +-
>  scripts/make-update                | 2 +-
>  secilc/docs/cil_user_statements.md | 2 +-
>  6 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
> index e6a677a0..575410bf 100644
> --- a/CONTRIBUTING.md
> +++ b/CONTRIBUTING.md
> @@ -8,8 +8,8 @@ You can find a list of open issues where you might contri=
bute to the SELinux ker
>  https://github.com/SELinuxProject/selinux-kernel/issues or to the SELinu=
x userspace code at
>  https://github.com/SELinuxProject/selinux/issues.
>
> -See the selinuxproject.org [user resources
> -page](http://selinuxproject.org/page/User_Resources) for more
> +See the SELinux userspace
> +[wiki page](https://github.com/selinuxproject/selinux/wiki) for more
>  information on mailing lists, documentation, and other resources.
>
>  ## Reporting Bugs
> diff --git a/libselinux/src/libselinux.pc.in b/libselinux/src/libselinux.=
pc.in
> index 7c66b1fa..cca4753b 100644
> --- a/libselinux/src/libselinux.pc.in
> +++ b/libselinux/src/libselinux.pc.in
> @@ -6,7 +6,7 @@ includedir=3D@includedir@
>  Name: libselinux
>  Description: SELinux utility library
>  Version: @VERSION@
> -URL: http://userspace.selinuxproject.org/
> +URL: https://github.com/selinuxproject/selinux/wiki/Releases
>  Requires.private: libsepol @PCRE_MODULE@
>  Libs: -L${libdir} -lselinux
>  Cflags: -I${includedir}
> diff --git a/libsemanage/src/libsemanage.pc.in b/libsemanage/src/libseman=
age.pc.in
> index 43681ddb..303f8069 100644
> --- a/libsemanage/src/libsemanage.pc.in
> +++ b/libsemanage/src/libsemanage.pc.in
> @@ -6,7 +6,7 @@ includedir=3D@includedir@
>  Name: libsemanage
>  Description: SELinux management library
>  Version: @VERSION@
> -URL: http://userspace.selinuxproject.org/
> +URL: https://github.com/selinuxproject/selinux/wiki/Releases
>  Requires.private: libselinux libsepol
>  Libs: -L${libdir} -lsemanage
>  Libs.private: -lbz2
> diff --git a/libsepol/src/libsepol.pc.in b/libsepol/src/libsepol.pc.in
> index f807fec6..b5361404 100644
> --- a/libsepol/src/libsepol.pc.in
> +++ b/libsepol/src/libsepol.pc.in
> @@ -6,6 +6,6 @@ includedir=3D@includedir@
>  Name: libsepol
>  Description: SELinux policy library
>  Version: @VERSION@
> -URL: http://userspace.selinuxproject.org/
> +URL: https://github.com/selinuxproject/selinux/wiki/Releases
>  Libs: -L${libdir} -lsepol
>  Cflags: -I${includedir}
> diff --git a/scripts/make-update b/scripts/make-update
> index 4c940e1b..d83e1772 100755
> --- a/scripts/make-update
> +++ b/scripts/make-update
> @@ -30,7 +30,7 @@ echo "Copy $ARCHIVE from $DEST to the server and update=
 its download link and ch
>
>  echo ""
>
> -echo "[http://userspace.selinuxproject.org/releases/$TAG/$ARCHIVE $ARCHI=
VE]"
> +echo "[https://github.com/selinuxproject/selinux/releases/download/$TAG/=
$ARCHIVE $ARCHIVE]"
>  echo ""
>  echo "`sha256sum $ARCHIVE`"
>  echo ""
> diff --git a/secilc/docs/cil_user_statements.md b/secilc/docs/cil_user_st=
atements.md
> index d5674f12..dad88ef6 100644
> --- a/secilc/docs/cil_user_statements.md
> +++ b/secilc/docs/cil_user_statements.md
> @@ -358,7 +358,7 @@ The user `test` cannot have greater privileges than `=
unconfined.user`:
>  userprefix
>  ----------
>
> -Declare a user prefix that will be replaced by the file labeling utiliti=
es described at [http://selinuxproject.org/page/PolicyStoreConfigurationFil=
es](http://selinuxproject.org/page/PolicyStoreConfigurationFiles#file_conte=
xts.template_File) that details the `file_contexts` entries.
> +Declare a user prefix that will be replaced by the file labeling utiliti=
es described at [https://github.com/SELinuxProject/selinux-notebook/blob/ma=
in/src/policy_store_config_files.md](https://github.com/SELinuxProject/seli=
nux-notebook/blob/main/src/policy_store_config_files.md#building-the-file-l=
abeling-support-files) that details the `file_contexts` entries.
>
>  **Statement definition:**
>
> --
> 2.49.0
>
