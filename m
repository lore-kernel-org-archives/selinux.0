Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7175A36AB79
	for <selinux@vger.kernel.org>; Sat, 31 Jan 2026 19:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769888944; cv=pass; b=FsKerasUp4V8VXM7B9ZBxMJaMw3nKP/CdOmk64GlSHW7rqxJsaizyxatw6iwnwTJlX2UIZsrQX/MtKrPRaiafe1O/V3SL7OSXJuABTCgG3wAtgDE3lWciOCC/idGEOmm4+uPUMtlXU6g4i9GOjzt8f+Kxt0X6rsiKQlMV5uzIfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769888944; c=relaxed/simple;
	bh=9NhDPjT9NleZWRaZ1J3BDr5j3u7k2ymA7VxTgRJOjCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WS7wN2QTJGMtsu7vpzjRRXvmY88TagbWxdegSI2v8chvh2q4ZynlIdmdgOSlZusgdjdsovSi8iNixdmJNb/6QTZP5FrxhrrIJ4dTBo520zDLeiu45vcCpQx9GX12bvNp/KTdqd+ca7mDZcF8Pev2hpOmmtptGHEaixSZRCo4NdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MrZzAnm4; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MrZzAnm4"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-658d3d3ac37so5375527a12.1
        for <selinux@vger.kernel.org>; Sat, 31 Jan 2026 11:49:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769888941; cv=none;
        d=google.com; s=arc-20240605;
        b=UpCpZYMmSDgYziEzraCP8CWKiKbG01iaPVoUMS2FW4LTzvfWUw2UqltjW/UXnXWGWd
         RtDpKa0nSXJYPHoYkR5zZB2j+Z26KazXrTws3uRe+tDis4eW5JmIkTLDSfSKmJwbiIKK
         nASBiIWNHpcu1H3uJM/oeBoUjyih+TB/IBr3GTnDPVOSeTjxkJZDDrq4PJzHzhU7GlNY
         XCMDJb5i31WYKrTQUnURa6e93d2vG836ZrtebIOioMVxSYk/738vNLZ0TtrHNvLEGgy6
         NRELn8Z8lctBg69C7ZOPuQwyC+o8WxLT2m7Bevu0DRo/NVdzDUf/ILSOtnLqNl9qd9oR
         BClg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pvJH79c3ek4UlgvkC3XFusrRWLJlCUgDtsKCKKtm5AI=;
        fh=qeO7HOTmgqb9HKH5i87C51BQ98V2TNc+2odo0Gb+APQ=;
        b=PnF9OsefSQLCp/Ai0pMd3f8Hh84RmBUit+INK6ZviY/GGHXNelJohsf4ctJLNEfNfM
         vEvfBvXt6CyJX18NKOHuHw/LJ1kdcc0CKj/AZ8rguFH9Hquysn5C85FR5I/QXZ2ymaKr
         8aqsit8m+vjkDxE95hzTv71g6s0DaFyhRHIqHaSjhhAMcFdqlhhlnfTMT92MFoTzLD9c
         /UeDojsz88FlMNsRrrsqMHTwrz3k9HMXPsrX7THZ4ROzZz7AMyC8lnONaEFga84L0FW0
         rvQyu/YlgiQMUZh2CBQ0POXgTl8kpXp0cSIf0nSUqih1gSJXe6vTv7aO8v6qguOMHCm3
         14qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769888941; x=1770493741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvJH79c3ek4UlgvkC3XFusrRWLJlCUgDtsKCKKtm5AI=;
        b=MrZzAnm4xg410ODFP112+fAdfKXV9OfgE0okV1aFRtNGiMQlDgQaqTqJraNXtPS0Xu
         DzhHvSi8dHu/i8jEURbaWAGf1H0f6d16f6gP+PCOPUFed2XWVVG+ntDKlGQPAh7gLSVa
         I0X69y4HLDI83OZlY1nXXNRc+7aaVgJXOskCAQE5I3OOHp3I4M1NwgRTn/3erQkc7bDL
         r6Woqq70N3PyAMoBDZVK/+NM49SO20bYSnymAT4VPJGJWK0qOo3OyRiKPCl/+5RQpZhu
         QFqfLtpn1iY9vFqa7Bj42Z1/LqK+qzUdb87t2rfuXkaMCuMfWrg46GxomrboY4XcH25C
         6f0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769888941; x=1770493741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pvJH79c3ek4UlgvkC3XFusrRWLJlCUgDtsKCKKtm5AI=;
        b=nuFSR356A48I1+AA/+jLbWME8R8n+ZvrtiIa/efixAD3ior+qJfQIO9QOl6bt88fq0
         nHXZ3iqtyuyITHh/4YSpLiEZCRGDUrmSQ8dW7Q5CwI1ldREJ61tH306rpzaemS03H5Ch
         c8PZh/kKCrWpBltwV1Ib3O1r7XqcpBUQgMxdUdElcnIkZ2oqk0srk2Fddj6UcMMxW1LG
         CKYySU+kanM9BPUXCJ8daIgSDy7gTrtrDkGw3WWKqQeAOBi8BiMQX5CU8QrAwKj8AZGu
         BdF176H/8HvLx1OcGCFWawjldqcJBJkreTGVgXSh7PCiuB8rFHllVIG6MgpqCcGvxPdO
         dwZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxCPmwxUg15u2hizlZTJe0eNvu3ZbRx6OaR0vwZtUkilTXYX2jlbB7tebpChRWOFpDpdBn8FGR@vger.kernel.org
X-Gm-Message-State: AOJu0YwzJU/Affh5sod+4ChundrY1nleYxrBkqFL5UXc8+vD2WZQOx4Y
	A7OLP84XrKJ16IrnsCLKY1rR88m7EGXWGCpuoUlZfPzDphpcPBSCROWWfxyY39Q1/OGXRh6pze0
	d7pufHJTI0Qz7z3vjozTqAIM31DktBhc9dadisZ8K
X-Gm-Gg: AZuq6aLfpEF8hBrhzqutrSxp9MUKm6z+XL6jBtNMbcdX68XSo43i1Yl81T1MvHSoWsZ
	HB0tO9jJb6fMqo8f/6ZrLgyMkGtYJexDBZ2yDS/xSW2KBVTOc87MXOBoQ/JbE3I3eiRvqeQJFIY
	wHdrkxzeMBqA0xVSIjb8ynagLW+UhTxfK8cDRrHD6Fsrye+gKU3sJZqoHKZV2blJ/DOKpT0UnL7
	CwtbWVUs1taloD0MW3vWgEcx3onUzCgFBcAneRp9802csfkxXoMvF4kEJyRZXLvVyIm
X-Received: by 2002:a17:906:794b:b0:b73:6d56:7332 with SMTP id
 a640c23a62f3a-b8dff5288a2mr467832866b.13.1769888940424; Sat, 31 Jan 2026
 11:49:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
 <20260129032335.GT3183987@ZenIV> <20260129225433.GU3183987@ZenIV>
 <CAG2KctoNjktJTQqBb7nGeazXe=ncpwjsc+Lm+JotcpaO3Sf9gw@mail.gmail.com>
 <20260130070424.GV3183987@ZenIV> <CAG2Kctoqja9R1bBzdEAV15_yt=sBGkcub6C2nGE6VHMJh13=FQ@mail.gmail.com>
 <20260130235743.GW3183987@ZenIV> <CAG2KctotL+tpHQMWWAFOQEy=3NX-7fa9YroqsjnxKmTuunJ2AQ@mail.gmail.com>
 <20260131011831.GZ3183987@ZenIV> <CAG2KctoKDsfbyopQYq3-nJBg3fG+7Nrer17S6HqQ+nCWEcHeWQ@mail.gmail.com>
 <20260131024324.GA3183987@ZenIV>
In-Reply-To: <20260131024324.GA3183987@ZenIV>
From: Samuel Wu <wusamuel@google.com>
Date: Sat, 31 Jan 2026 11:48:49 -0800
X-Gm-Features: AZwV_Qix7s2zR2ubTIU666aQNHaAYNz5LepZwEs2cPS3Y4RZWye8TClZc5UBZ0c
Message-ID: <CAG2KctoJoBevAM=2F=dNnM3VUUcHX9VV-vhKDx5ydOwa4a6zUA@mail.gmail.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, 
	torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org, clm@meta.com, 
	android-kernel-team <android-kernel-team@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 6:41=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Fri, Jan 30, 2026 at 06:09:00PM -0800, Samuel Wu wrote:
> > On Fri, Jan 30, 2026 at 5:16=E2=80=AFPM Al Viro <viro@zeniv.linux.org.u=
k> wrote:
> > >
> > > On Fri, Jan 30, 2026 at 05:05:34PM -0800, Samuel Wu wrote:
> > >
> > > > > How lovely...  Could you slap
> > > > >         WARN_ON(ret =3D=3D -EAGAIN);
> > > > > right before that
> > > > >         if (ret < 0)
> > > > >                 return ret;
> > > >
> > > > Surprisingly ret =3D=3D 0 every time, so no difference in dmesg log=
s with
> > > > this addition.
> > >
> > > What the hell?  Other than that mutex_lock(), the only change in ther=
e
> > > is the order of store to file->private_data and call of ffs_data_open=
ed();
> > > that struct file pointer is not visible to anyone at that point...
> >
> > Agree, 09e88dc22ea2 (serialize ffs_ep0_open() on ffs->mutex) in itself
> > is quite straightforward. Not familiar with this code path so just
> > speculating, but is there any interaction with previous patches (e.g.
> > refcounting)?
> >
> > > Wait, it also brings ffs_data_reset() on that transition under ffs->m=
utex...
> > > For a quick check: does
> > > git fetch git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git =
for-wsamuel2
> > > git switch --detach FETCH_HEAD
> > > demonstrate the same breakage?
> >
> > Had to adjust forward declaration of ffs_data_reset() to build, but
> > unfortunately same breakage.
>
> That really looks like a badly racy userland on top of everything else...
> I mean, it smells like userland open() from one process while another
> is in the middle of configuring that stuff getting delayed too much
> for the entire thing to work.  Bloody wonderful...
>
> OK, let's see if a variant with serialization on spinlock works - how doe=
s
> the following do on top of mainline?

Excellent, this is working consistently for me on the latest 6.19-rc7.

>
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/func=
tion/f_fs.c
> index 05c6750702b6..fa467a40949d 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -59,7 +59,6 @@ static struct ffs_data *__must_check ffs_data_new(const=
 char *dev_name)
>         __attribute__((malloc));
>
>  /* Opened counter handling. */
> -static void ffs_data_opened(struct ffs_data *ffs);
>  static void ffs_data_closed(struct ffs_data *ffs);
>
>  /* Called with ffs->mutex held; take over ownership of data. */
> @@ -636,23 +635,25 @@ static ssize_t ffs_ep0_read(struct file *file, char=
 __user *buf,
>         return ret;
>  }
>
> +
> +static void ffs_data_reset(struct ffs_data *ffs);
> +
>  static int ffs_ep0_open(struct inode *inode, struct file *file)
>  {
>         struct ffs_data *ffs =3D inode->i_sb->s_fs_info;
> -       int ret;
>
> -       /* Acquire mutex */
> -       ret =3D ffs_mutex_lock(&ffs->mutex, file->f_flags & O_NONBLOCK);
> -       if (ret < 0)
> -               return ret;
> -
> -       ffs_data_opened(ffs);
> +       spin_lock_irq(&ffs->eps_lock);
>         if (ffs->state =3D=3D FFS_CLOSING) {
> -               ffs_data_closed(ffs);
> -               mutex_unlock(&ffs->mutex);
> +               spin_unlock_irq(&ffs->eps_lock);
>                 return -EBUSY;
>         }
> -       mutex_unlock(&ffs->mutex);
> +       if (!ffs->opened++ && ffs->state =3D=3D FFS_DEACTIVATED) {
> +               ffs->state =3D FFS_CLOSING;
> +               spin_unlock_irq(&ffs->eps_lock);
> +               ffs_data_reset(ffs);
> +       } else {
> +               spin_unlock_irq(&ffs->eps_lock);
> +       }
>         file->private_data =3D ffs;
>
>         return stream_open(inode, file);
> @@ -1202,15 +1203,10 @@ ffs_epfile_open(struct inode *inode, struct file =
*file)
>  {
>         struct ffs_data *ffs =3D inode->i_sb->s_fs_info;
>         struct ffs_epfile *epfile;
> -       int ret;
> -
> -       /* Acquire mutex */
> -       ret =3D ffs_mutex_lock(&ffs->mutex, file->f_flags & O_NONBLOCK);
> -       if (ret < 0)
> -               return ret;
>
> -       if (!atomic_inc_not_zero(&ffs->opened)) {
> -               mutex_unlock(&ffs->mutex);
> +       spin_lock_irq(&ffs->eps_lock);
> +       if (!ffs->opened) {
> +               spin_unlock_irq(&ffs->eps_lock);
>                 return -ENODEV;
>         }
>         /*
> @@ -1220,11 +1216,11 @@ ffs_epfile_open(struct inode *inode, struct file =
*file)
>          */
>         epfile =3D smp_load_acquire(&inode->i_private);
>         if (unlikely(ffs->state !=3D FFS_ACTIVE || !epfile)) {
> -               mutex_unlock(&ffs->mutex);
> -               ffs_data_closed(ffs);
> +               spin_unlock_irq(&ffs->eps_lock);
>                 return -ENODEV;
>         }
> -       mutex_unlock(&ffs->mutex);
> +       ffs->opened++;
> +       spin_unlock_irq(&ffs->eps_lock);
>
>         file->private_data =3D epfile;
>         return stream_open(inode, file);
> @@ -2092,8 +2088,6 @@ static int ffs_fs_init_fs_context(struct fs_context=
 *fc)
>         return 0;
>  }
>
> -static void ffs_data_reset(struct ffs_data *ffs);
> -
>  static void
>  ffs_fs_kill_sb(struct super_block *sb)
>  {
> @@ -2150,15 +2144,6 @@ static void ffs_data_get(struct ffs_data *ffs)
>         refcount_inc(&ffs->ref);
>  }
>
> -static void ffs_data_opened(struct ffs_data *ffs)
> -{
> -       if (atomic_add_return(1, &ffs->opened) =3D=3D 1 &&
> -                       ffs->state =3D=3D FFS_DEACTIVATED) {
> -               ffs->state =3D FFS_CLOSING;
> -               ffs_data_reset(ffs);
> -       }
> -}
> -
>  static void ffs_data_put(struct ffs_data *ffs)
>  {
>         if (refcount_dec_and_test(&ffs->ref)) {
> @@ -2176,28 +2161,29 @@ static void ffs_data_put(struct ffs_data *ffs)
>
>  static void ffs_data_closed(struct ffs_data *ffs)
>  {
> -       if (atomic_dec_and_test(&ffs->opened)) {
> -               if (ffs->no_disconnect) {
> -                       struct ffs_epfile *epfiles;
> -                       unsigned long flags;
> -
> -                       ffs->state =3D FFS_DEACTIVATED;
> -                       spin_lock_irqsave(&ffs->eps_lock, flags);
> -                       epfiles =3D ffs->epfiles;
> -                       ffs->epfiles =3D NULL;
> -                       spin_unlock_irqrestore(&ffs->eps_lock,
> -                                                       flags);
> -
> -                       if (epfiles)
> -                               ffs_epfiles_destroy(ffs->sb, epfiles,
> -                                                ffs->eps_count);
> -
> -                       if (ffs->setup_state =3D=3D FFS_SETUP_PENDING)
> -                               __ffs_ep0_stall(ffs);
> -               } else {
> -                       ffs->state =3D FFS_CLOSING;
> -                       ffs_data_reset(ffs);
> -               }
> +       spin_lock_irq(&ffs->eps_lock);
> +       if (--ffs->opened) {    // not the last opener?
> +               spin_unlock_irq(&ffs->eps_lock);
> +               return;
> +       }
> +       if (ffs->no_disconnect) {
> +               struct ffs_epfile *epfiles;
> +
> +               ffs->state =3D FFS_DEACTIVATED;
> +               epfiles =3D ffs->epfiles;
> +               ffs->epfiles =3D NULL;
> +               spin_unlock_irq(&ffs->eps_lock);
> +
> +               if (epfiles)
> +                       ffs_epfiles_destroy(ffs->sb, epfiles,
> +                                        ffs->eps_count);
> +
> +               if (ffs->setup_state =3D=3D FFS_SETUP_PENDING)
> +                       __ffs_ep0_stall(ffs);
> +       } else {
> +               ffs->state =3D FFS_CLOSING;
> +               spin_unlock_irq(&ffs->eps_lock);
> +               ffs_data_reset(ffs);
>         }
>  }
>
> @@ -2214,7 +2200,7 @@ static struct ffs_data *ffs_data_new(const char *de=
v_name)
>         }
>
>         refcount_set(&ffs->ref, 1);
> -       atomic_set(&ffs->opened, 0);
> +       ffs->opened =3D 0;
>         ffs->state =3D FFS_READ_DESCRIPTORS;
>         mutex_init(&ffs->mutex);
>         spin_lock_init(&ffs->eps_lock);
> @@ -2266,6 +2252,7 @@ static void ffs_data_reset(struct ffs_data *ffs)
>  {
>         ffs_data_clear(ffs);
>
> +       spin_lock_irq(&ffs->eps_lock);
>         ffs->raw_descs_data =3D NULL;
>         ffs->raw_descs =3D NULL;
>         ffs->raw_strings =3D NULL;
> @@ -2289,6 +2276,7 @@ static void ffs_data_reset(struct ffs_data *ffs)
>         ffs->ms_os_descs_ext_prop_count =3D 0;
>         ffs->ms_os_descs_ext_prop_name_len =3D 0;
>         ffs->ms_os_descs_ext_prop_data_len =3D 0;
> +       spin_unlock_irq(&ffs->eps_lock);
>  }
>
>
> @@ -3756,6 +3744,7 @@ static int ffs_func_set_alt(struct usb_function *f,
>  {
>         struct ffs_function *func =3D ffs_func_from_usb(f);
>         struct ffs_data *ffs =3D func->ffs;
> +       unsigned long flags;
>         int ret =3D 0, intf;
>
>         if (alt > MAX_ALT_SETTINGS)
> @@ -3768,12 +3757,15 @@ static int ffs_func_set_alt(struct usb_function *=
f,
>         if (ffs->func)
>                 ffs_func_eps_disable(ffs->func);
>
> +       spin_lock_irqsave(&ffs->eps_lock, flags);
>         if (ffs->state =3D=3D FFS_DEACTIVATED) {
>                 ffs->state =3D FFS_CLOSING;
> +               spin_unlock_irqrestore(&ffs->eps_lock, flags);
>                 INIT_WORK(&ffs->reset_work, ffs_reset_work);
>                 schedule_work(&ffs->reset_work);
>                 return -ENODEV;
>         }
> +       spin_unlock_irqrestore(&ffs->eps_lock, flags);
>
>         if (ffs->state !=3D FFS_ACTIVE)
>                 return -ENODEV;
> @@ -3791,16 +3783,20 @@ static void ffs_func_disable(struct usb_function =
*f)
>  {
>         struct ffs_function *func =3D ffs_func_from_usb(f);
>         struct ffs_data *ffs =3D func->ffs;
> +       unsigned long flags;
>
>         if (ffs->func)
>                 ffs_func_eps_disable(ffs->func);
>
> +       spin_lock_irqsave(&ffs->eps_lock, flags);
>         if (ffs->state =3D=3D FFS_DEACTIVATED) {
>                 ffs->state =3D FFS_CLOSING;
> +               spin_unlock_irqrestore(&ffs->eps_lock, flags);
>                 INIT_WORK(&ffs->reset_work, ffs_reset_work);
>                 schedule_work(&ffs->reset_work);
>                 return;
>         }
> +       spin_unlock_irqrestore(&ffs->eps_lock, flags);
>
>         if (ffs->state =3D=3D FFS_ACTIVE) {
>                 ffs->func =3D NULL;
> diff --git a/drivers/usb/gadget/function/u_fs.h b/drivers/usb/gadget/func=
tion/u_fs.h
> index 4b3365f23fd7..6a80182aadd7 100644
> --- a/drivers/usb/gadget/function/u_fs.h
> +++ b/drivers/usb/gadget/function/u_fs.h
> @@ -176,7 +176,7 @@ struct ffs_data {
>         /* reference counter */
>         refcount_t                      ref;
>         /* how many files are opened (EP0 and others) */
> -       atomic_t                        opened;
> +       int                             opened;
>
>         /* EP0 state */
>         enum ffs_state                  state;
