Return-Path: <SRS0=XEA0=3T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95C9C33CB3
	for <selinux@archiver.kernel.org>; Thu, 30 Jan 2020 19:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8081720708
	for <selinux@archiver.kernel.org>; Thu, 30 Jan 2020 19:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="hsPGwUPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbgA3Tws (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jan 2020 14:52:48 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:47100 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgA3Tws (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jan 2020 14:52:48 -0500
Received: by mail-ed1-f66.google.com with SMTP id m8so5099345edi.13
        for <selinux@vger.kernel.org>; Thu, 30 Jan 2020 11:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4i1kG9ZXyeioAEM+eqVjak8b7WGb9HCPi5uUMrMva4g=;
        b=hsPGwUPchBLKR4XJOhr59J0eY6115kzkgF+RIbrjtjJTKlUalzth8ZevByyqLDDU5a
         zUNFuN9EPlSud8em2c3DQ57YTbcypH5V/jEStmfOTq72TOvnntSNGR616PaE7VSEZh6v
         Q4RV0lQQHgu4aNJVw7LciF6qhfhxH8Jt+IyFW+tnXAGcCU/NTZKRvqEtsyQ0Gg3dhZtH
         H+oWB9poxixADrIOjg1JUAkT8uiAlx10OBc/RveOUalTHnDKUu5gibpRArH9KEtaaIJf
         bRF02HSzacQ+X/7NA2BU/D27TUJN+bAe1X4eA8q6xjoDKPtanr0Rv7oGGLuQVUBAUbN3
         8Trw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4i1kG9ZXyeioAEM+eqVjak8b7WGb9HCPi5uUMrMva4g=;
        b=QWyjxIWPe25D527Vwyqt8zf6XKDrWrDXy45JEzk1GemQRE44F/jjghfY0Cl8Zwil68
         B9Io1Q0kP5g08KhIbflMlQ2AmoJBIaOLBZhkmRY5FWoxbtORFSf95WBO+JzqAJ/JSBAE
         prqfaPOFKYSzG8DSPbUHfJQme0Ki96DEHXklvovWGZ1I11lpWHHquvp7Il7xOTNhWT/D
         PaxfuUKqrRf2uqNYsqLwfZdrmep9A1tjFZuNeavBNQrZwbebGF5r2EmwDwsYV+nCwnow
         9ZmfVtPYZ6xCAdUBsClHLa6ZLmwWOdqkoiMAF/vdpQWWnCxWwR9MLwdgmPsgOiiWbydZ
         rEbA==
X-Gm-Message-State: APjAAAXEE3RIQ5LR04tp23EaVcaYQLZPG5uhW8O6e+QOgpwbeRL2cQDa
        TunhUTyrwNMJz1h8M55cWklCiVQOJKoXIZ9r46iq
X-Google-Smtp-Source: APXvYqy5/iJ32RTZzikIwotFwUZLve5BzxwE1SwF0tk1cL6rlVbzn7jyO73IBkWiktLeHIZxxHCabE9qoKY04olokik=
X-Received: by 2002:a17:906:22cf:: with SMTP id q15mr5548132eja.77.1580413965444;
 Thu, 30 Jan 2020 11:52:45 -0800 (PST)
MIME-Version: 1.0
References: <20200130142343.163003-1-sds@tycho.nsa.gov>
In-Reply-To: <20200130142343.163003-1-sds@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 30 Jan 2020 14:52:34 -0500
Message-ID: <CAHC9VhTTenM5Yc9M7_cgRp6QR5vR5Qpaua7N0jzOuAQSuF+KdA@mail.gmail.com>
Subject: Re: [PATCH] testsuite: provide support for testing labeled NFS
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, omosnace@redhat.com,
        richard_c_haines@btinternet.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 30, 2020 at 9:23 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> Provide instructions in the README.md file, the required kernel config
> options in defconfig, and a nfs.sh script for running the testsuite
> within a labeled NFS mount.  This depends on the previous change to
> enable running over labeled NFS without failures.
>
> This completes the first part of
> https://github.com/SELinuxProject/selinux-testsuite/issues/32.
>
> What remains unfinished is adding tests that context mounts are properly
> honored, with and without security_label in exports, for NFS, and
> default labeling of NFS when neither security_label nor context mounts
> are used (i.e. genfscon default of nfs_t).
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  README.md | 41 +++++++++++++++++++++++++++++++++++++++++
>  defconfig | 10 ++++++++++
>  nfs.sh    | 13 +++++++++++++
>  3 files changed, 64 insertions(+)
>  create mode 100755 nfs.sh

Same as my common on the other NFS patch, I would suggest moving
nfs.sh into tools/.

-- 
paul moore
www.paul-moore.com
