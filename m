Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590BE242921
	for <selinux@vger.kernel.org>; Thu, 13 Feb 2025 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739448009; cv=none; b=TZP/PXSlflxF6BQ1vCWIw7YJqDBYKOZAJdvcdSWwJbeYsPWpnbMB0Ktxwsl48RIEE6XfC/ormGcRxPiJ0XeuacjZmypH0gZhEeOdMsa94QtDHsrWJFjBXsQ+svT4WBf0DYxZXYAU4aIqgiCh/2R8P+AjJCJOj5i9X76Bj45gqO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739448009; c=relaxed/simple;
	bh=jO0lN5x9guXp1a4LurUsJQThejvJaKRkotHrdOiQ9pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ak4K948HWe2w/jiQAESywHdNDLPymhtvGr+htRMp7/CddZ1/+73jWKxPkdwtyRA3S8QObIM/Uyu3WdUKiR3QVAtKJiIKpshsaurz8lChNRZcWjf5mcnnReSjiOP36JCq06EOnGllDl61WDiOTQdBa1tp5ffF2Fr3ASKu1ZddLMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Dg/FZGLk; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Dg/FZGLk"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-46fee2b9c7aso5920321cf.2
        for <selinux@vger.kernel.org>; Thu, 13 Feb 2025 04:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1739448006; x=1740052806; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WxIbGeZdAUj59XbtP18FGXOievh8ogWpoWw7ACveybI=;
        b=Dg/FZGLkaZ7ie6M7KfJ0TS6y+1v6GfledRzDEjzhrFVkV7uxrcCLh+GQvS5H4KHXL8
         B51WJr8ZenjcTJprsEiiDlKCbKsZzxvg9FvDFhorRi45bII61nN42/Ul+A/gOXOVchwk
         Bary65zTIufxEg3GLS9b65341xcV8kC1py7lY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739448006; x=1740052806;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WxIbGeZdAUj59XbtP18FGXOievh8ogWpoWw7ACveybI=;
        b=GDgHWvwhwU7kWNCGXsFy9dZF+DOXz2HdUgrcbDK1gwL7xiA833wNOTi4HAy95FuGqw
         G+8Ijp6R7fwoaDRK/IlDeIcoyfrmBjeEVE/bYO3KBpNAALKIA7K4VOVQLqe3hjLzFjls
         jJaDVsUQdEectZZO7wzD6zXw3SU5Rb3tP8iDUib6BkyDwUhGKiD5rKSfygg/DGQBAjSu
         94voZT4CdH23hl+svyywBknbI/axzj0S483VqSUGsr7BCtjQO+NyHuQWG429mymPdms6
         zYdII0TssH0lnTzPyfc6ax3U6LOUgw0FADQv5bHRMSuPA7cSDaKmiYuE6eqCudnFo+vU
         3zhw==
X-Forwarded-Encrypted: i=1; AJvYcCVCfuqkMFF+mbeMEUtOzSq3mI4krY6PacEhCGMldiLrphJHrzF3trfS7UM9coBAVXoB83EaXxsS@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Bp4EW4e2esvJ0Hk9tfhBY+Kb5ixZrteq/n1/exr5qcE5sVSU
	Z/mOXx8EVK5gJ/C4hVqqAdKGPaYSvl+gXedc3fJoyqQgb/uUsi1g4pwFYanAaRLNf7feupFbmiL
	Wcjnbcamma14zVSQ2rlZOsnR0PmIEZdope7QNCA==
X-Gm-Gg: ASbGncsOQ55pR5Oieeu14gJORN0T5CMhyA52MqLPxrrzCYEl3ZxIB3TkZGwFPdWtzbl
	SaAh1wrf1LvbwnvKY/l/jBvZARIwQT3+W2qwtGvfkGejcL9E5eu0bfd6UqoaPkehV0lJ0vA==
X-Google-Smtp-Source: AGHT+IECakDoTpDhiyRznxkiGj71HtCaKMx16upveVIQZiceah1ZrEWHrFOAhOuh92zW9TRY+grheUmpzNv0IRyez9s=
X-Received: by 2002:ac8:7e96:0:b0:471:bbdb:9f43 with SMTP id
 d75a77b69052e-471bbdba074mr60632641cf.24.1739448006112; Thu, 13 Feb 2025
 04:00:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129165803.72138-1-mszeredi@redhat.com> <20250129165803.72138-3-mszeredi@redhat.com>
 <7fjcocufagvqgytwiqvbcehovmehgwytz67jv76327c52jrz2y@5re5g57otcws>
In-Reply-To: <7fjcocufagvqgytwiqvbcehovmehgwytz67jv76327c52jrz2y@5re5g57otcws>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 13 Feb 2025 12:59:55 +0100
X-Gm-Features: AWEUYZlbIShCppFI0DHhIK5cm-ltnuxnlVq8Qowgi16SzeDjxo4poRs6xazAudA
Message-ID: <CAJfpegs2qoZHG4P+WiopDo92MxHQ_0QrZi0qMz7niannGFiPDQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] fanotify: notify on mount attach and detach
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Feb 2025 at 16:50, Jan Kara <jack@suse.cz> wrote:
>
> On Wed 29-01-25 17:58:00, Miklos Szeredi wrote:

> >       fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
> > -     if (mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_EVENT_FLAGS) &&
> > +     if (mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_MOUNT_EVENTS|FANOTIFY_EVENT_FLAGS) &&
>
> I understand why you need this but the condition is really hard to
> understand now and the comment above it becomes out of date. Perhaps I'd
> move this and the following two checks for FAN_RENAME and
> FANOTIFY_PRE_CONTENT_EVENTS into !FAN_GROUP_FLAG(group, FAN_REPORT_MNT)
> branch to make things more obvious?

Okay.  git diff -w below.

Thanks,
Miklos

--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1936,6 +1936,8 @@ static int do_fanotify_mark(int fanotify_fd,
unsigned int flags, __u64 mask,
             mark_type != FAN_MARK_INODE)
                return -EINVAL;

+       /* The following checks are not relevant to mount events */
+       if (!FAN_GROUP_FLAG(group, FAN_REPORT_MNT)) {
                /*
                 * Events that do not carry enough information to report
                 * event->fd require a group that supports reporting fid.  Those
@@ -1944,21 +1946,25 @@ static int do_fanotify_mark(int fanotify_fd,
unsigned int flags, __u64 mask,
                 * point.
                 */
                fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
-       if (mask &
~(FANOTIFY_FD_EVENTS|FANOTIFY_MOUNT_EVENTS|FANOTIFY_EVENT_FLAGS) &&
+               if (mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_EVENT_FLAGS) &&
                    (!fid_mode || mark_type == FAN_MARK_MOUNT))
                        return -EINVAL;

                /*
-        * FAN_RENAME uses special info type records to report the old and
-        * new parent+name.  Reporting only old and new parent id is less
-        * useful and was not implemented.
+                * FAN_RENAME uses special info type records to report the old
+                * and new parent+name.  Reporting only old and new parent id is
+                * less useful and was not implemented.
                 */
                if (mask & FAN_RENAME && !(fid_mode & FAN_REPORT_NAME))
                        return -EINVAL;

-       /* Pre-content events are not currently generated for directories. */
+               /*
+                * Pre-content events are not currently generated for
+                * directories.
+                */
                if (mask & FANOTIFY_PRE_CONTENT_EVENTS && mask & FAN_ONDIR)
                        return -EINVAL;
+       }

        if (mark_cmd == FAN_MARK_FLUSH) {
                if (mark_type == FAN_MARK_MOUNT)
