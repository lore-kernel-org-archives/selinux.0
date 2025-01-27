Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D49F78F41;
	Mon, 27 Jan 2025 14:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737989419; cv=none; b=IpJGZIF/mahLGrmMhJfvcr2YSeDJghoCjNM5nHLC1OlsL+IpLgmSqFa5+AQRqJ/pFcMtCAI9nGqvRrxbHvAdu4ZEkYe9Z0XflFGh9oyEAU7m/1nKfLQcs0bR2Lhe6CcnKlHOdpvGCZ6/YNemeXQCNTJ+9Xl8y4fv3VIiLrP6O6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737989419; c=relaxed/simple;
	bh=4jmummf21eCG5N7yeeWqWb8xZ7DSnhTI4KnzJZ2Brdg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=DzMuBIRGMBNtyNA8LZtV6lweSrhbcz3kfbZDSPs78fKCfggn2gHPY9Ika/J59qOKlTXUe2gguHil3o1oE65CO84itGXeF01G9cP/wQ4xSq8NHKxpbhGohNohHmjVoerj0OJhD96sehQKNpA1iFsTtoe/CLVEQNL8Ys1hp9imtjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZvylBee; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZvylBee"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4afde39e360so1156169137.0;
        Mon, 27 Jan 2025 06:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737989414; x=1738594214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+4PFphjG6BR9vrdCpxlvOY56GsX5BOUCbDC8gOl9Zs=;
        b=TZvylBee0wnmUmZb5Dw1rjWHugdMpT4Jk19QLxB1q069Xzx006zhdpcbrrt5OHX8t3
         TWgVThSJWszRHfGusKRmeeCq27y7C4D62JALk+so+uIFA85q0cvKH7in57Bm009mqyEl
         J99cuEFJh71px6z9xXrw3g9hs1BsJRyvAmSsZI6mqwtgk1yD37bHwvdAxKphva0yUJgd
         USCgLf8QDNSkJjvqpxT+BbSF/Lye2i5CtWVcaAmXtqwCdRbHasEmx8DHIEwva2Xtai9w
         HkI82kKS7CLBZdm7CSMB4nspwNr8kR2tSxsu77B8XHhoaulyTfj/GWVqaBqz+uM3Z3Tx
         c0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737989414; x=1738594214;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j+4PFphjG6BR9vrdCpxlvOY56GsX5BOUCbDC8gOl9Zs=;
        b=ZgZl4+VO6uJF/Z2zWzZjG5VDpZYbDTIV32iY+xXvGG93JxK4WrEyr3D/VbKrzSstQt
         2dNQ7QXbRQPMXvEsjXes+Urh1wpJJK9POJP6/gJqF1rGR2O5ybA1Psq5qb2raWvZpnCP
         ljZ/SUJUVG47J2pUejY97bxb3xffnZe4Ol6MsYuhasJgxmAGnhgwh8sXZ9XGyRSsdI1G
         LGx8NF1azLJr+JxuFJWNJLmkrTius07ov7eOmM5Paixhp4kI0v5wmpiaHegSIt/+kKzn
         QEHLix8EEsysUmjnfCfRlDb2C4qknMvHJfSupxXiItYAdRtmFBErl2aEX4nHrMSWKN7l
         DAnA==
X-Forwarded-Encrypted: i=1; AJvYcCUNYBUHFQ0VgcrlTihmnsc8Ee2U9ZT81264ru5u3zvDOeZbNSCRAbCgztOMz2QpU+MXLpwvhA+wJw==@vger.kernel.org, AJvYcCWBF2Os3npPTCkJjU5PaCe66UO/qWJF6lEq6VMhmaKsulC2odYW2bx1BfQETQH6xyFoQ6bTpsq/@vger.kernel.org, AJvYcCWtUtV5P/yfKmmXD16/a0089b11dvKOXxbZwpVxf84Vxx2Dg6lUryeS1dJvyH9RQvWVqXNQ4t/Vzyfy4yBibMZ23s2VZEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAJQB6AAlGEC29O8BN/HhzX4EASL7igIEC1FbUfYf5XLkLpOCJ
	KogZTZZhcq6U7TSqpphYUMsAH6gSzryOyB8aUTXf58M9i++k9HwW
X-Gm-Gg: ASbGnctfpAitHrpo/V7C2kCK8NjZWnTrfeIxNFWO5gHiu/Jtn/h0u9eG7smS0eSmePU
	zdsyJJnfSLzWDgPRXrxuvAYbeQtnzkYenr31bVTpWr+V6yaHO2J1V8QN1W2qDyp21LIGrTh0Qpa
	d05xm8aYZ4QVlcc3K4LSqz9bza+X00P5krgoxLdvhKv7kqyX1EfdIuctUVhvs4GAdW/WkrYbVh+
	zwadorQRx59paOWTJZ/3VmzrrSadfY5SaT+7fto2pzxb5tDBgatQtwADIAnLi+bAdT1PuLm9ZNs
	bvk0xLo3+87cpTPV21MREoUJdo7lx1b3hM3fKfQKegGWn39F2n7K
X-Google-Smtp-Source: AGHT+IHiPK8GERIaHyGFAwU9SeGFw2Lt/7vnkO4qXmXaLxYiJ6qqJJKmrSbn29Bn7h/SuNMzrSVk3w==
X-Received: by 2002:a05:6102:5249:b0:4af:e5fd:77fc with SMTP id ada2fe7eead31-4b690b5ba88mr36746604137.3.1737989414037;
        Mon, 27 Jan 2025 06:50:14 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-864a9af3a53sm1915095241.11.2025.01.27.06.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 06:50:13 -0800 (PST)
Date: Mon, 27 Jan 2025 09:50:12 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: stsp <stsp2@yandex.ru>, 
 Ondrej Mosnacek <omosnace@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Jason Wang <jasowang@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
 network dev <netdev@vger.kernel.org>, 
 Linux Security Module list <linux-security-module@vger.kernel.org>, 
 SElinux list <selinux@vger.kernel.org>
Message-ID: <67979d24d21bc_3f1a29434@willemb.c.googlers.com.notmuch>
In-Reply-To: <e8b6c6f9-9647-4ab6-8bbb-ccc94b04ade4@yandex.ru>
References: <CAFqZXNtkCBT4f+PwyVRmQGoT3p1eVa01fCG_aNtpt6dakXncUg@mail.gmail.com>
 <e8b6c6f9-9647-4ab6-8bbb-ccc94b04ade4@yandex.ru>
Subject: Re: Possible mistake in commit 3ca459eaba1b ("tun: fix group
 permission check")
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

stsp wrote:
> 27.01.2025 12:10, Ondrej Mosnacek =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Hello,
> >
> > It looks like the commit in $SUBJ may have introduced an unintended
> > change in behavior. According to the commit message, the intent was t=
o
> > require just one of {user, group} to match instead of both, which
> > sounds reasonable, but the commit also changes the behavior for when
> > neither of tun->owner and tun->group is set. Before the commit the
> > access was always allowed, while after the commit CAP_NET_ADMIN is
> > required in this case.
> >
> > I'm asking because the tun_tap subtest of selinux-testuite [1] starte=
d
> > to fail after this commit (it assumed CAP_NET_ADMIN was not needed),
> > so I'm trying to figure out if we need to change the test or if it
> > needs to be fixed in the kernel.
> >
> > Thanks,
> >
> > [1] https://github.com/SELinuxProject/selinux-testsuite/
> >
> Hi, IMHO having the persistent
> TAP device inaccessible by anyone
> but the CAP_NET_ADMIN is rather
> useless, so the compatibility should
> be restored on the kernel side.
> I'd raise the questions about adding
> the CAP_NET_ADMIN checks into
> TUNSETOWNER and/or TUNSETPERSIST,
> but this particular change to TUNSETIFF,
> at least on my side, was unintentional.
> =

> Sorry about that. :(

Thanks for the report Ondrej.

Agreed that we need to reinstate this. I suggest this explicit
extra branch after the more likely cases:

        @@ -585,6 +585,9 @@ static inline bool tun_capable(struct tun_str=
uct *tun)
        		return 1;
        	if (gid_valid(tun->group) && in_egroup_p(tun->group))
        		return 1;
        +       if (!uid_valid(tun->owner) && !gid_valid(tun->group))
        +               return 1;
        +
        	return 0;
         }

The intent clearly has always been to allow access if owner and group
are not explicitly set.

It's easy to see when group support was added in commit 8c644623fe7e
("[NET]: Allow group ownership of TUN/TAP devices."), and the even
simpler check before that:

                /* Check permissions */
-               if (tun->owner !=3D -1 &&
-                   current->euid !=3D tun->owner && !capable(CAP_NET_ADM=
IN))
+               if (((tun->owner !=3D -1 &&
+                     current->euid !=3D tun->owner) ||
+                    (tun->group !=3D -1 &&
+                     current->egid !=3D tun->group)) &&
+                    !capable(CAP_NET_ADMIN))
                        return -EPERM;


