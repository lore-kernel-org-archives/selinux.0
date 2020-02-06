Return-Path: <SRS0=oQIx=32=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286F7C2D0B1
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 14:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F982082E
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 14:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QrISQU2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgBFOUE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Feb 2020 09:20:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60089 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726765AbgBFOUE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Feb 2020 09:20:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580998803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hbxLdczcu+b8O+uglhTReBt6mEzf3UuoOUiPkBDS6MI=;
        b=QrISQU2APxneElZUH2ceo8cBhfyQHKKYShbvCdwmjWXF757OEOXcvivhQK47gWDc8Yum6k
        1jnKafpkO0ilERJgqc3cOHpxZBazD4OT2xnwHYRorwzxgyT0BOByAskCWqJjYf0quB+XIO
        1U1K94jPA/KnZgusACBw8viQh62Y4NE=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-7I3nlE5IO22fDExaGmoxYw-1; Thu, 06 Feb 2020 09:19:58 -0500
X-MC-Unique: 7I3nlE5IO22fDExaGmoxYw-1
Received: by mail-oi1-f198.google.com with SMTP id 199so2875586oie.10
        for <selinux@vger.kernel.org>; Thu, 06 Feb 2020 06:19:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hbxLdczcu+b8O+uglhTReBt6mEzf3UuoOUiPkBDS6MI=;
        b=XGIePELuQ8OvVmq1OBYC1As+2g6fWevcTFa0qsVAe1ICds+bUAtxcORctv6xfGXNAu
         TChQQZVmB/7HO0smABBm+0uRhtqmwWueUbfec6eiY24HEAXRqYMaGFpz+m3sM+Z8vc9m
         bSwH1XmZC7/dISSsvZEqw4xuiEP6wlktA/uYsfRq82PU8jJReUUR384wHp51FHS86Jmk
         kq7DB7slv0V4+CK27ZFxCm8bf6FMYKqjiYFlo8LdqscSE37a+Kc01mo3Gdq4YgTpz3yd
         /5MJKLcsegYGu6PdRXsYp6w+asxDK/zf93glH55Hkot/75mS52P13XZCfOSbHU/B0oml
         +ybA==
X-Gm-Message-State: APjAAAXVj2Q0NgbH+d2Vnbn6g05hmyVLXFaphRaZV4ojPNY/Ul6YbrGZ
        /1uahqEgMRXGjAy3baMePozA9M7XQczlXsoLJAydv3Mugjch/hkwpvDAhU0SZydZvuUqu+5Rg5d
        iZTD6wKOrQgQVf5SFmFkIgyP6zjhPhH21ow==
X-Received: by 2002:aca:1108:: with SMTP id 8mr7097808oir.127.1580998796305;
        Thu, 06 Feb 2020 06:19:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqwXyYTr/CGgk0qzOhAed4/U2fAXGizg8mDrWxqkgzsaw4EPBpvegRgDYTgHFaNchP/T//xSSSCeyk1yoYr9hGU=
X-Received: by 2002:aca:1108:: with SMTP id 8mr7097783oir.127.1580998795948;
 Thu, 06 Feb 2020 06:19:55 -0800 (PST)
MIME-Version: 1.0
References: <20200206131253.535302-1-omosnace@redhat.com> <20200206131253.535302-3-omosnace@redhat.com>
 <dfd44a69-8ba1-9de7-c3a8-bca702fdf6a0@tycho.nsa.gov>
In-Reply-To: <dfd44a69-8ba1-9de7-c3a8-bca702fdf6a0@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 6 Feb 2020 15:19:44 +0100
Message-ID: <CAFqZXNvkvuP2qVna2uj3zPPJC5rgJuOei7rF9=gLUo6QUxyvZw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] semodule: support changing policyvers via command line
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Petr Lautrbach <plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 6, 2020 at 2:44 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 2/6/20 8:12 AM, Ondrej Mosnacek wrote:
> > When using semodule for building a distribution policy package (as
> > Fedora does), the environment might not have selinuxfs available and
> > provide no way to modify semanage.conf. When we want to build a policy
> > with version X (because our kernel doesn't support X+1 and above yet),
> > but our libsepol already has support for X+1, then we currently have no
> > way to do so.
>
> Not fundamentally opposed, but unclear on the motivation.  The current
> approach is to generate the highest policy version supported by our
> libsepol at build time, then libselinux selinux_mkload_policy() uses
> libsepol functions (sepol_policydb_set_vers(),
> sepol_policydb_to_image()) to automatically downgrade the policy in
> memory to whatever version is supported by the kernel before writing it
> to the kernel.  This works as long as one uses the same or newer
> libsepol at load time as at build time and as long as policydb_write()
> supports writing older policy versions (generally discarding newer
> features).

The problem is that:
1. selinux-policy expects that the generated /etc/selinux/.../policy.X
file will be generated with a specific (hard-coded) value X, so if the
userspace is updated in buildroot, the selinux-policy build fails.
2. If we fix the above by expecting any value X and ship that, then
the build passes in such case, but if a user updates selinux-policy
without updating userspace and reboots, the system will not boot. So
even if we stop incrementing the expected policy version manually, we
would still need to manually increment the minimum required userspace
version each time the policy is rebuilt with userspace that has
incremented its max policyvers.

With these patches we can call semodule -V %{POLICYVER} ... and new
rebuilds of selinux-policy wouldn't be disrupted by userspace
upgrades. The only downside is that we would need to remember to
increment the specfile versions from time to time.

OTOH, maybe the build failure is actually a good thing in that it
serves as a reminder to bump all the hard-coded versions whenever
userspace bumps max policyvers...

>
> >
> > To resolve this, add a new command-line argument to semodule, which
> > allows to override the system-wide configured version to a different
> > one.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >   policycoreutils/semodule/semodule.8 |  3 +++
> >   policycoreutils/semodule/semodule.c | 12 +++++++++++-
> >   2 files changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/semodule/semodule.8
> > index 18d4f708..88e027fd 100644
> > --- a/policycoreutils/semodule/semodule.8
> > +++ b/policycoreutils/semodule/semodule.8
> > @@ -64,6 +64,9 @@ A module is extracted as HLL by default. The name of the module written is
> >   <module-name>.<lang_ext>
> >   .SH "OPTIONS"
> >   .TP
> > +.B  \-V,\-\-policyvers
> > +force specific kernel policy version
> > +.TP
> >   .B  \-s,\-\-store
> >   name of the store to operate on
> >   .TP
> > diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
> > index a1f75e16..30c4495b 100644
> > --- a/policycoreutils/semodule/semodule.c
> > +++ b/policycoreutils/semodule/semodule.c
> > @@ -50,6 +50,8 @@ static int build;
> >   static int disable_dontaudit;
> >   static int preserve_tunables;
> >   static int ignore_module_cache;
> > +static unsigned policyvers;
> > +static int policyvers_set = 0;
> >   static uint16_t priority;
> >   static int priority_set = 0;
> >
> > @@ -137,6 +139,7 @@ static void usage(char *progname)
> >       printf("  -d,--disable=MODULE_NAME  disable module\n");
> >       printf("  -E,--extract=MODULE_NAME  extract module\n");
> >       printf("Options:\n");
> > +     printf("  -V,--policyvers  force specific kernel policy version\n");
> >       printf("  -s,--store       name of the store to operate on\n");
> >       printf("  -N,-n,--noreload do not reload policy after commit\n");
> >       printf("  -h,--help        print this message and quit\n");
> > @@ -210,7 +213,7 @@ static void parse_command_line(int argc, char **argv)
> >       no_reload = 0;
> >       priority = 400;
> >       while ((i =
> > -             getopt_long(argc, argv, "s:b:hi:l::vr:u:RnNBDCPX:e:d:p:S:E:cH", opts,
> > +             getopt_long(argc, argv, "V:s:b:hi:l::vr:u:RnNBDCPX:e:d:p:S:E:cH", opts,
> >                           NULL)) != -1) {
> >               switch (i) {
> >               case 'b':
> > @@ -248,6 +251,10 @@ static void parse_command_line(int argc, char **argv)
> >                       fprintf(stderr, "The --upgrade option is deprecated. Use --install instead.\n");
> >                       set_mode(INSTALL_M, optarg);
> >                       break;
> > +             case 'V':
> > +                     policyvers = (unsigned)strtoul(optarg, NULL, 10);
> > +                     policyvers_set = 1;
> > +                     break;
> >               case 's':
> >                       set_store(optarg);
> >                       break;
> > @@ -363,6 +370,9 @@ int main(int argc, char *argv[])
> >               goto cleanup_nohandle;
> >       }
> >
> > +     if (policyvers_set)
> > +             semanage_set_policyvers(sh, policyvers);
> > +
> >       if (store) {
> >               /* Set the store we want to connect to, before connecting.
> >                * this will always set a direct connection now, an additional
> >
>

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

