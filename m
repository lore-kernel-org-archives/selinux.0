Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB07836EABE
	for <selinux@vger.kernel.org>; Wed, 16 Sep 2026 03:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789529410; cv=none; b=edwCNUqfqMKohE3eZigW83qlgf+RSik6VhgDKB9BleYc358a78FjRTWOfLTkBxA87OzpURf8y1nJtzNW7NxXpsXMK3rtqtXqayLBfmzJEGCTPLyToLCwYv6WrGAxq29BxM7H1kC9414ovdwRiiA+tAd1kjsb1o8bkgJBcXKcCGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789529410; c=relaxed/simple;
	bh=lADoJEvJwLqad1Os9IZPoKdohrwVmSPNwKLow4aYg5Q=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=r0OBkfh1DZaZOyI9ToS3Z87FQRixQA6eiGqQKCreZKPUsDdkvEeBROValz/oj678nXCjWHoX00JAKVcV/k16YOift+wbvvkFfquxl+k1kXlklAXHd3iLmJoN8emQr/KM1z0xxdmq3xbvJmhO5FOV8jUur9Z24qaOnvdPF9/3eLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OH7+hthr; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OH7+hthr"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5309ce58730so6769881cf.2
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 20:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789529407; x=1790134207; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2bm31ePa7WsV8qeFRceTtEGTceD7Q/MB+XojEjfCZKc=;
        b=OH7+hthrzUpNeHKYeYOdtaWhni6Isql8vs2c0NKuX2NCWCbAI5wCrK2wt8OT8DqDHh
         8Gi53QBJ/6Zo9Tw8M4+KwkjWgeNIQpLoTKmQuom/wd0+/NLAG8ltlBrwcwddIlmxTg6Z
         8RtoohipTkW00LsL/fcLpylbxVHXJxkcSn4gOsfE2p4633GUSiJJ5+f+aGqLU0Y85tYR
         c6/TAle8X2TbiqyNNhhKIfFjq0Yh5Nu8DxIjXwLWWwP/us9kBevxJ1n0hwG1x/igfytA
         35UzFKqsCGhJiGCgOYjunMhQOpgSgeiMpFkGSJKeyFmeC0N9A2P/Sacij/ZqWZO9xLX+
         u9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789529407; x=1790134207;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2bm31ePa7WsV8qeFRceTtEGTceD7Q/MB+XojEjfCZKc=;
        b=lSFD+8sbK2aXadyRyTwGsC9VsWBBOT52abtWXomqMzFwFJB2dFGoHJmRPucFq+pD/O
         Ddh+tnpZH9tuULog73/kej1nMDCqorSJSEcpXbke7XQzXAwHKg5g4VgiFJ/nOvK1sy5w
         FgZC5M/dEG+btreHd4txAmW7MzVvk1O4LIQ/KZ8APfqcqYUYxDyL/VynEvU981bjDAtk
         nv3KBKEkpYeTPcTPwzEGhF743KF5j0psP7cLPgB96aahF7M+WuVM2xMAP2huqLSuDQKP
         YJyoTLStcTvp2myfxNxtrZoBtufLiBuE5qSIGR2CEqNja+CcZYw3UhNES20Un0SzLtWj
         01lQ==
X-Forwarded-Encrypted: i=1; AKwUvBwNfsMl+ZgFgj4sF1UJva9FWDXL9aeyHOONtgGwzE30DiCDKZKNGe3n1BIdaO5lDl7ZBOr9RCk8@vger.kernel.org
X-Gm-Message-State: AFuF++niU29wmU0da15pCXgVXnIn30FMeaiqoAtGLkD7BV2lHDHbPyHR
	/ADWoKym0ol1El0SSGQwBd1WvqnAQkwBJxzqZtlhtY2u9RS/TCl+9GvnnGx9DfbTQQ==
X-Gm-Gg: AYBFou1QvFfB5JJS9n+N/QT3rL8tRa1E8utL6vfRagu9xowJlnue47EUEMHbkrS6/Ru
	YWtsHwbfjxMBbWq3+Dvufh5hgtrPfhwZePBeNcffgSxa9XpcpArH2xQn/r4LIt//yAbIBMkFoFu
	hegHPN+Vwcwp/oACwl8+CCVujqmfQRBLRTE58e+q/g3ymU/1PrerrU/cjKZMkZmzC7eTOdVNrKw
	w6geHSeuIFDqmG/6oFho5wZOVpZYGSJTzg14Wcb16EQ05z7N1LKyZW3CGeLKZsr6E+F8u43dU0X
	rWvajGyFc7GCt6JhZMIs+SXcdhUF0v2z54cmjRKtuEsy3I/rkWcMYu1wBCeWjmwg9V9/MGdyhl9
	yNZVbIs1GByx1+rrywhxIgVXv4TxYuN8QLGXdWHonIy9Xg3xbkllSSDdVrAa2H0Y2ihQRoB/ItT
	xjMkCcZckqTtbCjil8dQAzCjh97h0T54m9WsphiNXq8YG4U5zlsa+cvX7xGzJeSwx5+WprfhxmP
	rUrFrV5vdEpr17L6vg7IGs55jsCIaJvExqqbjB2dK0X1X1jrSUEuaW7mOX53RaC0ixfCMjU5Ozc
X-Received: by 2002:ac8:6543:0:b0:530:b2e1:2f3d with SMTP id d75a77b69052e-5327f5a6abfmr16520821cf.52.1789529406632;
        Tue, 15 Sep 2026 20:30:06 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5326201c60bsm11362971cf.13.2026.09.15.20.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 20:30:05 -0700 (PDT)
Date: Tue, 15 Sep 2026 23:30:04 -0400
Message-ID: <44bb4aac4a7957bc4c2418967eaae790@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260915_1728/pstg-lib:20260915_1318/pstg-pwork:20260915_1728
From: Paul Moore <paul@paul-moore.com>
To: Karl Mehltretter <kmehltretter@gmail.com>, selinux@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, Christian Brauner <brauner@kernel.org>, Baokun Li <libaokun@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] selinux: recheck intermediate backing files on  mprotect
References: <20260829213256.51527-3-kmehltretter@gmail.com>
In-Reply-To: <20260829213256.51527-3-kmehltretter@gmail.com>

On Aug 29, 2026 Karl Mehltretter <kmehltretter@gmail.com> wrote:
> 
> mprotect() can be used to bypass the SELinux checks that mmap() performs
> against the intermediate layers of a stacked filesystem.
> 
> mmap() checks every backing layer as the request descends through the
> stack.  mprotect() only has the lowest backing file in vma->vm_file, so it
> rechecks the top-level user and the lowest mounter, but skips the mounters
> of every layer in between.  With two nested overlayfs mounts and a policy
> denying mounter_t -> middle_file_t:file { execute }, a direct
> mmap(PROT_EXEC) is denied:
> 
>   avc:  denied  { execute } for  pid=71 comm="nested_exec"
>     path="/payload" dev="overlay" ino=9
>     scontext=user_u:base_r:mounter_t
>     tcontext=user_u:object_r:middle_file_t tclass=file permissive=0
> 
> while mmap(PROT_NONE) followed by mprotect(PROT_EXEC) succeeds.
> 
> Preserve each intermediate path, mounter SID and file-description SID in
> the backing-file security blob, copying the saved entries when another
> backing layer is opened.  Allocate the array only for nested backing files,
> and release it and the path references in the backing_file_free hook.
> 
> During mprotect(), recheck fd { use } and the requested inode permissions
> for every saved mounter, and include the intermediate layers in the execmod
> checks.  Policy for nested stacking may then need to grant intermediate
> mounters what a direct mmap() already requires, and execmod on intermediate
> labels for binaries using text relocations.
> 
> Tested on arm64 QEMU with a small BusyBox initramfs and a purpose-built
> SELinux policy, on a mainline tree containing
> commit f2381b546e7e ("fs: fix user path of nested backing files").
> 
> Fixes: 82544d36b172 ("selinux: fix overlayfs mmap() and mprotect() access checks")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/hooks.c          | 141 ++++++++++++++++++++++++++----
>  security/selinux/include/objsec.h |   8 ++
>  2 files changed, 133 insertions(+), 16 deletions(-)

Merged into selinux/stable-7.3, thanks!

--
paul-moore.com
