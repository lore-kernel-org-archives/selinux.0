Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029C1155757
	for <selinux@vger.kernel.org>; Mon,  6 May 2024 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715012460; cv=none; b=kH3ku7oY0bOXVqDrcsS7a5ecgFYntXesQxzW+ThYN85H/uBo8V5nv2j6+BdKJAzaFBgFy3AyFnGZkR5TObgq3QGzoPCPQ/wua4sikUheqF8GEovI/SvJ5PcozXh9fbIk2j8OeAQNYZ9pNmk1DjtDHeEsYGzu6PHMaERTPSS1gOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715012460; c=relaxed/simple;
	bh=BssCodaqu33MUIfYVQG2oqQr41T5dZB3ECr7+PBwOpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=SlEhh9cUHrMRkSL2G1KjZUEx2xCYcfE8l6Wi+631SQzUcOVMzdysoY6iZwu3LjjpTjN/9loFWlkIkJMhDXuiKAj0SfwTkTxwssOJYiAoQIPqd55CCd2vcz8MA0jkOe7Tb1Phs1lPRoMxYRfiGsWFlMQUXnZ1Aw6U/uZ6auO5WwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZptO6r+q; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZptO6r+q"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso1240306a12.3
        for <selinux@vger.kernel.org>; Mon, 06 May 2024 09:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715012458; x=1715617258; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U98anwabhazhWdTC9GPHJ3m6Ff/e+zDn7XrjGKGSo9o=;
        b=ZptO6r+qZo1a5ZhmZPhXgr0/eL34PBKPcgihJygSmC1tDboHoFlaLI8OKvB83TS9xB
         zbk5jVTxI34nIfohdeuTTFzjU258KRsHhdgTR16Qb9e1xo4Zp7LmPMGKUh2pAxgVy7V/
         lC5vOf6iToAH793NxrbQ0EQI70QpmQASqMlROl4kMB/FoiiriRjDe5GNKWJeLRoc5Avt
         a6rawlr58PuRLAUY8YVlk9Bjba4zkeLlffrrX1uCWH1mgx+BtwXFWMALldYU1NWo+frK
         g6/tjzqbX7IEb2xWpuYSz5cJ635amF1mbrPvihkbTUO1oozgXoeqfYshr/dxeyCbfGXr
         stIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715012458; x=1715617258;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U98anwabhazhWdTC9GPHJ3m6Ff/e+zDn7XrjGKGSo9o=;
        b=T+D1qsoT/bpISJfmvhwjeLQNRmjK+Q2dAlMLpzichH1J/SsjV+0O8oIQxPaNiwNPNm
         aPx2eUqMlCpmUEN9+YcZPWGaep7NSWijO7BFtDyd4MOfHkqgJYmGp/LNVOlhXwla83YC
         yOySWyZyL5ke8CFoDlLXAxjdL8r47rTYZ+C+ofjWeeGg2Ste7eTLhpOqAOqaRbRU7uPO
         kmBjUuyMNlMR3Hk4RxIrlZGoMOaX53uH20bmBZiM7kX38cN8J39YNMxPz+UFMbxzzfnX
         mXtGYl2pkhlRv1/SsqSNYuTBqDmqL/vdPeN6YhKoUfnLR0WsIuvv71l4H8HQP5ZBIDm8
         2Uxg==
X-Forwarded-Encrypted: i=1; AJvYcCVjgh3TjZ2gyuR/8watL4dgFcWzAbSHGptlGCUZgmZy5eV4xNUGYyRzFYmolruL+lhqqrpClaDTiTX5cxRWyQKKlja3gDJsQQ==
X-Gm-Message-State: AOJu0YwGBHPonxfVI/Rzn9UEfzDQP6OvkohTP+9tZv6XIwFZ1rJLA2ej
	iMi7k99KA5mcg2CxvUGSY+DG60mfQP3rxP7elCwKYb2tc8v7REmTKCfroquocmyjlTgp3mEa5Mv
	yplXB/SF45AoOymIXxjyLILSGcPR6v6VL
X-Google-Smtp-Source: AGHT+IF7cHlz74THlM7aWDDi7mtlSNQeTtgkip/GF+5CYmn63zIe7CT+bVGHk4M3PO53xvPUoB9kGGRBJTAVDpTuHO4=
X-Received: by 2002:a17:90a:d48f:b0:2af:53c6:5fb0 with SMTP id
 s15-20020a17090ad48f00b002af53c65fb0mr7522361pju.28.1715012457933; Mon, 06
 May 2024 09:20:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ67XPMa2DhZ-O1EJG+Q2ZUrjSspUf=rY1DahymiEvew3w@mail.gmail.com>
In-Reply-To: <CAEjxPJ67XPMa2DhZ-O1EJG+Q2ZUrjSspUf=rY1DahymiEvew3w@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 6 May 2024 12:20:46 -0400
Message-ID: <CAEjxPJ6+J+c5tjVjzV4p16NzKEnSwt3J11pyeTjhVvi8whVhDw@mail.gmail.com>
Subject: Re: NFS context mount failures
To: Ondrej Mosnacek <omosnace@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 10:29=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> So I'm looking into the remaining failures when running the nfs.sh
> tests in the selinux-testsuite, and the next failures are during
> mount(2) when using the fscontext mount option, with the following
> messages showing up repeatedly in dmesg output:
> [  446.205230] SELinux: inode_doinit_use_xattr:  getxattr returned 95
> for dev=3D0:59 ino=3D632702863
> [  446.205344] SELinux: inode_doinit_use_xattr:  getxattr returned 95
> for dev=3D0:59 ino=3D632702863
> [  446.205383] SELinux: inode_doinit_use_xattr:  getxattr returned 95
> for dev=3D0:59 ino=3D632702863
> [  446.205387] SELinux: inode_doinit_use_xattr:  getxattr returned 95
> for dev=3D0:59 ino=3D632702863
>
> The errno 95 corresponds to EOPNOTSUPP. __vfs_getxattr() returns this
> when there is no handler for the attribute name. The NFS handler for
> getting security.* is nfs4_xattr_get_nfs4_label(), which calls
> security_ismaclabel() to check whether the name is in fact the
> attribute name that corresponds to the MAC label, and SELinux returns
> 1 for its name so I am unclear as to why we are getting this error.
>
> Line 709 of tests/filesystem/test is the first such failure:
> print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> print "Using mount options:\n\t$mount_opts\n";
> $result =3D system(
> "runcon -t test_filesystem_no_getattr_t $basedir/mount -s $dev -t
> $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts -v"
> );
> ok( $result eq 0 );
>
> Verbose output is:
> Run 'filesystem' tests with mount context option:
> fscontext=3Dsystem_u:object_r:test_filesystem_file_t:s0
> filesystem/test .. 1/41 Failed mount(2): Permission denied
>
> AVC message is:
> type=3DAVC msg=3Daudit(05/06/2024 10:14:42.359:3649) : avc:  denied  {
> search } for  pid=3D11312 comm=3Dmount name=3Dmntpoint dev=3D"0:54"
> ino=3D285625107 scontext=3Dunconfined_u:unconfined_r:test_filesystem_no_g=
etattr_t:s0-s0:c0.c1023
> tcontext=3Dsystem_u:object_r:unlabeled_t:s0 tclass=3Ddir permissive=3D0
>
> Unsurprising that it is unlabeled_t since the getxattr failed, so the
> getxattr failure seems to be the key here.
>
> Maybe because this is happening during mount(2), the server isn't yet
> offering labels and that's the cause? I know we had a similar problem
> with FUSE filesystems when we were trying to allow labeling of
> those...

Ok, if I undo the one part of commit cec5fe700799b ("selinux: make
labeled NFS work when mounted before policy load") that changed
inode_doinit_with_dentry() to fall through to the USE_XATTR case from
USE_NATIVE, then we no longer get the messages from
inode_doinit_use_xattr() but still fail the permission check on the
unlabeled directory and thus fail the mount operation.
