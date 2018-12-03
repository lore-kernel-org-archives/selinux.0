Return-Path: <SRS0=Et+u=OM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45061C04EBF
	for <selinux@archiver.kernel.org>; Mon,  3 Dec 2018 23:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0497020851
	for <selinux@archiver.kernel.org>; Mon,  3 Dec 2018 23:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="MUA+QTYl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0497020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbeLCX2N (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:28:13 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37378 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLCX2M (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Dec 2018 18:28:12 -0500
Received: by mail-lf1-f66.google.com with SMTP id p17so10546112lfh.4
        for <selinux@vger.kernel.org>; Mon, 03 Dec 2018 15:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xsnx777dnp60qOJRp6DiaP6WDfZUuGwjTpf8nB7zqFQ=;
        b=MUA+QTYlQlsdMUPiaO/+eevkriVRWDKNWRfiPdLTUb03vwFJvce0Sgi4uez38pg0ts
         j11r+I7AZm+lTxiLq5DEl/xanK/zEEmdeD7tjU2GjrB23ZuOWBDgurZH/Ug+InIvKjZw
         o7wTTvX/Y80cpECHe4xb5c+HCbdCB0qMysZBrDGH1S1+2bjckaapcFE0XmEYqI5sqK3C
         SCl6tuY/1iG4iGaJSN9++3zf5d67Y629uwRVvGEKLF6hWKq52bgLMrkvXgQbXPlDvgVv
         YQRvEUA39qdKiZ77k2T30iCfnL23T04NlpJM48zftpS9cLQtJa0R5lWfmRpibIASu1Zo
         xQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xsnx777dnp60qOJRp6DiaP6WDfZUuGwjTpf8nB7zqFQ=;
        b=BQl4ahbf/AeEwxFvwm/bB6gPHvULoT7RfiiRwta8m3BoEj2TGmpjA6uf69B8ORiy0L
         d7WFOH1EOtYi1NZomO5VeeiviujaUgN+Kgf2IAQcfUqcoEP5sY+U0/WP/4cZH9VV5SXW
         WOn0H5HeGFwLWqhOSmsXK9Mi9F71lhsmRjl46NuntgbzFL5FC1Qqn89jV7rqIN+GqJWN
         htxmcn0hXzhCC4k6rEo27Np5sipMcecPoOS16FGGwPiXoGWXOFdCSy/b/Oe0+6qqdgf+
         2YGviydRYFdv3PfDMYbZJp0Tq0nIu9lzS5cEHl9QF7544e5Mlpi6C3+gdVd10HuQcF7p
         gyeg==
X-Gm-Message-State: AA+aEWZG+8hM6yG0vo/jylwh2yiAvHFpr1lyDHxEPGwMMJgdCGeznALE
        XcCCUKyK1SQXOcw3uK0KNQSkzaSMBdjRc+J7jxEm
X-Google-Smtp-Source: AFSGD/XBu+cEWD6kM1tzsJkKX5nBgV9UuheQDOUZBOnXZls0NR1JAUKyUI/dREBvu1ju9nHgcdlQfVmxccbqbtoKmME=
X-Received: by 2002:a19:a7c1:: with SMTP id q184mr9870170lfe.4.1543879689460;
 Mon, 03 Dec 2018 15:28:09 -0800 (PST)
MIME-Version: 1.0
References: <CAJfpegs9JjkXguemL4qSiBvRP6Dnut-D+nJo-oLFXkfCL1Egvw@mail.gmail.com>
 <CAJfpegvfqx+0D32n1h2X7oj5d1mZWiLTcSSGpBnD+ba7AKzPyA@mail.gmail.com>
 <20181127210542.GA2599@redhat.com> <CAJfpegtQGM2z9TOt3DWwd39fC60cQknsC4vNnj7YimVEubRzUg@mail.gmail.com>
 <20181128170302.GA12405@redhat.com> <377b7d4f-eb1d-c281-5c67-8ab6de77c881@tycho.nsa.gov>
 <CAJfpegtNhcWD0VWy6LPtoDtQBfPu4x5iFsB053UMCidj6oMsuw@mail.gmail.com>
 <26bce3be-49c2-cdd8-af03-1a78d0f268ae@tycho.nsa.gov> <CAJfpeguL9xOh9Eq8LOP=ddJ4YD6nbp2UY6e2AYDVoHeCLuVhZA@mail.gmail.com>
 <6b125e8e-413f-f8e6-c7ae-50f7235c8960@tycho.nsa.gov> <CAJfpegv6y56k1-Tewu-Pu3x1W75LL6qYB6Hb6=n+2BJoNfEigA@mail.gmail.com>
 <f3a911a7-47eb-9922-a4be-25a834250e92@redhat.com>
In-Reply-To: <f3a911a7-47eb-9922-a4be-25a834250e92@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 3 Dec 2018 18:27:57 -0500
Message-ID: <CAHC9VhRcQdLRZoYi9g-MZzG8xPaNyFFX1nPppo7D93BTFQ6BZg@mail.gmail.com>
Subject: Re: overlayfs access checks on underlying layers
To:     Dan Walsh <dwalsh@redhat.com>
Cc:     miklos@szeredi.hu, Stephen Smalley <sds@tycho.nsa.gov>,
        vgoyal@redhat.com, omosnace@redhat.com, bfields@fieldses.org,
        salyzyn@android.com, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 29, 2018 at 5:22 PM Daniel Walsh <dwalsh@redhat.com> wrote:
> On 11/29/18 2:47 PM, Miklos Szeredi wrote:
> > On Thu, Nov 29, 2018 at 5:14 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >
> >> Possibly I misunderstood you, but I don't think we want to copy-up on
> >> permission denial, as that would still allow the mounter to read/write
> >> special files or execute regular files to which it would normally be
> >> denied access, because the copy would inherit the context specified by
> >> the mounter in the context mount case.  It still represents an
> >> escalation of privilege for the mounter.  In contrast, the copy-up on
> >> write behavior does not allow the mounter to do anything it could not do
> >> already (i.e. read from the lower, write to the upper).
> > Let's get this straight:  when file is copied up, it inherits label
> > from context=, not from label of lower file?
>
> Yes, in the case of context mount, it will get the context mount directory.
>
> In the case of not context mount, it should maintain the label of  the
> lower.
>
> > Next question: permission to change metadata is tied to permission to
> > open?  Is it possible that open is denied, but metadata can be
> > changed?
>
> Yes, SElinux handles open differently then setattr.  Although I am not
> sure if any tools handle this.
>
> > DAC model allows this: metadata change is tied to ownership, not mode
> > bits.   And different capability flag.
> >
> > If the same is true for MAC, then the pre-v4.20-rc1 is already
> > susceptible to the privilege escalation you describe, right?
>
> After talking to Vivek, I am not sure their is a privilege escallation.

More on this below, but this thread doesn't have me convinced, and we
are at -rc5 right now.  We need to come to some decision on this soon
because we are running out of time before v4.20 is released with this
code.

> For device nodes, the mounter has to have the ability to create the
> devicenode with the context mount, if he can do this, then he can do it
> with or without Overlay.  This might lead to users making mistakes on
> security, but the model is sound. And I think this stands even in the
> case of the lower is mounted NODEV and the upper is not.  If the mounter
> can create a device on the upper with a particular label, then he does
> not need the lower.

The problem I have when looking at the current code is that permission
is given, regardless of what is requested, for any special_file() on
an overlayfs mount.

It also looks like the mounter's creds are used when checking
permissions regardless of the file has been copied up or not; I would
expect that the mounter's permissions would only used when checking
permissions against the lower inode, no?  I think there is also some
weird behavior if the underlying inode only allows the mounter to
write (no read) and a write is requested at the overlayfs layer.  I'm
sure I'm missing some subtle thing with overlayfs, but why aren't we
doing something like the following:

  int ovl_permission(...) {

    if (!realinode) {
      ...
    }

    err = generic_permission(inode, mask);
    if (err)
      return err;

    if (upperinode) {
      err = inode_permission(upperinode, mask);
    } else {
      // on the lower inode, always use the mounter's creds
      old_cred = ovl_override_creds(...);

      // check to see if we have the right perms first, if
      // that fails switch to a read/copy-up check if we
      // are doing a write (note: we are not bypassing the
      // exec check, the task can change the metadata like
      // every other fs)
      err = inode_permission(lowerinode, mask);
      if (err && (mask & (MAY_EXEC | MAY_APPEND))) {
        // PM: my guess is that we also need to add a
        // "&& !special_file(lowerinode)" to the conditional
        // above because you can't copy-up a dev node in the
        // normal sense, but we'll leave that as a discussion
        // point for now...
        // turn the write into a read (copy-up)
        mask &= ~(MAY_WRITE | MAY_APPEND);
        mask |= MAY_READ;
        err = inode_permission(lowerinode, mask);
      }

      // reset the creds
      revert_creds(old_cred);
    }

    return err;
  }

> For sockets, I see the case where a process is listening on the lower
> level socket, the mounter mounts the overlay over the directory with the
> socket.  Then the mounter changes the attributes of the socket,
> performing a copy up.  If the mounter can not talk to the socket and the
> other end is still listening, then this could be an issue.  If the
> socket is no longer connected to the listener on the lower, then this is
> not an issue.
>
> Similar for a FIFO.

See my comment "// PM: my guess ..." in the pseudo code above.  I
think the write->read permission mask conversion really should only
apply to normal files where you can do a copy-up.

> With SELinux we are also always checking not only the file access to the
> socker, but also checking whether the label of the client is able to
> talk to the label of the server daemon.  So we are protected by a
> secondary check.

That's making some assumptions on the LSM and the LSM's loaded policy
and is not something I would want to rely on.

-- 
paul moore
www.paul-moore.com
