Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBC81C32EB
	for <selinux@vger.kernel.org>; Tue,  8 Oct 2024 13:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392528; cv=none; b=G1zll0DvrwVD0spgHJsOAkaj+JZmXuuJzCaTAxZlqnS9mgN3Ui+YSdKiK6iVaF4uxnqXOjfX0WBEw9p7ikAauyChtBUjJWTUh2LZ1eMXuCNyi81UXnHnh/9U9HFSYrMYVnLmjMnwf32rVNANVD87QldOvN6IcaFmZHaAN5JkTQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392528; c=relaxed/simple;
	bh=WWMK04RgpgvtGwABW6Azmd4fUqlPUKb3HPPhno68bNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QbhQ1MtHRVegi2Wl3y1y1SE/2AhJFOPB7jmA5d2JDqENF+MHg0b8MsPItwvsNwTcuGiMH6UwsbpaWUqgpk1hQxEFJ9480d4jjnkMboekwXiwfKNSwIQLSIu4WRLsuFfk7HFVF/FtrugfnktzQIINgSxJfMovWIV8KSYZHnaej8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTkmfmKk; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTkmfmKk"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-208cf673b8dso61749905ad.3
        for <selinux@vger.kernel.org>; Tue, 08 Oct 2024 06:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728392526; x=1728997326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kB1EffgpNL5cT+4OWiNink4/mrU3X1SP4EcIUEGg7GQ=;
        b=FTkmfmKkAf7vzj4pLjbkM6c68IlC/u42VFju2Y2VOJDY3BntL0fguxTcUvb/kA9/ML
         /igPiHQ6e/1wuayYmthgiWcBA3iHhfu4fcuiawf2m89PvklhN6sQW8+xdkiZKO9LFZKp
         QNPdhAlUaMzBtBqlXQyb76/vNmbjMtfv/sWYdyLHN77J5kUOl0NUTM+sujG1aNWjaD9E
         SmG2Dwgf3f9slibsqlfBc8Fnhc5hQHmmkZ7i1S/mSVJN8UIIKIfzq/HXXag86HRDnQL5
         FbLsQr3d8QodjkPAS8KIjachRF0CODi8dLmCC2xRZ61TYmpzsaPwSc52mND6uerA9Q8d
         c6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728392526; x=1728997326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kB1EffgpNL5cT+4OWiNink4/mrU3X1SP4EcIUEGg7GQ=;
        b=mJAIkTG9JzvIZQ4N6g/DJiawzY5W3ozzFZ/fwViSDchRApqMUZSTPuvDztCengc6Ou
         QkTu6JZXAnpUYLxzs8TL4DZ+MZmr9M13OgKnfWvYQCpN0jWj6D7+8i1MSbp6mrcp+c0n
         xHt8Ot08oqKQdQpxeIBrFXkrnJDNEvpG7T5bf+EYQ60PgUfrBxAfXxP/ZwhP36c6WGT/
         7mEtPsVe5aOx7UD7iA+VJogF4dq9mKAD4G7D/7VxQiuyck0u/zYD5CizPv1HbD5f6RBM
         BSeiIc9boodFdtfX6DyP3u0Ab0uG3+LoCk6u77EXj5U+evr8U+gssPdI6U4AVW3RoEVZ
         gxZg==
X-Gm-Message-State: AOJu0YxcibyOboHLawDGV8Th++XeuR/7/WozOt5n1ZhGAeW81ERdb0ei
	Ufn+l698FOgO/5NGaOHH5gBiO3ER9kukkGQ2EEcz1a79xAzZ7q4BqJ0Rx9gtchAUX/S8jWwiIAK
	YweTqhx1Gfe52AA5Dbw2l7gs2wG4axg==
X-Google-Smtp-Source: AGHT+IG/ox/uDIz+RkTa/VZvz5soDszSec3ATj0ebx1rkow85jJACT1lTNYdGW+9U5FwWEgUzDo6bPjgBUbUW3z/jF8=
X-Received: by 2002:a17:90a:b383:b0:2d9:dd4a:6a95 with SMTP id
 98e67ed59e1d1-2e1e631e1c6mr19276097a91.25.1728392526302; Tue, 08 Oct 2024
 06:02:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828195755.19385-1-stephen.smalley.work@gmail.com> <CAEjxPJ4MH_r36Oy4K1Mcg4isGRQ+TC3Yr86DJV9fFOe3oddmLw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4MH_r36Oy4K1Mcg4isGRQ+TC3Yr86DJV9fFOe3oddmLw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 8 Oct 2024 09:01:55 -0400
Message-ID: <CAEjxPJ40boVZji2DZVzHn63KmNOf0MkjkS5h9eBU4CSptfSuNQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] policy,tests: add tests for netlink xperms
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnace@redhat.com, tweek@google.com, 
	brambonne@google.com, jeffv@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 9:04=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Aug 28, 2024 at 4:00=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Add tests for netlink xperms. Test program is based on an earlier test
> > program for netlink_send checking by Paul Moore. Exercising these
> > tests depends on the corresponding kernel patch, userspace patches,
> > and updating the base policy to define the new nlmsg permissions
> > and to enable the new netlink_xperm policy capability.
> >
> > For testing purposes, you can update the base policy by manually
> > modifying your base module and tweaking /usr/share/selinux/devel
> > (latter only required due to writing the test policy as a .te file
> > rather than as .cil in order to use the test macros) as follows:
> >     sudo semodule -c -E base
> >     sudo sed -i.orig "s/nlmsg_read/nlmsg nlmsg_read/" base.cil
> >     sudo semodule -i base.cil
> >     echo "(policycap netlink_xperm)" > netlink_xperm.cil
> >     sudo semodule -i netlink_xperm.cil
> >     sudo sed -i.orig "s/nlmsg_read/nlmsg nlmsg_read/" \
> >         /usr/share/selinux/devel/include/support/all_perms.spt
> >
> > When finished testing, you can semodule -r base netlink_xperm to
> > undo the two module changes and restore your all_perms.spt file
> > from the saved .orig file.
> >
> > NB The above may lead to unexpected denials of the new nlmsg permission
> > for existing domains on your system and prevent new ssh sessions from
> > being created. Recommend only inserting the netlink_xperm.cil module
> > just prior to running the testsuite and removing immediately thereafter=
.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Now that the kernel and userspace patches have been accepted, can we
> get this testsuite patch merged please? The test will only be enabled
> when the underlying policy defines the new nlmsg permission and
> enables the new netlink_xperm policy capability, so it won't break
> anything in the interim. We will need to separately submit a patch for
> refpolicy and/or Fedora policy to add these.

Any objections to merging these tests now that the corresponding
kernel support is merged?
They will only run if the underlying base policy defines the new nlmsg
permissions and enables the new netlink_xperm policy capability so
nothing should break in the interim.
