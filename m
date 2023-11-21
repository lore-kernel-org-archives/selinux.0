Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22467C54FB9
	for <selinux@archiver.kernel.org>; Tue, 21 Nov 2023 09:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbjKUJ50 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Nov 2023 04:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbjKUJ5Y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Nov 2023 04:57:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE3310E
        for <selinux@vger.kernel.org>; Tue, 21 Nov 2023 01:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700560635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2N+3y+C/URMSo56iJMRB1pc/gXcFjwKifuYkxPTo4bY=;
        b=IL7swelW1Pm9NEh0+gYvIMT9OCxBKVPK2A9cF7rUulFFOPkfV8ksSJbXbdZn/YQoCbE+uD
        hyPt0zkzU3pxgvFmlBFcRo5kftX8Mhe3LBopNW/60RmZFm+vPD/5vUTaoo8nFVfpAJEaWz
        NkMzdZnpyuk4SnB0d4Jbu+eBx3BoLfg=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-yJStSHGHNjOzD8R7kXj4tQ-1; Tue, 21 Nov 2023 04:57:13 -0500
X-MC-Unique: yJStSHGHNjOzD8R7kXj4tQ-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5bdd8eee498so6510906a12.0
        for <selinux@vger.kernel.org>; Tue, 21 Nov 2023 01:57:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700560633; x=1701165433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2N+3y+C/URMSo56iJMRB1pc/gXcFjwKifuYkxPTo4bY=;
        b=B34bYVeIrWS8yxl7Vox2kIC78hzKsYm30b5Fz5Hoi8O7AhSMFhratLzWgIojpB9IDi
         bnICpHEemtaTUQD7Q1J82iSyTy88Vz0nB8yoi8RfBB5swnliu91NVTnOgeoLyQf0YKHf
         0STGUTDkmMY99j/3FcdYBYt9R9sOn1uMCLtctEtCw+f0dJy6tMNEPAVtEl2a5Pd2cDM1
         KzFDos57ksdiRhKr7alpn9+jvURacIovNiQ7HinkawkdL3s7wPbQJROPhj9e2adVGvV+
         rzMpx59Jb3jQtu8ThP31KA8bV03MoKelc9WQJm/UA6SI+xjniDxWPJ89bnV1k65rcPUn
         syZw==
X-Gm-Message-State: AOJu0Yzn7Cee0mg1oF51Y1P9QLA6uQqNiRXPkNc8IBm22f/0ZJPunX2S
        R584xWpEgZS/A/MKojKUUDSm1e0E0DFs1MHB4dPQErFrpVtTDeJoMMhvA+ciFl9tJssiBuSR0b/
        vEBztRmxvwym6+rsGdQ/JsogknifCfHQNtg==
X-Received: by 2002:a05:6a20:2caa:b0:188:2622:1599 with SMTP id g42-20020a056a202caa00b0018826221599mr4709709pzj.6.1700560632870;
        Tue, 21 Nov 2023 01:57:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXGzkn7eZP9n7+6chdCXUTPK2D58Z3FBBTiqamsshbKNk7gS6tAN98RGG1bMeVPFSWN3liCf077ifA/tJgB2Q=
X-Received: by 2002:a05:6a20:2caa:b0:188:2622:1599 with SMTP id
 g42-20020a056a202caa00b0018826221599mr4709706pzj.6.1700560632574; Tue, 21 Nov
 2023 01:57:12 -0800 (PST)
MIME-Version: 1.0
References: <20231120160548.2341315-1-lautrbach@redhat.com>
In-Reply-To: <20231120160548.2341315-1-lautrbach@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 21 Nov 2023 10:57:01 +0100
Message-ID: <CAFqZXNt1vLh5YEM98UKqOQSxNP0=b7kBVA14921qk8n=J9HtYg@mail.gmail.com>
Subject: Re: [PATCH] sepolicy: port to dnf4 python API
To:     Petr Lautrbach <lautrbach@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 20, 2023 at 5:06=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> yum module is not available since RHEL 7.
>
> Drop -systemd related code as it's obsoleted these days - only 2
> packages ship their .service in -systemd subpackage
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
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

Aren't you forgetting to call base.close() at the end? Tip: in Python
3 you can use this syntax:

with dnf.Base() as base:
    # do some work with 'base'...
# when control flow exits the 'with' block, base.__exit__() is called
# automatically, which calls base.close()

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

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

