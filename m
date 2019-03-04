Return-Path: <SRS0=k4Wl=RH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C5EC43381
	for <selinux@archiver.kernel.org>; Mon,  4 Mar 2019 19:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAACF2070B
	for <selinux@archiver.kernel.org>; Mon,  4 Mar 2019 19:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbLZHzKY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfCDTVh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:21:37 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36207 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCDTVh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Mar 2019 14:21:37 -0500
Received: by mail-yw1-f67.google.com with SMTP id 189so4973349ywi.3;
        Mon, 04 Mar 2019 11:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=extC+jTr5pWK30PAUD6QYJw7226CRGsx/QKZa5MaJeM=;
        b=ZbLZHzKYX45wtzGXIGNwVS39YLY+czb5wG7npSP47iuXpBZrbjR+/NmDLdTmip20vk
         vpdOzxmvKgG3zzDVd/qyL+t1PAH+K9NuV3Gz3f/AgrRpW2WNSGE+IShwZFH5yIms2n5w
         8F7pmXs6CHOLmMOc1d6TO/o2rAC1XEe/+V2pdRqCP4xBcoBGtvoKUIbTBU1+fXv5kymm
         qDMpxGhsOzP6Jhnsbul1ihGspghltC2ugzrAyijTGYdvIxYspe9iw+arFuKByrTgOYYP
         X/FgsJzDnSHgygkGuz1EnVXEyug3dWbpQxT0Q1i6ZG2SecaEPwSDmpNAmiz/k7ckA8s4
         i64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=extC+jTr5pWK30PAUD6QYJw7226CRGsx/QKZa5MaJeM=;
        b=PymrH/+e86DAUuW6cImxQ3FVB/7aaUNx6xJBY+7FXiUoHWDt7nteTGG7tc1iA0X/E7
         +3ZUjWE8T4eFR80bCQ5zvk2QquySGcp8ONfovOidiP4o022gOw5L+o2DWotR1dO0mO9o
         Y3A7+EIS/e+lwwBZYmNe33LumXimAvxukVFmXBObwA2v0WvTC5erLnk1LkDudsFYXXoo
         oJKgX0y/Ktzx9BBVSl04lEIg9vTh9tB5UOdybDYGVhyaUwwfr0X9vPnXum9DEkFv7z28
         lPMhNtyJ5+y6DBbW4EpH+d+IVmjOeC4QNZL/9+8+1Fvag4JNpxDxDd2roeaNub7sFTBH
         2iWw==
X-Gm-Message-State: APjAAAVWou0wMnHLNY1gYszddq+IajSiDum1CSXXZczC4IEj/GNaIEpH
        m5RPlcpuFvSB3s1vVor3uGZ2XsB+LhlT4v3qN/Or/R+7
X-Google-Smtp-Source: APXvYqxKb6Tlif6noVtQofVZhNymQQDgv3+IWkSwyZg/qcSo3mjxa+Od1FbteUKDC/HxNvLmuRzUMHF50aX7yVM6Vt8=
X-Received: by 2002:a81:1b4b:: with SMTP id b72mr15066728ywb.211.1551727295288;
 Mon, 04 Mar 2019 11:21:35 -0800 (PST)
MIME-Version: 1.0
References: <CAJfpegs9JjkXguemL4qSiBvRP6Dnut-D+nJo-oLFXkfCL1Egvw@mail.gmail.com>
 <CAJfpegvfqx+0D32n1h2X7oj5d1mZWiLTcSSGpBnD+ba7AKzPyA@mail.gmail.com>
 <20181127210542.GA2599@redhat.com> <CAJfpegtQGM2z9TOt3DWwd39fC60cQknsC4vNnj7YimVEubRzUg@mail.gmail.com>
 <20181128170302.GA12405@redhat.com> <377b7d4f-eb1d-c281-5c67-8ab6de77c881@tycho.nsa.gov>
 <CAJfpegtNhcWD0VWy6LPtoDtQBfPu4x5iFsB053UMCidj6oMsuw@mail.gmail.com>
 <26bce3be-49c2-cdd8-af03-1a78d0f268ae@tycho.nsa.gov> <CAJfpeguL9xOh9Eq8LOP=ddJ4YD6nbp2UY6e2AYDVoHeCLuVhZA@mail.gmail.com>
 <20181129134943.GA16762@redhat.com> <fe78aaed-5fb1-3c51-1330-39de46ae39c5@android.com>
 <ae2682f2-4a15-39e6-eb49-b9c0e72f10e4@tycho.nsa.gov>
In-Reply-To: <ae2682f2-4a15-39e6-eb49-b9c0e72f10e4@tycho.nsa.gov>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 4 Mar 2019 21:21:23 +0200
Message-ID: <CAOQ4uxg34ZjHxXSfCgLmbcUh_JZptYyY9j74ZFX3esRn7OSLVw@mail.gmail.com>
Subject: Re: overlayfs access checks on underlying layers
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Paul Moore <paul@paul-moore.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        selinux@vger.kernel.org, Daniel J Walsh <dwalsh@redhat.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 4, 2019 at 8:53 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 3/4/19 12:01 PM, Mark Salyzyn wrote:
> > On 11/29/2018 05:49 AM, Vivek Goyal wrote:
> >> So will override_creds=off solve the NFS issue also where all access will
> >> happen with the creds of task now? Though it will stil require more
> >> priviliges in task for other operations in overlay to succeed.
> >
> > NFS problems seems to have ended the discussion, too many stakeholders?
> > too many outstanding questions?
> >
> > Do we accept the limitations of the override_creds patch as is, and then
> > have the folks more familiar with the NFS scenario(s) build on it?
> >
> > [TL;DR]
> >
> > After looking at all this discussion, it feels like a larger audited
> > rewrite of the security model is in order and override_creds=off may be
> > a disservice (although expediently deals with Android's needs) to a
> > correct general solution. I admit I have little idea where to go from
> > here for a general solution.
> >
> > As far as I see it, the model of creator && caller credentials is a
> > problem for any non-overlapping (MAC) privilege models. This patch
> > allows one to drop any creator privilege escalation, re-introducing the
> > "caller" to the lower layers.
> >
> > As such I would expect a better model is to _always_ check the caller
> > credentials again in the lower layers, and only check the creator
> > credentials, some without caller credentials, for some special cases?
> > Change an && to an || for some of the checks? What are those special
> > cases? I must admit _none_ of those special cases need attention in the
> > Android usage models though making it difficult for me to do the fight
> > thing for the associated stakeholders.
>
> As I recall, there were multiple problems with using current process'
> creds for the operations on the lower/upper/work directories:
>
> - Some overlayfs operations on the lower/upper/work directories required
> privilege (capabilities) that the current process might lack, e.g. to
> set ownership and the like on upper or work files, to set special xattrs
> used internally by overlayfs for whiteouts or similar purposes, to act
> on files within the work dir which was inaccessible to the current
> process to prevent accessing files in an incomplete state, etc.
> Originally that was handled by temporarily elevating the effective
> capabilities around the privileged operation in the overlayfs code but
> that didn't help with the SELinux or other LSM capability checking that
> was triggered upon the capable calls.  Without some change there you'd
> have to allow all client process domains all of the relevant
> capabilities in policy, greatly increasing their privileges.
>
> - The original logic was checking access to the lower dir/files in the
> context of the current process when performing some operation that
> modifies the file content or metadata, thereby triggering a SELinux/LSM
> write or similar check, even though the actual data or metadata
> modification occurs to the copied-up file instead and does not affect
> the lower dir/files.  That was preventing making the lower dir/file
> labels read-only to the client processes in the policy, which was
> desired for the container use case.
>
> You'd need to solve those problems in some way.
>

This is entire discussion in avoiding the elephant in the room -
Tampering with underlying layers.
We only talk about functionality and enforcement of legit overlayfs
operation, but what about an adversary that writes/changes files on
underlying layers? For example, permission to write new files can
be elevated to effectively modifying or deleting files.

To me the logic in "mounter credentials" is not only functional.
Whoever has access to underlying layer can really cause a lot of
damage to users accessing the overlay mount, so in a way, this
power needs to be translated to some sort of elevated credentials.

The the current model seems solid in that respect - access to
underlying layer can be restricted to the "mounter" who effectively
crafts an entirely new set of files.

Another way to think about this - consider a user space overlayfs
implementation, for example:
https://github.com/containers/fuse-overlayfs

In what way should the requirements to overlayfs security model
differ from the model already imposed on a user space implementation?

I do understand the Android use case for override_creds=off, but
to me, this is a functional configuration that says "turn off overlay
specific security considerations... I know what I am doing".
I am not saying that the Android adb debug use case is insecure.
I am just not seeing how a && or || model for mounter and caller
credential add up to a coherent story (yet...).

Thanks,
Amir.
