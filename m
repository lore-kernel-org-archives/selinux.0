Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1212CC197A0
	for <selinux@archiver.kernel.org>; Mon, 20 Nov 2023 21:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjKTVQj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Nov 2023 16:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbjKTU7Y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Nov 2023 15:59:24 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEF1E8
        for <selinux@vger.kernel.org>; Mon, 20 Nov 2023 12:59:20 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507962561adso7074891e87.0
        for <selinux@vger.kernel.org>; Mon, 20 Nov 2023 12:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700513959; x=1701118759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ab5gTclA1QqxzKtENjw/bPZGNkmJpOaQvUqYvEJCJqA=;
        b=KpGb/1VlbOIBPGJNBmkU0psyk0InHeXgfd0GxTijZtAUmoWkg56Aoflt4ZU6q+WxJ+
         bIlgnqUTd2x48HnjUB7Q5GITZhUENpye1XAdId0Z7hBF17xzHFQSlcWUWCKiKmvPKoup
         45lpZMRbZYtjLNAWaaoo3WiBNn4MnVGacfyKfST16mRhwdRry7ApRGpVVZglwLi4GVq7
         Smq86qzhGY0j/SsWag6TSIvZDRDbre4eYaHJeGLUvbV+lArthktFNqvvhxd9txL9pCzo
         7wta6resnnMeCz2EpEaDVZj4vkFTiyYlL47oXIFkaAPKK8yQeE85ZepkscMuNTIkTwI5
         krWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700513959; x=1701118759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ab5gTclA1QqxzKtENjw/bPZGNkmJpOaQvUqYvEJCJqA=;
        b=UYfXxPjZzQesVa3EvYLovIam4a/l/GaRr7KDRywIZ55KTHpsZBihdDLONmQA5X9UyZ
         a0QVxR74mPfDY6Ju+vemiJcQcX5e9AX2AZ1iEMvkibkl+7nMPLQSjp0rLE+25/ctHqwh
         M+d5jStFSrBWdZ0hKc75RnyFyxp2x8AVPDdP4augKEnIniP8p9/o/2Vlmghj34Jfoq7l
         ySP0nifUaXfXdl3IcqeaG2c6GMA+9Anlz2XBDyaW92l9pHrSIxcEm8dGB0dLHtC1gBro
         clL7iH5I1IjEmESwnJ6+V0sQlVkkFrDI9GUYIi5OvcZrozIW/MC+M2wptj9IBMrS94Q4
         PlyQ==
X-Gm-Message-State: AOJu0YxWFYN3zV1A5UZMBtQig68KjTsAXw5X9wxgmhJMmFHJvPgkDWtV
        okijPExDbIePmvvfXPdn9w+9tA0fVq9nXWuUKar9Oov321w=
X-Google-Smtp-Source: AGHT+IEPGEmIZSAL3rSFc7IAZdloYRlrv9zXHq897Rf33X+BGeSenlfzhXuYxRNuQU/xeMLJpPVoJpx7xry+lxtOVHU=
X-Received: by 2002:a19:f60d:0:b0:509:8e20:e7c6 with SMTP id
 x13-20020a19f60d000000b005098e20e7c6mr5593171lfe.32.1700513958719; Mon, 20
 Nov 2023 12:59:18 -0800 (PST)
MIME-Version: 1.0
References: <20231120160548.2341315-1-lautrbach@redhat.com>
In-Reply-To: <20231120160548.2341315-1-lautrbach@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 20 Nov 2023 15:59:07 -0500
Message-ID: <CAP+JOzRrOaNPU_F2AoU40Gw+SAaqErbu2_sykZs6W+pPhhmM3g@mail.gmail.com>
Subject: Re: [PATCH] sepolicy: port to dnf4 python API
To:     Petr Lautrbach <lautrbach@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 20, 2023 at 11:06=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.c=
om> wrote:
>
> yum module is not available since RHEL 7.
>
> Drop -systemd related code as it's obsoleted these days - only 2
> packages ship their .service in -systemd subpackage
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  python/sepolicy/sepolicy/generate.py | 38 ++++++++++++----------------
>  1 file changed, 16 insertions(+), 22 deletions(-)
>
> diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepol=
icy/generate.py
> index b6df3e91160b..5aa71357f6a9 100644
> --- a/python/sepolicy/sepolicy/generate.py
> +++ b/python/sepolicy/sepolicy/generate.py
> @@ -1262,13 +1262,20 @@ allow %s_t %s_t:%s_socket name_%s;
>          return fcfile
>
>      def __extract_rpms(self):
> -        import yum
> -        yb =3D yum.YumBase()
> -        yb.setCacheDir()
> +        import dnf
>
> -        for pkg in yb.rpmdb.searchProvides(self.program):
> +        base =3D dnf.Base()
> +        base.read_all_repos()
> +        base.fill_sack(load_system_repo=3DTrue)
> +
> +        query =3D base.sack.query()
> +
> +        pq =3D query.available()
> +        pq =3D pq.filter(file=3Dself.program)
> +
> +        for pkg in pq:
>              self.rpms.append(pkg.name)
> -            for fname in pkg.dirlist + pkg.filelist + pkg.ghostlist:
> +            for fname in pkg.files:
>                  for b in self.DEFAULT_DIRS:
>                      if b =3D=3D "/etc":
>                          continue
> @@ -1277,9 +1284,10 @@ allow %s_t %s_t:%s_socket name_%s;
>                              self.add_file(fname)
>                          else:
>                              self.add_dir(fname)
> -
> -            for bpkg in yb.rpmdb.searchNames([pkg.base_package_name]):
> -                for fname in bpkg.dirlist + bpkg.filelist + bpkg.ghostli=
st:
> +            sq =3D query.available()
> +            sq =3D sq.filter(provides=3Dpkg.source_name)
> +            for bpkg in sq:
> +                for fname in bpkg.files:
>                      for b in self.DEFAULT_DIRS:
>                          if b =3D=3D "/etc":
>                              continue
> @@ -1289,20 +1297,6 @@ allow %s_t %s_t:%s_socket name_%s;
>                              else:
>                                  self.add_dir(fname)
>
> -        # some packages have own systemd subpackage
> -        # tor-systemd for example
> -        binary_name =3D self.program.split("/")[-1]
> -        for bpkg in yb.rpmdb.searchNames(["%s-systemd" % binary_name]):
> -            for fname in bpkg.filelist + bpkg.ghostlist + bpkg.dirlist:
> -                for b in self.DEFAULT_DIRS:
> -                    if b =3D=3D "/etc":
> -                        continue
> -                    if fname.startswith(b):
> -                        if os.path.isfile(fname):
> -                            self.add_file(fname)
> -                        else:
> -                            self.add_dir(fname)
> -
>      def gen_writeable(self):
>          try:
>              self.__extract_rpms()
> --
> 2.41.0
>
