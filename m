Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA0918AEA
	for <selinux@vger.kernel.org>; Fri, 26 Jul 2024 17:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722016462; cv=none; b=R77zZLml4tvljtLf9cnmBPLj8FRQT2cbe3p+0E68j8u53KDJqxLS5CVKbsAI6a3VL7wg9JNeSnij3qtRDCPG6bnKRY9Ofabdrhq1GiO4ON9Q/E7GPQkE62eRRIpwFSA1H68dZm6phIsRgb+lJqUCJeG8IeYEfb4k75eOENHssKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722016462; c=relaxed/simple;
	bh=SddvNEbDo8qvgZSKH9ERTMQHB8TWcPFbmlC8UnNjOW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mMbvyBJyzUv+++rv5bjd8D03pQPJI57Z0I17oDr8eqWPWOD3gufPq8v2JXiaE5wFk8JhAHH5ABjaK9DXPLy6I8PN2PMBBAy5zTpimKBHHWpYVeCfHCEHyXjEWtxGm6v9RdEFVvbsf6eThXdLe0OGEgd3qDPKuOGoSBYB7WtmehI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKd5+nJt; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKd5+nJt"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2cb09dc1dafso887847a91.2
        for <selinux@vger.kernel.org>; Fri, 26 Jul 2024 10:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722016461; x=1722621261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTO8ddm9U9MZLzCL9oiPj5X+e4pVQJfDmscjOpnCBZ4=;
        b=CKd5+nJtO6TBUcIWDnOw+abQZhXCyA3foCSx69wJhehLBu+R64APstDU+uZWNIL5C9
         5fc4jpfKJW1odrmIRAUufde+bZJIBwmi6yHenieWcwtqq//vDhtlm4KkcPh0TSxRBMpO
         PlxC4b6/n2aJdomw2P4QmBGIxsA68fJQ85Ir7E2QDZkaELIoqgZMTLH1MviFYML5ImSk
         a3BShLrpP92foSTOUPyCgPd8X8pU0SnXo82XAOTcM+xH9/v7vJYdzB80Qc17n2xYruzd
         FZbrM7M4tPGQVZSKOFkDWbCAa+EYJxtmmO8fPAwFlv0/A3l6mZQcI7OtXi+2HLrSQO/j
         b6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722016461; x=1722621261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTO8ddm9U9MZLzCL9oiPj5X+e4pVQJfDmscjOpnCBZ4=;
        b=IGcHFtrMDtZXg/n2YYkOha0Rx2cAAJhoSGhxKQS8gfhqwzS1caHsWm3sJbsOgwwiaZ
         dSpn0jJ4NVuhofNnD5risGGPTXXy7ITf6NXBxQ2aA2ZnJQk4l3TO0bfmqJ9DIkTccp7J
         ztgwj0i5XpoEmCqvBvxB1PytvkQ91Z5yVMAFIYYYkgHM6Y4ECv5ePjbThvCSKMe8CgGK
         gGd7UUCfUaIrPGuaf6Baw3cXW0KfH1QDvoFcZ7EVxBfoqfwLRVYe+hXVqtrvKjWI8Exa
         +2I8oJaAiQVJIOABX4Gz5KXpQDgqbSFjCw/onZoVIVgvechjvSukD+woRvs2B5UnNqiY
         +RWA==
X-Gm-Message-State: AOJu0Yz0oDztd0hqB3dNr0Zy0DjgsMrXBBg3BHQ1PkrchOaXQT7y6jBS
	w/FYl3PkMyidDQJzSgXoajuzTemMs0MJBul2qbhg1A9DqupAeadn5ymz4ap/5AT+pKe1uTGdNBg
	12FjPn4JlpcvekwI/k7GXDIIBg3k=
X-Google-Smtp-Source: AGHT+IE7SbxuhYLSutjtZKJRpkQxXxb9+P+AViPyRlXHwh91wsD/iAqGft8ISowqaIbl1qt/UpQ5DxLnkOvppb1grdU=
X-Received: by 2002:a17:90b:1bca:b0:2c9:cf1d:1bcc with SMTP id
 98e67ed59e1d1-2cf7e726983mr262249a91.36.1722016460604; Fri, 26 Jul 2024
 10:54:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b4ec6621-dbbb-4f59-9d2e-7fd4edc6b116@redhat.com>
 <20240725161107.1446978-1-vmojzis@redhat.com> <CAEjxPJ72F11Y2qSa4A6xaU=gdOt18u2H9OOqhZwv0RFkR0OEfg@mail.gmail.com>
In-Reply-To: <CAEjxPJ72F11Y2qSa4A6xaU=gdOt18u2H9OOqhZwv0RFkR0OEfg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 26 Jul 2024 13:54:09 -0400
Message-ID: <CAEjxPJ6_FN9NuO-jHmnPVFqypt=6Pxyko9J1=G9xQdC+umWEmA@mail.gmail.com>
Subject: Re: [PATCH v4] libsemanage: Preserve file context and ownership in
 policy store
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 1:50=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jul 25, 2024 at 12:11=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com> =
wrote:
> >
> > Make sure that file context (all parts) and ownership of
> > files/directories in policy store does not change no matter which user
> > and under which context executes policy rebuild.
> >
> > Fixes:
> >   # semodule -B
> >   # ls -lZ  /etc/selinux/targeted/contexts/files
> >
> > -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0 421397 =
Jul 11 09:57 file_contexts
> > -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0 593470 =
Jul 11 09:57 file_contexts.bin
> > -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0  14704 =
Jul 11 09:57 file_contexts.homedirs
> > -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0  20289 =
Jul 11 09:57 file_contexts.homedirs.bin
> >
> >   SELinux user changed from system_u to the user used to execute semodu=
le
> >
> >   # capsh --user=3Dtestuser --caps=3D"cap_dac_override,cap_chown+eip" -=
-addamb=3Dcap_dac_override,cap_chown -- -c "semodule -B"
> >   # ls -lZ  /etc/selinux/targeted/contexts/files
> >
> > -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0=
 421397 Jul 19 09:10 file_contexts
> > -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0=
 593470 Jul 19 09:10 file_contexts.bin
> > -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0=
  14704 Jul 19 09:10 file_contexts.homedirs
> > -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0=
  20289 Jul 19 09:10 file_contexts.homedirs.bin
> >
> >   Both file context and ownership changed -- causes remote login
> >   failures and other issues in some scenarios.
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>
> With the selinux/restorecon.h fix applied first,
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Ah, spoke too soon. The GitHub CI testing failed with this:
semanage_store.c: In function =E2=80=98semanage_setfiles=E2=80=99:
520 semanage_store.c:3047:25: error: ignoring return value of =E2=80=98fcho=
wn=E2=80=99
declared with attribute =E2=80=98warn_unused_result=E2=80=99 [-Werror=3Dunu=
sed-result]
521 3047 | fchown(fd, 0, 0);
522 | ^~~~~~~~~~~~~~~~
