Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE1546D559
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 13:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184083; cv=pass; b=WL2yusZsjaytxE+kLaxf3KU8zz5RIwKHZXAZEs4Erpi4ittrV+zHLIx9BOKpBz3y3C68NH1er++RXkcYsGw6DXjo3AE9U/aS+7CocUSN8dH1QFFsEpKWC6IJZTExypQk50XnPqK/MbzOev4lI637Rec2s9r9IIiPRqjpZ4s9ruY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184083; c=relaxed/simple;
	bh=6EmNPbgdthlv6HmYz6yjs79CFf+7Dk2QeNRcHQINiD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k2n+E36tpsc9NMHj/tNmgxLyNrWKgBaN3Jyn9WKG3EB185+blXtvZzRd8FRO6JWImWTHKhB5ilqjXF2orzLUHSQ0kdzN08o+CEc1PX8jKWCgiLFhVnDdNqIJ0T7zdkomf+Riif31CwAjOOUCVtRf/NkFYSVdGjIE54bgUnoscaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3NnNCrv; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3NnNCrv"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6b1b233ca98so990817eaf.1
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 06:48:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788184079; cv=none;
        d=google.com; s=arc-20260327;
        b=cvWPQK8Ff0wCWpxHjc6aouy9mgUsl5CkFtiO+noTn/twepGSIqKuBJi26OCYf/yg3q
         QF2tC4ZfTSYNyW918fXiPXgEQ4Tck+LG5xfJeOWs+h1n79G7WtIxuBh/gzXPkMmBNDS5
         scX/S9Bh/L58m7V4UpiwsnjAPW/h0FDfnyKvatSlPocQ6YwlUgXfnUYYTIdGyFu6xPTt
         XoE7kshAl7NA2Rv6yId78X6mGqkEZvxcoXFhMjXk1bZ9P9df+q9TvNu2Qzb0spdInm5V
         VmJDoTc6o5jOxsKqYtonoAhdvzSpDXM15UfdqpURnt6Q8CkukbOD8cqdK9L0yDRrklpL
         ky1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3dOxHAFAAnCNkFLAXANF8z/KGOYsJeBy4b5mYI3CnXY=;
        fh=/d4M6ijv21gr6cxMRV0NkeUq44hA+vKyTwiRbY3swvA=;
        b=azR++XESPpGaERpNFPOdjaTuglgVToXoY9mwBoBfkDYYfF14/xE8FX6LOJwIoDxh/d
         ccCH07YVewxaYhJHfADPLmQWOYmpqEEKwOUTYOlyou4oJcGxN7MEQGONQ0NtJ/wCOtkk
         zatuRZvf/HOOJNyoMbQkEBq07iMk5rbeH0ArzQUTOaOoNjyYUykz4i9gMNwiR8gXEnWQ
         bgHO3P7Ynv2UjCcmXCA5198/N9dZqaDJ6ODL+nQ47HJTqXHd9YF1LJB+rMTstvXv3JA3
         iJWlWD3LZY7dlueyHPJ9VFso0qmBgFMrBJMHOUjU31kdwALWmXNKYaAmQ55q3qFYwzgR
         v/7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788184079; x=1788788879; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3dOxHAFAAnCNkFLAXANF8z/KGOYsJeBy4b5mYI3CnXY=;
        b=O3NnNCrv8fE+NwgENRV1hTWmfNlmYQ04qnTpHeyCr23Fszt14vlRqOb1klG6VGPuIM
         r9JvptzArNTlUaDCIVnBbcOnJlAXLK0rOsOwNyeFRLDTJN7Ixj5DAyrBA3azQthyUG09
         VcYxjs4FbKX9TWSTCJOCoWJWTtMJfd9MGYJwhRIsmikqdUB6MSzZazHPeGV52sYQ89Pm
         rxusbQb1lj8/HjcHXMP8lJuOkl5EAfWJb61G9cesuVJwIP9CvBzcA2zdtsNX3eN60f7m
         BQ3xS2p/vG3UzbWx86PniiA04tVscsBreLzSJx5XMZRV/X0UoLfGYgGEz/jz90bICLKP
         NMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788184079; x=1788788879;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3dOxHAFAAnCNkFLAXANF8z/KGOYsJeBy4b5mYI3CnXY=;
        b=ZjsxFiM8B6vseyQ42CtF4IqLAJ1RyHod32ujbSchmgonJUZwn1B66WW5DpJwKHd8H2
         Zwx34bgOjF6j+Uaur98+tIBUEvOdFu7rg+p0Z4QLdoseSugv3jdq0xnq++O9XrGmgLLJ
         7jFNLw0IZgMnoA2DhTb2Jaro6j2A7j0RI8pTYOV48BAptZU+cGPYnvWW4xSxPVU3GZgw
         aJ/GBOoqQ9K2XD7v/YtfXes9Vlyyb7v+RkhiZXFMlKCQlDarN8/cecQLBi59oEuWRQiK
         9B1U82Lfq0z3qiKyAxNqwDfsG+57930UgzJF7IxvmpXRd4Fu7NEQrYtmo5WsL2Qt0MEb
         /F1g==
X-Gm-Message-State: AFuF++kRHsWLK9bjU1IFUc4KxS5HJvPeQQ9DMJ4rEcp1v6mYJk3U3FSn
	Jmlx1uXezKYMqamoXKN5SOviLH/bFyvmyE5EEBJafjDxZ5d+00vq2vthoDGbNlMu4g2TiycMnjH
	Xdq6p7SNZO7/ilsGgaGc2LXSKsGEiomrS1nYh
X-Gm-Gg: AR+sD12qRpQQYXK0a2znKIdIAqvnxpSii3onJSaUC2N5LFJGR+9tI680cTlFKlu9UEX
	WwGJetzI33MuwbJBg34kMfEdp4xnvDJiCxBdDYvLCxcObFzUWCevpProwrO3hhy2byHpxWSIHHC
	icaed9ndmDOyWEo77+uK4SszJ0UJBQ4U3d3KMIJDyCskwhGx3av6GGhld6RsYJDoDyxYd12yyef
	Ri/2/LC6IbgWz2cVW6HdNmFjLHG/wTdlV+qzhm51JTa9ze20P4GiV86H9SUlDQygIPaznS1sHzT
	OIE1CKNgov/zUcSyXvfWc+5xbuq/N+O9O+zEIVRlaYhawLJ21lXRmdt3
X-Received: by 2002:a05:6820:26a:b0:6ae:c68b:3a7 with SMTP id
 006d021491bc7-6b1c6753623mr18493696eaf.16.1788184078901; Mon, 31 Aug 2026
 06:47:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260829213256.51527-1-kmehltretter@gmail.com> <20260829213256.51527-3-kmehltretter@gmail.com>
In-Reply-To: <20260829213256.51527-3-kmehltretter@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 31 Aug 2026 09:47:47 -0400
X-Gm-Features: AcwNN1W99CqXWvenoG8rROnmu5fRwQuT08OeAJUbXEa2X-h97G_VigU5iiBhoYc
Message-ID: <CAEjxPJ6TRV5CZyuMHatON021ptwzfhsniVKER-vE6ASh0qhpRQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] selinux: recheck intermediate backing files on mprotect
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	Baokun Li <libaokun@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 29, 2026 at 5:33=E2=80=AFPM Karl Mehltretter <kmehltretter@gmai=
l.com> wrote:
>
> mprotect() can be used to bypass the SELinux checks that mmap() performs
> against the intermediate layers of a stacked filesystem.
>
> mmap() checks every backing layer as the request descends through the
> stack.  mprotect() only has the lowest backing file in vma->vm_file, so i=
t
> rechecks the top-level user and the lowest mounter, but skips the mounter=
s
> of every layer in between.  With two nested overlayfs mounts and a policy
> denying mounter_t -> middle_file_t:file { execute }, a direct
> mmap(PROT_EXEC) is denied:
>
>   avc:  denied  { execute } for  pid=3D71 comm=3D"nested_exec"
>     path=3D"/payload" dev=3D"overlay" ino=3D9
>     scontext=3Duser_u:base_r:mounter_t
>     tcontext=3Duser_u:object_r:middle_file_t tclass=3Dfile permissive=3D0
>
> while mmap(PROT_NONE) followed by mprotect(PROT_EXEC) succeeds.
>
> Preserve each intermediate path, mounter SID and file-description SID in
> the backing-file security blob, copying the saved entries when another
> backing layer is opened.  Allocate the array only for nested backing file=
s,
> and release it and the path references in the backing_file_free hook.
>
> During mprotect(), recheck fd { use } and the requested inode permissions
> for every saved mounter, and include the intermediate layers in the execm=
od
> checks.  Policy for nested stacking may then need to grant intermediate
> mounters what a direct mmap() already requires, and execmod on intermedia=
te
> labels for binaries using text relocations.
>
> Tested on arm64 QEMU with a small BusyBox initramfs and a purpose-built
> SELinux policy, on a mainline tree containing
> commit f2381b546e7e ("fs: fix user path of nested backing files").
>
> Fixes: 82544d36b172 ("selinux: fix overlayfs mmap() and mprotect() access=
 checks")
> Cc: <stable@vger.kernel.org>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
