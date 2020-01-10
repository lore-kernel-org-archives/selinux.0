Return-Path: <SRS0=2SWW=27=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768FCC282DD
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 21:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB772072E
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 21:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="BPnJhdNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgAJVCB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jan 2020 16:02:01 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37166 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgAJVCB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jan 2020 16:02:01 -0500
Received: by mail-lj1-f195.google.com with SMTP id o13so3524348ljg.4
        for <selinux@vger.kernel.org>; Fri, 10 Jan 2020 13:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z8WBZdCWjz+iFpfHXk0D3ftIaLDNxDnn8aRPtPk15T4=;
        b=BPnJhdNCBO579L4QrbdkZ5F1datZgkMX75UNQuJ4kkaRCV/1iDguLSgC7cYzDnywyf
         /0yOTBPSM8Xut4TMsVwwoVEKjsH/e4KD1ALTPvp8q5ZllakcMfybCFdAbZpHxsbKKQIa
         s989x5R6sAMC1O3RcJyg6pYGqn3FJcdv/WSxb61SouDOHlh2WIAVCE+K6A5GQq9HsfKf
         ZXAvODO6lLADa8gD3mQ6sZdN9IKfUYUKGmN/vU8f2Svx4K9HUJMCUNcVbOl97hE68Jm4
         pO0dOtIE/ORhlyWJ+P8zaKK7hd33fhuckdj2JZ2trWHQqH7E/73TmsImc+QIVFNPWC/y
         vnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z8WBZdCWjz+iFpfHXk0D3ftIaLDNxDnn8aRPtPk15T4=;
        b=kPZaKiSoJgH0XbeluUF2u6Vi7R8TtxAIR5xDR5LrnAAzjZ86MTH1Ac8J77t654gEt0
         aegpB+UBZizzNymr1DDBnU0jQO5YMxqA+hs1S1NCRE0rfOkUWHQQltd5NN1//ucIkiie
         rbvqm3Gvu0h+mu2Xl4IQvFAEdr4wkjKYx9d/eLgMf1A3kCSDOXIfu0x5D9bb4+dinzkO
         hfj726exyzg5MXtw30cQtfyzYbKp5RFBRtZWM7n0glDKT5v3hC7Ut7xEq/ExEDrAx72k
         QfGcdO12yX0KsVIWuVU+/rRX9UdEQa5AbvtE77I60xrYl/Z0qBM7dDFdnRq9e5qcXGGL
         sFMw==
X-Gm-Message-State: APjAAAUo7ZKRFEFVZCT3CvqMWQaAktPsC7o/S6P1iiNFcFZvy1K2iAue
        Jx57C/X7L37F44WKtBjtw0kypgHLum89IgSqeQZk
X-Google-Smtp-Source: APXvYqwUUr/W/4yxA8nw49ohd7jXSBYrmH3UanlUmXHqdo+3Vgl6HEGf+3zBxXmgAk9Mk9Ty3LkgQ1+vlLmu4btovoU=
X-Received: by 2002:a2e:8152:: with SMTP id t18mr3680289ljg.255.1578690118328;
 Fri, 10 Jan 2020 13:01:58 -0800 (PST)
MIME-Version: 1.0
References: <20200110142038.21602-1-cgzones@googlemail.com>
 <CAHC9VhTm4Mv2=vy7-LVFnnVnNd87MajzN1imjSLcqx9H17uQqg@mail.gmail.com>
 <8426e416-cc8e-e054-aded-075cfc381057@tycho.nsa.gov> <03490eb6-ac2f-ce43-4534-fd7a25f89020@tycho.nsa.gov>
 <0f0a3b90-583e-bae0-bc23-5ddf1d64924e@tycho.nsa.gov>
In-Reply-To: <0f0a3b90-583e-bae0-bc23-5ddf1d64924e@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Jan 2020 16:01:47 -0500
Message-ID: <CAHC9VhQDjwHXCS5ZKRwrVbTqVG62yBQ5g5LfCdLFZydcxQog_g@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: add policy capability for systemd overhaul
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 10, 2020 at 1:12 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 1/10/20 1:03 PM, Stephen Smalley wrote:
> > On 1/10/20 12:41 PM, Stephen Smalley wrote:
> >> On 1/10/20 11:55 AM, Paul Moore wrote:
> >>> On Fri, Jan 10, 2020 at 9:20 AM Christian G=C3=B6ttsche
> >>> <cgzones@googlemail.com> wrote:
> >>>> Support a SELinux overhaul of systemd by adding a policy capability.
> >>>>
> >>>> The systemd patch can be found at
> >>>> https://github.com/systemd/systemd/pull/10023
> >>>> and has NOT yet been accepted.
> >>>>
> >>>> This is just a rfc to test the water.
> >>>> ---
> >>>>   security/selinux/include/security.h | 1 +
> >>>>   security/selinux/ss/services.c      | 3 ++-
> >>>>   2 files changed, 3 insertions(+), 1 deletion(-)
> >>>
> >>> Generally the SELinux policy capabilities are reserved for *kernel*
> >>> changes that potentially break compatibility with existing SELinux
> >>> policies.  I'm probably not the best person to talk about
> >>> tricks/conventions used to do similar things in userspace, but you've
> >>> come to the right place :)
> >>
> >> It was my suggestion to use policy capabilities for this.  There is no
> >> separate mechanism for supporting major changes to userspace SELinux
> >> permission checks in a backward-compatible manner.  Userspace already
> >> relies upon /sys/fs/selinux/{deny_unknown,reject_unknown} to get the
> >> handle_unknown setting from the kernel policy to decide how to handle
> >> unknown userspace classes/permissions.  That however is insufficient
> >> for these changes to systemd's permission check because they go beyond
> >> introducing new classes and permissions and overhaul the existing
> >> checks.  Policy capability seemed like the best way to do it, and
> >> getting it from the kernel is consistent with the fact that we are
> >> also getting the userspace classes/perms from the kernel via
> >> /sys/fs/selinux/class and the userspace access decisions from the
> >> kernel via /sys/fs/selinux/access (through the libselinux AVC,
> >> typically).

I would argue that the examples you mention above
(/sys/fs/selinux/class, etc.) are different enough from the policy
capabilities that it isn't a fair comparison.  Although given your
other responses (below), it's probably not worth our time digging into
this argument further.

> > As to why we keep the userspace policy as part of the kernel policy and
> > not as a separate entity:
> >
> > - It allows us to provide an effective atomicity in policy changes that
> > may span both kernel and userspace components,
> >
> > - There is significant overlap between the contexts used in the kernel
> > and userspace policies, since most userspace policy enforcers are using
> > contexts obtained from the kernel for the subject (e.g.
> > SO_PEERSEC/getpeercon) or for the object (e.g. getfilecon),
> >
> > - Policy lookups via /sys/fs/selinux/access are more efficient than
> > performing an IPC to a userspace security server.  Of course, in both
> > cases, we try to maximize use of the libselinux AVC first to avoid
> > needing to perform the policy lookup at all.
> >
> > There were experiments done with introducing support for userspace
> > security server(s) for things like XACE/XSELinux and it was found to be
> > unsatisfying both performance and security-wise.
> >
> > There are still cases where we would recommend userspace security
> > server(s), such as when the userspace component is implementing a polic=
y
> > entirely distinct from that of the kernel (e.g. a remote document serve=
r
> > implementing RaDAC policies, as in one of our earlier experimental
> > research projects), but not for things like systemd.
>
> All that said, I can see that we probably don't want a hardcoded
> reference to systemd in the kernel, since not everyone uses systemd ;)

That is definitely one of my concerns; the last thing I want to do is
start a Debian-esque argument about init systems :)

> Perhaps what we need is for some range of policy capabilities to be
> user-defined, with generic names in the kernel and then userspace can
> choose to associate meaning with them.

It sounds like we may not need this after all, but if we do have to go
this route, I would be okay with establishing a
range/subset/namespace/etc. of policy capabilities for use by
userspace so long as we somehow ensure that there is a clear
separation between kernel and userspace policy capabilities.  The last
thing I want is to add a new policy capability to the kernel only to
find out that the capability name already conflicts with someone's
policy, that would be very bad.

> This would be a bit easier if we implemented a solution to the 2nd part
> of https://github.com/SELinuxProject/selinux/issues/55, i.e. pass
> capabilities to the kernel as a list of uninterpreted string names
> rather than a bitmap.  Then the kernel only needs to recognize its own
> capability names and create selinuxfs nodes for all of them reflecting
> their policy values, but no hard-coded references to systemd required.

We would probably want to enforce some sort of prefix string on the
userspace policy capabilities during policy load to ensure that we
don't have accidental overlap between kernel and userspace
capabilities.

--=20
paul moore
www.paul-moore.com
