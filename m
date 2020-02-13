Return-Path: <SRS0=XRjJ=4B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6408C3B190
	for <selinux@archiver.kernel.org>; Thu, 13 Feb 2020 22:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1DB24694
	for <selinux@archiver.kernel.org>; Thu, 13 Feb 2020 22:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="0Bw9Jlfk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgBMW2f (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Feb 2020 17:28:35 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38836 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgBMW2f (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Feb 2020 17:28:35 -0500
Received: by mail-ed1-f65.google.com with SMTP id p23so8803771edr.5
        for <selinux@vger.kernel.org>; Thu, 13 Feb 2020 14:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SVLFAl58EhriuJu04QHjLNX3CRXrfYfxd6GndNVdclY=;
        b=0Bw9JlfkDR6QYnf0MlK7mMFB4beY5mcpJxdJRbFnNmi9E+PApH779mWioaEJCILT8g
         stPSovpa3f34BW7TkGsJuDt6Xa7lv9M05jquQppGQA/XFv0ary4CUV1s9neTXMt+IHEQ
         fC14S+yihP2NJFJpZxw/mSRSj94TSCm0UFbeP9EgOWE+R95wy5BgDJ7GE4cKYzoTbVCw
         JnKPi4ipRCZqlb0sTh6Y8dNKX1JozKUr+zmFGOLZirD46ehXaJiuHIvTVYpHAUk5i8Pb
         0ykZrzavdqvTJr2JgJpCScdZQoSYxmZrG283bBzMPZzuLVNa9PXltim1Deeh5+RLuC3O
         W0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SVLFAl58EhriuJu04QHjLNX3CRXrfYfxd6GndNVdclY=;
        b=hTzdGtIT1yR5I+rRlBUkeQqmHfiYvkEtiq6x8Q29mkwYdHt48Tqd9aYgqwfbj+ALrl
         GNhmg+Y3iA1fM7dlzDJ3nvMkWVUJQtnu7DXE1aC8hFKBBlEAXCFgLepHgmsJ0K3wNoaU
         zKpLkER8Rm54RQY4iZ1IDRO4aU0cgOsnBbmNOOwB9sIUARgj7jMFU2TSarZHD4zaplLB
         F2ofKnELDOMxyoLvzPadj+6TYUIQhEDoZtCt375OSTo7VnwyrYh9muHpo2UucYGG/R2K
         e0C/aKiAtwAQ7O0v9uKYCgSjb1pglwU3GFlCsqEX9P2YwXehKXknavoLvAs7CQ8gW4VC
         wtCw==
X-Gm-Message-State: APjAAAWATmyC1Q8kqYL74zJ15xZjLCio5PlihumubiXD2TtMaX5gRZ3K
        E0fljsKfTF2JfUcdfrdZemsNni28fJIvRKNSKqne
X-Google-Smtp-Source: APXvYqxo1k509KUZbou0P11C35wbTbsOfx/V08QzAnt5b/rTW2S0XXbSho+UqbiDcsDM2ZsyHlcvS6LOWo3ZYJpp0ts=
X-Received: by 2002:a17:906:22cf:: with SMTP id q15mr17613129eja.77.1581632913177;
 Thu, 13 Feb 2020 14:28:33 -0800 (PST)
MIME-Version: 1.0
References: <20200213163037.14494-1-richard_c_haines@btinternet.com>
 <9ee7126b-b021-b384-ecb5-615f041d0a09@tycho.nsa.gov> <1761fd15-6d7d-7f2f-71c5-ffb2e930727b@tycho.nsa.gov>
In-Reply-To: <1761fd15-6d7d-7f2f-71c5-ffb2e930727b@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 13 Feb 2020 17:28:22 -0500
Message-ID: <CAHC9VhTdKKDZBT5o75FFxTgSRh-r2jScx8kwHryR=9TN38dvdw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] selinux-testsuite: Use native filesystem for fs tests
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 13, 2020 at 3:59 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 2/13/20 3:55 PM, Stephen Smalley wrote:
> > On 2/13/20 11:30 AM, Richard Haines wrote:
> >> This is a first attempt at running the filesystem and fs_filesystem tests
> >> on the native filesystem.
> >>
> >> It supports NFS when using the tools/nfs.sh script. NFS will support
> >> options
> >> with rootcontext and fscontext, however due to the fsconfig(2) they
> >> bug will
> >> not pass with these (see note in nfs.sh).
> >>
> >> The filesystem types supported are: ext2, ext3, ext4, xfs, btrfs,
> >> hfsplus,
> >> reiserfs, nfs4. If not in this list, tests are skipped. I'm not sure what
> >> others need supporting, these seem reasonable and available on Fedora.
> >
> > Didn't receive the patch but will comment on a few items in your cover
> > letter.
> >
> > Offhand, I'd suggest pruning it to just ext4, xfs, and nfs4.  There is
> > no separate ext3 filesystem in the kernel anymore (ext4 provides the
> > implementation for both ext3 and ext4).  ext2 and reiserfs seem to be
> > legacy filesystems and reiserfs never supported SELinux well to my
> > knowledge.  btrfs SELinux support seems to not be well supported; absent
> > a distro supporting them both that seems unlikely to change. hfsplus is
> > orphaned per MAINTAINERS and not likely to be used as a primary
> > filesystem for SELinux regardless.
> >
> >> I've had to add a number of policy rules to support these types, however
> >> I've made no attempt to consolidate them. Most are for supporting
> >> rootcontext
> >> and fscontext on NFS. Rules for the 'context' option were many more so
> >> decided not to add them - any views on this.
> >
> > Wasn't sure what issue you are encountering there.  Could you use an
> > attribute ala file_type and/or fs_type or the corresponding refpolicy
> > interfaces to allow what you need with just a few rules?
> >> When testing btrfs, most tests will fail on tests/fs_filesystem due to
> >> the fsconfig(2) bug.
> >
> > Yes, I'm disinclined to include btrfs in our testing until/unless a
> > SELinux maintainer is using a distro that defaults to it (or the
> > maintainer defaults to using it regardless) and ensures that it is kept
> > functioning.
>
> Actually, I take that back.  I wouldn't want the testsuite to
> automatically try to create and test btrfs filesystems itself, but if
> you are just whitelisting on which filesystem types the testsuite will
> try to apply its tests when run there, including btrfs makes sense.
> Then it won't break automated testing runs on distros not using btrfs
> but we can still refer btrfs developers to the testsuite to identify and
> reproduce bugs/regressions.

I would agree with that.

-- 
paul moore
www.paul-moore.com
