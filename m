Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E62C433E6
	for <selinux@archiver.kernel.org>; Tue, 16 Feb 2021 14:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E48F64E68
	for <selinux@archiver.kernel.org>; Tue, 16 Feb 2021 14:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbhBPOl4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Feb 2021 09:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhBPOlw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Feb 2021 09:41:52 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA83C061574
        for <selinux@vger.kernel.org>; Tue, 16 Feb 2021 06:41:12 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 100so9175935otg.3
        for <selinux@vger.kernel.org>; Tue, 16 Feb 2021 06:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A001vMaPKkrejc2PnvNRSE7uR4tTUYeQmjy5Yi+EBe8=;
        b=aR7qm3VDdFoNB1zVPA8LgRCchqg/5OC8j549VQ9Yv8ofhVw845xOwsr8N4fdUM5GcU
         eRp73wHhTKyH0OaW6YdtgFgkJjQeSFkaUzjDIHRpJtAuf7uR/COm/rOXxP45/mjJleTq
         YAQ4k5DFOKh0rEZ/gYOQ6tx5jnLu3MCvZDWX27IzgR+owi2KYDosqKhCaN+MIOqyowFw
         IB6H0kc6IeszxOmWgwE+LkQzf+TNygbAWviG2oJmDHzKX/A+bFC9005hsUjwCaiT3vRG
         zQYUOZzx38g4MeAcCwzPAsE3mzvvzrh3dBxWrf/a8CcbLEK1Hpwu1iaDiPMP24tWWWum
         JcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A001vMaPKkrejc2PnvNRSE7uR4tTUYeQmjy5Yi+EBe8=;
        b=tesInPrdARFn76zEJV0vKcwOesfCfsXC7CwYk7zqA9nFmuWBfOP+g//X9C6lffkrBW
         q+LQnjnIxSnxPXI22BMFChdJocSIxlEpA6DYhMaTpOWACrteF1LgvUlTu34F0ssafQAj
         AmRk5Iy0nsNy3juuFEgum8NTus9y2YRBw6uYfO477jQSgNj/eO+OaI29W+lxFtvaknQB
         SN1KxIDHHSHYB95xx1UcXEmT1w/Ky4LIHosIXH7cVQUs0Gr16bZ+vYqdBPvuV20UuTe9
         hnOTUsp2bE4ESUzoXWO7/JvjGNlbd9h74P5jTh8bVxozpWiAUCfP9a5etzEOncD+ak6f
         AlzA==
X-Gm-Message-State: AOAM5321ws//o1HniBGv9C8s2JMzESEgMfTlOW1jIOg25FsGzHvMY9fz
        0prbIUW23TkBvTBEAnFPEgGxlMSY7KLVqgF5jG4=
X-Google-Smtp-Source: ABdhPJzF7McU9k7CEDbEVoZ03w/QUeqwwfT4W8ZDz1M9HMpx4Jcql2bvyBBzDVBz99QLZ2PjmfCjUrs2VQDGNIjykjg=
X-Received: by 2002:a05:6830:1db3:: with SMTP id z19mr14924241oti.295.1613486471957;
 Tue, 16 Feb 2021 06:41:11 -0800 (PST)
MIME-Version: 1.0
References: <a8abefda-5c2b-918d-65d9-e21b89e9a2bf@gmail.com>
 <90473e07-fe79-18d8-4772-52deb4f8e1bd@gmail.com> <CAP+JOzSeJs5X_LTSvKojLtPMQuxQz5xETDfNikxKwTOqNgTwWw@mail.gmail.com>
In-Reply-To: <CAP+JOzSeJs5X_LTSvKojLtPMQuxQz5xETDfNikxKwTOqNgTwWw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 16 Feb 2021 09:41:01 -0500
Message-ID: <CAP+JOzQ+uE3BaUi+RTySF0mONAzSu-m+VTnwPA7pYw8ZKsagYQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] secilc/docs: add syntax highlighting for secil
To:     bauen1 <j2468h@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 11, 2021 at 6:35 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Sat, Feb 6, 2021 at 4:05 PM bauen1 <j2468h@googlemail.com> wrote:
> >
> > This is done by creating a somewhat rudimentary KDE syntax xml for
> > pandoc.
> >
> > The default styles provided by pandoc don't look very good and don't
> > highlight e.g. the strings marked as builtin.
> >
> > Signed-off-by: Jonathan Hettwer <j2468h@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Applied.
Thanks,
Jim

> > ---
> >  secilc/docs/Makefile  |  10 +-
> >  secilc/docs/secil.xml | 236 ++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 242 insertions(+), 4 deletions(-)
> >  create mode 100644 secilc/docs/secil.xml
> >
> > diff --git a/secilc/docs/Makefile b/secilc/docs/Makefile
> > index 79a165ba..a91bcde0 100644
> > --- a/secilc/docs/Makefile
> > +++ b/secilc/docs/Makefile
> > @@ -28,6 +28,8 @@ FILE_LIST ?= cil_introduction.md \
> >
> >  PANDOC_FILE_LIST = $(addprefix $(TMPDIR)/,$(FILE_LIST))
> >
> > +PANDOC_HIGHLIGHT_STYLE="pygments"
> > +
> >  PDF_OUT=CIL_Reference_Guide.pdf
> >  HTML_OUT=CIL_Reference_Guide.html
> >  PANDOC = pandoc
> > @@ -54,13 +56,13 @@ $(TMPDIR)/policy.cil: $(TESTDIR)/policy.cil
> >         $(SED) -i '1i Example Policy\n=========\n```secil' $@
> >         echo '```' >> $@
> >
> > -html: $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil
> > +html: $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil secil.xml
> >         mkdir -p $(HTMLDIR)
> > -       $(PANDOC) -t html $^ -o $(HTMLDIR)/$(HTML_OUT)
> > +       $(PANDOC) --highlight-style=$(PANDOC_HIGHLIGHT_STYLE) --syntax-definition=secil.xml --standalone --metadata title="CIL Reference Guide" -t html $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil  -o $(HTMLDIR)/$(HTML_OUT)
> >
> > -pdf: $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil
> > +pdf: $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil secil.xml
> >         mkdir -p $(PDFDIR)
> > -       $(PANDOC) --standalone --toc $^ -o $(PDFDIR)/$(PDF_OUT)
> > +       $(PANDOC) --highlight-style=$(PANDOC_HIGHLIGHT_STYLE) --syntax-definition=secil.xml --standalone --toc $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil -o $(PDFDIR)/$(PDF_OUT)
> >
> >  clean:
> >         rm -rf $(HTMLDIR)
> > diff --git a/secilc/docs/secil.xml b/secilc/docs/secil.xml
> > new file mode 100644
> > index 00000000..daa80ded
> > --- /dev/null
> > +++ b/secilc/docs/secil.xml
> > @@ -0,0 +1,236 @@
> > +<?xml version="1.0" encoding="UTF-8"?>
> > +<!-- https://docs.kde.org/trunk5/en/applications/katepart/highlight.html#katehighlight-xml-format -->
> > +<!DOCTYPE language SYSTEM "language.dtd">
> > +<language name="secil" section="Sources" extensions="*.cil" version="1" kateversion="2.4">
> > +    <!--
> > +        The keywords where extracted from libsepol/cil/src/cil.c sorted into the
> > +        right lists and sorted alphabetically
> > +    -->
> > +    <list name="keywords_blockstart">
> > +        <item>allow</item>
> > +        <item>allowx</item>
> > +        <item>auditallow</item>
> > +        <item>auditallowx</item>
> > +        <item>block</item>
> > +        <item>blockabstract</item>
> > +        <item>boolean</item>
> > +        <item>booleanif</item>
> > +        <item>category</item>
> > +        <item>categoryalias</item>
> > +        <item>categoryaliasactual</item>
> > +        <item>categoryorder</item>
> > +        <item>categoryset</item>
> > +        <item>class</item>
> > +        <item>classcommon</item>
> > +        <item>classmap</item>
> > +        <item>classmapping</item>
> > +        <item>classorder</item>
> > +        <item>classpermission</item>
> > +        <item>classpermissionset</item>
> > +        <item>common</item>
> > +        <item>constrain</item>
> > +        <item>context</item>
> > +        <item>defaultrange</item>
> > +        <item>defaultrole</item>
> > +        <item>defaulttype</item>
> > +        <item>defaultuser</item>
> > +        <item>devicetreecon</item>
> > +        <item>dontaudit</item>
> > +        <item>dontauditx</item>
> > +        <item>expandtypeattribute</item>
> > +        <item>false</item>
> > +        <item>filecon</item>
> > +        <item>fsuse</item>
> > +        <item>genfscon</item>
> > +        <item>handleunknown</item>
> > +        <item>ibendportcon</item>
> > +        <item>ibpkeycon</item>
> > +        <item>ioctl</item>
> > +        <item>iomemcon</item>
> > +        <item>ioportcon</item>
> > +        <item>ipaddr</item>
> > +        <item>level</item>
> > +        <item>levelrange</item>
> > +        <item>mls</item>
> > +        <item>mlsconstrain</item>
> > +        <item>mlsvalidatetrans</item>
> > +        <item>netifcon</item>
> > +        <item>neverallow</item>
> > +        <item>neverallowx</item>
> > +        <item>nodecon</item>
> > +        <item>optional</item>
> > +        <item>pcidevicecon</item>
> > +        <item>perm</item>
> > +        <item>permissionx</item>
> > +        <item>pirqcon</item>
> > +        <item>policycap</item>
> > +        <item>portcon</item>
> > +        <item>rangetransition</item>
> > +        <item>role</item>
> > +        <item>roleallow</item>
> > +        <item>roleattribute</item>
> > +        <item>roleattributeset</item>
> > +        <item>rolebounds</item>
> > +        <item>roletransition</item>
> > +        <item>roletype</item>
> > +        <item>selinuxuser</item>
> > +        <item>selinuxuserdefault</item>
> > +        <item>sensitivity</item>
> > +        <item>sensitivityalias</item>
> > +        <item>sensitivityaliasactual</item>
> > +        <item>sensitivitycategory</item>
> > +        <item>sensitivityorder</item>
> > +        <item>sid</item>
> > +        <item>sidcontext</item>
> > +        <item>sidorder</item>
> > +        <item>true</item>
> > +        <item>tunable</item>
> > +        <item>tunableif</item>
> > +        <item>type</item>
> > +        <item>typealias</item>
> > +        <item>typealiasactual</item>
> > +        <item>typeattribute</item>
> > +        <item>typeattributeset</item>
> > +        <item>typebounds</item>
> > +        <item>typechange</item>
> > +        <item>typemember</item>
> > +        <item>typepermissive</item>
> > +        <item>typetransition</item>
> > +        <item>unordered</item>
> > +        <item>user</item>
> > +        <item>userattribute</item>
> > +        <item>userattributeset</item>
> > +        <item>userbounds</item>
> > +        <item>userlevel</item>
> > +        <item>userprefix</item>
> > +        <item>userrange</item>
> > +        <item>userrole</item>
> > +        <item>validatetrans</item>
> > +    </list>
> > +
> > +    <list name="function">
> > +        <item>blockinherit</item>
> > +        <item>call</item>
> > +        <item>in</item>
> > +        <item>macro</item>
> > +    </list>
> > +
> > +    <list name="operators">
> > +        <item>and</item>
> > +        <item>dom</item>
> > +        <item>domby</item>
> > +        <item>eq</item>
> > +        <item>incomp</item>
> > +        <item>neq</item>
> > +        <item>not</item>
> > +        <item>or</item>
> > +        <item>range</item>
> > +        <item>xor</item>
> > +    </list>
> > +
> > +    <!-- list of "magic" functions or values -->
> > +    <list name="builtins">
> > +        <item>*</item>
> > +        <item>all</item>
> > +        <item>dccp</item>
> > +        <item>false</item>
> > +        <item>h1</item>
> > +        <item>h2</item>
> > +        <item>l1</item>
> > +        <item>l2</item>
> > +        <item>object_r</item>
> > +        <item>r1</item>
> > +        <item>r2</item>
> > +        <item>r3</item>
> > +        <item>sctp</item>
> > +        <item>self</item>
> > +        <item>t1</item>
> > +        <item>t2</item>
> > +        <item>t3</item>
> > +        <item>tcp</item>
> > +        <item>true</item>
> > +        <item>u1</item>
> > +        <item>u2</item>
> > +        <item>u3</item>
> > +        <item>udp</item>
> > +
> > +        <!--
> > +            Excluded because they lead to a lot of false-positives
> > +        <item>allow</item>
> > +        <item>any</item>
> > +        <item>char</item>
> > +        <item>deny</item>
> > +        <item>dir</item>
> > +        <item>file</item>
> > +        <item>glblub</item>
> > +        <item>high</item>
> > +        <item>low-high</item>
> > +        <item>low</item>
> > +        <item>pipe</item>
> > +        <item>reject</item>
> > +        <item>socket</item>
> > +        <item>source</item>
> > +        <item>symlink</item>
> > +        <item>target</item>
> > +        <item>task</item>
> > +        <item>trans</item>
> > +        <item>xattr</item>
> > +        -->
> > +    </list>
> > +    <highlighting>
> > +        <contexts>
> > +            <context name="Normal" attribute="Normal" lineEndContext="#stay">
> > +                <DetectChar attribute="Brackets" context="BlockStart" char="("/>
> > +
> > +                <DetectChar attribute="Comment" context="Comment" char=";"/>
> > +            </context>
> > +            <context name="BlockStart" attribute="Normal" lineEndContext="#stay">
> > +                <keyword attribute="Keyword" context="Block" String="keywords_blockstart"/>
> > +                <keyword attribute="Function" context="Block" String="function"/>
> > +                <keyword attribute="Operator" context="Block" String="operators"/>
> > +
> > +                <DetectChar attribute="Comment" context="Comment" char=";"/>
> > +            </context>
> > +            <context name="Block" attribute="Normal" lineEndContext="#stay">
> > +                <keyword attribute="Builtin" context="#stay" String="builtins"/>
> > +
> > +                <DetectChar attribute="Comment" context="Comment" char=";"/>
> > +                <DetectChar attribute="String" context="String" char="&quot;"/>
> > +
> > +                <DetectChar attribute="Brackets" context="BlockStart" char="("/>
> > +                <DetectChar attribute="Brackets" context="#pop" char=")"/>
> > +            </context>
> > +
> > +            <!-- single line comment -->
> > +            <context name="Comment" attribute="Comment" lineEndContext="#pop"></context>
> > +
> > +            <!-- string / name -->
> > +            <context name="String" attribute="String" lineEndContext="#stay">
> > +                <RegExpr attribute="Char" context="#stay" String="#\\."/>
> > +
> > +                <!-- allow escaping " or similiar -->
> > +                <HlCStringChar attribute="String Char" context="#stay"/>
> > +
> > +                <DetectChar attribute="String" context="#pop" char="&quot;"/>
> > +            </context>
> > +        </contexts>
> > +        <itemDatas>
> > +            <itemData name="Normal" defStyleNum="dsNormal" />
> > +            <itemData name="Keyword" defStyleNum="dsKeyword"/>
> > +            <itemData name="Function" defStyleNum="dsFunction"/>
> > +            <itemData name="Operator" defStyleNum="dsOperator"/>
> > +            <itemData name="Builtin" defStyleNum="dsBuiltIn"/>
> > +
> > +            <itemData name="Comment" defStyleNum="dsComment"/>
> > +
> > +            <itemData name="String" defStyleNum="dsString"/>
> > +            <itemData name="String Char" defStyleNum="dsSpecialChar"/>
> > +        </itemDatas>
> > +    </highlighting>
> > +    <general>
> > +        <comments>
> > +            <comment name="singleLine" start=";"/>
> > +        </comments>
> > +        <keywords casesensitive="1" weakDeliminator="."/>
> > +    </general>
> > +</language>
> > --
> > 2.30.0
> >
