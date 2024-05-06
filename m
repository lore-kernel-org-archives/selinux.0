Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD7513D51D
	for <selinux@vger.kernel.org>; Mon,  6 May 2024 14:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005790; cv=none; b=NVxq6IfJJQ2IVM9p3MgKe9b6iSqOvZZ5qnoIqOwtgq+Yx0rlSfoSotYSOXP4hzR2udPCURF4Ip/vmQ8WYYNGY3W1qoGyVWPkgr5mCLPKNnx15B4ocklfDJpxFktmsWh0tL3gAwGYakx+cyyDeaQraOpNbT9kqj2yRYUbd5yzoE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005790; c=relaxed/simple;
	bh=kacXuv4Zv4M5nH0hW4lSJjgJCkP0TMYHaB10Ys05Wm8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=IKNpTYas4Eb2PWTZ4SwhJaFKk9qtQh3d9cGWKTmxFc8Qyiwk4BA17E5NSZfBW3eoMcgdkAJCJRUhYc/5QBwQFaEWg6czzwohvp27VA63perBykn4lGZrqF9PtfCymM3MNkhoqzdFiXQ+QMBtbbaLwJyHggaNIqgUcJL3hOCqGmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELgtBwe9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELgtBwe9"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ec486198b6so15073025ad.1
        for <selinux@vger.kernel.org>; Mon, 06 May 2024 07:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715005788; x=1715610588; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9kD2nSQp6uWkq/HkjXcHmK+TkNXJ5uIBsUJaetl2FV4=;
        b=ELgtBwe9VMYZDJ+zVgEepOofxPLRwP3xIO65SKwwxAQH6+x3KMLxC7lhbB+Z58L2t3
         Yn6NT/TG/pWtBmHAiWsLOouRlVobFxC3tfgYT7FVY+OJ0pDOWAt1cTTVNdBSy1nvAJLS
         qwX4ZyDmcJ6X4HzsO9r+75OHT3hZ2YOz67dznU4ZSqyPQgyT41csMv7+sRvFCx3GcEAk
         ze5qQ4rCebqvVCl/euNJqfSXweCL86pvNo2vLeYYeoL3ChoH9+MK8bO5pEL9p555EC+x
         ECRXL/lAwXmu3DREg0+oxggS7GKNelH3YUSVQa2sZ0uw7A0AfX5p6xsOLLdZOEzL+0Zm
         mLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715005788; x=1715610588;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9kD2nSQp6uWkq/HkjXcHmK+TkNXJ5uIBsUJaetl2FV4=;
        b=qvd9M/R8X/Akc1xFr47fE5Lxl6HXZyz8CHLxdGl2ry0EcZW7IEVoG+mdFmbrVcPEju
         qBBSqBtOXWpjG+2JLpJ7vEs0sKE6QtGmOHiFMj677NrLTVy5VKEW8xqrRD600Dnay044
         0f8T6Us5XiQTthqphikBoNoK7IRM02B4FtvUQhG4Iv/Y5oJ185EKMOlhXqUOTldhMCyu
         mS+mN+cVC9SEtcXanhqPzCc0vgGDXniZyt9d/rYjlSV6cmi1PdwCnk/e9ji1XBsZAaxS
         22m2RDUGohlbCqZ0vYIIfwWjhRhg03IvKNPyJLPaOP2yqa39KAGApaSTfLTCgsMYTPFN
         sNSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPvF7yQmdOIolTgOOdigajvdkVUcWR7df6nX2nf3TUc0s85RCQxSRWMLMJ0DLHOosxPF+F5nR99y6EOC9ukjje42NINqzimA==
X-Gm-Message-State: AOJu0YxCExwLELDubhnC5Xrqb4btpdVXBX/ZB4/fXT92KT6LOAfGW9MK
	aG2HRhYrboFbHNSYC2x5BIO5mzrNTr881ZptLwmzwmLkN7bdc+5usL6Q7MdnLaetFWUngfmtGcU
	kLnnIoCJcrDoRcOhzPU5vkSBU6VE=
X-Google-Smtp-Source: AGHT+IHrQvir0PM4Vbol8DWXywU+z0nYDLCMIpAPSYefrxXKT75eeviP8rZthmYTF/1n1YleQattOv7sLo33RelbThc=
X-Received: by 2002:a17:90b:3ccd:b0:2b5:91d1:3ae9 with SMTP id
 qd13-20020a17090b3ccd00b002b591d13ae9mr924483pjb.19.1715005787956; Mon, 06
 May 2024 07:29:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 6 May 2024 10:29:36 -0400
Message-ID: <CAEjxPJ67XPMa2DhZ-O1EJG+Q2ZUrjSspUf=rY1DahymiEvew3w@mail.gmail.com>
Subject: NFS context mount failures
To: Ondrej Mosnacek <omosnace@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

So I'm looking into the remaining failures when running the nfs.sh
tests in the selinux-testsuite, and the next failures are during
mount(2) when using the fscontext mount option, with the following
messages showing up repeatedly in dmesg output:
[  446.205230] SELinux: inode_doinit_use_xattr:  getxattr returned 95
for dev=0:59 ino=632702863
[  446.205344] SELinux: inode_doinit_use_xattr:  getxattr returned 95
for dev=0:59 ino=632702863
[  446.205383] SELinux: inode_doinit_use_xattr:  getxattr returned 95
for dev=0:59 ino=632702863
[  446.205387] SELinux: inode_doinit_use_xattr:  getxattr returned 95
for dev=0:59 ino=632702863

The errno 95 corresponds to EOPNOTSUPP. __vfs_getxattr() returns this
when there is no handler for the attribute name. The NFS handler for
getting security.* is nfs4_xattr_get_nfs4_label(), which calls
security_ismaclabel() to check whether the name is in fact the
attribute name that corresponds to the MAC label, and SELinux returns
1 for its name so I am unclear as to why we are getting this error.

Line 709 of tests/filesystem/test is the first such failure:
print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
print "Using mount options:\n\t$mount_opts\n";
$result = system(
"runcon -t test_filesystem_no_getattr_t $basedir/mount -s $dev -t
$basedir/mntpoint/mp1 -f $fs_type -o $mount_opts -v"
);
ok( $result eq 0 );

Verbose output is:
Run 'filesystem' tests with mount context option:
fscontext=system_u:object_r:test_filesystem_file_t:s0
filesystem/test .. 1/41 Failed mount(2): Permission denied

AVC message is:
type=AVC msg=audit(05/06/2024 10:14:42.359:3649) : avc:  denied  {
search } for  pid=11312 comm=mount name=mntpoint dev="0:54"
ino=285625107 scontext=unconfined_u:unconfined_r:test_filesystem_no_getattr_t:s0-s0:c0.c1023
tcontext=system_u:object_r:unlabeled_t:s0 tclass=dir permissive=0

Unsurprising that it is unlabeled_t since the getxattr failed, so the
getxattr failure seems to be the key here.

Maybe because this is happening during mount(2), the server isn't yet
offering labels and that's the cause? I know we had a similar problem
with FUSE filesystems when we were trying to allow labeling of
those...
