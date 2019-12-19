Return-Path: <SRS0=Xw2L=2J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB403C2D0C1
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 12:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C3E227BF
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 12:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfLSMUK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Dec 2019 07:20:10 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46148 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbfLSMTo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Dec 2019 07:19:44 -0500
Received: from localhost (unknown [IPv6:2a00:5f00:102:0:3aba:f8ff:fe58:9ca1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: smcv)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id D4AC3292E68;
        Thu, 19 Dec 2019 12:19:41 +0000 (GMT)
Date:   Thu, 19 Dec 2019 12:19:39 +0000
From:   Simon McVittie <smcv@collabora.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: Re: [PATCH v12 23/25] NET: Add SO_PEERCONTEXT for multiple LSMs
Message-ID: <20191219121939.GA1291250@horizon>
References: <20191216223621.5127-1-casey@schaufler-ca.com>
 <20191216223621.5127-24-casey@schaufler-ca.com>
 <56b96440-a304-42b6-1515-1ad2659b2581@tycho.nsa.gov>
 <e7aa3b6f-cee1-6277-21dd-77a4db9bbc2b@tycho.nsa.gov>
 <a522de22-ba62-a24d-24f7-b69418e7ec0b@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a522de22-ba62-a24d-24f7-b69418e7ec0b@tycho.nsa.gov>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 18 Dec 2019 at 15:50:45 -0500, Stephen Smalley wrote:
> Ok, this seems to be a lack of support in AppArmor for saving the peer info
> for unix/local domain sockets, so not your bug.  Doesn't implement the
> necessary hooks.

Ubuntu kernels have working getsockopt SO_PEERSEC for AppArmor (which
definitely works for D-Bus, or did when I tried it in the past), but it
seems to be a downstream patch.

Is there a combination of LSMs where this works correctly and shows
multiple LSMs' labels, either upstream or with downstream patches? D-Bus
ought to be an early consumer of this information, but that's going to
be difficult if there's nowhere I can test it. If there was a pair of
in-tree or out-of-tree test LSMs that automatically labelled process
12345 and all sockets that it created with something like (pseudocode)

{
  "labeltest1": "labeltest1process12345",
  "labeltest2": "labeltest2process12345"
}

then that would make testing straightforward.

From my user-space developer perspective, I'd really like the kernel
to have at least brief documentation of the assumptions that can be
made about the compound format, to avoid people like me having to
ask the linux-security-module mailing list and use the answers as our
documentation:

- Can I assume that the LSM names (conceptually, keys in the associative
  array) are printable ASCII? If not, can I at least assume that they are
  printable UTF-8, or that LSMs whose names are not printable UTF-8 are
  too weird to be worth supporting in user-space APIs?

  If this decision hasn't been made yet, I would like to request ASCII,
  or UTF-8 if a wider character repertoire is desired - that would make
  user-space APIs a lot easier to write.

- What can I assume about the format of the labels (values in the
  associative array)?

  From previous conversations on linux-security-module it seems the
  answer is: they are intended to be printable strings; their encoding
  is unspecified (could be ASCII or UTF-8, but equally could be Latin-1
  or anything else); there are no reserved or disallowed characters
  except '\0'; individual LSMs like SELinux and AppArmor might impose
  tighter restrictions, but LSM-agnostic code can't assume those
  restrictions are present.

  Even if the format is conceptually an unspecified encoding with every
  nonzero byte allowed, if LSM and security policy authors establish a
  convention that the labels are ASCII or UTF-8 without control characters
  such as newlines, that would make user-space a lot easier to deal with.

- Can I assume that the names and labels in /proc/$pid/attr/context
  correspond exactly (same label <=> same bytes) to the ones in
  SO_PEERCONTEXT?

  In particular, a design issue in the previous interfaces with
  /proc/$pid/attr/current and SO_PEERSEC was that AppArmor puts
  "unconfined\n" in /proc/$pid/attr/current, but "unconfined\0" in
  SO_PEERSEC, and implementations of protocols like D-Bus can't know
  that these are meant to be the same without LSM-specific knowledge
  (namely "AppArmor profile names can't contain newlines").

  If this new API is an opportunity to declare that LSMs are expected
  to put the same canonical form of a label in /proc/$pid/attr/context and
  SO_PEERCONTEXT, possibly with a non-canonical version (adding '\n' or
  '\0' or similar) exposed in the older /proc/$pid/attr/current and
  SO_PEERSEC interfaces for backwards compatibility, then that would make
  life a lot easier for user-space developers like me.

- Does the order of the names and values matter? Can I assume anything
  about them?

  It would make the D-Bus API more straightforward if I can assume that
  the order doesn't matter, and represent it as an unordered map
  (associative array), like a Perl hash or Python dict.

I'm asking all this from the D-Bus perspective, but anything that
wants to store or forward LSM contexts in an LSM-agnostic way will
have essentially the same requirements - I could imagine X11, Wayland,
varlink etc. hitting the same problems D-Bus did.

Thanks,
    smcv
