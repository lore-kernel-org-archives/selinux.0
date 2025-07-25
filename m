Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750FC2EF282
	for <selinux@vger.kernel.org>; Fri, 25 Jul 2025 16:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753461781; cv=none; b=gGW4L/7dJ5AvM/XmFK0jsAQ8cz2rL4gvOuXf5OCDlpVn/dTcNLcMYaaqUyqu0Hn6O06m1I4mJuAlX0wJHP5VuHTDqGXSHh1ImmXY9aw7NiJFqK8TfgQMGhWG9alb6fEj2I3eGelJfalurQDAH3dasHqtIRcPtF/GCEfToQ6iJwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753461781; c=relaxed/simple;
	bh=hhtlTKXXECi8yi5iXycyKR9shLCwOKiYr5xEdB0jQpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KcfG9U92ijd7LT+2atWjBuzlHN+6X68+xkDWsh/LHNJZlTLENlQsR8THWVNulV5GQNIoneeRJE3KgK98UlvC4yJdoPxDpUM3iJlbajGPJAdlB56mXrwChN/70flhRA5DL9aRTXZJNveLoYqLxtnVobLGLGBRokKFd6B4mbVdtt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=L4jAhkKB; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="L4jAhkKB"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e8bbb605530so2691013276.0
        for <selinux@vger.kernel.org>; Fri, 25 Jul 2025 09:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753461778; x=1754066578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJzRqhe+x1DhI6Hy5VLKk5oBTrst/YcQYkVXjLnnM6c=;
        b=L4jAhkKBoJMuMXC9u1RsjBdJG7LPDmsUParFxp7tg2e951gGEBiypKbYWYA3C+5ERg
         3d0hupBGQTEfzoxQnTTqo7vq9dYZyYPQjt9c7rLMb6w/Gt10+jaKamR0bDeG/VVeXQI7
         T18xrTnnIZT0k7/GTymY6bimvCfa6/ccFYt+x5C+qO2O62TmnKWMB7o8R2BzHG8olMeE
         bPU1JZCla6S0UBqTKR3ghgpJlzvh851wBNIMmEf/GnnwAXZ7p/K+GvN3F+SNLh9MXgdh
         vYfHO+s7L/rskIXo+s7gdnhN62PNcNnu09CIsliUHngJGcs+/aBOD53iNySU/Tui1U75
         D86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753461778; x=1754066578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJzRqhe+x1DhI6Hy5VLKk5oBTrst/YcQYkVXjLnnM6c=;
        b=X8bpKUnjQdbWvoLiljJTlYr0IvlNeulMEnLCQPPhBqqXu89jdl3y9TDQ5ElA7fKBEP
         cnnJfhd9qQeUW6/aX6DcJ/JUXim9OZzPPm6K9X/n5u+6qqA0v2UuNDE2Kof/cjNtIz9I
         fv3bZZo0Xtjgt4QeH7ME1yjSkSlCJ0K760jH182yTyhXiGoxFNvF0ATqnm7m2qy/Mo8Y
         EN2Yo5rkbUxORA0HI95bwhEatgaJ19Sq59lfeINK5XxnXvrrJGERfxRocI5Ztc4hnR/1
         dZuOepvCNMkGV8GLLchYEsV0pCqYGLSS8ss0KJj0OMbTF8fSX6hJNhepJMPkw1xc27L/
         rN9g==
X-Forwarded-Encrypted: i=1; AJvYcCX5QiqjjQZjoe7kErjKBUFpJV/skUFgvnnw4cpjeDkijHRJMcv1dzX7iDG8ayFfJCpzWVV+3U8n@vger.kernel.org
X-Gm-Message-State: AOJu0YzH/WJgl6VROEEMlPcI6Ea0XmYNZrjSW1C/m+M/isXk3YNEoZ9J
	0iIrYw5IjvqhZvpu3T2e8RfG83L9noX+20XLE7dCWvRY/M057OQtFj2hTZYoDAEsEHFWXkh3e2m
	V4Byru5iE82fdI0dn5WJRIxwQ9jxs1I6RQQeWA7WQ
X-Gm-Gg: ASbGncuI9XOMSwmbLCe8bYGB+cr/aBkdI7wQDHRum0RvUT9GhchHIRAyYbPSiBFbwaC
	X+GWHI/t9iP2Nl4jb6aZARosvtV8H5CtiwiX4IxCShgiht9V43jEmvb4NS//rPwVAVCk3sz+BPt
	uus/xFBD/RYY6cBfOSopbAepX3udlWaNLjbDJ3GogjN+T8LUQXrE8V+Z6xFZ2JDZPL+AhPTqbQd
	nMMO1df3yuytA56Uw==
X-Google-Smtp-Source: AGHT+IF1faD5g6+XnhuNEv7CBYvFQPNcZ+LK70Kcbf62OUhg6COOmvkNfui8ej3LxKAZeu2xE91uB+0DguYnF971Bic=
X-Received: by 2002:a05:6902:18d4:b0:e8d:7904:f065 with SMTP id
 3f1490d57ef6-e8defb397acmr2712573276.15.1753461778426; Fri, 25 Jul 2025
 09:42:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721232142.77224-36-paul@paul-moore.com> <20250721232142.77224-47-paul@paul-moore.com>
 <6e5422c4-0458-4a15-8833-462e318f283d@schaufler-ca.com> <CAHC9VhThNtGCA-jmjRagJfzPJaTh9myqFcwqA4J5Zv3ojEFDfQ@mail.gmail.com>
 <6621fbb0-fb66-4aa0-b77b-1cd0db195660@schaufler-ca.com>
In-Reply-To: <6621fbb0-fb66-4aa0-b77b-1cd0db195660@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 25 Jul 2025 12:42:47 -0400
X-Gm-Features: Ac12FXzZH4VsZDsAGPbKQw8Kv6dIfR7tsNmxsQ9bEltpRC2GFe7Nt38l4hGhaAY
Message-ID: <CAHC9VhSdLO-TdMp+oZjxb-jzuqoQX0sD-84G+SoqNwn2i3VZaA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 11/34] lsm: get rid of the lsm_names list and do
 some cleanup
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 10:27=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 7/24/2025 7:28 PM, Paul Moore wrote:
> > On Thu, Jul 24, 2025 at 11:39=E2=80=AFAM Casey Schaufler <casey@schaufl=
er-ca.com> wrote:
> >> On 7/21/2025 4:21 PM, Paul Moore wrote:
> >>> The LSM currently has a lot of code to maintain a list of the current=
ly
> >>> active LSMs in a human readable string, with the only user being the
> >>> "/sys/kernel/security/lsm" code.  Let's drop all of that code and
> >>> generate the string on first use and then cache it for subsequent use=
.
> >>>
> >>> Signed-off-by: Paul Moore <paul@paul-moore.com>
> >>> ---
> >>>  include/linux/lsm_hooks.h |  1 -
> >>>  security/inode.c          | 59 +++++++++++++++++++++++++++++++++++++=
--
> >>>  security/lsm_init.c       | 49 --------------------------------
> >>>  3 files changed, 57 insertions(+), 52 deletions(-)
> > ..
> >
> >>> +/* NOTE: we never free the string below once it is set. */
> >>> +static DEFINE_SPINLOCK(lsm_read_lock);
> >>> +static char *lsm_read_str =3D NULL;
> >>> +static ssize_t lsm_read_len =3D 0;
> >>> +
> >>>  static ssize_t lsm_read(struct file *filp, char __user *buf, size_t =
count,
> >>>                       loff_t *ppos)
> >>>  {
> >>> -     return simple_read_from_buffer(buf, count, ppos, lsm_names,
> >>> -             strlen(lsm_names));
> >>> +     int i;
> >>> +     char *str;
> >>> +     ssize_t len;
> >>> +
> >>> +restart:
> >>> +
> >>> +     rcu_read_lock();
> >>> +     if (!lsm_read_str) {
> >>> +             /* we need to generate the string and try again */
> >>> +             rcu_read_unlock();
> >>> +             goto generate_string;
> >>> +     }
> >>> +     len =3D simple_read_from_buffer(buf, count, ppos,
> >>> +                                   rcu_dereference(lsm_read_str),
> >>> +                                   lsm_read_len);
> >>> +     rcu_read_unlock();
> >>> +     return len;
> >>> +
> >>> +generate_string:
> >>> +
> >>> +     for (i =3D 0; i < lsm_active_cnt; i++)
> >>> +             /* the '+ 1' accounts for either a comma or a NUL */
> >>> +             len +=3D strlen(lsm_idlist[i]->name) + 1;
> >>> +
> >>> +     str =3D kmalloc(len, GFP_KERNEL);
> >>> +     if (!str)
> >>> +             return -ENOMEM;
> >>> +     str[0] =3D '\0';
> >>> +
> >>> +     for (i =3D 0; i < lsm_active_cnt; i++) {
> >>> +             if (i > 0)
> >>> +                     strcat(str, ",");
> >>> +             strcat(str, lsm_idlist[i]->name);
> >>> +     }
> >>> +
> >>> +     spin_lock(&lsm_read_lock);
> >>> +     if (lsm_read_str) {
> >>> +             /* we raced and lost */
> >>> +             spin_unlock(&lsm_read_lock);
> >>> +             kfree(str);
> >>> +             goto restart;
> >>> +     }
> >>> +     lsm_read_str =3D str;
> >>> +     lsm_read_len =3D len;
> >> You're going to get a nul byte at the end of the string because
> >> you accounted for the ',' above, but there isn't one at the end
> >> of the string.
> > I'm not sure I understand your concern here, can you phrase it differen=
tly?
>
> "lockdown,capability,...,evm\0" You get the '\0' because you always expec=
t
> a trailing ','. On the last element there is no ',' but the length is add=
ed
> as if there is.
>
> +       lsm_read_len =3D len - 1;
>
> will fix the problem.

Ah, yes, gotcha.  Thanks for catching this, the fix will be in the
next revision.

--=20
paul-moore.com
