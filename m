Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B1312FF62
	for <selinux@vger.kernel.org>; Thu, 29 Feb 2024 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216168; cv=none; b=tJrN/OZfYY56ohTgtRDGky7jglOGI21IyMLnW/5NqYqnWy4SYxeOzrCB0z+VMyh5IzbsOTQabVn+fARKOBUza90LHEx9GuXz8zfPbqsfMbkL5l+Ub1Z8Im6RbalHH3y4ktZuT3yB3Dygj6WhIl0AftwZ+IK2J0WozHmrJrN90lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216168; c=relaxed/simple;
	bh=VvnspcI825xzCKoZPwDhbNY6I4S7idw6AsCEFX1lh8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANmKlszpwENX72JIqBaHb6qU+2zv/r+cRr+UnPaTEdHQWtCmLw930WKrQ82bS01IsF/kpJ6LXRAswrYbTAlW2TPZoqUkgobKeaeVn6xPA27l/6RWvkJu9wOxQs6DFwgAgUhsjoyNqiDs8ROvNcuWcs8DiXIyBP6MRegaMu7Qsmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nj2H5XdJ; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nj2H5XdJ"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c1a172e46bso666112b6e.3
        for <selinux@vger.kernel.org>; Thu, 29 Feb 2024 06:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709216165; x=1709820965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+Uef7uOfpGy2SXCCH/V8U25t8tG1PXpCw2s4Mtn1ZE=;
        b=Nj2H5XdJ4W9RJU8piA3PQrZu74R01yeyiWClmpMfCzACK7FBMrPOjE+M8xJJ9o2G1o
         JUn+Rqib+5pqFdftQN4I+e/yIkegdehlXqORAAidG/GIAgLBA7QGLmHgO88EPT/BTCgU
         3uG7WTghDhBfWgROtDcHf8tfu7qx5OxMKEEIMET/J20VLEj0P1JDoRJVisIAFNWNhKhe
         8G0dLYUND5Penr2pAlyZr4sFHSSseJsaHtmwqnsyG1x663Z8/gKM9U84JUVKhv1EAoED
         UH2mVDXg199wk88fFCXubFbICtLLly9Qm+viYvfIlXomkaFTc64vy+Yqd3VmmNEjvGZY
         8yPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709216165; x=1709820965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+Uef7uOfpGy2SXCCH/V8U25t8tG1PXpCw2s4Mtn1ZE=;
        b=kIV4hJGRAFuDLlN3cFT0U1uQLou4JYYebokBw1D7XbWOqBz6oh9d2TdDQBVVLfucWY
         bXcekGaR2Lm4mRK3OnM1OPJudkjsqIZDsBSKW+LVVf1N8jT/syXltXSvQFI5NoAthbvq
         ZJkkfW/5QjwYLy0y7XjQaXvOskq4jQefGctVPnqT0/emncMp687clodDc2Sz6yU8jCkp
         VWWbOZVcXPc5JB1TbsNxIwsLKTj59tsgDkc4D9s7mYWO0L/fJ71WP2U+Z3lUheUJF0/b
         42CbLn/4a+ZDrAnDEjH0IwKZOQiEZsNDs0jr9jnbM1/l5Ji886S5RiYeqGc9kKIM0YW3
         GqBg==
X-Forwarded-Encrypted: i=1; AJvYcCVmzzbwDb4b3aLx6exdOv/Nmcpyqzuy9yDrl5gCEolLvjND62g8jlX6csJun46GIb6ZqNZ+678EdZl1z9doFp+Jjba0cs8e8A==
X-Gm-Message-State: AOJu0Yyf4MEs5NgwO/PwnCi8KRnYM8EriwvfRhLxQjpk29M6l56ZCsqd
	nbbsbakcG0VOvIpPN0olmCU99c2Qmpm4l7Yd1PcUcb4hsnX/Kb6fkYmg5Xuq5YR9F6Hq47Y+NKj
	b/MG+bXKcw/S7NvdGsuspVICujKtXYlA4
X-Google-Smtp-Source: AGHT+IEEh3OYcpu1Ra7n/NEi+hBa4p9/xiotG9VKDAKmQrUYgUlHyA7RuoIhDrts9BmwELHGzSur6Ei3YDvVl00lFM0=
X-Received: by 2002:aca:110a:0:b0:3c1:5f25:1447 with SMTP id
 10-20020aca110a000000b003c15f251447mr1961950oir.57.1709216165603; Thu, 29 Feb
 2024 06:16:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207150003.174701-1-vmojzis@redhat.com> <87zfw3dl6k.fsf@redhat.com>
 <fcac920c-7bd1-476a-88dd-478b1f3992a1@redhat.com>
In-Reply-To: <fcac920c-7bd1-476a-88dd-478b1f3992a1@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 29 Feb 2024 09:15:54 -0500
Message-ID: <CAP+JOzRu7WMLz4nzg-USfoBvsrmYLZxV0NEqdG3x0ySw6NN3RQ@mail.gmail.com>
Subject: Re: [PATCH] python/semanage: Do not sort local fcontext definitions
To: Vit Mojzis <vmojzis@redhat.com>
Cc: Petr Lautrbach <lautrbach@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 8:13=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> wro=
te:
>
> On 2/14/24 18:12, Petr Lautrbach wrote:
> > Vit Mojzis <vmojzis@redhat.com> writes:
> >
> >> Entries in file_contexts.local are processed from the most recent one =
to
> >> the oldest, with first match being used. Therefore it is important to
> >> preserve their order when listing (semanage fcontext -lC) and exportin=
g
> >> (semanage export).
> >>
> >> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> >>
> >
> > I think it's good approach. I just hit the following ui issue:
> >
> >
> > [root@localhost ~]# semanage fcontext -a -t httpd_sys_content_t '/opt/s=
elinux_testing(/.*)?'
> > [root@localhost ~]# semanage fcontext -a -t httpd_sys_content_rw_t '/op=
t/selinux_testing/webroot(/.*)?'
> > [root@localhost ~]# semanage fcontext -a -t httpd_log_t '/opt/selinux_t=
esting/logs(/.*)?'
> > [root@localhost ~]# semanage fcontext -l -C
> > SELinux fcontext                                   type               C=
ontext
> >
> > /opt/selinux_testing(/.*)?                         all files          s=
ystem_u:object_r:httpd_sys_content_t:s0
> > /opt/selinux_testing/webroot(/.*)?                 all files          s=
ystem_u:object_r:httpd_sys_rw_content_t:s0
> > /opt/selinux_testing/logs(/.*)?                    all files          s=
ystem_u:object_r:httpd_log_t:s0
> >
> > [root@localhost ~]# matchpathcon /opt/selinux_testing/logs /opt/selinux=
_testing/webroot/
> > /opt/selinux_testing/logs       system_u:object_r:httpd_log_t:s0
> > /opt/selinux_testing/webroot    system_u:object_r:httpd_sys_rw_content_=
t:s0
> >
> >
> > If it's first match, I'd expect that both would be matched with
> > '/opt/selinux_testing(/.*)?' -> httpd_sys_content_ >
> >
> >
> > [root@localhost ~]# semanage fcontext -d '/opt/selinux_testing(/.*)?'
> > [root@localhost ~]# semanage fcontext -a -t httpd_sys_content_t '/opt/s=
elinux_testing(/.*)?'
> > [root@localhost ~]# semanage fcontext -l -C
> > SELinux fcontext                                   type               C=
ontext
> >
> > /opt/selinux_testing/webroot(/.*)?                 all files          s=
ystem_u:object_r:httpd_sys_rw_content_t:s0
> > /opt/selinux_testing/logs(/.*)?                    all files          s=
ystem_u:object_r:httpd_log_t:s0
> > /opt/selinux_testing(/.*)?                         all files          s=
ystem_u:object_r:httpd_sys_content_t:s0
> >
> > [root@localhost ~]# matchpathcon /opt/selinux_testing/logs /opt/selinux=
_testing/webroot/
> > /opt/selinux_testing/logs       system_u:object_r:httpd_sys_content_t:s=
0
> > /opt/selinux_testing/webroot    system_u:object_r:httpd_sys_content_t:s=
0
> >
> > And here it looks like it should match webroot, resp logs.
> >
> >
> > So it's first match but from bottom to top. It kind of make sense as th=
e
> > last added item is at bottom. OTOH people generally reads from top to
> > bottom.
> >
> > What do you think?
>
> To me it makes more sense to leave it as is, since the fist added item
> is at the top (same as file_contexts.local file).
> The man page also says that entries are processed from the most recent
> one to the oldest, so you should read them from the bottom up.
>
> But I'm happy to reverse the order if you feel it will be more intuitive
> for users.
>
> Vit
>

The order with the most recently added item at the bottom makes the
most sense to me.
Jim


> >
> >
> >
> >
> >
> >> ---
> >> Not sure if this is the best solution since the local file context
> >> customizations are still sorted in the output of "semanage fcontext -l=
".
> >> Adding a new section for "Local file context changes" would make it
> >> clear that such changes are treated differently, but it would make it
> >> harder to find context definitions affecting specific path.
> >> The most important part of this patch is the change to "customized"
> >> since that stops "semanage export | semanage import" from reordering t=
he
> >> local customizations.
> >>
> >> Note: The order of dictionary.keys() is only guaranteed in python 3.6+=
.
> >>
> >> Note2: The change to fcontextPage can only be seen when the user
> >> disables ordering by "File specification" column, which is enabled by
> >> defalut.
> >>
> >>   gui/fcontextPage.py         | 6 +++++-
> >>   python/semanage/seobject.py | 9 +++++++--
> >>   2 files changed, 12 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/gui/fcontextPage.py b/gui/fcontextPage.py
> >> index 767664f2..c88df580 100644
> >> --- a/gui/fcontextPage.py
> >> +++ b/gui/fcontextPage.py
> >> @@ -133,7 +133,11 @@ class fcontextPage(semanagePage):
> >>           self.fcontext =3D seobject.fcontextRecords()
> >>           self.store.clear()
> >>           fcon_dict =3D self.fcontext.get_all(self.local)
> >> -        for k in sorted(fcon_dict.keys()):
> >> +        if self.local:
> >> +            fkeys =3D fcon_dict.keys()
> >> +        else:
> >> +            fkeys =3D sorted(fcon_dict.keys())
> >> +        for k in fkeys:
> >>               if not self.match(fcon_dict, k, filter):
> >>                   continue
> >>               iter =3D self.store.append()
> >> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> >> index dfb15b1d..25ec4315 100644
> >> --- a/python/semanage/seobject.py
> >> +++ b/python/semanage/seobject.py
> >> @@ -2735,7 +2735,7 @@ class fcontextRecords(semanageRecords):
> >>       def customized(self):
> >>           l =3D []
> >>           fcon_dict =3D self.get_all(True)
> >> -        for k in sorted(fcon_dict.keys()):
> >> +        for k in fcon_dict.keys():
> >>               if fcon_dict[k]:
> >>                   if fcon_dict[k][3]:
> >>                       l.append("-a -f %s -t %s -r '%s' '%s'" % (file_t=
ype_str_to_option[k[1]], fcon_dict[k][2], fcon_dict[k][3], k[0]))
> >> @@ -2752,7 +2752,12 @@ class fcontextRecords(semanageRecords):
> >>           if len(fcon_dict) !=3D 0:
> >>               if heading:
> >>                   print("%-50s %-18s %s\n" % (_("SELinux fcontext"), _=
("type"), _("Context")))
> >> -            for k in sorted(fcon_dict.keys()):
> >> +            # do not sort local customizations since they are evaluat=
ed based on the order they where added in
> >> +            if locallist:
> >> +                fkeys =3D fcon_dict.keys()
> >> +            else:
> >> +                fkeys =3D sorted(fcon_dict.keys())
> >> +            for k in fkeys:
> >>                   if fcon_dict[k]:
> >>                       if is_mls_enabled:
> >>                           print("%-50s %-18s %s:%s:%s:%s " % (k[0], k[=
1], fcon_dict[k][0], fcon_dict[k][1], fcon_dict[k][2], translate(fcon_dict[=
k][3], False)))
> >> --
> >> 2.43.0
> >
>
>
