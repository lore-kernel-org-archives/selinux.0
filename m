Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7C6145FED
	for <selinux@vger.kernel.org>; Mon, 29 Jul 2024 11:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722254305; cv=none; b=bKXxrjxhXibvPd8dQd+SNnz5BRi0gvG12iWbZ7pjwbsOh1vQeT+6vOxFdyflAiLXqB9Bx3bU4b6KC/2hhlTxoW5KuK8kSfhowP2UKRWFw6NyObjImyUsJWFlVm9C/TJhvQE9IZFS1yIfSBdAiyddWtMEpJfhivgxXueH/1Npx5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722254305; c=relaxed/simple;
	bh=66ayRA1lHfwmXqoAYgYEjZHenh9jdVtf7KDHCWN5OIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dT72kJHsJ1C7uhH2i+z3haLAwVsylR7H0R6YEuFxuTzxmHIregjZ2guXgkkkZj4YyTvZJc4ve9YtBPSo1CVHgPuZU193JQdYX7P7mivyKpe3r/cb4SBgyzullA5t9pXWlnnQSHJ9R4PxTwozZi+T2Lsv3zXjjv/N8aWWMcSbo/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2PkR83N; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2PkR83N"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7a130ae7126so2292400a12.0
        for <selinux@vger.kernel.org>; Mon, 29 Jul 2024 04:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722254304; x=1722859104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95CTbvk3VHZEf3H9OLH0mGhZoY/abRJJBTcdMnNQlEs=;
        b=I2PkR83Nxz2LYLNu8iMwmlHlG5Q/wOrmEK+kg65a1Vu918ST5oqOy7QJE1mtxp65fW
         2I9MuoyHjd7vF6hG/5/8GxbRbAGmXKvkwINOI02TlYrtzeyC8d8XmMWGtFLGtE3lLxgD
         bCzhCgUXnil/q49Fup/58Xdl/bX62Hl5oYTaPaWttZXXO5twqjc6BNjws/ABVzm25f1n
         Js2xW+BYO/tFGZEURl8kVwOOpwzKPCsileGgpaqESBSLjFuZ3NO4joGLHeFqX9Oj6Rw1
         SEK5r1Thinba4StpSWwBi+sP9yBJcMpvAYksAjZK3Yzo6UHWAa2rNQPmASfkNxWl6P0R
         WS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722254304; x=1722859104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95CTbvk3VHZEf3H9OLH0mGhZoY/abRJJBTcdMnNQlEs=;
        b=maRjZRyYeQ+oECfyAPfy6HNk8NQqxaeOLMu/QuoR1MUQvDTPwbxQBw3PyUTSOOPt75
         ZzO90zGA3AaRfWLzuxt3LGR+pBWQzJwwqywiO+AWPZ354uZ4/0rppshrQ1PqI9iFi/mi
         lX34tOqDgrqyc3EtV0TongN18GoZLOVaSBt2MAhXo35GvP5KaTeDHX8+sdEDOqJWQVgR
         ryTDpz+LssMmqhQO5bQyuoTkJdThyYyF7jbddh+t/2+/X9mphSXmJ2F42guIPEd3Iu/A
         myMvMhA6fhlknVLlAj/HiQ/17ceQAyE6oGBLugp8GTIgbwvC+H/lBaAU+nIPgVGoHhva
         Pm/A==
X-Gm-Message-State: AOJu0YwDKd1wWZOrc60AC+OE0FfKQowFUqeODcrfjqDpnkPLmBm759jG
	JgjjauyPc6OFnXFAveoOMC1sYOLpvTZ9YTDdqIyzUZF63Kn10A1KX3t4Uv7FyjpdUy9g1r+7Ahu
	SqATFfZQ+SGbCLTHVVLBa5bJfsKencg==
X-Google-Smtp-Source: AGHT+IEsLZPoTsU3PT1fvP5p4P2KHFe2433LjKARfSofA8i+xGkJLjKV+GhWe9UYWr66GLXr1ZWwS0n2lQ//fJ28tBc=
X-Received: by 2002:a17:90b:1c86:b0:2c1:a9a2:fcea with SMTP id
 98e67ed59e1d1-2cf7e20f3bemr8832325a91.24.1722254303716; Mon, 29 Jul 2024
 04:58:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ4bQZeZzLGdk0HPFPkm4uob7oHB7sygyXQo2km9BAK5Xg@mail.gmail.com>
 <20240729113247.1673713-1-vmojzis@redhat.com> <CAEjxPJ4ymgQyf2rzD4exOZ5jQ71B=1a+AVswN4+dM3=LU2RFyQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ4ymgQyf2rzD4exOZ5jQ71B=1a+AVswN4+dM3=LU2RFyQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 29 Jul 2024 07:58:11 -0400
Message-ID: <CAEjxPJ56=x_-w_7hL07wDjh_CAaYb1tAMr5hri7Ct85_9DVq2Q@mail.gmail.com>
Subject: Re: [PATCH v5] libsemanage: Preserve file context and ownership in
 policy store
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 7:44=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jul 29, 2024 at 7:33=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> w=
rote:
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
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> > ---
> > Changes in V5:
> >  - Check return value of fchown and warn user if it fails
> >
> > Should I start creating github pull requests for each patch to catch th=
is
> > type of issue in the future (so that I don't waste your time)?
>
> You don't need to create a PR to trigger the GitHub CI testing; just
> push the change to a branch of your own fork of the selinux repo and
> it will run the tests for you.

And this patch has also been applied to main. Thanks!
