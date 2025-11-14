Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCE62FBDE4
	for <selinux@vger.kernel.org>; Fri, 14 Nov 2025 20:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763153922; cv=none; b=Z0bFIb0hur2BL9vJAJ0Sm7ansk5qSSB4gXkBaGxcpS9NBGGscIR5JA7CHBsJS8lPrwwYLLytIuEBCUhCz89vJhIEHejGOWBrzbfxUfbR420j7Yx6QrL3s9gwn6pjlDHUoicymgDTkknh7eZkPFm+7Tn9CRT195HaW7U/uD12gC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763153922; c=relaxed/simple;
	bh=FyT1azdedHZS9ZcVgxxBbDMJyduDcvmn/k2kvaNJ7CI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1ks/UUa1+d2ogeE3lqjIzcnRRMkKKvXj7paO8Rtd5A2chUdfbyfiXWnOXaMTiwSnwjyARC7/7ETrqj1LgY+SUJgZ9w/3lgztuypMcBAJevwgr+TZC5BglZXMjL4g4vWS9cncpkiBMDlcaaskwLG0x/39FDYMH8x3FRMSkFIK+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+bsT46z; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+bsT46z"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3437ea05540so2455297a91.0
        for <selinux@vger.kernel.org>; Fri, 14 Nov 2025 12:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763153920; x=1763758720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2QNS6uTyD1nHA1X6duPvIXz/xy/fnS84CgIyN2dERc=;
        b=J+bsT46zSbmP+1oPPkEhoZAMEw1F6MIUd6jr5pbSCIEE4U5MGp4PHVfpTIsyD+/XpA
         pD6q4NieUJk2blJZ4Z5jeYu05A1O4HZSt/n5buFPhfmkHxD8kqNeQe6rlm9nHEzZguEC
         vyp0/pBga+GImjBa52/kCRP9+aegFc47kq8WGk8KwcuDrPDBFdjkRjQ0u1VJPDDNRsc0
         9VZUaIXEF7B6C8OshYy+X/GtODXS5cBilO4rnclnHoAKsc0UU8TxYuUe0lXTBVtvafuY
         ZKWr5ro9/mMAdht/DHN9raZJSSqz8DirYVdNwIymxjG1Kj9THg/OmTAw4Nm1604ajR3H
         buZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763153920; x=1763758720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g2QNS6uTyD1nHA1X6duPvIXz/xy/fnS84CgIyN2dERc=;
        b=v0DsxZbBtY0I706rCTSVF5A8rB4iuhfdEEy7ZBBdnuLpGDDprd7LaKWaPg6fwERLa8
         epn0cbf4W8eifbUzZ4sKEOPZJ9tTlGZZiRsbZ+hVD3XIViPxkq1WA1/H0pGERR6py+6r
         xQp+FGTnceVT8g4WQUFCdNLH5qfhxJwVcTso4TXRcIk0js0JE6WhIt2ljGdlTjr8h/sK
         I9832rSqByOuijSXvMHMzZZZqrrgo/Lv7CsGjf8WDfNrxl1iOsvx/MwxhOI0u46mBCmb
         pLJuUOtIe0/v2Istqs7YHW6g8T4oJYWhRQq8ptMziFYJDj/2fWC6N+gM6s/p3yOuV/na
         azow==
X-Gm-Message-State: AOJu0YxvduhKodUCNMLyFi3WAGU6cPKzkcl8IHWjKhRjcMIm5csgMZK+
	P2x9UdTL6l3uTi3VhZCSChiFySOm/USnHHvTTypXPxV7sjWN7PhF/xGyOGBXeJncpMN23k4kVmf
	Rkv/L35R0k67UFJmzwJGgU4BNzDs7cfQ=
X-Gm-Gg: ASbGnct2zvg7Hglon4V0/BanX327rsiBnj8p70Hm5qxrmSMoymhgDSeB/NWWhq1ZOr0
	wxxyQL9NH0Nvhz7yTIsIl7UdPLn+g5LyPE+Kdl20KMb8488jzlpjxM0qTiDgETMAwADm7rONK7y
	nVXuwSc2ozdAGMzsOK28JvwffFBth7DEAbSMgxWCtFDE1T+gggvbsFZT4FgkXB+9aZZcMDJ6V6g
	izN8Z35OY++XGquMrqaWv+FF5/ulj0WD9xKHdK+13J8yHZ8nm0o3PViX6mXfi+oOrU+p/T8zoBv
	XER+3Q==
X-Google-Smtp-Source: AGHT+IGYt9n5s931BoMPdWRetNYaGDRhy+O8WMLpcvfiEDDtc6ZnqKNLL7Lpnn77sGPUs0Pcq4TmzZAUfB0/dCixrYQ=
X-Received: by 2002:a17:90b:5206:b0:32d:e07f:3236 with SMTP id
 98e67ed59e1d1-343fa52826bmr4844879a91.22.1763153919618; Fri, 14 Nov 2025
 12:58:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <io56y7r63uyeduqe7ukx3wcjvhzfnnsxle2go5raxqy76lrn3n@edx4doao3gv3>
 <CAEjxPJ5cGzHDrsUGKCOxOUZm-0d8shoPahbZB7zVFTivujRNsw@mail.gmail.com>
 <kakoxc3dfli7fjjistybeqhf34abzqovkmq2gs4fg5sv7nviam@w36m2srscmbu>
 <CAEjxPJ5rD7Fq_t5EDoy8EYHzMhgntR+KK=3OZAAuA0V047yKWQ@mail.gmail.com>
 <CAEjxPJ744wutA3FZmA88OMyay__P0qVAYTB6RRnh=v+LiPyxJQ@mail.gmail.com>
 <aoskc4jnsb2ivi7mgdkhxxxahwmrblzayvu7qdtpgjjnz7u7ca@6x6bz243yu4b> <CAEjxPJ4xff=wfvVpnSNuydWN4k1TX6f8GtBtWmv_Fc7yKMZaUA@mail.gmail.com>
In-Reply-To: <CAEjxPJ4xff=wfvVpnSNuydWN4k1TX6f8GtBtWmv_Fc7yKMZaUA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 14 Nov 2025 15:58:28 -0500
X-Gm-Features: AWmQ_blvuZZyDfAJKEg6NYj85nF-hPZisoUZtmrtvVv1kn3GwofMmdtNXRYr1mA
Message-ID: <CAEjxPJ5dmu2qBejhAft72rA9DrEs++qjhhvk8z+3-n0thM1DSA@mail.gmail.com>
Subject: Re: SELinux Namespace work
To: =?UTF-8?Q?Martin_Erts=C3=A5s?= <mertsas@cisco.com>
Cc: selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, 
	Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 10:25=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Nov 14, 2025 at 9:15=E2=80=AFAM Martin Erts=C3=A5s <mertsas@cisco=
.com> wrote:
> > Thank you for the help so far. I have dug quite a bit into an issue wit=
h
> > this together with the cgroup namespace, which is required for running
> > Android in a container.
> >
> > What I see is that before mounting the cgroup namespace, it is labeled
> > based on the new selinux namespace as expected. But when mounting the
> > cgroup2 filesystem, some of the labels change to the host labels. This
> > causes problems, as I on the host have the user system_u, while android
> > only has u. So when I try to make a subdirectory in the new cgroup, I
> > get -ENOMEM as selinux can not find a system_u user.
> >
> > This is what I can observe:
> >
> > # echo 1 > /sys/fs/selinux/unshare
>
> Note that my current working-selinuxns branch has switched from the
> /sys/fs/selinux/unshare interface to the system call-based approach
> recommended by the discussion on the LSM list so at some point you may
> need to switch over to using that as well. That however is not
> relevant to your issue below; I am just mentioning it for your
> awareness. It remains to be seen what the final upstream API will be.
>
> > # unshare -m -n -C -p --fork /tmp/setup_namespace.sh
> > [cisco:/] $ load_selinux_policy
> > Loaded selinux policy. Enforcing=3D0
> > load_selinux_policy-3.2# ls -lZ /sys/fs
> > drwxr-xr-x    2 root     root     u:object_r:sysfs:s0                  =
    0 Nov 14 14:05 9p
> > dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0                  =
    0 Nov 14 14:05 bpf
> > dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0                  =
    0 Nov 14 14:05 cgroup
> > drwxr-xr-x    8 root     root     u:object_r:sysfs:s0                  =
    0 Nov 14 14:05 ext4
> > drwxr-xr-x    3 root     root     u:object_r:sysfs:s0                  =
    0 Nov 14 14:05 fuse
> > drwxr-xr-x    3 root     root     u:object_r:sysfs:s0                  =
    0 Nov 14 14:05 nfs
> > dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0                  =
    0 Nov 14 14:05 pstore
> > drwxr-xr-x    8 root     root     u:object_r:selinuxfs:s0              =
    0 Nov 14 14:05 selinux
>
> Looks like your container sysfs mount was labeled per its policy
> rather than the host policy, as expected. Did you do anything special
> when mounting sysfs?
>
> > load_selinux_policy-3.2# mount -t cgroup2 none /sys/fs/cgroup
> > load_selinux_policy-3.2# ls -lZ /sys/fs
> > drwxr-xr-x    2 root     root     u:object_r:sysfs:s0                  =
    0 Nov 14 14:05 9p
> > dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0                  =
    0 Nov 14 14:05 bpf
> > drwxr-xr-x    2 root     root     system_u:object_r:cgroup_t           =
    0 Nov 14 13:53 cgroup
> > drwxr-xr-x    8 root     root     u:object_r:sysfs:s0                  =
    0 Nov 14 14:05 ext4
> > drwxr-xr-x    3 root     root     u:object_r:sysfs:s0                  =
    0 Nov 14 14:05 fuse
> > drwxr-xr-x    3 root     root     u:object_r:sysfs:s0                  =
    0 Nov 14 14:05 nfs
> > dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0                  =
    0 Nov 14 14:05 pstore
> > drwxr-xr-x    8 root     root     u:object_r:selinuxfs:s0              =
    0 Nov 14 14:05 selinux
> > load_selinux_policy-3.2# ls -lZ /sys/fs/cgroup/
> > -r--r--r--    1 root     root     u:object_r:unlabeled:s0              =
    0 Nov 14 13:53 cgroup.controllers
> > -r--r--r--    1 root     root     system_u:object_r:cgroup_t           =
    0 Nov 14 13:53 cgroup.events
> > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0              =
    0 Nov 14 13:53 cgroup.freeze
> > --w-------    1 root     root     u:object_r:unlabeled:s0              =
    0 Nov 14 13:53 cgroup.kill
> > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0              =
    0 Nov 14 13:53 cgroup.max.depth
> > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0              =
    0 Nov 14 13:53 cgroup.max.descendants
> > -rw-r--r--    1 root     root     system_u:object_r:cgroup_t           =
    0 Nov 14 13:53 cgroup.procs
> > -r--r--r--    1 root     root     u:object_r:unlabeled:s0              =
    0 Nov 14 13:53 cgroup.stat
> > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0              =
    0 Nov 14 13:53 cgroup.subtree_control
> > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0              =
    0 Nov 14 13:53 cgroup.threads
> > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0              =
    0 Nov 14 13:53 cgroup.type
> > -r--r--r--    1 root     root     u:object_r:unlabeled:s0              =
    0 Nov 14 13:53 cpu.stat
>
> That's very odd indeed - I would expect them all to be labeled based
> on either the container policy or the host policy, not a mix of the
> two. cgroup2 and sysfs are both kernfs-based so I'm wondering how/why
> they differ.
>
> > load_selinux_policy-3.2# mkdir /sys/fs/cgroup/foo
> > mkdir: can't create directory '/sys/fs/cgroup/foo': Cannot allocate mem=
ory
> > load_selinux_policy-3.2#
> >
> > The setup_namespace just creates a new rootfs and mounts the android
> > container and selinux policy into that. And load_selinux_policy is just=
 a wrapper that loads the android selinux policy.
> >
> > What I have traced it down to is that when kernfs_get_tree from
> > fs/kernfs/mount.c is mounting the cgroup, the superblock is reused from
> > the old cgroup namespace, which also has the security context from the
> > old selinux namespace. This causes the labels to be mixed as shown
> > above. This doesn't seem to involve SELinux code directly, but just the
> > kernfs code.
> >
> > Should the kernfs test function for the superblock involve checking the
> > security context as well? Not sure what a proper fix for this would be?
> > Or if I'm missunderstanding something and doing something fundamentally
> > wrong here?
>
> First I'd like to understand why it seems to be working for sysfs but
> not cgroup2 since they are both kernfs-based. What's different between
> the two?
> And since you unshared the cgroup namespace, why doesn't that trigger
> a new superblock creation by itself? It's better if we can avoid
> introducing a special check just for SELinux/LSM here.

Would help if you could provide the scripts you used above and perhaps
the Android policy being loaded. It occurs to me that this might also
be related to the cgroup_seclabel policy capability being enabled in
your host OS policy but disabled in the Android policy.
