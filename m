Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487CD3A7F50
	for <selinux@vger.kernel.org>; Tue, 30 Jun 2026 18:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782845212; cv=pass; b=LuJCFQlNRy1xBVpy+Q1S1MlmzMN69b0j5576X5cHh5CWhnl6ZuNx0KF22hzOdjjd0PO48AEFW7cKNgrhS25MfmQMusnSExsRfhZEoJy5kTqgUYQGnCHw1uHAEUG8rUuf7bSwEU44z8R611IlKSA/9+0DDYfZwXGgliDU7Dbv9uE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782845212; c=relaxed/simple;
	bh=/mr0mxcymU+YTx8PbSVH8xKSeGb4CtbjDq3BsjMlcFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oagPiu/M8JJzhHGRma+PV2v45T1fNxXfnq6PXyf8AACB0pzum4dwzFPP5oZDsNDk49Nnx/kAjUNjukI3CWDyw2kOk4OkfP9yPQaCitOrusikFsfaB9zKEZ4P0ixR7V0L8D/ZiHIjpYimoyQFo198NMemIu0uYzcJyiweryqTvzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQSgW7XY; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQSgW7XY"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8f0d6853360so18022446d6.0
        for <selinux@vger.kernel.org>; Tue, 30 Jun 2026 11:46:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782845210; cv=none;
        d=google.com; s=arc-20260327;
        b=piz7GsNAGLWOIAlNiwA/YOnn67yvCvT3O3oUlCax6U/QPS7qI0lmDb5QbifBnwTnxU
         X83AXQeG/cZkv0vmc6XuZzXgfzMcWVsVqHquFeYnNWwnRR4i8hYeEDT5vFiZmirm0SRN
         jkeS3Y2PoNOqa3lL1b7UL6XOCURhjTzVoFzcBgnqNUhXlIn950OkGP4YNNFz50iTRDjP
         ZXoYixnzw5LiB9QHmzc4mBUnj9WvFMAI1xJk/JKx4yRiPWSp30fYHLYfZYFCtKgrctaD
         TTBYMtHhBZOzsHVOPmh/j1tBeIKzAejFUyYd23j+YjIbrypMj+7qlLmWqtwZ30oY0ph6
         HLZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/mr0mxcymU+YTx8PbSVH8xKSeGb4CtbjDq3BsjMlcFI=;
        fh=a83HFKpSuQPJzyzoN1rO84dsH9o1Ej6pbTAY9s1AkDg=;
        b=gy/kGWwCp5ttluCKocEW9Jozrbct4t9hRgRgpoUx+J0PNkvpQSyU05ynNC59rafdlK
         m5zg6/CM1XNT4dv68ZiWJCQNLOAHyuCW/sdJp0ZDPBX6y2rfQg5SFwUbYjU3fAb5SQqF
         68I2h3wkbPpbr45ooBBMCb0FPhColiyfGy/pTNAbYmKueBebOjKUtW1EYyq42VUGTmfe
         RRB9NpncU41nJ8awSYzXQ5Iper6AV3sBXMQZ9/tOGvYY/5OuitpMS/Kg62K6Yd3bb1yN
         JYm9ChnAoHCqv9tPhqjI029L2YgkuKTknOSvRjppHcHWuCqfzF+2BQp93E/hXR1VdH8k
         FUOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782845210; x=1783450010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mr0mxcymU+YTx8PbSVH8xKSeGb4CtbjDq3BsjMlcFI=;
        b=EQSgW7XYwFqpR2UhR5oIjGjz1p7Sl5z7prkaHtU62QYm16o5fwYNMZbZzXDw4N1o7w
         TjaTc8/oiqjtm0zKD8i/CcS95pH2dm+43MADe2rn9aMf1hKPGLdSdl+rh7nEvSKdwdWb
         QjR+GW8xwXjKE83wXgRxXBKZFIbpxBvEorTFKDTnaw6FQqAGR1E6nY0qU6hw6SonOJ6f
         UnNgIa6B4mckZ2hxw1SIudwaouFYge5A1ubJndzfYxye9NPihpkUAmXXjBYL0RLjqY1x
         hVUSvSmtURF36OOyxm9jT4L44uwrOo02x0k956HPazkIOlQs3pQRuCDykMIY8f+Jh/HA
         PW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782845210; x=1783450010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/mr0mxcymU+YTx8PbSVH8xKSeGb4CtbjDq3BsjMlcFI=;
        b=AddLsMh9g2S2/QehtNbz2yBUQPP4MsGt4LJsZv9jmNou+8Q8CBeG1wriEX2lp0S6A+
         EjuPHwXQ3kMlqt9yORNJGFKrTPNzDiGeYPh3E0O0FMTP094xpfM1juMvDvEUMHS9qGMq
         szbtzRzKUL57h1hc0AB87JlIxD9T5yORMnQOhV9L+HhW1op0y+8VD2oJV4KP6pH3vHeJ
         a6JnRXD0nAy1BoTuqWApwMJPD+BmU9SrZq/oaiPXvYHbYxSVUSJl5hAhC59pV8G9A5l4
         eHXHNbHQFqYALBMXpwIRj6QXELbBIySRjrHQ2XEvMHQklaz5Cavmonw00X5ngBUKNL3j
         1IsA==
X-Forwarded-Encrypted: i=1; AHgh+Rr+Sz4uAztBTQq2W/1t1w7qHjU2yW1c67edE0U4nBxI7Y4tby2s/ua2MAVwdO47k0vcyuticCVx@vger.kernel.org
X-Gm-Message-State: AOJu0YykGhpacu1kWnAucJIgzoCxVyu7BRRVI+P6JX1foBCxFLFFNOoL
	j1b+HJzdIJTJ1UlwajDfduYYPt6MwdLFid2ksikgO9aP/juqHRoQCKpeJqFgvw7oUZcl9IyaeGY
	zv047j1QwxOPN12J3h2NuQuhvMI9c7MY=
X-Gm-Gg: AfdE7clhdw5VCJ6RAV5YzRMxCINRo9YtVMY+SlqZ106PPg20fq3ovUJHZYSzvgLkN/Q
	ZsDvl2zgyOzA5kBjxeXYaQcy6gRtg8AHy0eeQK4YRpz+Z6yvZkFpr6B432yW4y9jNX2cH0EIOW0
	NSwc81yoEYSsRVmX2OezdqO8C3woM7KU+zmj07aHl3H/A+mKfF65dXBCxYyc8GSRNYHD1ymcEKt
	5EPzdQMrw8p3pQ2pmbWlOhznnl8BvzgXkIMLXkUSNwHH7EwNLK+ahs5OPKoqvJ/3dhzV/admhuW
	47WauVPNG6We+0t3P3wxuT/srDffDZBAXtwk6A==
X-Received: by 2002:a05:6214:4d01:b0:8f0:b08d:1327 with SMTP id
 6a1803df08f44-8f1bab7325amr66906576d6.20.1782845210237; Tue, 30 Jun 2026
 11:46:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630183956.281293-1-dwindsor@gmail.com> <20260630183956.281293-3-dwindsor@gmail.com>
In-Reply-To: <20260630183956.281293-3-dwindsor@gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Tue, 30 Jun 2026 14:46:38 -0400
X-Gm-Features: AVVi8CeaiheJ3F5i-jO4LvtVLGlRB5U5ReoDcpDUEtFteA-6-xXjOCWxSS0LCkE
Message-ID: <CAEXv5_jCoYbs63RRukH44CMCxiOFzvWWraBOunKrgTVw+inUPg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/3] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 7:23=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
<snip>
>
> We expose a bunch of VFS heavy operations for various security modules
> and this is really not different. For xattrs we have it all centralized
> in the VFS and in general all VFS related bpf kfuncs should continue
> living there and be registered there. Anything that's just bpf infra
> specific can go to security/bpf/kfuncs.c instead. But anyway, it's a bpf
> specific helper so it's the bpf maintainer's call.

After Alexei's requested changes removing the attach-time checks,
there's really not much left to go in an LSM-specific kfuncs file. The
bpf infra plumbing for registering the kfunc and bpf_xattrs_used()
seem to be the only LSM-specific bits aside from the kfunc.

I am willing to put this code anywhere. I've tried to CC all involved
in all 3 patches, even though there's some split in concerns.
