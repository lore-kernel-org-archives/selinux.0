Return-Path: <SRS0=ShWd=O5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEB2C43387
	for <selinux@archiver.kernel.org>; Thu, 20 Dec 2018 21:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFA321903
	for <selinux@archiver.kernel.org>; Thu, 20 Dec 2018 21:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731870AbeLTVzk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:55:40 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:60849 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730700AbeLTVzk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Dec 2018 16:55:40 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 2F4C056471A
        for <selinux@vger.kernel.org>; Thu, 20 Dec 2018 22:55:37 +0100 (CET)
Received: by mail-oi1-f178.google.com with SMTP id i6so3162888oia.6
        for <selinux@vger.kernel.org>; Thu, 20 Dec 2018 13:55:37 -0800 (PST)
X-Gm-Message-State: AJcUukfjCYezeeXO7kR9zpJ7MDhSFYkOVgmqkXQ83YGcLNwHUhRQont4
        wnzLKJmkoRm10ggCKphTNLXaUbbFO1gVTFg4ovY=
X-Google-Smtp-Source: AFSGD/VgezH38w8sjU4sWCfAm716My3bd1XB0MyZX472m/uqRiWkO8C3PQpWgg+89xLuAOM+6Pa902R0NNYleW4bjSo=
X-Received: by 2002:aca:4b48:: with SMTP id y69mr328767oia.200.1545342936111;
 Thu, 20 Dec 2018 13:55:36 -0800 (PST)
MIME-Version: 1.0
References: <20181220151420.30878-1-plautrba@redhat.com> <20181220151420.30878-4-plautrba@redhat.com>
In-Reply-To: <20181220151420.30878-4-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 20 Dec 2018 22:55:24 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==MHDK9HjB0o-BiMitED=8vGRqLyRZ=wu266pXi1muG_g@mail.gmail.com>
Message-ID: <CAJfZ7==MHDK9HjB0o-BiMitED=8vGRqLyRZ=wu266pXi1muG_g@mail.gmail.com>
Subject: Re: [PATCH 3/4] python/sepolicy: Add sepolicy.load_store_policy(store)
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Dec 20 22:55:37 2018 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 20, 2018 at 4:14 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> load_store_policy() allows to (re)load SELinux policy based on a store name. It
> is useful when SELinux is disabled and default policy is not installed; or when
> a user wants to query or manipulate another policy.
>
> Related: https://bugzilla.redhat.com/show_bug.cgi?id=1558861
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>  python/sepolicy/sepolicy/__init__.py | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
> index fbeb731d..b69a6b94 100644
> --- a/python/sepolicy/sepolicy/__init__.py
> +++ b/python/sepolicy/sepolicy/__init__.py
> @@ -129,6 +129,13 @@ def get_installed_policy(root="/"):
>          pass
>      raise ValueError(_("No SELinux Policy installed"))
>
> +def get_store_policy(store, root="/"):
> +    try:
> +        policies = glob.glob("%s%s/policy/policy.*" % (selinux.selinux_path(), store))
> +        policies.sort()
> +        return policies[-1]
> +    except:
> +        return None

Hi, I agree this function is useful. Nevertheless the sorting order
seems to be fragile because '100' < '99', so the policy filename needs
to be parsed in order to extract the version as an integer and sort
according to it. Moreover its second parameter ("root") is not used
and I would rather avoid adding new bare excepts to the code base.

I suggest the following implementation of this function:

def get_store_policy(store):
    """Get the path to the policy file located in the given store name"""
    def policy_sortkey(policy_path):
        # Parse the extension of a policy path which looks like
.../policy/policy.31
        extension = policy_path.rsplit('/policy.', 1)[1]
        try:
            return int(extension), policy_path
        except ValueError:
            # Fallback with sorting on the full path
            return 0, policy_path
    policies = glob.glob("%s%s/policy/policy.*" %
(selinux.selinux_path(), store))
    if not policies:
        return None
    # Return the policy with the higher version number
    policies.sort(key=policy_sortkey)
    return policies[-1] if policies else None

It is more complex but fixes the issues I have identified. If you want
to keep "root", it may be possible to use it with both
"glob.glob("%s/%s/%s/policy/policy.*" % (root, selinux.selinux_path(),
store))" and "return os.path.realpath(policies[-1]) if policies else
None" (in order to simplify double-slashes into a single "/"
character). What do you think of this?

Anyway, thanks for the patches!
Nicolas

