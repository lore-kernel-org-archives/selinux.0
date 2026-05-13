Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53312C0274
	for <selinux@vger.kernel.org>; Wed, 13 May 2026 13:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680733; cv=pass; b=NEl08MUMof58zQhLgmbTdbHZv8MeGCyaBEi+dSI0L5CE+nSG+wIoiDv4zWF6fWPjsMu3hPfLV+apVU4gpmfSru6fmhfs9eGt1oGjdkCgKZ6s+Wq1p3ZNtwQ2mzFeLp1S3WBK8MdIP2XfQSa7GWLQdqRXESqC60WzJDM8VTygLck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680733; c=relaxed/simple;
	bh=yFxBd7seYracYZCviOuGV+DQ+uTuKzGjGNtX7CPg0bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jCPacVfZsqo/SGr3n0JtVbAlUouMEnEpPzNboNbvJIiUaXDELNWEPgGIDPLrLgcAtFOa7X+aI4SINgZKYHc00nVaEeV0IFiDR43B6EadavNGc+vL+8o7P33i+qcEjV/X2uRfMXpvk1yPzAKNCQGvx23IR+H1BEK6XTo1kP3uhsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDqExI9d; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDqExI9d"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-393da8f389bso69108831fa.1
        for <selinux@vger.kernel.org>; Wed, 13 May 2026 06:58:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778680729; cv=none;
        d=google.com; s=arc-20240605;
        b=NE+gLIKhFkA5n4nGyX96IhL/ixloZdAZUKywz9kP1baPd2gqPVPMcQ6MSNwd/NyKIl
         D1W6ujLab3MXh9T3XxOZcQiJsr2GIgIUq6pykFitBYDqjXa+yBHdgo0koIXMnIyMi2e0
         7CQjQ+tiyr7KFHmKOd049UdEwru7ynKPVk6cICDdieTFDxGINMPbm/vAHYompPjUakcG
         3FzREiiAJfl6QWOldYwngS+SkUlieprkhAfck6j0gzoK0ZpndpDrPMLYCCOo2FEQo0H1
         9SWoF5/oSYZJoyEOnnP5tWF04Px4pks2dzfu9F0/VC65N7CBj6GpXdlOV59T2g3rAOgw
         pUgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PsuXsibOCMxM5qBRPlxS1FnzSOlRT8+VKmgCfVRKLU8=;
        fh=TKbMSK+P3sbMjQBRNMHn82AHHumeyBZwKmxsbQE3PEI=;
        b=BxIM1XkuYEcUzEXnNahn6ePC435kalDVmIT8b+EmXk1189FSwc6YaxiS85ZpKbGIoX
         wqiJjq3ebD3R2tbocLhnCvqnjI/wb3OyMVIPxpZoI16Tqorl75/Gaa+2Enw0YR35dctx
         B/3194nfPFxDVyyq3kZVwLhBpBKxyTIhmZHaSoLyIOvMt2zgBIr0H6F3ujtln4/Xlb4q
         UX7YyDX+9swJ9OwlWDAif+jdejNk285mCKY6+VM+e/HyztR86KtOoRG2gOeo7247x64c
         xmKlIvIpOy1cCvCoOuYbys/Msz/k2pZ7w2UUUxFkseRfk2gSszD7rSSdf+iXwB+5bZsp
         kLHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778680729; x=1779285529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsuXsibOCMxM5qBRPlxS1FnzSOlRT8+VKmgCfVRKLU8=;
        b=aDqExI9dwHnXOj2VsU+4Gl+5vebBYYVaHptEDiSrdDdFY/csSCEJ5oX7OpXeOiQ0tE
         HLtfyi9fyLSWstUBzcH/mWGPiWeaZHIdNb8IRG9vYWPO0jQBNzpGMqzq7PIpgelfmyLj
         s/2bEibhEat/O20Feu+TS5Fos8P/1bGAxxTSBNV5Qy+OSB2bU3RBhcmvLdtNnyqrInKk
         mseA3lrsx+A4VUJON8+h+BCuuFzzL0vr0SV16stgT28eaCWaeIjF24mQSXrwJnu/riaV
         vu2tD2remDhnhvPzerHGVOvIDNNsxCLRwb2gfYTUJtDLUJVtWaNQmjmlbAoz6GPpEZTN
         q/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778680729; x=1779285529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PsuXsibOCMxM5qBRPlxS1FnzSOlRT8+VKmgCfVRKLU8=;
        b=YZmmfuJth0QUK3MuuE7i93oSXRtWrGtbtkdliWQwpvT6beO4B7j4nrjPIFZ2s3UDSQ
         1oyZ1M/GoR8Rw3wSianlO9meYSj9vZctdoEYN8/0y67GDy1ytVcrCWuHFyTSCkwB9fX6
         SGtftQq5ZNkaHWEFF6aLwks9xu5zPZM1IJYhieIGQ5xuGOrQKWj6+H+KkZZbaQHHXl2N
         /5E6ZETyYCF3uuHybnP1RynMvNyLFKcClt3Q6aWZKK8lJubiOWnnUjdoGz7bzd4mF4G6
         S6jeWOQU0LZRcaNGL0AmhS94pXdcIr9KTxZyTlv1nPtVlt6cyEE4geCkD11K+DcPjC2H
         n4Rg==
X-Forwarded-Encrypted: i=1; AFNElJ/0rK+2XPE4PmNm7qqvrUL2J9PxZBJ+CGy+Iz9hYPWCxxaF27ZnBsbCn/CRPvCq+nqZziVQBJIN@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4meuvF2nbWOpzf8p/MniB2j3IPYTUwY8kJAuFeGNqaECrKjCU
	bwE1QkSQaiuag22Kn+biJMXg6O4Rey0FouzpN0g36ncHYt1523f7oR5HLHuEnnfeaODZrT4KUIs
	kaKrCPitBcr/xG0G/6Ye8zjGvrCrmEeU=
X-Gm-Gg: Acq92OEjFPjzA2vkdDTTw6X+z3AFcbGWXKTb4oq2M1T6Po6lRP7rbOSo4SnjiO7mza3
	+84JFTL79ysftRjecBL93I15Ma1mvkpUGQeeKoXwf5PrVyoBuH0z4YaIm8glChN/YxmSid/eM4s
	wtifQ6Yqe2Gqx7T/16a7IDCJzOn/bFHdTO650+F9pFapBFzzdzrf8saOclhmCWMCg4PoZFEXiDs
	361FFcy5rRfNSe07yx0rs8neWaeGE1tbIPy7UdBGQoy2s0nS6U037oCElKrdSwmKnxCJlenfM22
	VxBk+J3p6rVLz1g=
X-Received: by 2002:a2e:bc03:0:b0:38e:9638:d718 with SMTP id
 38308e7fff4ca-3944b3d4261mr13012311fa.13.1778680728841; Wed, 13 May 2026
 06:58:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407054003.801744-1-lautrbach@redhat.com> <CAEjxPJ6NcY9NsxV+NihjNaE3zSztQKgD8=O3LyXi-4_0+xFi+g@mail.gmail.com>
In-Reply-To: <CAEjxPJ6NcY9NsxV+NihjNaE3zSztQKgD8=O3LyXi-4_0+xFi+g@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 13 May 2026 09:58:37 -0400
X-Gm-Features: AVHnY4LCHhPse79druMD-ww3IvKJOcNmdsNhlPAKWaBQqKZwWdZYOCKVRXXrXQY
Message-ID: <CAP+JOzTfCfe6vGkUwwk-59t65NKJdpiQONLeCtn2MpAeiUgRuA@mail.gmail.com>
Subject: Re: [PATCH 1/2] restorecond: Add -F for run in foreground
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Petr Lautrbach <lautrbach@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 11:44=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Apr 7, 2026 at 1:40=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.c=
om> wrote:
> >
> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>

These two patches have been merged.
Thanks,
Jim

> > ---
> >  restorecond/restorecond.8 |  5 ++++-
> >  restorecond/restorecond.c | 13 ++++++++-----
> >  2 files changed, 12 insertions(+), 6 deletions(-)
> >
> > diff --git a/restorecond/restorecond.8 b/restorecond/restorecond.8
> > index bf8ec87562f8..bb99b24a2d69 100644
> > --- a/restorecond/restorecond.8
> > +++ b/restorecond/restorecond.8
> > @@ -3,7 +3,7 @@
> >  restorecond \- daemon that watches for file creation and then sets the=
 default SELinux file context
> >
> >  .SH "SYNOPSIS"
> > -.B restorecond  [\-d] [-h] [\-f restorecond_file ] [\-u] [\-v]
> > +.B restorecond  [\-d] [-h] [\-f restorecond_file ] [\-F] [\-u] [\-v]
> >  .P
> >
> >  .SH "DESCRIPTION"
> > @@ -26,6 +26,9 @@ Print usage statement.
> >  .B \-f restorecond_file
> >  Use alternative restorecond.conf file.
> >  .TP
> > +.B \-F
> > +Run in foreground, do not become a daemon.
> > +.TP
> >  .B \-u
> >  Turns on user mode.  Runs restorecond in the user session and reads /e=
tc/selinux/restorecond_user.conf.  Uses dbus to make sure only one restorec=
ond is running per user session.
> >  .TP
> > diff --git a/restorecond/restorecond.c b/restorecond/restorecond.c
> > index d5f70fc2e2c1..36f82ae5e9cb 100644
> > --- a/restorecond/restorecond.c
> > +++ b/restorecond/restorecond.c
> > @@ -76,6 +76,7 @@ int debug_mode =3D 0;
> >  int terminate =3D 0;
> >  int master_wd =3D -1;
> >  int run_as_user =3D 0;
> > +int foreground_mode =3D 0;
> >
> >  static void done(void) {
> >         watch_list_free(master_fd);
> > @@ -124,7 +125,7 @@ static void term_handler(int s __attribute__ ((unus=
ed)))
> >
> >  static void usage(char *program)
> >  {
> > -       printf("%s [-d] [-f restorecond_file ] [-u] [-v] \n", program);
> > +       printf("%s [-d] [-f restorecond_file ] [-F] [-n] [-u] [-v] \n",=
 program);
> >  }
> >
> >  void exitApp(const char *msg)
> > @@ -165,7 +166,7 @@ int main(int argc, char **argv)
> >         sigaction(SIGTERM, &sa, NULL);
> >
> >         atexit( done );
> > -       while ((opt =3D getopt(argc, argv, "hdf:uv")) > 0) {
> > +       while ((opt =3D getopt(argc, argv, "hdf:Fuv")) > 0) {
> >                 switch (opt) {
> >                 case 'd':
> >                         debug_mode =3D 1;
> > @@ -173,6 +174,9 @@ int main(int argc, char **argv)
> >                 case 'f':
> >                         watch_file =3D optarg;
> >                         break;
> > +               case 'F':
> > +                       foreground_mode =3D 1;
> > +                       break;
> >                 case 'u':
> >                         run_as_user =3D 1;
> >                         break;
> > @@ -209,13 +213,12 @@ int main(int argc, char **argv)
> >
> >         read_config(master_fd, watch_file);
> >
> > -       if (!debug_mode) {
> > +       if (!debug_mode && !foreground_mode) {
> >                 if (daemon(0, 0) < 0)
> >                         exitApp("daemon");
> > +               write_pid_file();
> >         }
> >
> > -       write_pid_file();
> > -
> >         while (watch(master_fd, watch_file) =3D=3D 0) {
> >         }
> >
> > --
> > 2.53.0
> >
> >
>
