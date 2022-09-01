Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57438ECAAD2
	for <selinux@archiver.kernel.org>; Thu,  1 Sep 2022 19:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbiIAT7P (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Sep 2022 15:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbiIAT66 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Sep 2022 15:58:58 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A911A9CCD6
        for <selinux@vger.kernel.org>; Thu,  1 Sep 2022 12:58:39 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id d68so15523431iof.11
        for <selinux@vger.kernel.org>; Thu, 01 Sep 2022 12:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=L1aNNmoPoXU1NQiM0KwIWzdVLbFvoBFMFAWT4vY2/90=;
        b=R4gocWOB/8cr+W3DAOjyAkANLeQRDdpxAyUDe+ljKuRuW/f6ZGQFlRMqGkty9rYgl7
         VqTauVDUweqOVzQrTntjgeVFmJqO+g8sUBDh047UCq1J8DDrg0UbOtl61bKq6ubqz5lU
         YIGpWY01X4OMS8JeOHsH+uIYafA9MsS6q8L+zeSj+x5MZm2Vd0U6rXpuyEfxqXhf7ATP
         A5NADyhamZGr29v4C/WNu9GSjvPaEpGyfvuOFJvUGvutD28ib3MJtRqs8C+y1cOwb4jD
         gNqxfAPl5p0hpgwDGSRiWPUHQzfy1y5B0IZ4/B9KffByRIqH2T6DlUYtSDjmqBcjbu1H
         UBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=L1aNNmoPoXU1NQiM0KwIWzdVLbFvoBFMFAWT4vY2/90=;
        b=Wmtk8K1PjEahGOq43uPnOrGn0RzM8RziNSqQXDmQIeVpVGW02IWhiPA/wkh84JgZtK
         kqKohvu1w9nayrOJSC85WfyAZFQ8Yx+6VkX9HDGLQm/WjVRQwptKphPG8Bzonoup0wgp
         4zwS4ahBDLyU99RGORB2oa8Nf0J3hHEaDpPermw7oycWwFOnID7I3135feAhR3FCDGKk
         cJUw2scMmtynJebetOinWLiDxY+4CWyut8HRS2oTGb+ivAYmjUh7nqy/SQmcYWvyBTjq
         uA2DQVT6pYVfrCHHPiZhww8QHfh1M8Y33p1E+9fYOXbmcx70H+G1dTqJLctK24Sq7Ere
         zXMA==
X-Gm-Message-State: ACgBeo0Zz7DhUtoNoF0wnTyA/DYWWRvmmKNgfXoNU55ukKOPYoPqs1sQ
        Filq9jn4ywQJ+YUu7lAXOBerMAS+QziUiUa6hekuDAKh
X-Google-Smtp-Source: AA6agR5dMVzbjDWwqJ2n1hmmtLbQxxsYUPME5Vl4gDQU8dBm8eiAot+/jncWsaLwzpSC/KlU/BqF9ZwafwUtvmp4kdM=
X-Received: by 2002:a6b:510d:0:b0:689:5a18:1150 with SMTP id
 f13-20020a6b510d000000b006895a181150mr15126682iob.73.1662062317746; Thu, 01
 Sep 2022 12:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <50b132b2-3adb-042b-647d-962baf228701@gmail.com> <CAP+JOzQDnCYLMop4XjAZViFbcuv-=fXhxN9z4dGS3VDwtn34wA@mail.gmail.com>
In-Reply-To: <CAP+JOzQDnCYLMop4XjAZViFbcuv-=fXhxN9z4dGS3VDwtn34wA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 1 Sep 2022 15:58:26 -0400
Message-ID: <CAP+JOzTStPBLbDG=Dj-WV29_9ZkiXnv5=rHdLZA9ATxuZd5SgQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] secilc/docs: fix syntax highlighting
To:     bauen1 <j2468h@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 31, 2022 at 7:54 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Sun, Aug 28, 2022 at 8:16 AM bauen1 <j2468h@googlemail.com> wrote:
> >
> > It appears that a recent version of pandoc (or the library it uses)
> > changed where the lists are found in the XML or became more strict.
> >
> > Move the lists to the right location in the document.
> >
> > Signed-off-by: Jonathan Hettwer (bauen1) <j2468h@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

This patch has been merged.
Thanks,
Jim

> > ---
> >   secilc/docs/secil.xml | 344 +++++++++++++++++++++---------------------
> >   1 file changed, 172 insertions(+), 172 deletions(-)
> >
> > diff --git a/secilc/docs/secil.xml b/secilc/docs/secil.xml
> > index b015490d..38d7b030 100644
> > --- a/secilc/docs/secil.xml
> > +++ b/secilc/docs/secil.xml
> > @@ -2,182 +2,182 @@
> >   <!-- https://docs.kde.org/trunk5/en/applications/katepart/highlight.html#katehighlight-xml-format -->
> >   <!DOCTYPE language SYSTEM "language.dtd">
> >   <language name="secil" section="Sources" extensions="*.cil" version="1" kateversion="2.4">
> > -    <!--
> > -        The keywords where extracted from libsepol/cil/src/cil.c sorted into the
> > -        right lists and sorted alphabetically
> > -    -->
> > -    <list name="keywords_blockstart">
> > -        <item>allow</item>
> > -        <item>allowx</item>
> > -        <item>auditallow</item>
> > -        <item>auditallowx</item>
> > -        <item>block</item>
> > -        <item>blockabstract</item>
> > -        <item>boolean</item>
> > -        <item>booleanif</item>
> > -        <item>category</item>
> > -        <item>categoryalias</item>
> > -        <item>categoryaliasactual</item>
> > -        <item>categoryorder</item>
> > -        <item>categoryset</item>
> > -        <item>class</item>
> > -        <item>classcommon</item>
> > -        <item>classmap</item>
> > -        <item>classmapping</item>
> > -        <item>classorder</item>
> > -        <item>classpermission</item>
> > -        <item>classpermissionset</item>
> > -        <item>common</item>
> > -        <item>constrain</item>
> > -        <item>context</item>
> > -        <item>defaultrange</item>
> > -        <item>defaultrole</item>
> > -        <item>defaulttype</item>
> > -        <item>defaultuser</item>
> > -        <item>devicetreecon</item>
> > -        <item>dontaudit</item>
> > -        <item>dontauditx</item>
> > -        <item>expandtypeattribute</item>
> > -        <item>false</item>
> > -        <item>filecon</item>
> > -        <item>fsuse</item>
> > -        <item>genfscon</item>
> > -        <item>handleunknown</item>
> > -        <item>ibendportcon</item>
> > -        <item>ibpkeycon</item>
> > -        <item>ioctl</item>
> > -        <item>iomemcon</item>
> > -        <item>ioportcon</item>
> > -        <item>ipaddr</item>
> > -        <item>level</item>
> > -        <item>levelrange</item>
> > -        <item>mls</item>
> > -        <item>mlsconstrain</item>
> > -        <item>mlsvalidatetrans</item>
> > -        <item>netifcon</item>
> > -        <item>neverallow</item>
> > -        <item>neverallowx</item>
> > -        <item>nodecon</item>
> > -        <item>optional</item>
> > -        <item>pcidevicecon</item>
> > -        <item>perm</item>
> > -        <item>permissionx</item>
> > -        <item>pirqcon</item>
> > -        <item>policycap</item>
> > -        <item>portcon</item>
> > -        <item>rangetransition</item>
> > -        <item>role</item>
> > -        <item>roleallow</item>
> > -        <item>roleattribute</item>
> > -        <item>roleattributeset</item>
> > -        <item>rolebounds</item>
> > -        <item>roletransition</item>
> > -        <item>roletype</item>
> > -        <item>selinuxuser</item>
> > -        <item>selinuxuserdefault</item>
> > -        <item>sensitivity</item>
> > -        <item>sensitivityalias</item>
> > -        <item>sensitivityaliasactual</item>
> > -        <item>sensitivitycategory</item>
> > -        <item>sensitivityorder</item>
> > -        <item>sid</item>
> > -        <item>sidcontext</item>
> > -        <item>sidorder</item>
> > -        <item>true</item>
> > -        <item>tunable</item>
> > -        <item>tunableif</item>
> > -        <item>type</item>
> > -        <item>typealias</item>
> > -        <item>typealiasactual</item>
> > -        <item>typeattribute</item>
> > -        <item>typeattributeset</item>
> > -        <item>typebounds</item>
> > -        <item>typechange</item>
> > -        <item>typemember</item>
> > -        <item>typepermissive</item>
> > -        <item>typetransition</item>
> > -        <item>unordered</item>
> > -        <item>user</item>
> > -        <item>userattribute</item>
> > -        <item>userattributeset</item>
> > -        <item>userbounds</item>
> > -        <item>userlevel</item>
> > -        <item>userprefix</item>
> > -        <item>userrange</item>
> > -        <item>userrole</item>
> > -        <item>validatetrans</item>
> > -    </list>
> > +    <highlighting>
> > +        <!--
> > +            The keywords where extracted from libsepol/cil/src/cil.c sorted into the
> > +            right lists and sorted alphabetically
> > +        -->
> > +        <list name="keywords_blockstart">
> > +            <item>allow</item>
> > +            <item>allowx</item>
> > +            <item>auditallow</item>
> > +            <item>auditallowx</item>
> > +            <item>block</item>
> > +            <item>blockabstract</item>
> > +            <item>boolean</item>
> > +            <item>booleanif</item>
> > +            <item>category</item>
> > +            <item>categoryalias</item>
> > +            <item>categoryaliasactual</item>
> > +            <item>categoryorder</item>
> > +            <item>categoryset</item>
> > +            <item>class</item>
> > +            <item>classcommon</item>
> > +            <item>classmap</item>
> > +            <item>classmapping</item>
> > +            <item>classorder</item>
> > +            <item>classpermission</item>
> > +            <item>classpermissionset</item>
> > +            <item>common</item>
> > +            <item>constrain</item>
> > +            <item>context</item>
> > +            <item>defaultrange</item>
> > +            <item>defaultrole</item>
> > +            <item>defaulttype</item>
> > +            <item>defaultuser</item>
> > +            <item>devicetreecon</item>
> > +            <item>dontaudit</item>
> > +            <item>dontauditx</item>
> > +            <item>expandtypeattribute</item>
> > +            <item>false</item>
> > +            <item>filecon</item>
> > +            <item>fsuse</item>
> > +            <item>genfscon</item>
> > +            <item>handleunknown</item>
> > +            <item>ibendportcon</item>
> > +            <item>ibpkeycon</item>
> > +            <item>ioctl</item>
> > +            <item>iomemcon</item>
> > +            <item>ioportcon</item>
> > +            <item>ipaddr</item>
> > +            <item>level</item>
> > +            <item>levelrange</item>
> > +            <item>mls</item>
> > +            <item>mlsconstrain</item>
> > +            <item>mlsvalidatetrans</item>
> > +            <item>netifcon</item>
> > +            <item>neverallow</item>
> > +            <item>neverallowx</item>
> > +            <item>nodecon</item>
> > +            <item>optional</item>
> > +            <item>pcidevicecon</item>
> > +            <item>perm</item>
> > +            <item>permissionx</item>
> > +            <item>pirqcon</item>
> > +            <item>policycap</item>
> > +            <item>portcon</item>
> > +            <item>rangetransition</item>
> > +            <item>role</item>
> > +            <item>roleallow</item>
> > +            <item>roleattribute</item>
> > +            <item>roleattributeset</item>
> > +            <item>rolebounds</item>
> > +            <item>roletransition</item>
> > +            <item>roletype</item>
> > +            <item>selinuxuser</item>
> > +            <item>selinuxuserdefault</item>
> > +            <item>sensitivity</item>
> > +            <item>sensitivityalias</item>
> > +            <item>sensitivityaliasactual</item>
> > +            <item>sensitivitycategory</item>
> > +            <item>sensitivityorder</item>
> > +            <item>sid</item>
> > +            <item>sidcontext</item>
> > +            <item>sidorder</item>
> > +            <item>true</item>
> > +            <item>tunable</item>
> > +            <item>tunableif</item>
> > +            <item>type</item>
> > +            <item>typealias</item>
> > +            <item>typealiasactual</item>
> > +            <item>typeattribute</item>
> > +            <item>typeattributeset</item>
> > +            <item>typebounds</item>
> > +            <item>typechange</item>
> > +            <item>typemember</item>
> > +            <item>typepermissive</item>
> > +            <item>typetransition</item>
> > +            <item>unordered</item>
> > +            <item>user</item>
> > +            <item>userattribute</item>
> > +            <item>userattributeset</item>
> > +            <item>userbounds</item>
> > +            <item>userlevel</item>
> > +            <item>userprefix</item>
> > +            <item>userrange</item>
> > +            <item>userrole</item>
> > +            <item>validatetrans</item>
> > +        </list>
> >
> > -    <list name="function">
> > -        <item>blockinherit</item>
> > -        <item>call</item>
> > -        <item>in</item>
> > -        <item>macro</item>
> > -    </list>
> > +        <list name="function">
> > +            <item>blockinherit</item>
> > +            <item>call</item>
> > +            <item>in</item>
> > +            <item>macro</item>
> > +        </list>
> >
> > -    <list name="operators">
> > -        <item>and</item>
> > -        <item>dom</item>
> > -        <item>domby</item>
> > -        <item>eq</item>
> > -        <item>incomp</item>
> > -        <item>neq</item>
> > -        <item>not</item>
> > -        <item>or</item>
> > -        <item>range</item>
> > -        <item>xor</item>
> > -    </list>
> > +        <list name="operators">
> > +            <item>and</item>
> > +            <item>dom</item>
> > +            <item>domby</item>
> > +            <item>eq</item>
> > +            <item>incomp</item>
> > +            <item>neq</item>
> > +            <item>not</item>
> > +            <item>or</item>
> > +            <item>range</item>
> > +            <item>xor</item>
> > +        </list>
> >
> > -    <!-- list of "magic" functions or values -->
> > -    <list name="builtins">
> > -        <item>*</item>
> > -        <item>all</item>
> > -        <item>dccp</item>
> > -        <item>false</item>
> > -        <item>h1</item>
> > -        <item>h2</item>
> > -        <item>l1</item>
> > -        <item>l2</item>
> > -        <item>object_r</item>
> > -        <item>r1</item>
> > -        <item>r2</item>
> > -        <item>r3</item>
> > -        <item>sctp</item>
> > -        <item>self</item>
> > -        <item>t1</item>
> > -        <item>t2</item>
> > -        <item>t3</item>
> > -        <item>tcp</item>
> > -        <item>true</item>
> > -        <item>u1</item>
> > -        <item>u2</item>
> > -        <item>u3</item>
> > -        <item>udp</item>
> > +        <!-- list of "magic" functions or values -->
> > +        <list name="builtins">
> > +            <item>*</item>
> > +            <item>all</item>
> > +            <item>dccp</item>
> > +            <item>false</item>
> > +            <item>h1</item>
> > +            <item>h2</item>
> > +            <item>l1</item>
> > +            <item>l2</item>
> > +            <item>object_r</item>
> > +            <item>r1</item>
> > +            <item>r2</item>
> > +            <item>r3</item>
> > +            <item>sctp</item>
> > +            <item>self</item>
> > +            <item>t1</item>
> > +            <item>t2</item>
> > +            <item>t3</item>
> > +            <item>tcp</item>
> > +            <item>true</item>
> > +            <item>u1</item>
> > +            <item>u2</item>
> > +            <item>u3</item>
> > +            <item>udp</item>
> >
> > -        <!--
> > -            Excluded because they lead to a lot of false-positives
> > -        <item>allow</item>
> > -        <item>any</item>
> > -        <item>char</item>
> > -        <item>deny</item>
> > -        <item>dir</item>
> > -        <item>file</item>
> > -        <item>glblub</item>
> > -        <item>high</item>
> > -        <item>low-high</item>
> > -        <item>low</item>
> > -        <item>pipe</item>
> > -        <item>reject</item>
> > -        <item>socket</item>
> > -        <item>source</item>
> > -        <item>symlink</item>
> > -        <item>target</item>
> > -        <item>task</item>
> > -        <item>trans</item>
> > -        <item>xattr</item>
> > -        -->
> > -    </list>
> > -    <highlighting>
> > +            <!--
> > +                Excluded because they lead to a lot of false-positives
> > +            <item>allow</item>
> > +            <item>any</item>
> > +            <item>char</item>
> > +            <item>deny</item>
> > +            <item>dir</item>
> > +            <item>file</item>
> > +            <item>glblub</item>
> > +            <item>high</item>
> > +            <item>low-high</item>
> > +            <item>low</item>
> > +            <item>pipe</item>
> > +            <item>reject</item>
> > +            <item>socket</item>
> > +            <item>source</item>
> > +            <item>symlink</item>
> > +            <item>target</item>
> > +            <item>task</item>
> > +            <item>trans</item>
> > +            <item>xattr</item>
> > +            -->
> > +        </list>
> >           <contexts>
> >               <context name="Normal" attribute="Normal" lineEndContext="#stay">
> >                   <DetectChar attribute="Brackets" context="BlockStart" char="("/>
> > --
> > 2.36.1
> >
