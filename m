Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C10366067
	for <selinux@vger.kernel.org>; Tue, 12 May 2026 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778597632; cv=pass; b=tHiz/TZiVRpyDD+QoGRMRvl3qXDC8MIMLtd2gUww6OjcdkmgN/eiPpIxpo9eFlInFCeawXGexhnZ6DN+BjvGmuwyCR/ajCc74RFZj05uHEiJzMQRqJZl3ssxCa31IkYU8LoK6BqHZQfTC8qLGs+WhQSYmIqBxyYpzm/BKeJZg+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778597632; c=relaxed/simple;
	bh=23ns6DSefgZhewWpAaBvJL3XYhQuq0nw6HiXecR8+zA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RKhy8fv/L7DNqFIx7PlRCUfH9kUKvEwIhDRx2UqV0SYfZ0ciO57mlEW1cTYeGvA/NvnnzA/NwNdO3Ik6nSi7HM8p5Fziu3OGtCIv9Vb8sVArdN6XGQwmZvMHtvXauVi3adkCv7OpInkXsknzDv9R7b37LFsXWoSWBSMM2JYzGBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnTmKNmo; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnTmKNmo"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8379e010b01so2392091b3a.1
        for <selinux@vger.kernel.org>; Tue, 12 May 2026 07:53:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778597630; cv=none;
        d=google.com; s=arc-20240605;
        b=Dyfr3ICIfJf5IkIasfdGLk2xYSzALKBLDjce/SsGzc2fsfL2WuQFM8KMeAS8wkJlWh
         kYxmSXVdTJEZ51ejCZ7k3k0VhCvGve5xNrc7Qs1dk8KkGEyrRcaaKbu4Vf+/ePyBLdue
         llXPk4VK232X/kXDRT5WzMRoX/dhUZiR5x8A8D1dvReaBDCHLtRLdB2dh4X4hBiYTxVc
         bwYgl1aZquCmBmOQEXS6UwPGwNlgqLCLLLhaLDSDqHCtUmWAj7KXbysYrrJia359yloh
         LfTYM4QVcW0RSl6D9gSpeiByVOgy9TbvTMAHKYPw/UwvEoD1B1SQ6opXypmG+7vmz/2C
         fAwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7zFWPoNDoNE3aZgEOdX8brsR9bQ6a+4+Ps/EUgODSGY=;
        fh=VWwbX+H1Sc8ilbX5LEN836EN17/lKaPP6kwZv2JuZcs=;
        b=kaKDCAk79gj32y7GnslcPlThrhBK4B0BbQlBHy4CoB0s8CXrtkPS9K4tuG8gBUKMtr
         7pz04bUmhEpdeV0bdkbx8QxffgQ9Pr1AHXt2btUeHDfuV4cQBvxcWrVTCcoNObjCHcnj
         NLeqIUSgRISo0GcXBMHDcwDGp5+rqFffLA3qUKvkXQYKTSUPqixGoesCHtAyDWeKuevw
         1J9lPhFz/0zclOfdc1cu8Ay6uOAkMx2+/VyVwQDoWVdNJSh/KYhVTDSwpn8LCy9Ja2wj
         te/YV1HBYsOPewwJbBSnDGuE8DrR4L2BHFLt2AvXEdCKX5/riBDPJ/RZXcauMhxXy99K
         MItw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778597630; x=1779202430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zFWPoNDoNE3aZgEOdX8brsR9bQ6a+4+Ps/EUgODSGY=;
        b=AnTmKNmoxV1as++iWmIDDRMCOD0a3OzOoDUX08tE6/xDjD4vb1BBfu9Hu6sv1lvm4P
         vWa10jBHpXYdCSNpU083pgO+5+PT+RF9SzeygpXxPV9LgRgTEbbKA/+1Ug+U6WalJNIX
         X/rFVdskCqFHKtBCeEV1lE5dPsdBt+T4Y9PvJIQIS8Cg82v7l8yz4CyYxK1lqucTjzYa
         GtKOH6HkrIylpvSsx7olqyJSjzMnv9aNb+bnPzR/8R12xgUevFPWGLZao5GprU2GqgWR
         ZbI/I7+RGrJS4Aa+FTgjx7YHftvid5SPeXciz9n+GLUB8RDTJCPLecQmgeA8hDXi/r0P
         y4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778597630; x=1779202430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7zFWPoNDoNE3aZgEOdX8brsR9bQ6a+4+Ps/EUgODSGY=;
        b=pfsf82BOrNBG4Wy5p52YBWulTM1lJ9nbCYWoNdV+fBlAgKoErQtK/JIIvXtxcN6GxL
         nJpoSCUVDZZLQThYUlSAXW5GBCA58Z+vi+iORafcNreSz4xjVwPxeRGbq5AI31KmFwlV
         ggGoEGDFq9z0sWViyKJqLlXvK/PYdNyntZrER6C/YhZ5puEObEONLJtlj0k5A2IJIvv1
         13CSl65+nDkYJ98rVvx9mvspKOPG3NCHxfDUvolbU2+XsCX71+DgU5vSZXrPaYvCaQX5
         6xi3Jceet6MDY22nLOAUspeSr9bxKdvIB6j5HdsSyQdKI3yIqe7nr6LZPcjAHfgrW31E
         IVgw==
X-Gm-Message-State: AOJu0Yyrixj0BUSel4IYtR9LzaIO1fC1WkPLGGU177a4Go4P+ZYS1t8r
	iqrVs9p/4r6JZq6BBkLi4i4bytm9DSzeQe8d553sBo5DxYTERLnqqgTD3EWDVni/uuEWBoZHTPY
	Tokk3GvYe6sJ7/9QHyuIgUuz4W/bBjMw=
X-Gm-Gg: Acq92OFygI6y+rHPPeyP31/9poMNYy+Qp9AhIp0ztHKZpB+VyvJL+61A9LdmjFoANmE
	McI1p8ejHc6XHFTJOX21kUrzTb3ps0pRpuZj1eMbYhpoY2GMcTfBsB4JI81x/6KLBrqvXJliReF
	SWKVy6LGNcqB+4K2kDAlta+csNAuit1rQWY01AQMX7mJf5Npq2p7I0ezQ6qsowBpDKhtXnZ+6aX
	6M3Thf1GzWAebmJ2o6xrdCzPVnXx5btOHNYBm1QPUIrgvALi6VVUvTh/7MPywm+IugbS5enM9EP
	K1dQnP/d/R2y3H5IyQ==
X-Received: by 2002:a05:6a00:124d:b0:837:80a:5abe with SMTP id
 d2e1a72fcca58-83a5dc5decdmr28547972b3a.37.1778597630448; Tue, 12 May 2026
 07:53:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407054003.801744-1-lautrbach@redhat.com>
In-Reply-To: <20260407054003.801744-1-lautrbach@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 12 May 2026 10:53:38 -0400
X-Gm-Features: AVHnY4JxE2ss2d570H2dh2DdstZv3vRvlIc8iLEy27p4GkI7oUbHl1h4X5Eq2SY
Message-ID: <CAEjxPJ6NcY9NsxV+NihjNaE3zSztQKgD8=O3LyXi-4_0+xFi+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] restorecond: Add -F for run in foreground
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 1:40=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.com=
> wrote:
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  restorecond/restorecond.8 |  5 ++++-
>  restorecond/restorecond.c | 13 ++++++++-----
>  2 files changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/restorecond/restorecond.8 b/restorecond/restorecond.8
> index bf8ec87562f8..bb99b24a2d69 100644
> --- a/restorecond/restorecond.8
> +++ b/restorecond/restorecond.8
> @@ -3,7 +3,7 @@
>  restorecond \- daemon that watches for file creation and then sets the d=
efault SELinux file context
>
>  .SH "SYNOPSIS"
> -.B restorecond  [\-d] [-h] [\-f restorecond_file ] [\-u] [\-v]
> +.B restorecond  [\-d] [-h] [\-f restorecond_file ] [\-F] [\-u] [\-v]
>  .P
>
>  .SH "DESCRIPTION"
> @@ -26,6 +26,9 @@ Print usage statement.
>  .B \-f restorecond_file
>  Use alternative restorecond.conf file.
>  .TP
> +.B \-F
> +Run in foreground, do not become a daemon.
> +.TP
>  .B \-u
>  Turns on user mode.  Runs restorecond in the user session and reads /etc=
/selinux/restorecond_user.conf.  Uses dbus to make sure only one restorecon=
d is running per user session.
>  .TP
> diff --git a/restorecond/restorecond.c b/restorecond/restorecond.c
> index d5f70fc2e2c1..36f82ae5e9cb 100644
> --- a/restorecond/restorecond.c
> +++ b/restorecond/restorecond.c
> @@ -76,6 +76,7 @@ int debug_mode =3D 0;
>  int terminate =3D 0;
>  int master_wd =3D -1;
>  int run_as_user =3D 0;
> +int foreground_mode =3D 0;
>
>  static void done(void) {
>         watch_list_free(master_fd);
> @@ -124,7 +125,7 @@ static void term_handler(int s __attribute__ ((unused=
)))
>
>  static void usage(char *program)
>  {
> -       printf("%s [-d] [-f restorecond_file ] [-u] [-v] \n", program);
> +       printf("%s [-d] [-f restorecond_file ] [-F] [-n] [-u] [-v] \n", p=
rogram);
>  }
>
>  void exitApp(const char *msg)
> @@ -165,7 +166,7 @@ int main(int argc, char **argv)
>         sigaction(SIGTERM, &sa, NULL);
>
>         atexit( done );
> -       while ((opt =3D getopt(argc, argv, "hdf:uv")) > 0) {
> +       while ((opt =3D getopt(argc, argv, "hdf:Fuv")) > 0) {
>                 switch (opt) {
>                 case 'd':
>                         debug_mode =3D 1;
> @@ -173,6 +174,9 @@ int main(int argc, char **argv)
>                 case 'f':
>                         watch_file =3D optarg;
>                         break;
> +               case 'F':
> +                       foreground_mode =3D 1;
> +                       break;
>                 case 'u':
>                         run_as_user =3D 1;
>                         break;
> @@ -209,13 +213,12 @@ int main(int argc, char **argv)
>
>         read_config(master_fd, watch_file);
>
> -       if (!debug_mode) {
> +       if (!debug_mode && !foreground_mode) {
>                 if (daemon(0, 0) < 0)
>                         exitApp("daemon");
> +               write_pid_file();
>         }
>
> -       write_pid_file();
> -
>         while (watch(master_fd, watch_file) =3D=3D 0) {
>         }
>
> --
> 2.53.0
>
>
