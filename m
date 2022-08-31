Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511ABECAAD1
	for <selinux@archiver.kernel.org>; Wed, 31 Aug 2022 11:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiHaLyt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 Aug 2022 07:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiHaLys (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 Aug 2022 07:54:48 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EC5B2F
        for <selinux@vger.kernel.org>; Wed, 31 Aug 2022 04:54:45 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id s11so5897866ilt.7
        for <selinux@vger.kernel.org>; Wed, 31 Aug 2022 04:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Xs9J7tRJg9yqOUo4vNb6aPOoDgmiA+LPLOykhAe/KWc=;
        b=hcxQ3wKvWd57fPBIOWVKlt9I4v8iQsD5LkRFTYwO9XJds6VWA0ZwWjSujuhO4BDtEx
         0l7K8GOdeZkd2/lN2mlzp7lGrPOYPNtdjfeFPgSwwdOYn8PpqyleqjdM4HCbyCOc5jf2
         SjnqcoRrSr8Pk7HwWVJdytNgpuq+RVPA6uLFMTTxK+RfJyqd0f5JQUesn7jysSeQicGP
         +BagxBlECamJPW1KySzn91QpVa/q3VXZRrMXr8e6wBvSnEt57OGe97RBQdz2QoGwdBQ3
         lQcii5AEz92lg1LVoX8BSRXgavALp6DgLnDCL/kJXBVdk8eTlL0VYom8zv+5+iToVB8g
         qXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Xs9J7tRJg9yqOUo4vNb6aPOoDgmiA+LPLOykhAe/KWc=;
        b=wouixxULesZH5rrtBkboUIbBQ6+qUKWaKh+XhO9e9/wbjGLnFpSlE4VlSenukMX/Uh
         D07t3WloMqgehnnnq6bJYF8Ihk1XoVTo28Qm0BNA86tn36MeZckBQlf0CughwOlOytwr
         +IAGNQu5diq082ALrXmCkXIzlUa6jV99pNTlPciGYzCZY3926NDnVZZu/0y5XDhRdTfB
         G/E/BId8KpoIhDqRR96hhLXICy1B82rDqSK4lf6sCMP4DQLNxi1+0FnmcGZyIdwRHm3B
         nu1ZUWSdC9Ylhj3QD5yzgvHbkIhn9NaWV5VfpUPz390U8vieZiCF+CSqcYTobx8p5EHn
         KgWw==
X-Gm-Message-State: ACgBeo2eMtJie7RP/Nn3OS4vT2LJ04Ro8N0yBp8zpDkPon/ZA1fgUfF8
        +9Ikp6+XLXUG0MiSZEa1Xy4PYIrbKNejPg3JfcuKBORtuyI=
X-Google-Smtp-Source: AA6agR6OWuVvGoFM2wZFOKHiQDn8PJR48HdkzWOcPrABSl8vulsXg7KH4q1eDVmMqZfH/gEKJuDbJVFDYrNR+wvUpWQ=
X-Received: by 2002:a05:6e02:194c:b0:2eb:6cfa:1615 with SMTP id
 x12-20020a056e02194c00b002eb6cfa1615mr2824604ilu.10.1661946885176; Wed, 31
 Aug 2022 04:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <50b132b2-3adb-042b-647d-962baf228701@gmail.com>
In-Reply-To: <50b132b2-3adb-042b-647d-962baf228701@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 31 Aug 2022 07:54:34 -0400
Message-ID: <CAP+JOzQDnCYLMop4XjAZViFbcuv-=fXhxN9z4dGS3VDwtn34wA@mail.gmail.com>
Subject: Re: [PATCH 2/3] secilc/docs: fix syntax highlighting
To:     bauen1 <j2468h@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Aug 28, 2022 at 8:16 AM bauen1 <j2468h@googlemail.com> wrote:
>
> It appears that a recent version of pandoc (or the library it uses)
> changed where the lists are found in the XML or became more strict.
>
> Move the lists to the right location in the document.
>
> Signed-off-by: Jonathan Hettwer (bauen1) <j2468h@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>   secilc/docs/secil.xml | 344 +++++++++++++++++++++---------------------
>   1 file changed, 172 insertions(+), 172 deletions(-)
>
> diff --git a/secilc/docs/secil.xml b/secilc/docs/secil.xml
> index b015490d..38d7b030 100644
> --- a/secilc/docs/secil.xml
> +++ b/secilc/docs/secil.xml
> @@ -2,182 +2,182 @@
>   <!-- https://docs.kde.org/trunk5/en/applications/katepart/highlight.html#katehighlight-xml-format -->
>   <!DOCTYPE language SYSTEM "language.dtd">
>   <language name="secil" section="Sources" extensions="*.cil" version="1" kateversion="2.4">
> -    <!--
> -        The keywords where extracted from libsepol/cil/src/cil.c sorted into the
> -        right lists and sorted alphabetically
> -    -->
> -    <list name="keywords_blockstart">
> -        <item>allow</item>
> -        <item>allowx</item>
> -        <item>auditallow</item>
> -        <item>auditallowx</item>
> -        <item>block</item>
> -        <item>blockabstract</item>
> -        <item>boolean</item>
> -        <item>booleanif</item>
> -        <item>category</item>
> -        <item>categoryalias</item>
> -        <item>categoryaliasactual</item>
> -        <item>categoryorder</item>
> -        <item>categoryset</item>
> -        <item>class</item>
> -        <item>classcommon</item>
> -        <item>classmap</item>
> -        <item>classmapping</item>
> -        <item>classorder</item>
> -        <item>classpermission</item>
> -        <item>classpermissionset</item>
> -        <item>common</item>
> -        <item>constrain</item>
> -        <item>context</item>
> -        <item>defaultrange</item>
> -        <item>defaultrole</item>
> -        <item>defaulttype</item>
> -        <item>defaultuser</item>
> -        <item>devicetreecon</item>
> -        <item>dontaudit</item>
> -        <item>dontauditx</item>
> -        <item>expandtypeattribute</item>
> -        <item>false</item>
> -        <item>filecon</item>
> -        <item>fsuse</item>
> -        <item>genfscon</item>
> -        <item>handleunknown</item>
> -        <item>ibendportcon</item>
> -        <item>ibpkeycon</item>
> -        <item>ioctl</item>
> -        <item>iomemcon</item>
> -        <item>ioportcon</item>
> -        <item>ipaddr</item>
> -        <item>level</item>
> -        <item>levelrange</item>
> -        <item>mls</item>
> -        <item>mlsconstrain</item>
> -        <item>mlsvalidatetrans</item>
> -        <item>netifcon</item>
> -        <item>neverallow</item>
> -        <item>neverallowx</item>
> -        <item>nodecon</item>
> -        <item>optional</item>
> -        <item>pcidevicecon</item>
> -        <item>perm</item>
> -        <item>permissionx</item>
> -        <item>pirqcon</item>
> -        <item>policycap</item>
> -        <item>portcon</item>
> -        <item>rangetransition</item>
> -        <item>role</item>
> -        <item>roleallow</item>
> -        <item>roleattribute</item>
> -        <item>roleattributeset</item>
> -        <item>rolebounds</item>
> -        <item>roletransition</item>
> -        <item>roletype</item>
> -        <item>selinuxuser</item>
> -        <item>selinuxuserdefault</item>
> -        <item>sensitivity</item>
> -        <item>sensitivityalias</item>
> -        <item>sensitivityaliasactual</item>
> -        <item>sensitivitycategory</item>
> -        <item>sensitivityorder</item>
> -        <item>sid</item>
> -        <item>sidcontext</item>
> -        <item>sidorder</item>
> -        <item>true</item>
> -        <item>tunable</item>
> -        <item>tunableif</item>
> -        <item>type</item>
> -        <item>typealias</item>
> -        <item>typealiasactual</item>
> -        <item>typeattribute</item>
> -        <item>typeattributeset</item>
> -        <item>typebounds</item>
> -        <item>typechange</item>
> -        <item>typemember</item>
> -        <item>typepermissive</item>
> -        <item>typetransition</item>
> -        <item>unordered</item>
> -        <item>user</item>
> -        <item>userattribute</item>
> -        <item>userattributeset</item>
> -        <item>userbounds</item>
> -        <item>userlevel</item>
> -        <item>userprefix</item>
> -        <item>userrange</item>
> -        <item>userrole</item>
> -        <item>validatetrans</item>
> -    </list>
> +    <highlighting>
> +        <!--
> +            The keywords where extracted from libsepol/cil/src/cil.c sorted into the
> +            right lists and sorted alphabetically
> +        -->
> +        <list name="keywords_blockstart">
> +            <item>allow</item>
> +            <item>allowx</item>
> +            <item>auditallow</item>
> +            <item>auditallowx</item>
> +            <item>block</item>
> +            <item>blockabstract</item>
> +            <item>boolean</item>
> +            <item>booleanif</item>
> +            <item>category</item>
> +            <item>categoryalias</item>
> +            <item>categoryaliasactual</item>
> +            <item>categoryorder</item>
> +            <item>categoryset</item>
> +            <item>class</item>
> +            <item>classcommon</item>
> +            <item>classmap</item>
> +            <item>classmapping</item>
> +            <item>classorder</item>
> +            <item>classpermission</item>
> +            <item>classpermissionset</item>
> +            <item>common</item>
> +            <item>constrain</item>
> +            <item>context</item>
> +            <item>defaultrange</item>
> +            <item>defaultrole</item>
> +            <item>defaulttype</item>
> +            <item>defaultuser</item>
> +            <item>devicetreecon</item>
> +            <item>dontaudit</item>
> +            <item>dontauditx</item>
> +            <item>expandtypeattribute</item>
> +            <item>false</item>
> +            <item>filecon</item>
> +            <item>fsuse</item>
> +            <item>genfscon</item>
> +            <item>handleunknown</item>
> +            <item>ibendportcon</item>
> +            <item>ibpkeycon</item>
> +            <item>ioctl</item>
> +            <item>iomemcon</item>
> +            <item>ioportcon</item>
> +            <item>ipaddr</item>
> +            <item>level</item>
> +            <item>levelrange</item>
> +            <item>mls</item>
> +            <item>mlsconstrain</item>
> +            <item>mlsvalidatetrans</item>
> +            <item>netifcon</item>
> +            <item>neverallow</item>
> +            <item>neverallowx</item>
> +            <item>nodecon</item>
> +            <item>optional</item>
> +            <item>pcidevicecon</item>
> +            <item>perm</item>
> +            <item>permissionx</item>
> +            <item>pirqcon</item>
> +            <item>policycap</item>
> +            <item>portcon</item>
> +            <item>rangetransition</item>
> +            <item>role</item>
> +            <item>roleallow</item>
> +            <item>roleattribute</item>
> +            <item>roleattributeset</item>
> +            <item>rolebounds</item>
> +            <item>roletransition</item>
> +            <item>roletype</item>
> +            <item>selinuxuser</item>
> +            <item>selinuxuserdefault</item>
> +            <item>sensitivity</item>
> +            <item>sensitivityalias</item>
> +            <item>sensitivityaliasactual</item>
> +            <item>sensitivitycategory</item>
> +            <item>sensitivityorder</item>
> +            <item>sid</item>
> +            <item>sidcontext</item>
> +            <item>sidorder</item>
> +            <item>true</item>
> +            <item>tunable</item>
> +            <item>tunableif</item>
> +            <item>type</item>
> +            <item>typealias</item>
> +            <item>typealiasactual</item>
> +            <item>typeattribute</item>
> +            <item>typeattributeset</item>
> +            <item>typebounds</item>
> +            <item>typechange</item>
> +            <item>typemember</item>
> +            <item>typepermissive</item>
> +            <item>typetransition</item>
> +            <item>unordered</item>
> +            <item>user</item>
> +            <item>userattribute</item>
> +            <item>userattributeset</item>
> +            <item>userbounds</item>
> +            <item>userlevel</item>
> +            <item>userprefix</item>
> +            <item>userrange</item>
> +            <item>userrole</item>
> +            <item>validatetrans</item>
> +        </list>
>
> -    <list name="function">
> -        <item>blockinherit</item>
> -        <item>call</item>
> -        <item>in</item>
> -        <item>macro</item>
> -    </list>
> +        <list name="function">
> +            <item>blockinherit</item>
> +            <item>call</item>
> +            <item>in</item>
> +            <item>macro</item>
> +        </list>
>
> -    <list name="operators">
> -        <item>and</item>
> -        <item>dom</item>
> -        <item>domby</item>
> -        <item>eq</item>
> -        <item>incomp</item>
> -        <item>neq</item>
> -        <item>not</item>
> -        <item>or</item>
> -        <item>range</item>
> -        <item>xor</item>
> -    </list>
> +        <list name="operators">
> +            <item>and</item>
> +            <item>dom</item>
> +            <item>domby</item>
> +            <item>eq</item>
> +            <item>incomp</item>
> +            <item>neq</item>
> +            <item>not</item>
> +            <item>or</item>
> +            <item>range</item>
> +            <item>xor</item>
> +        </list>
>
> -    <!-- list of "magic" functions or values -->
> -    <list name="builtins">
> -        <item>*</item>
> -        <item>all</item>
> -        <item>dccp</item>
> -        <item>false</item>
> -        <item>h1</item>
> -        <item>h2</item>
> -        <item>l1</item>
> -        <item>l2</item>
> -        <item>object_r</item>
> -        <item>r1</item>
> -        <item>r2</item>
> -        <item>r3</item>
> -        <item>sctp</item>
> -        <item>self</item>
> -        <item>t1</item>
> -        <item>t2</item>
> -        <item>t3</item>
> -        <item>tcp</item>
> -        <item>true</item>
> -        <item>u1</item>
> -        <item>u2</item>
> -        <item>u3</item>
> -        <item>udp</item>
> +        <!-- list of "magic" functions or values -->
> +        <list name="builtins">
> +            <item>*</item>
> +            <item>all</item>
> +            <item>dccp</item>
> +            <item>false</item>
> +            <item>h1</item>
> +            <item>h2</item>
> +            <item>l1</item>
> +            <item>l2</item>
> +            <item>object_r</item>
> +            <item>r1</item>
> +            <item>r2</item>
> +            <item>r3</item>
> +            <item>sctp</item>
> +            <item>self</item>
> +            <item>t1</item>
> +            <item>t2</item>
> +            <item>t3</item>
> +            <item>tcp</item>
> +            <item>true</item>
> +            <item>u1</item>
> +            <item>u2</item>
> +            <item>u3</item>
> +            <item>udp</item>
>
> -        <!--
> -            Excluded because they lead to a lot of false-positives
> -        <item>allow</item>
> -        <item>any</item>
> -        <item>char</item>
> -        <item>deny</item>
> -        <item>dir</item>
> -        <item>file</item>
> -        <item>glblub</item>
> -        <item>high</item>
> -        <item>low-high</item>
> -        <item>low</item>
> -        <item>pipe</item>
> -        <item>reject</item>
> -        <item>socket</item>
> -        <item>source</item>
> -        <item>symlink</item>
> -        <item>target</item>
> -        <item>task</item>
> -        <item>trans</item>
> -        <item>xattr</item>
> -        -->
> -    </list>
> -    <highlighting>
> +            <!--
> +                Excluded because they lead to a lot of false-positives
> +            <item>allow</item>
> +            <item>any</item>
> +            <item>char</item>
> +            <item>deny</item>
> +            <item>dir</item>
> +            <item>file</item>
> +            <item>glblub</item>
> +            <item>high</item>
> +            <item>low-high</item>
> +            <item>low</item>
> +            <item>pipe</item>
> +            <item>reject</item>
> +            <item>socket</item>
> +            <item>source</item>
> +            <item>symlink</item>
> +            <item>target</item>
> +            <item>task</item>
> +            <item>trans</item>
> +            <item>xattr</item>
> +            -->
> +        </list>
>           <contexts>
>               <context name="Normal" attribute="Normal" lineEndContext="#stay">
>                   <DetectChar attribute="Brackets" context="BlockStart" char="("/>
> --
> 2.36.1
>
