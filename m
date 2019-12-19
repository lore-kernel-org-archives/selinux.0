Return-Path: <SRS0=Xw2L=2J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4020DC43603
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 16:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD43227BF
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 16:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfLSQsf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Dec 2019 11:48:35 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49334 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfLSQsf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Dec 2019 11:48:35 -0500
Received: from localhost (unknown [IPv6:2a00:5f00:102:0:3aba:f8ff:fe58:9ca1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: smcv)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B1ED428DE70;
        Thu, 19 Dec 2019 16:48:33 +0000 (GMT)
Date:   Thu, 19 Dec 2019 16:48:31 +0000
From:   Simon McVittie <smcv@collabora.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: Re: [PATCH v12 23/25] NET: Add SO_PEERCONTEXT for multiple LSMs
Message-ID: <20191219164831.GA1308552@horizon>
References: <20191216223621.5127-1-casey@schaufler-ca.com>
 <20191216223621.5127-24-casey@schaufler-ca.com>
 <56b96440-a304-42b6-1515-1ad2659b2581@tycho.nsa.gov>
 <e7aa3b6f-cee1-6277-21dd-77a4db9bbc2b@tycho.nsa.gov>
 <a522de22-ba62-a24d-24f7-b69418e7ec0b@tycho.nsa.gov>
 <20191219121939.GA1291250@horizon>
 <55b5c889-ff38-38c4-578e-ec4211b837a4@tycho.nsa.gov>
 <93912039-e64e-cc56-20fc-095accf6c4dd@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93912039-e64e-cc56-20fc-095accf6c4dd@tycho.nsa.gov>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 19 Dec 2019 at 10:00:31 -0500, Stephen Smalley wrote:
> Looks like userspace is generally forgiving of whether the terminating NUL
> byte is included or omitted by the kernel (with different behaviors for
> SELinux - always included, Smack - omitted by /proc/pid/attr/current but
> included in SO_PEERSEC, and AppArmor - omitted for /proc/pid/attr/current
> but includes a terminating \n, omitted for SO_PEERSEC but no terminating
> \n), and procps-ng explicitly tests for printable characters (but truncates
> on the first unprintable character).

Because LSM people have told me in the past that the '\0' is not
conceptually part of the label, the D-Bus specification and reference
implementation already assume that its presence or absence is irrelevant,
and normalize to a canonical form (which happens to be that it appends a
'\0' if missing, to be nice to C-like languages, but I could equally
have chosen to strip the '\0' and rely on an out-of-band length count).

By design, SO_PEERCONTEXT and /proc/pid/attr/context don't (can't!)
preserve whether the label originally ended with '\0' or not (because
they are designed to use '\0' as a terminator for each label), so these
new kernel interfaces are already a bit closer than the old kernel
interfaces to how D-Bus represents this information.

The problematic case is AppArmor's terminating '\n' on
/proc/pid/attr/current, because when I asked in the past, I was told
that it would be (unwise but) valid to have a LSM where "foo" and "foo\n"
are distinct labels.

If that hypothetical LSM would make procps-ng lose information (because
procps-ng truncates at the first unprintable character), does that change
the situation any? Would that make it acceptable for other LSM-agnostic
user-space components, like the reference implementation of D-Bus, to
assume that stripping a trailing newline from /proc/pid/attr/context
or from one of the component strings of /proc/pid/attr/current is a
non-lossy operation?

> > >    If this new API is an opportunity to declare that LSMs are expected
> > >    to put the same canonical form of a label in
> > > /proc/$pid/attr/context and
> > >    SO_PEERCONTEXT, possibly with a non-canonical version (adding '\n' or
> > >    '\0' or similar) exposed in the older /proc/$pid/attr/current and
> > >    SO_PEERSEC interfaces for backwards compatibility, then that
> > > would make
> > >    life a lot easier for user-space developers like me.
> > 
> > I'm all for this but the current implementation reuses the same
> > underlying hooks as SO_PEERSEC, so it gets the same result for the
> > per-lsm values.  We'd need a separate hook if we cannot alter the
> > current AppArmor SO_PEERSEC format.

If AppArmor was going to change the format of one of its interfaces
(or deviate from it when implementing new interfaces), I'd actually
prefer it to be /proc/pid/attr/current that changed or was superseded,
because /proc/pid/attr/current is the one that contains a newline that
consumers are meant to ignore.

For what it's worth, libapparmor explicitly removes the newline, so this
only matters to LSM-agnostic readers like D-Bus implementations, and to
lower-level AppArmor-aware readers that use the kernel interfaces directly
in preference to using libapparmor.

    smcv
