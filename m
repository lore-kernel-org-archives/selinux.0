Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63212FD1DC
	for <selinux@vger.kernel.org>; Tue, 27 Jan 2026 22:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769551623; cv=pass; b=cjDKd5gDl/MRvSJACGcGBa3lELvQbk7ybexPI6M+57tOcO76ag8BQ+xd6QnHNkOVYF3k4QiyAFYW92GpXcusJJky38gtnNbGGGA5gna5MBx0xre8MnD+sMHKnvMT/z13/2vtLmSkXs0MFjqxvVXdhpIRZLHJyTx2dAH8TRIhPiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769551623; c=relaxed/simple;
	bh=XKfjnHsBZAYgJApNq6t6VLNpHjKp5fSp10j9/3sDWYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rPer7nkZces5PzUvsMneTTx4ervro2Y/WzAc8Y8gOnkcBtwSd2IVAYBOpw7o/bGXdVB0GWGXhdNXoQ7pC4o7ERrwaMEpAKhuvRgVYyXt9O6KhcJVyijYzZTLiE30cQVCXpQeoId8pojzbRYi24d0586zsK7rhAMdh7FNPs9uAV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LhtTuf5R; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LhtTuf5R"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c633984fbeeso108387a12.0
        for <selinux@vger.kernel.org>; Tue, 27 Jan 2026 14:07:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769551621; cv=none;
        d=google.com; s=arc-20240605;
        b=fL0av2dWlatLmCNPR6cnzbKLavSMqa5TO3Rn4FVIXU9XUCNORUaaoPXSPq4BkY1uAs
         A6X8I7NTGXhNfcdlZ3x0qVzVpT4h+Se10tmCgTsb4vb2e+chmUH9WMsbNH9p+rZs2owA
         /VmVNxEJXYy74xS9PcIObZi5v5tnuJwBhWzyGz2yXLIaL1A8HR7hOnvbDnsxJ5aU0oXd
         Zc/KNpnMzz2XwJ10rqIdbr5qdcmBzZ/8d+P8eSzwhDavpwgOu9N6cFGkCZXtT8uertGF
         2FnqXuxViEk4TSgrFdRy8bdTZtSGYkcWCzq6dwQ2OtcKNjYhqVxHGyaRrbgP2dJZT0mi
         kxXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZE0HZ09BWMy+Q/V9UHBO/lkHNdcHXcIuvBmx4T0PBPk=;
        fh=yTeRVZQkzpZJy+G5XmFjEbRwvKQc3erhbH4eLsxRtFU=;
        b=R8t5wM0B3O8A1L2/EIGj0ZVLWaAjpvTwWZi/WzKc8AuvCP8j32PEGAaJt4AwN30pQV
         OCm+PUXsDd1UsKgopPrTptDrEhhTFDnknMJFcQQwr3Z31XqVHDIRnG0OR+KKRTXTXRmu
         IzqyMMoH/ny6Pufm0zQB3ExYjVibqhC8T27xxYQNrr80A/piXE24bfSdMGp4u0FMSEf6
         3U3K1TyFPnuS/2pFWPpW2m8OMd4+Kv5zyR0kOEBo7De4mxzH0Vf9ae0V8iDti8TVKz3y
         TQoMyl84w3JgGqK1Kf8JLRcSRfZDD+Kx1H4Tdox9epljHLgtbHwpjVSGXbdlY90ycTf/
         hiIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769551621; x=1770156421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZE0HZ09BWMy+Q/V9UHBO/lkHNdcHXcIuvBmx4T0PBPk=;
        b=LhtTuf5RUDlpqAv5u+/zkhzGd0Hxb6pivngVsQMBjk4UhC8h//Xe1n8gW2DWsySgiI
         Dm8OYBRjpMc7aSgsO0xqCubEx57D5gjKZv69WtLFtLxn8/cI93roN0b89R81zApTcSMm
         JgPVR5ljI5qus/3mKrFQ2ci8U7J1Lz4ql/oVNEg4+Kq8SldEOzaObts/nosoFi+OsIpJ
         TTzAa+VXC62y1BRwV8+taXqaD78gjIf/0qMLoHFwxhCWu5bHPEQiTOkaRoLiDaJMfYGm
         7PXfmc/Fx9ZYIcT/HA9b6bFsgqdqInwsFXWnejNDmb42gG8zecV4u5/Gc26jV02DcodI
         C+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769551621; x=1770156421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZE0HZ09BWMy+Q/V9UHBO/lkHNdcHXcIuvBmx4T0PBPk=;
        b=FBw6U07bENyMM09709ErlWbmAxYvClFSp+H4D9PPEmMU/ZlF3bFCvQRajQCnOnkURe
         c2eCJer623oEv52FxLBgtwHXD1Fnk8lWpcuQHv6T/CvD7+EgJmcSqgQ3at3hssg+0/pT
         zDuwJXyQ1vR5ZIpgR2Z9aVDLG0XeS4dOCtnRqgpfbwXXccmY8KFUGC6URQiySnz4mPNC
         IyfZP4bV29OWrFIf5xJYk15urjnH1CgTctYVKghz8vKUB21+fy/R1o0N5GPxn8TmXR2A
         QYKW83CNTJknFSzuzBHhsC1yqKgYmxTOTRmzKPzeium9d6fOfYuW6Hvyf22kUI1eiBTq
         ylOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFG1swndjLkXNjdH5bjUAD6BWcUEmwrqFL2WyE/XhcxloLDe/fL9L4hlwsPYTYt73DMQe8rZdF@vger.kernel.org
X-Gm-Message-State: AOJu0YwShMavIuofJQPA6NZ1g9LY8h8la2kHB/Ol7kfw5n/CYZMGyiHn
	LsdkRL+g2XtMMm89qpwaYXWRi8FBf24pyFD8fM1Tq6StWx9eNmwNVOaDHoX4lZ9d06fZ4hUy+lu
	MZ4ST4q13kW16Ba2X7slLXG81stxRShqPZJACazLJ
X-Gm-Gg: AZuq6aJXXaOyyx6a2b47JvUmDsWe+wd1Wg6Gdbhqc4y/xD1+zPqiAEKZYEoW8srBxHx
	0kJgCdjbG7R2VZC4C/Jo9iZr2G1d0HaWAq/InA3siMPmiT1bDOjePaRnCTz91Yql1JaIJo4Rtc8
	ut4WvuOeUX/5CCoOo47GGMWoSULZNU34rfHE45xq8q50pCBIf24ll9ayFnZ6dwskVQ70tTdSpPW
	LXM2aePbVIRFWPA6Hg/Y6M2YcQCBXAA+ZYwcMyAglgIdWRMfYoBoQ7FAfBj1Ux9NqGrQmg=
X-Received: by 2002:a17:902:d588:b0:2a0:b432:4a6 with SMTP id
 d9443c01a7336-2a8712f2a71mr34602905ad.15.1769551621104; Tue, 27 Jan 2026
 14:07:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122141303.241133-1-omosnace@redhat.com> <CAHC9VhQYLJVweDgBkRo=0_kS1TAUQH_YfT+woSfBW0SjUO4nqg@mail.gmail.com>
 <aXgcd81ktMaAHhwj@mail.hallyn.com>
In-Reply-To: <aXgcd81ktMaAHhwj@mail.hallyn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 27 Jan 2026 17:06:47 -0500
X-Gm-Features: AZwV_QhrzCWyWyOCOztscIRZCxotOlDxZzu489IoZSksCt0ceKp2sRAbzStURrM
Message-ID: <CAHC9VhSLi2-TBUyayML+tAuC+XF7jCAAL48oCB4qQqTrGXcMyA@mail.gmail.com>
Subject: Re: [PATCH] ipc: don't audit capability check in ipc_permissions()
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Eric W . Biederman" <ebiederm@xmission.com>, Alexey Gladkov <legion@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 9:01=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com> =
wrote:
> On Mon, Jan 26, 2026 at 05:50:12PM -0500, Paul Moore wrote:
> > On Thu, Jan 22, 2026 at 9:56=E2=80=AFAM Ondrej Mosnacek <omosnace@redha=
t.com> wrote:
> > >
> > > The IPC sysctls implement the ctl_table_root::permissions hook and
> > > they override the file access mode based on the CAP_CHECKPOINT_RESTOR=
E
> > > capability, which is being checked regardless of whether any access i=
s
> > > actually denied or not, so if an LSM denies the capability, an audit
> > > record may be logged even when access is in fact granted.
> > >
> > > It wouldn't be viable to restructure the sysctl permission logic to o=
nly
> > > check the capability when the access would be actually denied if it's
> > > not granted. Thus, do the same as in net_ctl_permissions()
> > > (net/sysctl_net.c) - switch from ns_capable() to ns_capable_noaudit()=
,
> > > so that the check never emits an audit record.
> > >
> > > Fixes: 0889f44e2810 ("ipc: Check permissions for checkpoint_restart s=
ysctls at open time")
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  include/linux/capability.h | 6 ++++++
> > >  ipc/ipc_sysctl.c           | 2 +-
> > >  2 files changed, 7 insertions(+), 1 deletion(-)
> >
> > This change seems reasonable to me, but I would make sure Serge has a
> > chance to review/ACK this patch as it has a capability impact.
>
> Acked-by: Serge Hallyn <serge@hallyn.com>
>
> Thanks - looks good to me.

I don't see a dedicated IPC maintainer/tree, do you want to take this
via the capabilities tree Serge?

--=20
paul-moore.com
