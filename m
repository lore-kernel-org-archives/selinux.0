Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15797254B18
	for <selinux@vger.kernel.org>; Tue,  2 Dec 2025 08:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764665216; cv=none; b=CaSC6sauXHV2a2rr9ur8nH9DSTpQ2Ed8XOcYGuP+Xc/46GaE3+umB4cN3XDT4V9V1xUwg8MjmSk2Qhtn+6HGOOao10/FxNLdE55Q7hvRKsFhQcWOJaXZJc/hpK9Hynu7JsNKIz0YD2FTWCMx2vnc9Aw5HbxulCBuLXgdwj/BRhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764665216; c=relaxed/simple;
	bh=qcpxFQirLzafdSnNIq92XhuOn+HzWCu4AcZ2SW0UjqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t4BtovtT16OSWETXotPi2ZIS7lixpGiMSlwqLsp45WyqcvfhSweKr0cXqz/Cw49yQshYAhueM5Sx6N9flD6dD+ko2corIGOYQTfwtqL2WY5sBA95x8LXUY82BF81FL13uTKJaSWyp8AKD4J+jGSR8lpj0vlGHPZQ8WnFL/MQx4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=bbbrFs6+; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="bbbrFs6+"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ee0ce50b95so53517181cf.0
        for <selinux@vger.kernel.org>; Tue, 02 Dec 2025 00:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1764665213; x=1765270013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dxvySic7ZCI3Kve7CCt8lN1Lme0d3OPvrFfTikR164w=;
        b=bbbrFs6+5vw0v4zASrPuLyid+iafPWKvHeYf/XOZ4RlTfrAcYHZVAdk6e+pk3VUvT5
         48D6eTBCgo/3krpFsqeWdnF8GCD9YaUPsH9bnVDmtOnvHdlmeiRQ7K1+nPucKysf1DKV
         mmqSSKGrjMO7aaGrUT4vdZIAqeiNk+895+LjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764665213; x=1765270013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxvySic7ZCI3Kve7CCt8lN1Lme0d3OPvrFfTikR164w=;
        b=VaVDvoiDMDCN6EPlUdGE+oPz62YN1pv2enJCjTMqOTPZQQT9MYO61W2651xVuUKGiA
         DlGlaqG3NpIEKbn7WNKYQk41Kh44gTgnrsYlEbN0cpi5X1tL1O5jI+M1h5H12i3BUdVq
         E1LtQXXe2trVS51n5CblouW0NOsLM7zgidtLBvK2UOALDNxljt3UOCTEtbPO7EUeqkZX
         UVYlFefTlZ4xm/bEKJYI+s5KVKFfAn0XkupOtdwfBd5bPlyMcLRgDVfiYS9xuAhgm8vO
         d4zyT0DslLF92D14zYDRbHsdy/tCfONwYt9GdTVN/fA5KJwqJDKyrb38DNV8VFIzlCYM
         qfVg==
X-Forwarded-Encrypted: i=1; AJvYcCU9OpLIGl0qHbjRgYgJzlDsLElNUOks10SaWDnb8cW6AWVpi09MEknPS0Fbm7ck4pdsENZKT6dt@vger.kernel.org
X-Gm-Message-State: AOJu0YzFGMIn5YLru4Uar8nCQKs1VzcidoRPXsk2cauSed+3wAjOdCCT
	TYU736x+5iEz+8KzKKri+LQ5l0yDGasxnpyz0zXNKMM+zbqsuJ9HfiVbOV9c9O5gk/1CT4Q5ClG
	RBERX4SLA2ylL4prc7D0UrqoTFWnQZlc0CmOshKYWEw==
X-Gm-Gg: ASbGncvOoKTPEO/q1T49wgNI6BiOyxQ8nRQaA7bcf5Py10khpnIZW454/EhgERg6wpD
	Tin+yf/izVi8ciVPAm9Wiw4/dpdByH3M10o0MDUhmSN34dwPqrw4HDypLO6leFBrhz7MTxfLD4q
	mMfMsSeyNIX7yDqGSeJgTODlJiD5DweRpQ4JnAT5g36mnPmMv1/bKXp98Vcs7x+pCuQAIQH0SGC
	mIg0EoLDn8E4I8glVTQACEHlPiIKvK8csOZqC29V9GWq51jCndjTuYddPNAAxTBjc6B3w==
X-Google-Smtp-Source: AGHT+IEmdgKRfEJt7lhW9JewHKYA/V5LXGRt+5HoCO1i6voev0VJmL65LKUm+BLjfUqBCpppRBhIODxs9MlwVlA6duw=
X-Received: by 2002:ac8:7dc2:0:b0:4ee:1f69:fdeb with SMTP id
 d75a77b69052e-4f0088dcc91mr26981181cf.11.1764665212783; Tue, 02 Dec 2025
 00:46:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113002050.676694-1-neilb@ownmail.net> <20251113002050.676694-7-neilb@ownmail.net>
 <6713ea38-b583-4c86-b74a-bea55652851d@packett.cool> <176454037897.634289.3566631742434963788@noble.neil.brown.name>
 <CAOQ4uxjihcBxJzckbJis8hGcWO61QKhiqeGH+hDkTUkDhu23Ww@mail.gmail.com>
 <20251201083324.GA3538@ZenIV> <CAJfpegs+o01jgY76WsGnk9j41LS5V0JQSk--d6xsJJp4VjTh8Q@mail.gmail.com>
 <20251201170813.GH3538@ZenIV>
In-Reply-To: <20251201170813.GH3538@ZenIV>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 2 Dec 2025 09:46:41 +0100
X-Gm-Features: AWmQ_blWv82I_AJ0z54S1o3oAiX82VQ2RDfse7yanE0u3ZklpA9ZzlQdeqtb1vo
Message-ID: <CAJfpegtJDJL7T0-Uj664xOm4N2e6fyJp_XwFecHX_9e9ipUyEw@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix conversion of fuse_reverse_inval_entry() to start_removing()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>, NeilBrown <neil@brown.name>, 
	Christian Brauner <brauner@kernel.org>, Val Packett <val@packett.cool>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, David Howells <dhowells@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Tyler Hicks <code@tyhicks.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Carlos Maiolino <cem@kernel.org>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Stefan Berger <stefanb@linux.ibm.com>, "Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, ecryptfs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Dec 2025 at 18:08, Al Viro <viro@zeniv.linux.org.uk> wrote:

> Then as far as VFS is concerned, it's an equivalent of "we'd done
> a dcache lookup and revalidate told us to bugger off", which does
> *not* need locking the parent - the same sequence can very well
> happen without touching any inode locks.

Okay.

> IOW, from the point of view of locking protocol changes that's not
> a removal at all.
>
> Or do you need them serialized for fuse-internal purposes?

Not as far as I can see. As to any fuse filesystem being reliant on
this behavior, I think that's unlikely, though it's sort of documented
in the libfuse APIs as:

 * To avoid a deadlock this function must not be called in the
 * execution path of a related filesystem operation or within any code
 * that could hold a lock that could be needed to execute such an
 * operation. As of kernel 4.18, a "related operation" is a lookup(),
 * symlink(), mknod(), mkdir(), unlink(), rename(), link() or create()
 * request for the parent, and a setattr(), unlink(), rmdir(),
 * rename(), setxattr(), removexattr(), readdir() or readdirplus()
 * request for the inode itself.

Why the locking was added in the first place?  Oversight, probably.

Thanks,
Miklos
