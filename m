Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5630F346AC2
	for <selinux@vger.kernel.org>; Wed, 20 May 2026 13:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779282418; cv=pass; b=VMa7lgFy+gwVR7QwXkUV6hJyvSi23+s+tz/6b26dkDXgNiAzpf2TKxhS/EZMUtf+tS+bJyrk8K++UpzL/YIk7f2HMNNzxjQ3gH2Q/5iTW/gsDrqKnodlndh+f6oC14ab8YB27On0IsQdQYdZDUZx6nBCoW2azvnBeBYFN2JaW1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779282418; c=relaxed/simple;
	bh=yosfyh5cu62n88uFPt9wt9lif5ArTykclkQQkcXlJUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ASOh/0kHkbfQi85OOx7eENGa5ijxWJ4zTTAfayWaGtQw9Rv1JQghhAhYMvcyBnr+GF6rIqSIe/AgKitjII2wnjhB9DIgjZdz2seDTZN1uJva+vYfbpEqO4BtlQkIMNIgSuSAuEWYe6rp+CwyTaiy6xheRL9I2E8ZeFfI4xTnRd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRzli6oe; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRzli6oe"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba928852a5so32914435ad.1
        for <selinux@vger.kernel.org>; Wed, 20 May 2026 06:06:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779282417; cv=none;
        d=google.com; s=arc-20240605;
        b=iQs4jsswYSyVXVb4nMbXMK3+7sKZymYY6su5yUBAEzmRUqojp7dftm5IbHNQhK3TTs
         k8Yhmm92/Gu8e5h4IiT3Dwl5Mck1DXI/7MUzejyJkcUN0wDDUfWgqFg0ajAA/70WtU4r
         Oe/o3V5brxqPsmtfLr/RM4QmUC79bv9+3OkgFiuJHnQmeH8xOSeaRa5ixPhlkvNWf/pz
         s56M5tEG+Q94nE0c9n2ijDMFJgzzj5ItFIU7RSGyIG+Pek6cAAp3HYnCXZ/xUuwHdSZE
         AbyQdPgWwQTcHhSanSqkJJkReC6t3hFpxtUhpCbq/3hbT8U31QPvFDWOA4h7hF7ieK/p
         A3tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W/cA55sflHjqfGyxkP5Vtl9WIPjeekw8M3rQTg08Wuc=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=dSG1carDuUBfYn+yGIIdkWnerraekiiIL6FkVed45sF2KCspIkTR+mSrwJ3UUR8y1V
         IDfgxFzPowjKwUZYR2K/Iz8k9DG5gS7qrsJGvqJojj8IWDuJUWHsSWFShoFkH5ua6X6j
         zqZCXZ7auIs2mh5tgPd7z6GGUMZ2Q7Cf4sVnKMtAwVej/CPP2bnYybgH6FJZx5lsh38A
         ftTRjI2HQEfvfqRHq4PQ3IDZBP/j7Pk5hE1+tUR08/DjBHaJzo0xzDZQiPnM4BHVDIFQ
         ywFky/iT6CvMbZHN5wOtjhgBwR/roBo4LSheRmSfLVS1OPopDfTlMenUNezSbXVRRUVb
         JzcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779282417; x=1779887217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/cA55sflHjqfGyxkP5Vtl9WIPjeekw8M3rQTg08Wuc=;
        b=mRzli6oetbdyBO0D6JrmjFZEk5jVrih9eSUHQUtQCwaod63EPWrKcK7Mt5ZAubpk9E
         f+/4Xr48MPVD3DbB5fsuMTlNpdCAhAP4nQQ0r64VOkIMjbWSmg+dsGuqjxVDqehYklfX
         2/DRDKEJSH/iQUkgaNEWxx2uyZ3nb2vHQ5otG2inJjRO4nMhNNzAVIlPmSk6s+FPFX/5
         cDzmRiWu9lR9LdrCnx8cAu4v/8SQgWokT6gxVH2m5cR0nPHLpaRzhoMcEW6kz04i1nhQ
         3XI+ULD9vYp/yd+yvvLWHFhOILOLf470GyRd29UMTy7nWxA+TJD22EeutxBLC8Y9yqQn
         kdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779282417; x=1779887217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W/cA55sflHjqfGyxkP5Vtl9WIPjeekw8M3rQTg08Wuc=;
        b=huJZ4jAUH0tRXb4SraO24SNB5R+qutQgf1Q50mIWZ9ciyIh+yufE2qfahV/vMq5bF8
         ym1Dx+2rHdMj5GK9x/5j1gQdZ0NDsqvUht4tXRStKs1hoOXfHrEWNr0GS67L5PJepqnS
         R3Me3jUuASJB5D+xfWc2RR7+5lsuBCi6QKD+mt8fpEwvnkmGF2Es7MOsbRouXX8r7U2P
         vpsUi9zYOyUTWaEuu99OLGTNr2YHMekZTmM/4UItupuV6T1gVIfMZzln1yzlboXZ3yE1
         Eo1tIdSS+zsqjxj41uVbxKZAHSJCtNNV5COkhxMXEaP6XcuNQowneMsgIK11vwoCJqWJ
         Dm1g==
X-Gm-Message-State: AOJu0YwmAG+TpDSTIlQOXJjOnuxsPtQjucJkJBjhfpQdXn452BT9YiAz
	nIaVukYllJic4MFxTQVW7nZV3lF2KD575Bi0L2CqWeCctf4opMIu+sXeKzH7on9qb3PhGqG2M5f
	zysFfyYfIQxSL0HWJKJF+rz3Sw17JR7DKOT18
X-Gm-Gg: Acq92OF3+K5qUWB00coK2zN2+KIvhwx+zw6jgt99CoXdpO7UceeamV1C+AR60pUdl5+
	Su/JDXRkw7fc8DmHyiiASgl24qxZ0iC8PP/qOUj6WmsVgIoSGv+jI7leTXrgPAuoul5v8h2qXLt
	NcHA6zLIbQV7ADQRvaS+Kb4MOn5oQlMgr+p1AdvQI1JQCLwdjootTmgcRXSWgMtNSaybNfmC4Ee
	+1g9M7ojzlNdWtSbh/graOzqbo528t4qCFfvmEZjJPWjjKZ+DnGisU6xIDqin4hNN1MfiAMSPHr
	M6qIIWaNAxsZR46Wig==
X-Received: by 2002:a17:902:7d96:b0:2b0:bed1:46f7 with SMTP id
 d9443c01a7336-2bd7e910f99mr184588845ad.37.1779282416483; Wed, 20 May 2026
 06:06:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519163154.449162-1-cgoettsche@seltendoof.de> <CAEjxPJ5ZDC2zTexckqdt1CNC_Vy7GXfZ9wJPBZNtq3-owmDq7A@mail.gmail.com>
In-Reply-To: <CAEjxPJ5ZDC2zTexckqdt1CNC_Vy7GXfZ9wJPBZNtq3-owmDq7A@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 20 May 2026 09:06:44 -0400
X-Gm-Features: AVHnY4Lo_S64g0YerGQqz8UJmAtEE67uHVvoZhIs00I-O9KOnSpqUgxgkpBnysM
Message-ID: <CAEjxPJ5XunS80_7VASNnKBAATo0jo8xNUDWiOv=2L-cbspPf2w@mail.gmail.com>
Subject: Re: [PATCH] libselinux: skip per-dirent fstat() when d_type is sufficient
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 3:25=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, May 19, 2026 at 12:45=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Profiling restorecon with perf on a multi-core SELinux-enabled host
> > showed that every dirent paid an fstat(2) even when d_type already
> > gave us the file type.
> >
> > In walk_next() skip fstat() when dirent::d_type is reliable, the entry
> > is not a directory, and neither SELINUX_RESTORECON_XDEV nor
> > SELINUX_RESTORECON_ADD_ASSOC needs st_dev/st_ino.  Directories and
> > DT_UNKNOWN still fstat as before.
> >
> > This relies on the kernel/filesystem reporting an accurate d_type for
> > non-directories (DT_UNKNOWN is handled by falling back to fstat()).
> > The same trust is already implicit in find(1) and similar tools, and
> > a buggy filesystem that mislabels a real directory as DT_REG would
> > already break a wide range of userspace; directories are still
> > verified via fstat() here for the cycle-detection and descend paths.
> >
> > Assisted-by: Claude:claude-4.7-opus
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged - note that I had to resolve one conflict with
c1efe48ab11b156ca ("libselinux: fix selinux_restorecon() error
handling").
>
> > ---
> >  libselinux/src/selinux_restorecon.c | 49 ++++++++++++++++++++++++-----
> >  1 file changed, 42 insertions(+), 7 deletions(-)
> >
> > diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selin=
ux_restorecon.c
> > index 8b6eba0c..2c329ac0 100644
> > --- a/libselinux/src/selinux_restorecon.c
> > +++ b/libselinux/src/selinux_restorecon.c
> > @@ -1040,6 +1040,24 @@ static bool walk_is_cycle(const struct rest_stat=
e *st, dev_t dev, ino_t ino)
> >         return false;
> >  }
> >
> > +/*
> > + * Map a dirent d_type to the matching S_IF* file-type bits, or 0 if d=
_type
> > + * is not informative (e.g. DT_UNKNOWN on filesystems that do not fill=
 it in).
> > + */
> > +static mode_t d_type_to_mode(unsigned char d_type)
> > +{
> > +       switch (d_type) {
> > +       case DT_REG:  return S_IFREG;
> > +       case DT_DIR:  return S_IFDIR;
> > +       case DT_LNK:  return S_IFLNK;
> > +       case DT_FIFO: return S_IFIFO;
> > +       case DT_SOCK: return S_IFSOCK;
> > +       case DT_BLK:  return S_IFBLK;
> > +       case DT_CHR:  return S_IFCHR;
> > +       default:      return 0;
> > +       }
> > +}
> > +
> >  static int open_final(int dfd, const char *name, struct stat *sb)
> >  {
> >         int fd;
> > @@ -1189,13 +1207,30 @@ static int walk_next(struct rest_state *state, =
int *ent_fd, int *rd_fd,
> >                         state->pathbuf[top->pathlen] =3D '\0';
> >                         continue;
> >                 }
> > -               if (fstat(fd, ent_sb) < 0) {
> > -                       selinux_log(SELINUX_ERROR,
> > -                                   "Could not stat %s: %m.\n",
> > -                                   state->pathbuf);
> > -                       close(fd);
> > -                       state->pathbuf[top->pathlen] =3D '\0';
> > -                       continue;
> > +
> > +               /*
> > +                * Skip fstat() when d_type already gives the file type=
 and
> > +                * neither xdev (st_dev) nor add_assoc (st_ino) is need=
ed.
> > +                * Directories always fstat for cycle detection and wal=
k_push().
> > +                */
> > +               mode_t mode_from_dtype =3D d_type_to_mode(de->d_type);
> > +               bool need_fstat =3D mode_from_dtype =3D=3D 0 ||
> > +                                 S_ISDIR(mode_from_dtype) ||
> > +                                 state->flags.set_xdev ||
> > +                                 state->flags.add_assoc;
> > +
> > +               if (need_fstat) {
> > +                       if (fstat(fd, ent_sb) < 0) {
> > +                               selinux_log(SELINUX_ERROR,
> > +                                           "Could not stat %s: %m.\n",
> > +                                           state->pathbuf);
> > +                               close(fd);
> > +                               state->pathbuf[top->pathlen] =3D '\0';
> > +                               continue;
> > +                       }
> > +               } else {
> > +                       memset(ent_sb, 0, sizeof(*ent_sb));
> > +                       ent_sb->st_mode =3D mode_from_dtype;
> >                 }
> >
> >                 int rdfd =3D -1;
> > --
> > 2.53.0
> >
> >
