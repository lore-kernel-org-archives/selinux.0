Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C1DC77B73
	for <selinux@archiver.kernel.org>; Tue,  6 Jun 2023 15:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjFFPVh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Jun 2023 11:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbjFFPVg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Jun 2023 11:21:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D524612D
        for <selinux@vger.kernel.org>; Tue,  6 Jun 2023 08:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686064846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Grhit3TiVpoXTHIpkWZdd4HkPm34oQ/lMgVsgY9hAdA=;
        b=jVMrxVl/0YUVBLBWoEbxOXRfA+MHvQ++fG6aq7sWzXKEh7isERdYPvlOSoExvH/jkaguVT
        msWMmI4dzX6WW6ZZQxlykSoUDFhd37xmrcWerbc8HrQ5wwsoBB2wUqYmtv6ezxwTiQX4o0
        LomG6EeFyDMOy2koY6AIfCBcV6yGMuY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-vExLDoDzNdSdVhmPMYC15A-1; Tue, 06 Jun 2023 11:20:42 -0400
X-MC-Unique: vExLDoDzNdSdVhmPMYC15A-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3f9a9df0b85so13972521cf.1
        for <selinux@vger.kernel.org>; Tue, 06 Jun 2023 08:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686064841; x=1688656841;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Grhit3TiVpoXTHIpkWZdd4HkPm34oQ/lMgVsgY9hAdA=;
        b=CUM3jVLFVHkUDBX2Tt2GJNOh0YP4ADohZllsE4lOMZQJ+5FCfiqXpDu31xO9ad01Mc
         cNweYTGPWzaBU9y/yDfTPUFM3p+lllHROu+/CqZcms6rsS5FQ2wae1WZFW9yYyg6LoLI
         XK4n5mZFG8lF1BZ0syHbEprPsVWUg2jcbDwAKW4qWLy+lEFY6s3C6Stog+op4TYuVQsn
         lKVXJ6CWoalFcWt64krNN/iQ2a4B8BEZevho4SLu3zGwqYDnHFkOojRtVEeVzX5u7y7i
         4CXhe9iaLg+lO8HHzdr/Z67eUHk/Kcvfz+b9X7VJUv+3kpalg2iWEi6BS9zow4/Kov39
         4Gsw==
X-Gm-Message-State: AC+VfDz3x0yA+EHkf4lHwvxpbz5S4RV5yqzqtYsoidCBPKDIJIsF2boT
        bp6uj+G0GIBJIG8vIoNOQOcjdVAaC3OoBeO0Qu9zotI0LETcXsDRldYySFi3aKwd3VZmpkOp0ng
        Dk2BavRphjiRPIAZhC+v7Br06rQ==
X-Received: by 2002:a05:622a:c6:b0:3dc:ac3b:ca6c with SMTP id p6-20020a05622a00c600b003dcac3bca6cmr62692qtw.6.1686064841659;
        Tue, 06 Jun 2023 08:20:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4alSjAbmKNPFnwdWgCp55friYw3WPCJcVAwQZwN1i4pd78R/8hD3VBvscLhmvofgyaodC9nw==
X-Received: by 2002:a05:622a:c6:b0:3dc:ac3b:ca6c with SMTP id p6-20020a05622a00c600b003dcac3bca6cmr62665qtw.6.1686064841299;
        Tue, 06 Jun 2023 08:20:41 -0700 (PDT)
Received: from [192.168.0.116] ([86.49.156.126])
        by smtp.gmail.com with ESMTPSA id ay38-20020a05622a22a600b003e4ee0f5234sm339758qtb.87.2023.06.06.08.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 08:20:40 -0700 (PDT)
Message-ID: <69d6f186-bdd7-32f0-8be1-340782fd1cee@redhat.com>
Date:   Tue, 6 Jun 2023 17:20:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/4] python/semanage: Drop hard formating from localized
 strings
Content-Language: en-US
To:     Petr Lautrbach <lautrbach@redhat.com>, selinux@vger.kernel.org
References: <20230517134934.709059-1-lautrbach@redhat.com>
 <20230517134934.709059-2-lautrbach@redhat.com>
From:   Vit Mojzis <vmojzis@redhat.com>
In-Reply-To: <20230517134934.709059-2-lautrbach@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/17/23 15:49, Petr Lautrbach wrote:
> It confuses translators and new lines are dropped by parser module anyway.
> 
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
> ---
>   python/audit2allow/audit2allow | 14 ++++++++---
>   python/semanage/semanage       | 44 +++++++++++++---------------------
>   2 files changed, 28 insertions(+), 30 deletions(-)
> 
> diff --git a/python/audit2allow/audit2allow b/python/audit2allow/audit2allow
> index 5587a2dbb006..35b0b151ac86 100644
> --- a/python/audit2allow/audit2allow
> +++ b/python/audit2allow/audit2allow
> @@ -234,9 +234,17 @@ class AuditToPolicy:
>               print(e)
>               sys.exit(1)
>   
> -        sys.stdout.write(_("******************** IMPORTANT ***********************\n"))
> -        sys.stdout.write((_("To make this policy package active, execute:" +
> -                            "\n\nsemodule -i %s\n\n") % packagename))
> +        sys.stdout.write(
> +"""******************** {important} ***********************
> +{text}
> +
> +semodule -i {packagename}
> +
> +""".format(
> +    important=_("IMPORTANT"),
> +    text=_("To make this policy package active, execute:"),
> +    packagename=packagename
> +))
>   
>       def __output_audit2why(self):
>           import selinux
> diff --git a/python/semanage/semanage b/python/semanage/semanage
> index e0bd98a95c77..898df4b93c10 100644
> --- a/python/semanage/semanage
> +++ b/python/semanage/semanage
> @@ -238,30 +238,22 @@ def parser_add_level(parser, name):
>   
>   
>   def parser_add_range(parser, name):
> -    parser.add_argument('-r', '--range', default='',
> -                        help=_('''
> -MLS/MCS Security Range (MLS/MCS Systems only)
> -SELinux Range  for SELinux login mapping
> -defaults to the SELinux user record range.
> -SELinux Range for SELinux user defaults to s0.
> -'''))
> +    parser.add_argument('-r', '--range', default='', help=_(
> +        "MLS/MCS Security Range (MLS/MCS Systems only) SELinux Range for SELinux login mapping defaults to the SELinux user record range. \
> +SELinux Range for SELinux user defaults to s0."
> +    ))
>   
>   
>   def parser_add_proto(parser, name):
> -    parser.add_argument('-p', '--proto', help=_('''
> -    Protocol  for  the specified port (tcp|udp|dccp|sctp) or internet protocol
> -    version for the specified node (ipv4|ipv6).
> -'''))
> +    parser.add_argument('-p', '--proto', help=_(
> +        "Protocol for the specified port (tcp|udp|dccp|sctp) or internet protocol version for the specified node (ipv4|ipv6)."
> +    ))
>   
>   def parser_add_subnet_prefix(parser, name):
> -    parser.add_argument('-x', '--subnet_prefix', help=_('''
> -    Subnet prefix for  the specified infiniband ibpkey.
> -'''))
> +    parser.add_argument('-x', '--subnet_prefix', help=_('Subnet prefix for  the specified infiniband ibpkey.'))
>   
>   def parser_add_ibdev_name(parser, name):
> -    parser.add_argument('-z', '--ibdev_name', help=_('''
> -    Name for the specified infiniband end port.
> -'''))
> +    parser.add_argument('-z', '--ibdev_name', help=_("Name for the specified infiniband end port."))
>   
>   def parser_add_modify(parser, name):
>       parser.add_argument('-m', '--modify', dest='action', action='store_const', const='modify', help=_("Modify a record of the %s object type") % name)
> @@ -372,10 +364,10 @@ If you do not specify a file type, the file type will default to "all files".
>       parser_add_extract(fcontext_action, "fcontext")
>       parser_add_deleteall(fcontext_action, "fcontext")
>   
> -    fcontextParser.add_argument('-e', '--equal', help=_('''Substitute  target  path with sourcepath when generating default
> -                                                                  label.  This is used with fcontext. Requires source  and  target
> -                                                                  path  arguments.  The context labeling for the target subtree is
> -                                                                  made equivalent to that defined for the source.'''))
> +    fcontextParser.add_argument('-e', '--equal', help=_(
> +        "Substitute target path with sourcepath when generating default label. This is used with fcontext. Requires source and target \
> +path arguments. The context labeling for the target subtree is made equivalent to that defined for the source."
> +    ))
>       fcontextParser.add_argument('-f', '--ftype', default="", choices=["a", "f", "d", "c", "b", "s", "l", "p"], help=_(ftype_help))
>       parser_add_seuser(fcontextParser, "fcontext")
>       parser_add_type(fcontextParser, "fcontext")
> @@ -426,9 +418,7 @@ def setupUserParser(subparsers):
>       parser_add_range(userParser, "user")
>       userParser.add_argument('-R', '--roles', default=[],
>                               action=CheckRole,
> -                            help=_('''
> -SELinux Roles.  You must enclose multiple roles within quotes, separate by spaces. Or specify -R multiple times.
> -'''))
> +                            help=_("SELinux Roles. You must enclose multiple roles within quotes, separate by spaces. Or specify -R multiple times."))
>       userParser.add_argument('-P', '--prefix', default="user", help=argparse.SUPPRESS)
>       userParser.add_argument('selinux_name', nargs='?', default=None, help=_('selinux_name'))
>       userParser.set_defaults(func=handleUser)
> @@ -901,9 +891,9 @@ def setupImportParser(subparsers):
>   def createCommandParser():
>       commandParser = seParser(prog='semanage',
>                                formatter_class=argparse.ArgumentDefaultsHelpFormatter,
> -                             description='''semanage is used to configure certain elements
> -                                                            of SELinux policy with-out requiring modification
> -                                                            to or recompilation from policy source.''')
> +                             description=_(
> +            "semanage is used to configure certain elements of SELinux policy with-out requiring modification or recompilation from policy source."
> +                             ))
>   
>       #To add a new subcommand define the parser for it in a function above and call it here.
>       subparsers = commandParser.add_subparsers(dest='subcommand')


python/semanage/semanage 343: ftype_help = '''
could also use some improvements (multiple double/triple spaces and 
missing spaces after commas).

Nitpick: The patch header says "python/semanage", but the patch also 
touches python/audit2allow.

Otherwise LGTM.

Vit

