Received: from mail-ua1-f65.google.com (mail-ua1-f65.google.com [209.85.222.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9745C3542CE
	for <selinux@vger.kernel.org>; Wed, 11 Feb 2026 19:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770839014; cv=pass; b=YUPpQxOXmqGwsU5tvqvZWYzfg4Fq6p7f84Ix45PeB3Fz9A1Lw8izTyk8uOlAXeLFjX8pOKPqSRmJ5EXa4h2Tko0C/mcM9qoweuXD9cgK5fIw+EuUoFwMjymyZ8r4IjWY044rOJ79NQJB7gP3AkigZJfit7nsbiBOb0mUFAHBxLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770839014; c=relaxed/simple;
	bh=oXQ1XB8B3wClH1fLqpgOnCS78LK40SPPGujDt6bxq94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6iNYv1OFwBuSYaifGrQzTf8El999KgtGnmHugX5n64aXCbOb5b/gyteqnY8navME69+F9T5jykfIbr0vo8RTqy2CEaQdH4CSnGAZyNxfhs9fifD6KeNdGZh96QVVEH4CfpPx7rKPGEKI8lUSsW1SQLvPSLWJOYV6jU7UalAF90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PowYvJbT; arc=pass smtp.client-ip=209.85.222.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PowYvJbT"
Received: by mail-ua1-f65.google.com with SMTP id a1e0cc1a2514c-94ac8cbf3feso1272377241.0
        for <selinux@vger.kernel.org>; Wed, 11 Feb 2026 11:43:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770839013; cv=none;
        d=google.com; s=arc-20240605;
        b=VT94Vzu/0v0jq9Vg5TcEtoU4teL9AzXSxCVFhv+b23IehA5s4Xm+/LGzRT10mJ07mf
         k/ZCTujVpo4kAnbNyDugwiWytBtJELnty54dhCgdUBiHRxNGAV0/bvtLk/MA3b2LGjbe
         cmczFmzMNcMs177y6fm3rsbHAcS157THrSU3VMs5FChZ4sFvuNkTIW94hQtj/jBfQIyR
         qY9sCK0M4VddVc4ZaILoEfQ/A4gEJZQOfyNlscjA+IPVGE8WHOZ/yYZklaIYk7VmXO3z
         Ft23XloXsUa7w7T0OYQU5JX/aPnXnbdwdrp09KHKs19f8LF7Ao4+gCWi5nAbVblrsEek
         M8Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gHntEFiFJWWh+7XoaBNqKXQpADrwgSFaOdTDNIvp++o=;
        fh=iReHhgpadxpn78WMn80rWuNr8Z27fHvCxXiFKNnO4Ko=;
        b=SLym43QyWfhH4xNkI9stRAgN7DSxyh7MsZjxfrGcRbELWcnEkPHZ6FQ0i8UJm/cEox
         27/BEUDpG6nHhqKP8/X98+Q8qtfuviAsxp5IPzVArId8ZEX+MAKqqWCTcHf61LKd3Git
         0XXJ5tgj+xjnUn1tBPqNlwHhuUxrlN07QfyFA3eIKJTX4W6oPcx5mhP1rsVvdPXQKDGu
         H9KhoBC2c2OZDLydhj/4NT4q1iJu8TxbxPp6lTAAw50KFImop7cTMj19xTghGAkQDADT
         45PS7fnLoMNEqSGkotFNBe5o7QHHQL186g72Pz1T9dvUiD7ZJ3elRHHHGfyqbeDZTS/P
         kRuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770839013; x=1771443813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHntEFiFJWWh+7XoaBNqKXQpADrwgSFaOdTDNIvp++o=;
        b=PowYvJbTJPD5aOP9KtNXgpElGAHlayOJtccZi17gLCiV7NklgomQwPWvFL+tS/F06+
         a4IHJWMKWcQOCMuG0V5Y1S7C3NMpWRRazWJSMGJ/+lW0n8XplZ7g7PHPZvoIPWr7ddC6
         kBURI9c6WeteHacV61ibMk9mDDzli28UvAOwlslzqHBLPbUBqJzca/m0c5JolC7p1VcV
         qs5+NNIx3MrvmcDaY/OsicJhdP7sZwy9m5emE/013J9SvcxjRvFzxDsyfLjLcjyYInMY
         HBHhumq6HhVkgF0CZKb1GWABndE+59YlInwq0nEKWZ3tZaa6o+GwTjhAB8RDB0zcOK4h
         ee1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770839013; x=1771443813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gHntEFiFJWWh+7XoaBNqKXQpADrwgSFaOdTDNIvp++o=;
        b=HNlNXbFPCLIP3Xd9O1ZgPZ1ZYVz9Kq0nbFsG852tKzSnlZm1aewG5VXpzrXMU86t0r
         W69Bsf33Kil6I+9BJhkjqBY5UbDyVvnNeUrZDblOHmLP2YEhIeEnXtnawLdi9BkGSqY2
         9yDkFC2N5+919VfFGYgDj2dPyR+U1Q5dIec8LvjqUvE9N78PS1+ZDalwasW3uMss0NtP
         +a0oIiljfsq31ztjF6+X/167kpjMVTOjWwIUlxCEXMqqwfujSu7DIMMrRZiYFuYxF3cG
         Tp1rDQtyKbcTYLSDZIMmN8Mx55YWr32mQFJzDZ1XxdXLYir/P+7TjHpJzjAKomLJzwyb
         nbJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6iRnRA0f6ecqtVtN0GaIRSazbxEon+6meauN7xOPUHbfHnCYeAJPoI25gdMPP17CUtC8IJBcy@vger.kernel.org
X-Gm-Message-State: AOJu0YwOmKZ+Pxe9XZoi5bukaj3QgR+B0o7SZfde0/i8RqUNYXv0P/w8
	KfbCw70U050lTMdjZ7jyUp9PHmt3Mfj9CD7qP6Gkq48bAM05+iRxVghbKRhOYXZaHujOPNcrYI4
	j9uWbeJh2zuG+AY9lK9NhNUV/qHorIAo=
X-Gm-Gg: AZuq6aISDUaQ9O/ZTfTqo321CLxvtn2yE8jFRwtOdW20VpdClVPmeyKLav3M/vxk9Fm
	Sajp40Ovv96RJFNUanXT0QpeaxrLFMSrqVfmSuUYLwosSb027YcnYYwnq5SasySctGYkB7Av+pv
	ZmHDGO+w0nVYga06Qxlh61E3JuaCq/IUonFB4X9QzuxpVsLCpT52b2EDOc4QCP9MdPJMT03ytCv
	U8UG7z6tvPgcvw/NGf7WEIAGDVVt01fU2FS5IvmjutWNwiUmB++6FI2uO7znqZ1z51UaiLZactV
	6ZyKVXQ=
X-Received: by 2002:a05:6102:b03:b0:5fd:faf5:bc7a with SMTP id
 ada2fe7eead31-5fdfbe41f38mr144483137.41.1770839012601; Wed, 11 Feb 2026
 11:43:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206180248.12418-1-danieldurning.work@gmail.com> <20260209-spanplatten-zerrt-73851db30f18@brauner>
In-Reply-To: <20260209-spanplatten-zerrt-73851db30f18@brauner>
From: Daniel Durning <danieldurning.work@gmail.com>
Date: Wed, 11 Feb 2026 14:43:21 -0500
X-Gm-Features: AZwV_Qhs3SxVp8P05lu1S3k0H4-gjDRINJd9WaPk3va07O3EBGHdjmRA3KZwHck
Message-ID: <CAKrb_fEXR0uQnX5iK-ACH=amKMQ8qBSPGXmJb=1PgvEq8qsDEQ@mail.gmail.com>
Subject: Re: [RFC PATCH] fs/pidfs: Add permission check to pidfd_info()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	paul@paul-moore.com, stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 9:01=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Fri, Feb 06, 2026 at 06:02:48PM +0000, danieldurning.work@gmail.com wr=
ote:
> > From: Daniel Durning <danieldurning.work@gmail.com>
> >
> > Added a permission check to pidfd_info(). Originally, process info
> > could be retrieved with a pidfd even if proc was mounted with hidepid
> > enabled, allowing pidfds to be used to bypass those protections. We
> > now call ptrace_may_access() to perform some DAC checking as well
> > as call the appropriate LSM hook.
> >
> > The downside to this approach is that there are now more restrictions
> > on accessing this info from a pidfd than when just using proc (without
> > hidepid). I am open to suggestions if anyone can think of a better way
> > to handle this.
>
> This isn't really workable since this would regress userspace quite a
> bit. I think we need a different approach. I've given it some thought
> and everything's kinda ugly but this might work.
>
> In struct pid_namespace record whether anyone ever mounted a procfs
> with hidepid turned on for this pidns. In pidfd_info() we check whether
> hidepid was ever turned on. If it wasn't we're done and can just return
> the info. This will be the common case. If hidepid was ever turned on
> use kern_path("/proc") to lookup procfs. If not found check
> ptrace_may_access() to decide whether to return the info or not. If
> /proc is found check it's hidepid settings and make a decision based on
> that.
>
> You can probably reorder this to call ptrace_may_access() first and then
> do the procfs lookup dance. Thoughts?

Thanks for the feedback. I think your solution makes sense.

Unfortunately, it seems like systemd mounts procfs with hidepid enabled on
boot for services with the ProtectProc option enabled. This means that
procfs will always have been mounted with hidepid in the init pid namespace=
.
Do you think it would be viable to record whether or not procfs was mounted
with hidepid enabled in the mount namespace instead?

> > I have also noticed that it is possible to use pidfds to poll on any
> > process regardless of whether the process is a child of the caller,
> > has a different UID, or has a different security context. Is this
> > also worth addressing? If so, what exactly should the DAC checks be?
>
> Oleg and I had discusses this and decided that such polling isn't
> sensitive information so by default this should just work and it's
> relied upon in Android and in a bunch of other workloads. An LSM can of
> course restrict access via security_file_ioctl().
>
> Fwiw, pidfds now support persistent trusted extended attributes so if
> the LSM folks wanted we can add security.* extended attribute support
> and they can mark pidfds with persistent security labels - persistent as
> in for the lifetime of the task.
>
> > Signed-off-by: Daniel Durning <danieldurning.work@gmail.com>
> > ---
> >  fs/pidfs.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/fs/pidfs.c b/fs/pidfs.c
> > index dba703d4ce4a..058a7d798bca 100644
> > --- a/fs/pidfs.c
> > +++ b/fs/pidfs.c
> > @@ -365,6 +365,13 @@ static long pidfd_info(struct file *file, unsigned=
 int cmd, unsigned long arg)
> >               goto copy_out;
> >       }
> >
> > +     /*
> > +      * Do a filesystem cred ptrace check to verify access
> > +      * to the task's info.
> > +      */
> > +     if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
> > +             return -EACCES;
> > +
> >       c =3D get_task_cred(task);
> >       if (!c)
> >               return -ESRCH;
> > --
> > 2.52.0
> >
