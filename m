Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAE128C5A6
	for <selinux@vger.kernel.org>; Tue, 22 Apr 2025 17:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745342942; cv=none; b=MK30TJQhPK92lV4SJGPfDIosp+SDNUbdocm62AJsR1pG/3TJUIxqmefLzxbAsqqTpsiniWkOVEgmjwG3c3e6Q4iZgtXa0Geaovmtm9n/Q+tdW88m/ksm3YwxLTLfaqmdSoDdwZY+u6+1u0vsDhhNnU1rHOKjlgvqlfThSnQrfFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745342942; c=relaxed/simple;
	bh=jQrELbMOQP+XffBeiKVwr+3ugpatE+fGrGJWHkCXRnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/Vz+MYF9PxBcoO1Vz3XDBFVtbY/hSrJntyeWKaPPOGjYybIux2+fOlFpE5yX9aoZfPuuOI2CDGJQNWXzhFiSrvBnf1bp1OG5rEZ0CLuhPjsZ79WLd8/5MyYe3aWmYE9wLT6gvlfdomfsx/qHe7W+JDfrhlyxUkgrOnGQ1TqUpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1JCoPHz; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1JCoPHz"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-30572effb26so4954157a91.0
        for <selinux@vger.kernel.org>; Tue, 22 Apr 2025 10:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745342940; x=1745947740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQrELbMOQP+XffBeiKVwr+3ugpatE+fGrGJWHkCXRnk=;
        b=F1JCoPHzy4qQH/8QbOOoGSbymBxhRUsHLwbZLIR9Cwc5+1xnYf0QIUA7ecjpUviygH
         wrgXpErNI2iSfBFZsLUC6sPnxwjkURbPCk0pjYX+SNYXqCKklhLyqp1871SnwiQOHTZo
         JErXVvuKfz3q8qDe0p0AyScZTuhDqf7FFqoUR4Q2QdytRJSTWDDR7v0Anbw1hfhmHhPf
         wGKvlHuzxbvB56GTlwxNQahgDIWU2YgLyzll3X89WQ0yUxh9RRRIBE26pNvBpO/Px8SM
         odQ08zcVcCDKbc9zVPHLzqEs4xmHfDDZfJ1M3l7MQIHQngcctX9DidoDhTm9IoIwFg/B
         4sxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745342940; x=1745947740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQrELbMOQP+XffBeiKVwr+3ugpatE+fGrGJWHkCXRnk=;
        b=mcBjilbn2JgIeGtkWPMJv5t0NOdlGw4iJGjjGFrLD2X3Ir8EVMr0PqQiQH+2YpXg2A
         CENxUOYhOx7C6AW4J9hyks/FW/0yrs5U/ZBdWiIA0upi5xx2Vb1jiMAKfk5jmiyL3i4b
         iWkiXjA9yTBz1YK1wY9G2RNh63IgdT91q/LufNl+zOGkxhQuuML0rnl1cN4Sq7SOppai
         qgb2KTyGDaSIhy5nqC34N7p+v9ifyilZTgmZSZxhEcXCZ7kIuQI95w+iPJMT1Axxt0UD
         SSxUqRzBYJK/uNq35igG3z9wMIq/TBMi4DdFobnBCs12fVTWFXbJgn6SwvjYRANHkrBj
         dE0A==
X-Forwarded-Encrypted: i=1; AJvYcCU4uPi7MNq7ncePCgVqoBGtkJu2oQ8i1J7vF+Ehdif6ED2AeKu8XDeGd9bKLm8RBCMCL2bsOof5@vger.kernel.org
X-Gm-Message-State: AOJu0YwhsxQMKuMjzUb1FJ5M0n7CcvNKfou/AGCgx19EAx0nqHE1jW4Y
	Mcx5Vddbg0py4oonjU3Eybc7804JZapijt10gSjFm5bzJTeMdi2riO44dpi+gq/T4WWAHrdktHQ
	UlWK/3hzG82SINHERxBJ2q0CsM3k=
X-Gm-Gg: ASbGncuCXZUIlMeH0BEA71Vggq1tikxfKrBNwwUJoBl6ERmvlE55c09l1ShgF5LDi8y
	tKPi6oWZSlQDVqPngskqFXuv3EdfqgGR7RQD+8yaBPo/tn9H+R28EuwuDc/zxghJN6DClEkZMVG
	LK55WC8WqJ+POsnSJQ3IuDdg==
X-Google-Smtp-Source: AGHT+IGm4E32ZGTYgwwxjqT4nh2dUz6wKOjzNCmF3Vxg+0pNjhEVNvsvBEvwKdAmZRC9jIpilZ2oAjjwdd+x4UB3Sqw=
X-Received: by 2002:a17:90b:3f8e:b0:2f6:d266:f462 with SMTP id
 98e67ed59e1d1-3087bbba604mr23612969a91.35.1745342939755; Tue, 22 Apr 2025
 10:28:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRj4CWBbSCEiznjNh_WaHr2vEGB-_Xem=VqRyptR=MtGw@mail.gmail.com>
 <D9DB7KSD01JE.1LSPBCYV65C6Y@gmail.com>
In-Reply-To: <D9DB7KSD01JE.1LSPBCYV65C6Y@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 22 Apr 2025 13:28:46 -0400
X-Gm-Features: ATxdqUEtHO5aJ-VCJg4fuLy1M2CB_ldQnruknprkKXX1j13JyLP2go6qVYJNS6w
Message-ID: <CAEjxPJ5GVOrX8-MhQqMJ6U+1TSYJ=mPyL1GxMitetkovgh1O8w@mail.gmail.com>
Subject: Re: ls from coreutils 9.6 doesn't show labels of some files
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: paul@paul-moore.com, omosnace@redhat.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 12:31=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> wr=
ote:
>
> Hey,
>
> > I can't think of a good reason why we would ever want the *listxattr()
> > syscalls to not provide security.selinux, if there is an individual
> > filesystem that is different/broken in this regard it should be
> > treated as a BUG and fixed.
>
> I've spoken to coreutils upstream[1], and they also seem to see this as
> something which should be fixed in the kernel too[2][3], and appear to
> want a solution in the kernel rather than working around it in ls(1).

So I assume this was introduced when tmpfs/shmem grew its own xattr
handlers, since previously it would just fall back to the LSM
security_inode_listsecurity() hook and return the SELinux ones
unconditionally. shmem_mknod() calls security_inode_init_security(),
so inodes created after policy is loaded get their security.selinux
xattrs set and returned via listxattr. Root directory of tmpfs mount
and any tmpfs mount that precedes policy load (e.g. initramfs) would
be the exceptions. Could modify shmem_listxattr() to call
security_inode_listsecurity() and combine with its own list before
returning.

>
> Thanks,
> Rahul
>
> [1] https://lists.gnu.org/archive/html/bug-coreutils/2025-04/msg00011.htm=
l
> [2] https://lists.gnu.org/archive/html/bug-coreutils/2025-04/msg00025.htm=
l
> [3] https://lists.gnu.org/archive/html/bug-coreutils/2025-04/msg00031.htm=
l
