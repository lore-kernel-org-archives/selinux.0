Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD9910A24
	for <selinux@vger.kernel.org>; Tue, 20 Aug 2024 18:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724176931; cv=none; b=FYZdf+eMvZt8LLih7rTvx8/9sXETayBo3y2/VN/dZEdIRV/tzIsMOLvpFNu0zvuvAETSPqt7tiHc+caVerI0x9Jl38Yt+qeigA2xG9xRsgaRoeZoaX1LiYeP2C6KfA55Gcls9RM77Y2ubTDPvOfNVB9gzr1cnljuc5wjh568Uuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724176931; c=relaxed/simple;
	bh=gDtqB931ZT+Ig4a7uxef+ifai5z1e+1eaPyibZ7VHns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SV3ba5e5JL1eXW1XtMy3YRjbAApolELj+Pn61VcXzs8/9bRLSrvW8yyGjU8vfl/TL4lFFBpHOwtHfXuB1K4+Bfh1xiLOAmp7Fs8kK+ig3+EXoD60ZgFV6Is/mCjRRXL+qGBXvHtwRyG2oQ64H56fh40ETPoosjqHoCzz+zvAouI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHJiwjhg; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHJiwjhg"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7c6aee8e8daso4025860a12.0
        for <selinux@vger.kernel.org>; Tue, 20 Aug 2024 11:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724176929; x=1724781729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K42rARqpI6NOVCLQGBPnTFm7caaAVFAZd7OKmyJJykE=;
        b=aHJiwjhg8DI/VPM6DiZuli2Ckx5XRtkGuP0pwR/rLxwD4zBA4nnVGciJ3A8tuSsRkg
         uuhNB1tCNAxVVQ6nJ2oezPAEcCVEF9v31aS2n4wz8fZlZb1ys56Mr/kSWjaC73ahmyB8
         aM6MzWTLJP9ih+VGf+qOoFKBK41n7HbxSp9THzuUStrPZOBI2hIYP2XjfilU4vZR5jmO
         vy3MNHVn2S7G/hZfM4f1XyjCZfEaWG00UbmfC/1TWOcH+9527Y8oLuIuRktQhdwCMGJC
         UNyP9BA6mfN3rS2fqnjlJ3TFqVmZVLDrlcx9Oc98DBZNER8lNQxRsNYQ82x70kLvHiEb
         s0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724176929; x=1724781729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K42rARqpI6NOVCLQGBPnTFm7caaAVFAZd7OKmyJJykE=;
        b=Eq8GO5RoxaoqoprcUnskvJJOsb0rMEoUnV4L3lpj7Q/s+lqJoVQtDCGDE1xyVc+xWa
         RHuI5YkxZZyicbnNYOigcgOcnwgWbc7sVQ3sIm80cIo3oLemcZKjFKbEGfDKBjF09dWL
         SVN7YvuU3XEeA6LySBnESrp8XEOKpnH1dYGQoWbkbeUBwewq0IKI3/IX+hDOOdCY5Nas
         PLfEMbW+wwfnMlIGJEBn1TGfNPXWe06itD5/aewDLl048TQKI6ehtHHOEZxM+guh/T4S
         3U4mR4L2c2CL1OFht/gMLoOazvmUp249ol69cxbeok4ypZrko9QRz6n0UxB/dMa8/6B9
         aAxg==
X-Forwarded-Encrypted: i=1; AJvYcCVriymSRMoFceGm+0kmrvnyXS0nqHebbd4gO3x+D2eE0wo/fMsXOv7712aky9st17HGeeiHztvL@vger.kernel.org
X-Gm-Message-State: AOJu0YznyAvzdsxhWqlIQElMp/3aV0hrhJQi0i1qpq7K2c+VDFLFo/IB
	NT3errCTwgBASOuWGHHnzC2KksLoqnXqhEESkSQBsEgSh6x/2LBZwyydeE1fGv4ekiXWBV6SqdM
	Nkm0JAnIGvkxRqjZRJyBeWlgJXgcCTQ==
X-Google-Smtp-Source: AGHT+IEL3G5Owoda9ii+XiWDpb2Phd1aw8ybB/T5mNM404wy2nQHaAMT8z54eeiu75WQ7Ei7I/Z3GfJWXUR44w8EO7Q=
X-Received: by 2002:a17:90a:c20b:b0:2d3:c2a0:a0f5 with SMTP id
 98e67ed59e1d1-2d3dfc63378mr15519967a91.11.1724176928640; Tue, 20 Aug 2024
 11:02:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820002723.1345639-1-tweek@google.com>
In-Reply-To: <20240820002723.1345639-1-tweek@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 20 Aug 2024 14:01:57 -0400
Message-ID: <CAEjxPJ7Jg6vYOQXVr_tT9F4SZcDHN==7LfORxxOACqtn_SRKTw@mail.gmail.com>
Subject: Re: [PATCH] selinux: Add netlink xperm support
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: paul@paul-moore.com, brambonne@google.com, jeffv@google.com, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 8:27=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@googl=
e.com> wrote:
>
> Reuse the existing extended permissions infrastructure to support
> policies based on the netlink message types.
>
> A new policy capability "netlink_xperm" is introduced. When disabled,
> the previous behaviour is preserved. That is, netlink_send will rely on
> the permission mappings defined in nlmsgtab.c (e.g, nlmsg_read for
> RTM_GETADDR on NETLINK_ROUTE). When enabled, the mappings are ignored
> and the generic "nlmsg" permission is used instead.
>
> The new "nlmsg" permission is an extended permission. The 16 bits of the
> extended permission are mapped to the nlmsg_type field.
>
> Example policy on Android, preventing regular apps from accessing the
> device's MAC address and ARP table, but allowing this access to
> privileged apps, looks as follows:
>
> allow netdomain self:netlink_route_socket {
>         create read getattr write setattr lock append connect getopt
>         setopt shutdown nlmsg
> };
> allowxperm netdomain self:netlink_route_socket nlmsg ~{
>         RTM_GETLINK RTM_GETNEIGH RTM_GETNEIGHTBL
> };
> allowxperm priv_app self:netlink_route_socket nlmsg {
>         RTM_GETLINK RTM_GETNEIGH RTM_GETNEIGHTBL
> };
>
> The constants in the example above (e.g., RTM_GETLINK) are explicitly
> defined in the policy.
>
> It is possible to generate policies to support kernels that may or
> may not have the capability enabled by generating a rule for each
> scenario. For instance:
>
> allow domain self:netlink_audit_socket nlmsg_read;
> allow domain self:netlink_audit_socket nlmsg;
> allowxperm domain self:netlink_audit_socket nlmsg { AUDIT_GET };
>
> The approach of defining a new permission ("nlmsg") instead of relying
> on the existing permissions (e.g., "nlmsg_read", "nlmsg_readpriv" or
> "nlmsg_tty_audit") has been preferred because:
>   1. This is similar to the other extended permission ("ioctl");
>   2. With the new extended permission, the coarse-grained mapping is not
>      necessary anymore. It could eventually be removed, which would be
>      impossible if the extended permission was defined below these.
>   3. Having a single extra extended permission considerably simplifies
>      the implementation here and in libselinux.
>
> The class NETLINK_GENERIC is excluded from using this extended
> permission because the nlmsg_type field is referencing the family id
> which is dynamically associated.
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> Signed-off-by: Bram Bonn=C3=A9 <brambonne@google.com>

Thank you for reviving this patch.
Do you have a corresponding userspace patch? And for extra credit, a
selinux-testsuite patch?
A minor comment below.

> ---
> diff --git a/security/selinux/include/classmap.h b/security/selinux/inclu=
de/classmap.h
> index 7229c9bf6c27..c95bf89c9ce5 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -96,17 +96,17 @@ const struct security_class_mapping secclass_map[] =
=3D {
>         { "shm", { COMMON_IPC_PERMS, "lock", NULL } },
>         { "ipc", { COMMON_IPC_PERMS, NULL } },
>         { "netlink_route_socket",
> -         { COMMON_SOCK_PERMS, "nlmsg_read", "nlmsg_write", NULL } },
> +         { COMMON_SOCK_PERMS, "nlmsg", "nlmsg_read", "nlmsg_write", NULL=
 } },

I would just add the "nlmsg" permission to the end of the list before
the NULL for each class.
Doesn't matter as much anymore since the dynamic class/perm mapping
support was added but generally we avoid perturbing the
class/permission bit assignments unless there is a good reason to do
so. Feel free to wait to see if Paul agrees since your code will work
as is.
