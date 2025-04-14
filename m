Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4EE26E145
	for <selinux@vger.kernel.org>; Mon, 14 Apr 2025 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744642857; cv=none; b=BHBWmv9Hen+Ex021LGR0pTJjX2AgLJJ+5QHIBBqHYHTjMjAiCAgC9H+tNTs3HYmfT3TZCpHqcgpnAuEwqtfidkLehOkbjl5dbygUq+Qyss6WLzpYgKhJJzVYW94XF545nQCtOpAOECZzbzJgcXGbIK+pHmx6PvWbtlu5Noe2oZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744642857; c=relaxed/simple;
	bh=jkpNBixp8PtoZfE7mFZ2PCIw0yuvgXSJYTulvOyGWqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7KMx0NKbXZwOf4peD/1wrlgxENBRGnyjzaYGtQgsdKkzAwA7CieXfSW9yIl5jv1DlTOYT1C+UvzVMJmboSZdWS+xQLngD9byVQ/9duU5vPL0bHPj9X4q9mJzZPBuHMeFM5mcm3JLg2sXHJcu4k6q7plKGFlpPfvtV/cqm4AFYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fLoB1ks2; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fLoB1ks2"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-86135ae2a29so413016339f.2
        for <selinux@vger.kernel.org>; Mon, 14 Apr 2025 08:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744642854; x=1745247654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nS4mARlb9lbPzVo8RPz8W4D3l8CsNnWBBA+Qm/k0dyA=;
        b=fLoB1ks28ckgWPtOglWLXeKEibsnkMuSQ85jTQXT/3oIkDpvH5HNKGwKAx4ORgUTDS
         gVv8aFuxEiesmeWMbBpR3j5jmyXeGwl+uau7Frgv6OHUgto9ntDNDAGbowah+eOU+z0H
         mA9pfzbNkQo5+8gNNmuKjbxA+mh3I7c+yZ7rGcYUDNVzjKabUSTi7dBd30K3uotgMDcU
         fHc2XctQPDH0z2W2N48P+bBO3k9S6/jN5hCvYlQgJL9KPicbDK9z5phF4Td+kdSt45hs
         X6zNLIZ5AxoSqgCTLi2/wRLZYZFKr0cLN8DDv1wrq7VbQuycpLNUwKUlXKeIdBXXFgHC
         MneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744642854; x=1745247654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nS4mARlb9lbPzVo8RPz8W4D3l8CsNnWBBA+Qm/k0dyA=;
        b=v/c3qnHP0RDpmGj7wWU9RHfdA6hIjUpgg3f13BUvXBtU8ANjV5HOp/FSgz8M2uXc0Y
         E9y/NIvbMYhStN0eXWDLurdUVa3g3vtk44pRwwpozxNW6gEtMG6gHKqK3WmOs8TqJUJI
         0xb3cYhuNyFaYPEF75x/Pt8xappbeAVb5lhL31tcRN/xwS3xBCICxYAbCYLZncb59jqB
         jsGrkzJQDCAWcMv6AyM1xvxRIStKhGsgKjWGS00q0GTIYfvr4hweyiyZzFxIXuo044ai
         JkAfRV3NZ53+PzmSeqhCNqUaNKEFL51G/MgiED75W5UGq1f0H40FUnvMt4V1K6DeFyvY
         nkTw==
X-Gm-Message-State: AOJu0YxD14dkqGrWe6ZsaZKtqZZ5qVkcaYMO9FWzBChG6f8JKZVlUGsm
	WmoyOFWPIB8lsNHtBZ5YZ+iWb7p4wnJukt4HIdJqO7jtBfcYgCm93ZmGY1XMbtZBo+xnjEQi1lZ
	Y/s2/yM01ddD4tLFrDYsvj0EWFlb43z8QJaj8x0/+Esx22a4=
X-Gm-Gg: ASbGnctMJkrObUnPu8hQiubveNNihXVqt4wNz3Mo5Kzhbc14oq0i1qvAvraZsBjFCwV
	JNAroAq3p2hgNLTj2HFbxt7u/A3ROxm4q2aIDdDgbTrzdSJmqoZSR6RzaVz6yJI6H8opZN4tsUF
	sVv/UAh2mYRHNQTL5Rn/dc7w==
X-Google-Smtp-Source: AGHT+IF9TErtcbXo8L8EuAgE01VDKQ3pHeSUxuKeVOWYjaPbfU3vFZM9slG9wzj+TuwzwAXa6NHnUIA+enhmcSWrvBU=
X-Received: by 2002:a05:6902:e82:b0:e6d:f048:2b65 with SMTP id
 3f1490d57ef6-e704deced6fmr20013476276.21.1744642842406; Mon, 14 Apr 2025
 08:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410191659.255003-1-paul@paul-moore.com> <CAFqZXNuY=Gr9wFPdNpY+Pf4=LFKK4v+phh_AGdRRFb=rUa=h2Q@mail.gmail.com>
In-Reply-To: <CAFqZXNuY=Gr9wFPdNpY+Pf4=LFKK4v+phh_AGdRRFb=rUa=h2Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 14 Apr 2025 11:00:30 -0400
X-Gm-Features: ATxdqUEfURMBAxaKbz9Q2gG2yk1GIEbhn71mrWLzm3ghhQ0PL9yhHaPqWG_dVZo
Message-ID: <CAHC9VhQZrip8qOsFemxJMSzckBcACOJ=LMMMLN8X2YSxhbTagw@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: don't override PATH variable when
 running tests
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 3:43=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
> On Thu, Apr 10, 2025 at 9:18=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > I have a test system that requires a PATH different than what is
> > embedded into the test suite's Makefile.  While there is perhaps some
> > risk in using the caller's PATH in the test suite, given that this is
> > a test suite I expect that the caller would be aware of such risks.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  tests/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tests/Makefile b/tests/Makefile
> > index 35bb35871b48..7a6aace180db 100644
> > --- a/tests/Makefile
> > +++ b/tests/Makefile
> > @@ -184,7 +184,7 @@ all:
> >
> >  test: all
> >         chcon -R -t test_file_t .
> > -       @SUBDIRS=3D"$(SUBDIRS)" PATH=3D/usr/bin:/bin:/usr/sbin:/sbin ./=
runtests.pl
> > +       @SUBDIRS=3D"$(SUBDIRS)" ./runtests.pl
> >
> >  clean:
> >         @for subdir in $(SUBDIRS); do \
> > --
> > 2.49.0
>
> Seems reasonable - applied:
> https://github.com/SELinuxProject/selinux-testsuite/commit/122484a43291ed=
ebc5a7c552f455ff35d0e01d95

Thanks Ondrej.

--=20
paul-moore.com
