Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DA7335071
	for <selinux@vger.kernel.org>; Tue, 11 Nov 2025 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762856573; cv=none; b=cMCoYEF9zHaw6TPkLUbDZB7IyfMt4Fs7eGCqdMo1WJrP5DHiVS3dIAFyDnwD/3iEzuqZMsMXNU51FmIRybEDd/05u52fYhKurc1RJQJXPJPMANVcuDxJChYxQuaka44HxjRraDe0z60NY2bhOsAT9cM/G3qJUGQVxUzhCYGq0FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762856573; c=relaxed/simple;
	bh=JrxCJS6doR540ni5O4K+fTfT2J1vhfEKtnYrNkU/J6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gNyZDrpyzzeW0TnusJ6tVkd5oIMNjE/qIaK3qKrnDobn1xv0R/BuQPLDueeJ+FK32PdTnXXCzH2vHcXv1l+QJk/noldhtr8X2ZpLAhX0g0KGiH5QTXr3jyw+hBknJb3V1bjdCDS+l7ntc0F6BSFs3DhMQQchwqx1kmia/N4FpxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Cxh7bLzT; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Cxh7bLzT"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4edb2eef810so32516031cf.0
        for <selinux@vger.kernel.org>; Tue, 11 Nov 2025 02:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1762856571; x=1763461371; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gr4TOuugTT1EseGcVB5iZB82tbqvLcivaLR74+txrKo=;
        b=Cxh7bLzTrr9BQePvVGjJ40vDC0NZ2fTThVB7BYFO3Iak6qyEFFlUvplymWg0joF7Q3
         HVvSugfkZBwk1iaxvYjWFo+NLRPZYh1e5zW3LFB3CpoBIX+SjOYunRJ+TM2+q8sIqGZU
         epcQ5oRizTN8F+VsWK6pLYxh6lReG0wjdPWAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762856571; x=1763461371;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gr4TOuugTT1EseGcVB5iZB82tbqvLcivaLR74+txrKo=;
        b=SUGe/H1yxqanx//NqxqCMK+5W3dkZrKtmt6qET1+Xt7339ckd2RTg4/WixnxJJiXBf
         ajNCSj6L3CCLDFJJnfaIExKlS/WxypQT+nAonJl7j0B5ALoKC64RN2DzCmtvItzNrhD+
         +igOaTYLLlsuH0sqZnAmMUZcHmGt5jmAKpyGi7RPZP0suPfO4ZbVfaKEkcgpcXOay4f7
         Phs4L4OWfKrZ3pP7ckHOfjhBzenoSS7CvnPliY86eoiH/3paXfINXoMmOwWPEelDiB6d
         DTj9VOsfIURimo+p0h+Vk2oJPQF3UAB+CYcQgDMgxK82P/+SH96l5czPSHPx1U50IH9B
         AUFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWm9vgakoUHLPfnkrJ8nGh+ZHy9t6UwM1PweWsiGAAhkJa0T04ZT1U7wJOWBluencDB+PRATft0@vger.kernel.org
X-Gm-Message-State: AOJu0YyiNarh6PD2FEfk2/+d4MoOEWfgpQaPNE/umyjPRgWWvhNrSlv/
	iTsv5S1Gv4NRBM2vwCHJ6h77Nj9365VXJZaPgwmr+UEFWD2alXv6yBToG1QmsifSnfNOYAqA26P
	v8AhA8ZgMamR5LjUDhV3HFy1VE6Fk9YW65rM05TpE2A==
X-Gm-Gg: ASbGncvlXoYzhtWsGQTppFrIfcIHJTgc42pIXwKmsDsz6VZMjfuSuw6up2irD2ARpvc
	dG+KHmtfwMNzxR52yz3T/ClB33p01rqtXNICZ5Nbtn0yaRXfv8Tor2RcrmYRYM4PeoS8fIWALlx
	YRBg0miZTNHndF4Fcwi8Wj5F51DMmP7k7NqBJtyxDVmTxiBT8i+uahwEpNe1SDpFRv4vsmbQxqV
	uYJy+nGuiQOL5ZUBKTGSLGV5bdKXB3DJwZyqhm9Zmf9PMO0OLUv87H6VFk=
X-Google-Smtp-Source: AGHT+IElRIVhqCvDTFpSgFEYkQvi9Gos4SnKPGf8Juir9zGtxxq03gYdBJSCGUUe4Ii0djCwuMFVWPO3CN8YKO0f0p8=
X-Received: by 2002:ac8:57d3:0:b0:4ec:f073:4239 with SMTP id
 d75a77b69052e-4eda4e7cbb2mr148255861cf.6.1762856570888; Tue, 11 Nov 2025
 02:22:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111065520.2847791-1-viro@zeniv.linux.org.uk> <20251111065520.2847791-2-viro@zeniv.linux.org.uk>
In-Reply-To: <20251111065520.2847791-2-viro@zeniv.linux.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Nov 2025 11:22:38 +0100
X-Gm-Features: AWmQ_bn6E4e4WTTnqqQ9ptsMdEgyTHjWIJOU4-smQyjZiT3MKecFKgj620d_-Vc
Message-ID: <CAJfpeguqvHUDVzR7N=To8keErrF8Bn9kuojoFtM_58sLY_XXDw@mail.gmail.com>
Subject: Re: [PATCH v3 01/50] fuse_ctl_add_conn(): fix nlink breakage in case
 of early failure
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, raven@themaw.net, neil@brown.name, 
	a.hindborg@kernel.org, linux-mm@kvack.org, linux-efi@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, kees@kernel.org, rostedt@goodmis.org, 
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, paul@paul-moore.com, 
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Nov 2025 at 07:55, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> fuse_ctl_remove_conn() used to decrement the link count of root
> manually; that got subsumed by simple_recursive_removal(), but
> in case when subdirectory creation has failed the latter won't
> get called.
>
> Just move the modification of parent's link count into
> fuse_ctl_add_dentry() to keep the things simple.  Allows to
> get rid of the nlink argument as well...
>
> Fixes: fcaac5b42768 "fuse_ctl: use simple_recursive_removal()"
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>
