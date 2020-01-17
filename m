Return-Path: <SRS0=ftCu=3G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C47C33CB6
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 15:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8710E214AF
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 15:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MG8cGzHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgAQP1A (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:27:00 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:41579 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgAQP07 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Jan 2020 10:26:59 -0500
Received: by mail-io1-f67.google.com with SMTP id m25so10794282ioo.8
        for <selinux@vger.kernel.org>; Fri, 17 Jan 2020 07:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8pDbiYBxZsNKECu9WjGHq+CIbdja3cshf9UKGwVtSrM=;
        b=MG8cGzHD46kMSnUsBJzzffIEnTAgKlsP/AXPg9miPZKZWWCkeexBwbwUayal/nbG+Q
         6YMPL+u+WBRuC14xzHKFdF2xJogwoBJg2vfu39QNp0Nw+X4MqJPdODdbWA2SSO1Tn/4S
         SIz9Al9WdgV24ben6PnolNjUH6CCgtLsMRn79a+Bdg6XgLQK1dcoLHU34p6bD+AFRfP5
         Lbpj6xWWhr8CnGdWNq4qOo/qE7rXZJel4QWWgj9dUaYDsEK+wRQYoR906ZoTG887lJ72
         dedJTsuSmABQBY2B3j9Y9HWrxYExdz0+g/ZIIKYepkjSwxgELQUQ/3bfWYl/FeV6pV4D
         VSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8pDbiYBxZsNKECu9WjGHq+CIbdja3cshf9UKGwVtSrM=;
        b=mvABh3YHctRZhkeIZuxVETcJSPOMkg1pkCtf9YAaO3KLqeqsTxcjChYuCM/0SAJf/N
         G1UgUo7mjOFFKNFfQEDIWZqkYyR7KcOaK3kJ1kUod9ZnkKD0gNgHNSWFE+yR7YMBIYWy
         zhujyo9UzAc5QccQKHp0hR0nvQPGPj4/tzTqjfUPwoiQVc5XhWfxW95xZ5nXe0MjE/Vl
         9AMYDSaqTmMaqR80TgH7fdZpV8QB0WKdHi2OF92EZu3sXBl3X+QwPY4ZijcbpzS+09YD
         pTAHGI2wATiRm2QbiYGLbJfgJi/zP6+GSS6feY3o4rEYZ/OsE2m6Nphuol+m2F7aEbWW
         4i6Q==
X-Gm-Message-State: APjAAAUxxjjoJNIHx9LlM2RtEhtZ2bCkT+6VJIPoF/ySJiyXcmYQVCD4
        AH5uk26RgoVcq8OhrFZ9fvKiOa/1UlopA6IvCl7W2VXo
X-Google-Smtp-Source: APXvYqz3fJktn3RyR9oSJ5FuoAF5oiFOj4We4VbgeOTChfosy0PoHBCOHu1oFzUEoU+3dhmRX8cjUKnl4sGwKNE1T0M=
X-Received: by 2002:a02:c773:: with SMTP id k19mr33048266jao.61.1579274818699;
 Fri, 17 Jan 2020 07:26:58 -0800 (PST)
MIME-Version: 1.0
References: <20200117144813.55896-1-sds@tycho.nsa.gov>
In-Reply-To: <20200117144813.55896-1-sds@tycho.nsa.gov>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 17 Jan 2020 09:26:46 -0600
Message-ID: <CAFftDdrWB6Aa6=O30KwCx5uoFCHC6kTSU0P6feoCYYPrn_iHgw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: update man pages for userspace policy enforcers
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 17, 2020 at 8:47 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> Despite deprecating use of flask.h and av_permissions.h back in 2014,
> the man pages for avc_has_perm(3) and security_compute_av(3) were not
> updated to provide instructions on how to dynamically map class/permissio=
n
> names nor to encourage use of selinux_check_access(3) instead of these
> interfaces.  Also, while selinux_set_mapping(3) supports dynamic
> class/perm mapping at initialization, it does not support changes to
> the class/perm values at runtime upon a policy reload, and no
> instructions were provided on how to set up a callback to support
> this case.  Update the man pages accordingly.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  libselinux/man/man3/avc_has_perm.3        | 37 +++++++++++++++++-
>  libselinux/man/man3/security_compute_av.3 | 47 +++++++++++++++++++++--
>  libselinux/man/man3/selinux_set_mapping.3 | 20 ++++++++--
>  3 files changed, 97 insertions(+), 7 deletions(-)
>
> diff --git a/libselinux/man/man3/avc_has_perm.3 b/libselinux/man/man3/avc=
_has_perm.3
> index 3e9fca8475f1..62809f9af47f 100644
> --- a/libselinux/man/man3/avc_has_perm.3
> +++ b/libselinux/man/man3/avc_has_perm.3
> @@ -34,6 +34,36 @@ avc_has_perm, avc_has_perm_noaudit, avc_audit, avc_ent=
ry_ref_init \- obtain and
>  .in
>  .
>  .SH "DESCRIPTION"
> +
> +Direct use of these functions is generally discouraged in favor of
> +the higher level interface
> +.BR selinux_check_access(3)
> +since the latter automatically handles the dynamic mapping of class
> +and permission names to their policy values and proper handling of
> +allow_unknown.
> +
> +When using any of the functions that take policy integer values for
> +classes or permissions as inputs, use
> +.BR string_to_security_class(3)
> +and
> +.BR string_to_av_perm(3)
> +to map the class and permission names to their policy values.
> +These values may change across a policy reload, so they should be
> +re-acquired on every use or using a
> +.B SELINUX_CB_POLICYLOAD
> +callback set via
> +.BR selinux_set_callback(3).
> +
> +An alternative approach is to use
> +.BR selinux_set_mapping(3)
> +to create a mapping from class and permission index values
> +used by the application to the policy values,
> +thereby allowing the application to pass its own
> +fixed constants for the classes and permissions to
> +these functions and internally mapping them on demand.
> +However, this also requires setting up a callback as above
> +to address policy reloads.
> +
>  .BR avc_entry_ref_init ()
>  initializes an
>  .B avc_entry_ref
> @@ -146,11 +176,16 @@ Make sure that userspace object managers are grante=
d appropriate access to
>  netlink by the policy.
>  .
>  .SH "AUTHOR"
> -Eamon Walsh <ewalsh@tycho.nsa.gov>
> +Originally Eamon Walsh.  Updated by Stephen Smalley <sds@tycho.nsa.gov>
>  .
>  .SH "SEE ALSO"
>  .ad l
>  .nh
> +.BR selinux_check_access(3),
> +.BR string_to_security_class(3),
> +.BR string_to_av_perm(3),
> +.BR selinux_set_callback(3),
> +.BR selinux_set_mapping(3),
>  .BR avc_init (3),
>  .BR avc_context_to_sid (3),
>  .BR avc_cache_stats (3),
> diff --git a/libselinux/man/man3/security_compute_av.3 b/libselinux/man/m=
an3/security_compute_av.3
> index cb1a9ba49f46..3de1b0fe7f1b 100644
> --- a/libselinux/man/man3/security_compute_av.3
> +++ b/libselinux/man/man3/security_compute_av.3
> @@ -50,6 +50,39 @@ the SELinux policy database in the kernel
>  .BI "int checkPasswdAccess(access_vector_t " requested );
>  .
>  .SH "DESCRIPTION"
> +
> +This family of functions is used to obtain policy decisions from the
> +SELinux kernel security server (policy engine).  In general, direct use =
of
> +.BR security_compute_av ()
> +and its variant interfaces is discouraged in favor of using
> +.BR selinux_check_access ()
> +since the latter automatically handles the dynamic mapping of class
> +and permission names to their policy values, initialization and use of
> +the Access Vector Cache (AVC), and proper handling of per-domain and
> +global permissive mode and allow_unknown.
> +
> +When using any of the functions that take policy integer values for
> +classes or permissions as inputs, use
> +.BR string_to_security_class(3)
> +and
> +.BR string_to_av_perm(3)
> +to map the class and permission names to their policy values.
> +These values may change across a policy reload, so they should be
> +re-acquired on every use or using a
> +.B SELINUX_CB_POLICYLOAD
> +callback set via
> +.BR selinux_set_callback(3).
> +
> +An alternative approach is to use
> +.BR selinux_set_mapping(3)
> +to create a mapping from class and permission index values
> +used by the application to the policy values,
> +thereby allowing the application to pass its own
> +fixed constants for the classes and permissions to
> +these functions and internally mapping them on demand.
> +However, this also requires setting up a callback as above
> +to address policy reloads.
> +
>  .BR security_compute_av ()
>  queries whether the policy permits the source context
>  .I scon
> @@ -102,7 +135,7 @@ instance.
>  .BR security_compute_user ()
>  is used to determine the set of user contexts that can be reached from a
>  source context. It is mainly used by
> -.BR get_ordered_context_list ().
> +.BR get_ordered_context_list (3).
>
>  .BR security_validatetrans ()
>  is used to determine if a transition from scon to newcon using tcon as t=
he object
> @@ -135,7 +168,9 @@ is used to check for a permission in the
>  .I passwd
>  class.
>  .BR selinux_check_passwd_access ()
> -uses getprevcon() for the source and target security contexts.
> +uses
> +.BR getprevcon(3)
> +for the source and target security contexts.
>
>  .BR checkPasswdAccess ()
>  is a deprecated alias of the
> @@ -146,4 +181,10 @@ function.
>  Returns zero on success or \-1 on error.
>  .
>  .SH "SEE ALSO"
> -.BR selinux "(8), " getcon "(3), " getfilecon "(3), " get_ordered_contex=
t_list "(3)"
> +.BR string_to_security_class (3),
> +.BR string_to_av_perm (3),
> +.BR selinux_set_callback (3),
> +.BR selinux_set_mapping (3),
> +.BR getprevcon (3),
> +.BR get_ordered_context_list (3),
> +.BR selinux (8)
> diff --git a/libselinux/man/man3/selinux_set_mapping.3 b/libselinux/man/m=
an3/selinux_set_mapping.3
> index a93f7b29497a..4624fbc7918a 100644
> --- a/libselinux/man/man3/selinux_set_mapping.3
> +++ b/libselinux/man/man3/selinux_set_mapping.3
> @@ -19,7 +19,19 @@ struct security_class_mapping {
>  .
>  .SH "DESCRIPTION"
>  .BR selinux_set_mapping ()
> -establishes a mapping from a user-provided ordering of object classes an=
d permissions to the numbers actually used by the loaded system policy.  Us=
e of this function is highly preferred over the generated constants in the =
libselinux header files, as this method allows the policy's class and permi=
ssion values to change over time.
> +establishes a mapping from a user-provided ordering of object classes an=
d permissions to the numbers actually used by the loaded system policy. If =
using this function, applications should also set a
> +.B SELINUX_CB_POLICYLOAD
> +callback via
> +.BR selinux_set_callback(3)
> +that calls this function again upon a policy reload to re-create the map=
ping
> +in case the class or permission values change in the new policy.
> +Generally it is preferred to instead use
> +.BR selinux_check_access(3)
> +instead of
> +.BR avc_has_perm(3)
> +or
> +.BR security_compute_av(3)
> +and not use this function at all.
>
>  After the mapping is established, all libselinux functions that operate =
on class and permission values take the user-provided numbers, which are de=
termined as follows:
>
> @@ -81,8 +93,10 @@ and
>  class) will be identified by 1, 2, 4, and 8 respectively.  Classes and p=
ermissions not listed in the mapping cannot be used.
>  .
>  .SH "AUTHOR"
> -Eamon Walsh <ewalsh@tycho.nsa.gov>
> +Originally Eamon Walsh.  Updated by Stephen Smalley <sds@tycho.nsa.gov>
>  .
>  .SH "SEE ALSO"
> -.BR avc_open (8),
> +.BR selinux_check_access (3),
> +.BR selinux_set_callback (3),
> +.BR avc_has_perm (3),
>  .BR selinux (8)
> --
> 2.24.1
>

Ack
