Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9883191D6
	for <selinux@vger.kernel.org>; Sat, 31 Jan 2026 02:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769825355; cv=pass; b=k3gBz99+11G/J1Dgrm9e/s5A9ruwABTzXMl2C2nt4J/07QDDIJIw/Z1IADzfpb5RV4gbAZYOtNYPQ2FCeJ/QGKCU/5GUIqvXjcseNA9/QEaMYJMQNBBWmwgUXUQ3NkWDMgDasxIDI9H2tjMuf9U8vbddxooeV2W3P39v6GJ7Qrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769825355; c=relaxed/simple;
	bh=q1+m69AC8OyppS+g1qL0airmm2fN+rGF7m5h75RejBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+BNFxKREAIksMawfrwwigPe+MVvdOInoTicJAwuGW86jXZQ1QyidN13r5mmyils9jrHsUyhaCbX9qNABf58+KzH3101FfdRSQEem61aeiGVKjeyphl1HgqVzC47NLL3sp3bqsCA2yGWYvz7WCWJ15ppfPsTbVk9lrQ36Y719m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mdY9sAoL; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mdY9sAoL"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b872f1c31f1so353932866b.0
        for <selinux@vger.kernel.org>; Fri, 30 Jan 2026 18:09:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769825352; cv=none;
        d=google.com; s=arc-20240605;
        b=OXb0sb+jb8RHGIcimaqQ+qLDAbgXSW8Jf5SUflXv4hHsN9540X5dlmZbZ7XC43FzMN
         9qM70bYtG3Ng/iqgbN4xvHXDhRS3UUZRgDH4yKfgeHnX7ehyckoQkUKoCRB3anAQUVT2
         BzGeaqLML8MIT6t4kkKpHyAEWOULl8QbdKVBy9UCeYfufqpCrKj/EpqFzKjvFq0Ut8ZJ
         0GKA9ZW9+b9Wsb6UzlFaHKHh3+UMEH4Iy8Y7sFb2UNUdQ88Grl1Fca4tMWwToA1UtRwy
         QJQyWE6G4G4FBW4IKWOWLTbBOBxj9SmeTW239yj1m6MsQZmQ+dhk/gOCSDjQopHuQR8k
         564w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fXBSGIys3SzCpVetTGHBAjMTb+eZCN0LoIysZIFKUFQ=;
        fh=r32mk2esH0PAOtSOLxAEmbIfAItALh/MSywnbmuFS8A=;
        b=MsdOLzTDoPJFwUryrVWTo3uEsJWFxLN8Nn1IbxV6oDhj4x+KB8fpB6lGAMi9yN5rPW
         V3Gk/d6AmT7fGrQMouKAp6zO5sOMXTrR+yBz6FHJgxmyHkHTdZNFtw79LTl5igd1s6gq
         QGV+HCaLrlu+y/I4OQ37fee3874y3camzl1NIigaAaMw+4dA8Vb2tr2Ff5XbRflC2/ff
         2f8Esxun8JpPaLWKdSOZv2J4lMhY7mPbfdBlhjNcnafnQn3EIILofLdSoIHK8M78EmFy
         lnxggV9YjytCiRwrp3T+b76Km9d7tl7h2IfgzAzLwQDg4k3vsVG7WVZPtA9MAtPPfkYY
         2CDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769825352; x=1770430152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXBSGIys3SzCpVetTGHBAjMTb+eZCN0LoIysZIFKUFQ=;
        b=mdY9sAoLvV09pJjCxND5Iu74NfN+XMMgrupYs9by8DK5G2zZFOokwzfRRZKmBD1gRY
         AjgQpgB5EjSE4J0xzK51/PodGanFU83GL26fHQqfL9/acxZXA7eQC4icggJ3OPvsx39F
         rYB9x3Oswo696/SSnggh0yy/9Iw7SYfPVlLnKssfKPM5puJqBDEgC8TBKfmP2p9p8y9J
         mT2bVhCFO3fDAmUxql8ri6GZjywb818fU2vt3kLT6LeM+Nf8WkTqwYY0efhXBrLT+AY4
         ERI/xwg6zoS67zkSfCmJiRPlXMmkdYhH8jWl+xYzOwFG7Hx6lv8E8XyifBvgTABOhkOv
         aGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769825352; x=1770430152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fXBSGIys3SzCpVetTGHBAjMTb+eZCN0LoIysZIFKUFQ=;
        b=iFVjXahcbCLngUQVlkhF5bn45xSKKyeuseIkuy1FqHznyJwS/V5nCIyjmO/guDE4Ke
         YnLJpX//tR4Bj5Ek3sPBqp0pmuja18J0FvIAL/TqBX54DZWNq7XuX6yGcrx3RuNBzGG8
         Ogu/vaFjqOSnx2NVhYx7bpecXT3JN28JAw400oJuCioG66lDGoHNHcUajLvTXjOszdng
         NGr/DpUhpUJA4C36SiZnDRvIl/yCxYGOifFp0FBBBplBEKo+nDG4FHx6C9YRoeKAD6PE
         J/EuU42g3hERbwoZ9iDGnt0EhDnjfM20lHoDGsyIbIoFRb2en9pXcoFERKJBumujMAUC
         K1TQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJNpOJLwchJY9+ldu2I/QxaQ+u9VQnfQIIUgTZ+r37HWxwrZYClx/iZIGSbldKpsJitSsQ/IcQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyMZniPWhLmY4U+0VNOZeXA6EgAkLHtHDspIJx4btimHRAVGtQX
	jt4exWfwr/mXxWfFtHMaKh//10/fgQiVPQodBGj9SjtII5e8mY2WTzLvLBYSHBMfwHlUS6fe/DP
	ngrk0KnekujnZKn0pZb6ian2SJX7RDB577Puq6cJF
X-Gm-Gg: AZuq6aLHrEM+IXvfTqeJ01Nn0tgWRBLuW4Iq1NQ/xMXFdqW+8UvBjQdKqD3QbOLI6Gg
	26X2Oyr/xGWbkFfynWOfYAIB8vktcFX2wvdI7hwMNjkyx/2EICC9JF5EA1Qk3wALmaXYgoYZwI7
	xV5O66UN87BA9QJFJEaqQDKRuFFSDjQ821WkIo1LjUgoaLlYJ3Y/cFBLi0JFB3G7rsegfKGZFos
	CJWYRB939tqC6b/ZjZqIpMTSEQAYMQ8eUoIZiD+GXH1Xhmi7f2nK+DnbR07X/NJTWNvXGah9AYG
	xWo=
X-Received: by 2002:a17:906:f5a8:b0:b74:984c:a3de with SMTP id
 a640c23a62f3a-b8dff5d84a1mr304116566b.28.1769825351931; Fri, 30 Jan 2026
 18:09:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
 <20260128045954.GS3183987@ZenIV> <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
 <20260129032335.GT3183987@ZenIV> <20260129225433.GU3183987@ZenIV>
 <CAG2KctoNjktJTQqBb7nGeazXe=ncpwjsc+Lm+JotcpaO3Sf9gw@mail.gmail.com>
 <20260130070424.GV3183987@ZenIV> <CAG2Kctoqja9R1bBzdEAV15_yt=sBGkcub6C2nGE6VHMJh13=FQ@mail.gmail.com>
 <20260130235743.GW3183987@ZenIV> <CAG2KctotL+tpHQMWWAFOQEy=3NX-7fa9YroqsjnxKmTuunJ2AQ@mail.gmail.com>
 <20260131011831.GZ3183987@ZenIV>
In-Reply-To: <20260131011831.GZ3183987@ZenIV>
From: Samuel Wu <wusamuel@google.com>
Date: Fri, 30 Jan 2026 18:09:00 -0800
X-Gm-Features: AZwV_QgpcNm32QTyYTJNZ2e8MpZD_azq4tiS_evKebHi_xWHPJAAyFUDpR04HdE
Message-ID: <CAG2KctoKDsfbyopQYq3-nJBg3fG+7Nrer17S6HqQ+nCWEcHeWQ@mail.gmail.com>
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

On Fri, Jan 30, 2026 at 5:16=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Fri, Jan 30, 2026 at 05:05:34PM -0800, Samuel Wu wrote:
>
> > > How lovely...  Could you slap
> > >         WARN_ON(ret =3D=3D -EAGAIN);
> > > right before that
> > >         if (ret < 0)
> > >                 return ret;
> >
> > Surprisingly ret =3D=3D 0 every time, so no difference in dmesg logs wi=
th
> > this addition.
>
> What the hell?  Other than that mutex_lock(), the only change in there
> is the order of store to file->private_data and call of ffs_data_opened()=
;
> that struct file pointer is not visible to anyone at that point...

Agree, 09e88dc22ea2 (serialize ffs_ep0_open() on ffs->mutex) in itself
is quite straightforward. Not familiar with this code path so just
speculating, but is there any interaction with previous patches (e.g.
refcounting)?

> Wait, it also brings ffs_data_reset() on that transition under ffs->mutex=
...
> For a quick check: does
> git fetch git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git for-=
wsamuel2
> git switch --detach FETCH_HEAD
> demonstrate the same breakage?

Had to adjust forward declaration of ffs_data_reset() to build, but
unfortunately same breakage.
