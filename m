Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474062AD20
	for <selinux@vger.kernel.org>; Wed, 29 Oct 2025 00:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761696643; cv=none; b=C3MAB2MoKOG2OLPTzv9sJo2ZFugCwxW4FvZVSGOJO9/ftCwOJGCOz7Qhf79ocYm/AEW7T3HkSaw0JGXyGzNAliJfXv/YsJGNqK/bu0heniQZxGtjcfUptPlmON9PROvXWtQr35InenoqYPL9WFCGnK+QmJVvXllCd72wHxd5Qkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761696643; c=relaxed/simple;
	bh=QloRiWksfwupmAUdBgNLV/svbMoFmzJRlSMrdXPaxnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lnXh9BfdK3QyPNvuTvtRGUpLWB2uHsJuiE6/ZHr80qaXuo5BSw1M+2JoCQwglSEgM/TcdepVoVKuMZuZ5QYy58JZkAmm3C6Rl82L4/bIUxKSrXuWMPjct0JRrhpJVB2o6ATVUaMq85Xj5W+Mb5f3gpAmU2gj4f71U25gW6ADAGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=evHEHdUk; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="evHEHdUk"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33be037cf73so6884299a91.2
        for <selinux@vger.kernel.org>; Tue, 28 Oct 2025 17:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761696642; x=1762301442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAeYT3sIf5J+urxpWRZdGCYWbbcmjWbjfXki2vhXqBo=;
        b=evHEHdUkGc41clD3/HvS6TCsRDFkA9q6MEZ+Ee8ikmU90EW0nwK1uXakOJknKdIEYw
         UPOMfeEvBNhKrHjLjHr7xIYCpdId2KHIvvTrAsza0xQeogPNi8UwwvqaI96FT8ITZ8vQ
         uzFC0R7kneeJXGfF8/cqcxLa3ozJQN2E70B69L9NShTl9bB++pcLxc0q3bhCZ6JHhbk2
         c7LXeRcZcT65SzKjp7o+Ph+jEW+BDN8aORwZ2Q6/pPfvCmUIvEEXu+nEyBOVi1hFu8Rr
         SUBY5Gz0grZxmej8kpSYf3nSsLE60De2XMA1fzyVirRng1clt1tCPFYnLsbjXnIXjkwS
         8jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761696642; x=1762301442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAeYT3sIf5J+urxpWRZdGCYWbbcmjWbjfXki2vhXqBo=;
        b=FK2fIlLuAXxo9aUXouWt1jf9vFb4C9rOs/xg30kBqpgvJNNZD+SgwkV+dJNHkMhBex
         ckK8icx4dAny2vrNr8NSxZMC1OAG3Ok7TvOsSWS+pEH5x7pB3A7aaBl2MNX/awCmdS1O
         VsMD5hAXdyEHpiswsz+5Kqf0LlYwhOaPajXA9j9W0gUBXhd/12z3bVkJRPvVL8pSlAs0
         Tfw+ohyPvgzvPMaLXUMPruFW9tQtBwMDS6EPqawaXnu9PAYSKaDnU7eQ4Wbj5XEv4epH
         0XkMcGRAAMTAm+m85X5CdoQTCfjA9p8S5Aor+fdKu+yH92MH2NVDd2aBnZM5Xm1P7yPC
         Uohg==
X-Forwarded-Encrypted: i=1; AJvYcCWn/torU6a6YvhC2PaVLSHGVTqv9YEJkefAJwRNehbMxzn+2z1bROHzZx8DdmH2+oGYeFppM2rI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz19aA0vY64sg1fQfqtxq+W/jul4+Wlp0fEKxFJcNkxHoJAJafo
	pK8s//mHWpkS4dFEU2dS2AaKxfOLT8dIbVfAzi8gkm9mN4o/+BNWGgNhSTnjJvCw3yw47QnhMnW
	XhBZLzZqg5xouk4AP9RRf0FdXojvCgPLNCuw5RPrt
X-Gm-Gg: ASbGncvRwXeGhZb2HVtl5GazSD0QzUX/k071SpISDPd4/JHk2mw6YfjvKqM0avzAx7y
	SoH5O5xLnVP5jbqVbrrA/zbhFGrJdOUnLY1RVqK0A5BMrra77u89aHA9MHW3wVuQIYOD5f1+wnx
	W6cOst6kCC1FkN3u+VJrLjuymEFrqfkk1tXm8s3bfZGL3+dtJjGHc0A4zML5VQIt/UpQVBiMIGr
	KhxlloiEG8nOLZpEl8kdUXzntm3a4U8JzFR7qBKCPfJ7yyrVgEGIAYSSgfZ
X-Google-Smtp-Source: AGHT+IGhjs8q4GiygXwr6DCqhQXMqWhNs5oaPfnq5KAn4id0agHe+xmdqRLWlZPNOFZ/N+dUgAnaM8QQHq+RXzkh3rE=
X-Received: by 2002:a17:90b:4c8c:b0:32e:d600:4fdb with SMTP id
 98e67ed59e1d1-3403a2a1014mr987268a91.18.1761696641654; Tue, 28 Oct 2025
 17:10:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk> <20251028004614.393374-49-viro@zeniv.linux.org.uk>
In-Reply-To: <20251028004614.393374-49-viro@zeniv.linux.org.uk>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Oct 2025 20:10:29 -0400
X-Gm-Features: AWmQ_bnyVa46lrJnSEC4p7b8a6-fhgKBPo6xvMl8XVNnPJL6uMjYjs2dxSO45Ps
Message-ID: <CAHC9VhRX6kqFbbKuOoKOLLve6c+7TN3=fXHrtXyj=osfNYd+2A@mail.gmail.com>
Subject: Re: [PATCH v2 48/50] convert securityfs
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, raven@themaw.net, miklos@szeredi.hu, 
	neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org, 
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, kees@kernel.org, 
	rostedt@goodmis.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 8:46=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> securityfs uses simple_recursive_removal(), but does not bother to mark
> dentries persistent.  This is the only place where it still happens; get
> rid of that irregularity.
>
> * use simple_{start,done}_creating() and d_make_persitent(); kill_litter_=
super()
> use was already gone, since we empty the filesystem instance before it ge=
ts
> shut down.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  security/inode.c | 33 ++++++++++++---------------------
>  1 file changed, 12 insertions(+), 21 deletions(-)

Much cleaner now.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
