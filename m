Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967F82DC340
	for <selinux@vger.kernel.org>; Mon, 22 Sep 2025 03:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758511397; cv=none; b=Gr0Hq5R9BRbDKFoqI00LzhPubLlDY/h+rkWNtk9k2KnZqn0OMTYHII1zi+B8mgfL4daHtba/Iivsjoh9AFXN+/s41OukNqAEsTMSxK5XK7pIpXjdFNuIt3glmIaZhzE27B10+6zwqyBPKo3UAtmtqbOwzwAAKlSl3DXqYCcn3V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758511397; c=relaxed/simple;
	bh=E/dcBmckf6s1cZOcdU6ceCyBy/PBSN1afXth3Qkt/8Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=irRq+iTJV5XgKH50HYVmflDhIpE+CKyWHSALojByqT0QUkbBAj4vLOAqsbO6CXHqKajRxlLB2x0P2OscE/jztOj3S9Ufg7cGgwjspPep9U6AyuLNR7GmcKtUZ1/eMKWwDFrOXFWARA5UrWo6PsOMs2+S4ICVOkrycClWZIpRFdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qowVR7c1; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qowVR7c1"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71d603cebd9so33888077b3.1
        for <selinux@vger.kernel.org>; Sun, 21 Sep 2025 20:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758511394; x=1759116194; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3FlwsER74cYqV32Cx96ZjhaczFHdoR+YcDNoqEmBa/E=;
        b=qowVR7c1wGXttdppv0v+Qj2ehmTK8srHEVnlX7swybKJd06q6F94qMZF5MhNh6bTWr
         Nn6LLwpK/GTwBXtcsySpNwC8fHZ958GocyVQiAgdDtCfwl9ofAQWSWHE2Muo6Q4kVB2V
         jQ9m1Q8+2zVYi/deG63wi3pWnjYoqFl9hCPUTJftoZoHph9bkUmUeOnW3cry8OjjPeD3
         N+iA6xdctGMlg3wIci1+qoHsY5BCE7AalDYINP72w6cFWp5QfibN9BUTrPPnmEEcjQRd
         Q0T1wFqooK7VH8QD5HOXZhDYcpV5WOr9K+xxPz11Wg8WtWrTasU0hBJ9GffL0bl360pT
         pDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758511394; x=1759116194;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3FlwsER74cYqV32Cx96ZjhaczFHdoR+YcDNoqEmBa/E=;
        b=LPHPkdAihFgjYyQd2kMR7tVlwSrPSG96iF1n8/NNR9bgHGpge4+CEAhItyhLdfRcZH
         B6ie2bNCPEnQUfDJMcoANqrT0BcGgrdEjgyOCh2Qb1QIwlw6sPqYJLRHOO/X8C3MLiSX
         e1W8KTjZYMC2TS2d3kTbpnPVl3INFdbffJfNSziD+wMvaOABn1MyR/jiHTlbH4gdMHyO
         Ydd24VX9P4b+bjA8s/+FxTwiecsrDPKpGc1AwC4jvxjoQGmaEa/8uVbwFhnDblwltTxT
         QLFpeMaXtzONDqMPRhmv1T1xcCP0KkOqv8lBOusqbnm0EdrAFyFdMpdsi4WRZNSAMPCE
         m5sw==
X-Forwarded-Encrypted: i=1; AJvYcCVwm1lh9l8t8PTfQtjM2qvHize1Fnoq3HQGPAy8zjqntAqSFZiouZHa1ANAdO5VuVFpCUx2TC69@vger.kernel.org
X-Gm-Message-State: AOJu0Yzan32SdpIhXOHszj0IoVxJcL74MKPfKIJC5MHVHPs9I7l8KsGs
	vLuHaJOi0zVVvZRuKoexqAt+NqZM8hiqqn2pn3WPC8lrfm4VluDhdiXMsts8UQ4Q+Q==
X-Gm-Gg: ASbGncvIbTNBK/lophI5Lhnt2KfwwK5ZuQHML90VucUAB10OpjxZgtQUkCDAzjW+caA
	rkhgy7GCcHy58cMDUkngXhB7ibekXbl9MkayLYn8DWtV+BQJgxAwDY8x2x1gZ5Lt19yhy0qyo83
	U/ddbH4UPw+Ajs20PikfgjarQtnjRznttTmyHHHzw9dHL8rnzkNcBLvDGb4kn+PE9OB+fZD7N3l
	6iQy+15S0+XjYbTjzWDr3zpFDQtdIoxIRP/7oOcZYFAK1jJq82C3VPgImbViqhrye+PSSA9JMFT
	OzLMwyiI5dl7KRxz9FcbznBCslKozhtxaSBrSFff3QpgIuJ10zx3sbc8/vjvKXXd0FnVqEBiuuz
	sxV56GqOp17Is5MSldos7mTrempV4hQPESmItejRWfeJwvWqTi5nouiYkSczBcHSi8rhxGR8hFa
	eQ+74/zVA=
X-Google-Smtp-Source: AGHT+IHN/ys8gHLrLIlg7s+DKUjMBq+p6tvCq2COmIp5lBOsMogpQZbYlGnq/VUVqHpKXGstFcOJKQ==
X-Received: by 2002:a05:690c:5c02:b0:722:6791:c5b2 with SMTP id 00721157ae682-73d3237b3bamr95872717b3.12.1758511394225;
        Sun, 21 Sep 2025 20:23:14 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-633bcce8a3esm3798775d50.6.2025.09.21.20.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 20:23:12 -0700 (PDT)
Date: Sun, 21 Sep 2025 20:23:01 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Paul Moore <paul@paul-moore.com>
cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
    Hugh Dickins <hughd@google.com>, James Morris <jmorris@namei.org>, 
    Stephen Smalley <stephen.smalley.work@gmail.com>, 
    Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, 
    Jeff Xu <jeffxu@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Isaac Manjarres <isaacmanjarres@google.com>, linux-kernel@vger.kernel.org, 
    linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
    linux-mm@kvack.org
Subject: Re: [PATCH v3] memfd,selinux: call
 security_inode_init_security_anon
In-Reply-To: <CAHC9VhSbWJ-8tj5BxSTxznGO8zraKRSE31a+tqdfMHB53ef-MQ@mail.gmail.com>
Message-ID: <a3f1a528-c2dc-74a6-b671-d8b2ccf23183@google.com>
References: <20250918020434.1612137-1-tweek@google.com> <CAHC9VhSbWJ-8tj5BxSTxznGO8zraKRSE31a+tqdfMHB53ef-MQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770367-1534621582-1758511392=:2554"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-1534621582-1758511392=:2554
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 21 Sep 2025, Paul Moore wrote:
> On Wed, Sep 17, 2025 at 10:04=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@go=
ogle.com> wrote:
> >
> > Prior to this change, no security hooks were called at the creation of =
a
> > memfd file. It means that, for SELinux as an example, it will receive
> > the default type of the filesystem that backs the in-memory inode. In
> > most cases, that would be tmpfs, but if MFD_HUGETLB is passed, it will
> > be hugetlbfs. Both can be considered implementation details of memfd.
> >
> > It also means that it is not possible to differentiate between a file
> > coming from memfd_create and a file coming from a standard tmpfs mount
> > point.
> >
> > Additionally, no permission is validated at creation, which differs fro=
m
> > the similar memfd_secret syscall.
> >
> > Call security_inode_init_security_anon during creation. This ensures
> > that the file is setup similarly to other anonymous inodes. On SELinux,
> > it means that the file will receive the security context of its task.
> >
> > The ability to limit fexecve on memfd has been of interest to avoid
> > potential pitfalls where /proc/self/exe or similar would be executed
> > [1][2]. Reuse the "execute_no_trans" and "entrypoint" access vectors,
> > similarly to the file class. These access vectors may not make sense fo=
r
> > the existing "anon_inode" class. Therefore, define and assign a new
> > class "memfd_file" to support such access vectors.
> >
> > Guard these changes behind a new policy capability named "memfd_class".
> >
> > [1] https://crbug.com/1305267
> > [2] https://lore.kernel.org/lkml/20221215001205.51969-1-jeffxu@google.c=
om/
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > ---
> > Changes since v2:
> > - Add WARN_ON when using unexpected class. Return -EACCES instead
> >   of -EPERM
> > - Remove extra new line
> > - Rebase on selinux/dev
> >
> > Changes since v1:
> > - Move test of class earlier in selinux_bprm_creds_for_exec
> > - Remove duplicate call to security_transition_sid
> >
> > Changes since RFC:
> > - Remove enum argument, simply compare the anon inode name
> > - Introduce a policy capability for compatility
> > - Add validation of class in selinux_bprm_creds_for_exec
> >  include/linux/memfd.h                      |  2 ++
> >  mm/memfd.c                                 | 14 ++++++++++--
> >  security/selinux/hooks.c                   | 26 +++++++++++++++++-----
> >  security/selinux/include/classmap.h        |  2 ++
> >  security/selinux/include/policycap.h       |  1 +
> >  security/selinux/include/policycap_names.h |  1 +
> >  security/selinux/include/security.h        |  5 +++++
> >  7 files changed, 44 insertions(+), 7 deletions(-)
>=20
> Thanks Thi=C3=A9baud, I'm going to merge this into selinux/dev-staging no=
w
> with the plan to move it over to selinux/dev after the upcoming merge
> window closes.
>=20
> Hugh, since the changes between this patch and the v2 you ACK'd are
> minimal and limited to the SELinux error handling code (see diff
> below), I'm going to carry over your ACK, but if you have any concerns
> or objections please let us know.

Sure, please do carry over my ACK - thanks.

Hugh
---1463770367-1534621582-1758511392=:2554--
