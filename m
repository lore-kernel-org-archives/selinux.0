Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9005140B38A
	for <selinux@vger.kernel.org>; Fri,  2 Oct 2026 19:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790969868; cv=pass; b=ObxXdxsxVs61wW+kzDB3mKnxnYouBJdpKIe3pz0w7/jY/6lvHLvavfJnftNj6WvJI4g06HtlVPuhjAT2y/xl7E5WuEkhDbokwVkjnk1IFLYA49NdgdP4GVIo9iH7JPXTYlEUyBP99IpvSeXpqqG5pRHoLXMAXJzBgIbosE3K7Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790969868; c=relaxed/simple;
	bh=jsa8p0PenOQe7xz/Cc2uUWiwjzhWN4cfUFkjzNzzRgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CuWbi3hdOGlK4v/Nc3LERjSlV/GVb5exzsUezlkKrNHZgrctDJB7qGnHsKdovqmgCokQvVUizWwTyHzzIsiwMpt02UuJ5cUdpoNFdpLe8P/Sum6rvxyJMZvmq5ayOkk2CEdmTvLBrRcLeDRasXCs9xpGDyivHyxHP4qPx09ydqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuC5NDEd; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuC5NDEd"
Received: by mail-yx2-f40.google.com with SMTP id 956f58d0204a3-6756a6320f6so351326d50.2
        for <selinux@vger.kernel.org>; Fri, 02 Oct 2026 12:37:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790969859; cv=none;
        d=google.com; s=arc-20260327;
        b=qHwiF4y3iAerxjgU8LdChs0IlZvSB4ja4AEBT7iVfwfxjhCEVU391gDCXU9eE2Wj/d
         NA6ifl+T+MX4wgUYXDz3FSWepnk5huTgOEkQWTcDWYZfOLkPreUEei5JeEgktSyRZIdC
         d1JZamDwStlalcLo51ArQF0UpGBd5+7itdY84YEi4TwJZB7Nzvu+MOEH5zUDytvahMKl
         +5JNoXvmLeYP2byVeJg6AsQNspHArFFDtmwHW1/zW7Q2bQC1+sFWdFAkahsL7L4IgjX1
         jXhqdg6VlF24f3RiPedPJJDlh+aPDAGSALUwBJ7sPYA9qlzbEw9Cd2YU75eXkjADg4s2
         LbGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jsa8p0PenOQe7xz/Cc2uUWiwjzhWN4cfUFkjzNzzRgk=;
        fh=E95boLTiTkq8XsjKw8GK1wyz25DmW0RgNCvDUxEAbME=;
        b=bf7y49q2IiahTFtFWtxRv9nU7n3sJEJ3/zHjzNJPeJ+1kMpOoOf+WZ7NQe3Y7b5Ukr
         HiTlOJ/3xkpOlno6rIfwGAAFABRucwRiQcDTrtrIHjw8PWTw3u95f3Qi4IFNU4/HNn0G
         nharVwPvkaQEmp9QGedl63M4adJFEOA1Y7u/OZKQNri+PX9IDt9Mi0bxDyivQsYh7/Y6
         1a/3q138i9uO2LnRxlC4+rk376grn4p08GDLFYjaZJTa4oiwihva3M0FOFVz5qMRsqUK
         nOsRIlYQMhrLmGxvRJEx8RtTwBks6orpgpb6YLBcd0GiCS9ZOPNz39gveExXJ3zQvZI0
         6RpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790969859; x=1791574659; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jsa8p0PenOQe7xz/Cc2uUWiwjzhWN4cfUFkjzNzzRgk=;
        b=FuC5NDEd0Ey0MJ5HK+kee1VQxi1zD0bNqORH8mZqD6HLv471xPdd0JpTqocoNdBu/1
         D8vQhACWIdhaxST+vVUC0IsTfA3wh5dhrrZBbhGMQt0r4NygAvMX5lxj1+tjF5ABuiBI
         YDWrnv3cp1XhV41y4JmWPo7Oe9QNu+JDxkqafltaEYgYEp2jXCU9k5nAcHXp45wHlve6
         gcFru6t1bmjn7bc8p72D/mtel1foMG4XKU3N7EKCDxtUjy7Mlu7U5hc93FLI7PMstZvt
         ON7Ee93OUGHxjEmnx1A/IAX/K3oUjh5+NWcwe8IOPpTh8Z/cOogaBR7LSY36duJ5g7J5
         theQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790969859; x=1791574659;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jsa8p0PenOQe7xz/Cc2uUWiwjzhWN4cfUFkjzNzzRgk=;
        b=i3BGXGQr2DSYyf6VLvyaq1H8Tzw8PvO/CLXSsAnVfiPJrqYlCXyEW535O0vgW+Plyk
         fmptk4CAeLu7Vxe0DvnCQBdka43Hfd2FTbnzuENG3R0Rg73U5A/zoVv6BQJKHQkwYTtD
         wbKx2tu6GOR7U608JDxDREQhixVUYYtCF/lgfhTlYDha54lY63IpDUQ0CrD1p9WpZlqJ
         yleWueH77cVgEBwXe2Wdul7v6dKHckkYbpkaemMRKZ3XfqKQ/X5KpdD8Brmd475wlRvA
         YO8hRsmC9zbfJfHOFHdmAUaevVXav/Sh1q6/2nyZ8To6ltt89HpSuz80Dw6byiQiDI6/
         rJlA==
X-Gm-Message-State: AFq9FYLQBDKNGMxSg3TmFpHyf59e/J63bPf27GJ1GDsIJRzJ+FdI5KS8
	I2zGNvU5fTPcDoSVYGdD1Xf7j/4c/YIZ8uZ51nSCj/Nc+R7hFMyW3pdY8A2vCSZZemZidErnhrM
	Zk1RFyd5spi3mt8CW21VmVAr5+QTwk2o=
X-Gm-Gg: AYBFou2DOK4Hd8fc+4kGTiQOgDuTeDwg/i5Xjhu7/ZU+aNFj8RbTJeiAHL1U5OdYR4Y
	QBjCMxN5kBNzsE33Ph4l36U3qQkclg4csi+48XugrZv19wPZP65OfdsUZVNzext/J8ZEKy5K7MG
	P3LbSVM1Zlymukm+Ic+BydVVV6hSAfeBj2nTscAncVPbwawOscbLOrrdKWsRuJipgqBVzWEGFyF
	m6CqiSlh0jLf/kHSo2ICzp9GXI0v4Dh3X8PsSXJ2kLmhBktBy8xRlfRWIhlUeYAo7zfi/FhF8FG
	ISaI2huicU4mLr2jy/euIucdWpOjJPMjVaR9bK+7JE2cPZv0bGyp9g0=
X-Received: by 2002:a05:690e:11c1:b0:677:bf8a:e4d0 with SMTP id
 956f58d0204a3-677bf8b223cmr16722d50.9.1790969859348; Fri, 02 Oct 2026
 12:37:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001153212.102261-1-bgrech@redhat.com> <CAEjxPJ4W5g6_938rr4k7Bmgm9Mq7HpL=CfasPZ4SEtr3YYFobw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4W5g6_938rr4k7Bmgm9Mq7HpL=CfasPZ4SEtr3YYFobw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 2 Oct 2026 15:37:28 -0400
X-Gm-Features: AclHuK-GZ4Qer7DNyR55XaH_ZcunMX7lAoi6OuS6Cw2MBdwI4YQPI0hTnGUuaD0
Message-ID: <CAEjxPJ6tyDPdezn00rEb8fCiz8x8m8XqJtnTrbexKkWuhewFYA@mail.gmail.com>
Subject: Re: [PATCH 1/3] tests/netlink_socket: skip iscsi subtest when
 NETLINK_ISCSI is unsupported
To: Brian Grech <bgrech@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 10:05=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Oct 1, 2026 at 12:22=E2=80=AFPM Brian Grech <bgrech@redhat.com> w=
rote:
> >
> > test_netlink_iscsi_socket_t's ability to create a NETLINK_ISCSI socket
> > depends on kernel support for the iSCSI netlink transport. On systems
> > built without it, socket(AF_NETLINK, SOCK_DGRAM, NETLINK_ISCSI) fails
> > regardless of SELinux confinement, so the create/deny pair of subtests
> > fail without exercising any access control.
> >
> > Probe support unconfined before running the confined cases, and skip
> > just those two subtests when unavailable, leaving the rest of the
> > netlink_socket tests (netfilter, generic, crypto) unaffected.
> >
> > Assisted-by: Claude Code:claude-sonnet-5
> > Signed-off-by: Brian Grech <bgrech@redhat.com>
>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This patch (not the entire series) has been merged.
