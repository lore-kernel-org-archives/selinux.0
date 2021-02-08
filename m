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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47657C433E9
	for <selinux@archiver.kernel.org>; Mon,  8 Feb 2021 17:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D21E64E85
	for <selinux@archiver.kernel.org>; Mon,  8 Feb 2021 17:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbhBHRx1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Feb 2021 12:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbhBHRv4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Feb 2021 12:51:56 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC394C061793
        for <selinux@vger.kernel.org>; Mon,  8 Feb 2021 09:43:49 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id r21so6453843otk.13
        for <selinux@vger.kernel.org>; Mon, 08 Feb 2021 09:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x5UU+FALll2OwK9GDy96o96F5GjMzMAxqrONINNl/dc=;
        b=MR5QkrdiBOjB+UCicoOBf8qr6eCvKPYQQvf3i8HM2ISITk19ukXrK7bKAwyIuiIysJ
         +MLlQRIvjj5743IwJXkHpgG+1DpUpSqcP8aFWgCE3jsdhA95+C7IlHVllBpOWbltjy74
         o06iaWvUQ6jL7nrHlswSNE8Bf4sc43r90H8LNPn7C2Q8SeXHjfCj9Lo1Ew8OYAKg4XvK
         aH3p3Zi+y8RXnw1LRoqVKG6n0pA6NCogMxVQ3ockm1mgVINlVPT023AvgB/kTI7QJx9C
         zqRkUorl6ZFRUiivhplUVAFegjxvj4Vu3srWYZtj+mze1VAV4Hau0GK2uidwVx4OffJu
         WKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x5UU+FALll2OwK9GDy96o96F5GjMzMAxqrONINNl/dc=;
        b=S0gzS/UBZbZrxZfqfbOnq0ztM6qsVQAePRtsqLohtaD0dHVpPmAlJkOR17qG2fscba
         FYBF7tWAUWfyVL05a8Z3WqgNjrae8u0SPXrr0WG+aEkfkFe2HxiJVrI0VFWWo3afjKeH
         nzJ3PNO5WIik0aeBUlAL/djogDGoIT1z90RWxToWmaZtGaTs13q3dJp6flA9Ki8MCX56
         bRtgTHpjvMGadFk2uus2+oDjFRojegr6osYgLg1NyAxl6744ddoWemXvlN338E9Abnvh
         rYlP6TITEETV0Unn9tIGuRiaari1sqz+fjTCLUzLfMGX5anL5MwXrn2yMeW6pepfgQGH
         F9ig==
X-Gm-Message-State: AOAM533Qn3IAKbWiYeY4Ea/AHv9loKCM50en6uKkzh+h5nyKS/UWVjzf
        PaSD8tPxuw+CkcA8gk/g2BBSDZusTV1lBrpvkTA=
X-Google-Smtp-Source: ABdhPJxZyt5bjF0ta+xPRR6W2VBiiJ7xtDX+Z31naoYZkwsoIofqejFBvEuJisvkiOBlLYt53bnioOgAZYqOsxW3pE4=
X-Received: by 2002:a9d:32e2:: with SMTP id u89mr13088287otb.196.1612806229403;
 Mon, 08 Feb 2021 09:43:49 -0800 (PST)
MIME-Version: 1.0
References: <a8abefda-5c2b-918d-65d9-e21b89e9a2bf@gmail.com> <90473e07-fe79-18d8-4772-52deb4f8e1bd@gmail.com>
In-Reply-To: <90473e07-fe79-18d8-4772-52deb4f8e1bd@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 8 Feb 2021 12:43:38 -0500
Message-ID: <CAP+JOzQBiEHBS7TFAGpyJJ0+G3u2aGKpkDRTxH_PgU7pQrogVA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] secilc/docs: add syntax highlighting for secil
To:     bauen1 <j2468h@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Feb 6, 2021 at 4:05 PM bauen1 <j2468h@googlemail.com> wrote:
>
> This is done by creating a somewhat rudimentary KDE syntax xml for
> pandoc.
>
> The default styles provided by pandoc don't look very good and don't
> highlight e.g. the strings marked as builtin.
>
> Signed-off-by: Jonathan Hettwer <j2468h@gmail.com>
> ---
>  secilc/docs/Makefile  |  10 +-
>  secilc/docs/secil.xml | 236 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 242 insertions(+), 4 deletions(-)
>  create mode 100644 secilc/docs/secil.xml
>
> diff --git a/secilc/docs/Makefile b/secilc/docs/Makefile
> index 79a165ba..a91bcde0 100644
> --- a/secilc/docs/Makefile
> +++ b/secilc/docs/Makefile
> @@ -28,6 +28,8 @@ FILE_LIST ?= cil_introduction.md \
>
>  PANDOC_FILE_LIST = $(addprefix $(TMPDIR)/,$(FILE_LIST))
>
> +PANDOC_HIGHLIGHT_STYLE="pygments"
> +
>  PDF_OUT=CIL_Reference_Guide.pdf
>  HTML_OUT=CIL_Reference_Guide.html
>  PANDOC = pandoc
> @@ -54,13 +56,13 @@ $(TMPDIR)/policy.cil: $(TESTDIR)/policy.cil
>         $(SED) -i '1i Example Policy\n=========\n```secil' $@
>         echo '```' >> $@
>
> -html: $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil
> +html: $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil secil.xml
>         mkdir -p $(HTMLDIR)
> -       $(PANDOC) -t html $^ -o $(HTMLDIR)/$(HTML_OUT)
> +       $(PANDOC) --highlight-style=$(PANDOC_HIGHLIGHT_STYLE) --syntax-definition=secil.xml --standalone --metadata title="CIL Reference Guide" -t html $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil  -o $(HTMLDIR)/$(HTML_OUT)
>
> -pdf: $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil
> +pdf: $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil secil.xml
>         mkdir -p $(PDFDIR)
> -       $(PANDOC) --standalone --toc $^ -o $(PDFDIR)/$(PDF_OUT)
> +       $(PANDOC) --highlight-style=$(PANDOC_HIGHLIGHT_STYLE) --syntax-definition=secil.xml --standalone --toc $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil -o $(PDFDIR)/$(PDF_OUT)
>
>  clean:
>         rm -rf $(HTMLDIR)
> diff --git a/secilc/docs/secil.xml b/secilc/docs/secil.xml
> new file mode 100644
> index 00000000..daa80ded
> --- /dev/null
> +++ b/secilc/docs/secil.xml
> @@ -0,0 +1,236 @@
> +<?xml version="1.0" encoding="UTF-8"?>
> +<!-- https://docs.kde.org/trunk5/en/applications/katepart/highlight.html#katehighlight-xml-format -->
> +<!DOCTYPE language SYSTEM "language.dtd">
> +<language name="secil" section="Sources" extensions="*.cil" version="1" kateversion="2.4">
> +    <!--
> +        The keywords where extracted from libsepol/cil/src/cil.c sorted into the
> +        right lists and sorted alphabetically
> +    -->
> +    <list name="keywords_blockstart">
> +        <item>allow</item>
> +        <item>allowx</item>
> +        <item>auditallow</item>
> +        <item>auditallowx</item>
> +        <item>block</item>
> +        <item>blockabstract</item>
> +        <item>boolean</item>
> +        <item>booleanif</item>
> +        <item>category</item>
> +        <item>categoryalias</item>
> +        <item>categoryaliasactual</item>
> +        <item>categoryorder</item>
> +        <item>categoryset</item>
> +        <item>class</item>
> +        <item>classcommon</item>
> +        <item>classmap</item>
> +        <item>classmapping</item>
> +        <item>classorder</item>
> +        <item>classpermission</item>
> +        <item>classpermissionset</item>
> +        <item>common</item>
> +        <item>constrain</item>
> +        <item>context</item>
> +        <item>defaultrange</item>
> +        <item>defaultrole</item>
> +        <item>defaulttype</item>
> +        <item>defaultuser</item>
> +        <item>devicetreecon</item>
> +        <item>dontaudit</item>
> +        <item>dontauditx</item>
> +        <item>expandtypeattribute</item>
> +        <item>false</item>
> +        <item>filecon</item>
> +        <item>fsuse</item>
> +        <item>genfscon</item>
> +        <item>handleunknown</item>
> +        <item>ibendportcon</item>
> +        <item>ibpkeycon</item>
> +        <item>ioctl</item>
> +        <item>iomemcon</item>
> +        <item>ioportcon</item>
> +        <item>ipaddr</item>
> +        <item>level</item>
> +        <item>levelrange</item>
> +        <item>mls</item>
> +        <item>mlsconstrain</item>
> +        <item>mlsvalidatetrans</item>
> +        <item>netifcon</item>
> +        <item>neverallow</item>
> +        <item>neverallowx</item>
> +        <item>nodecon</item>
> +        <item>optional</item>
> +        <item>pcidevicecon</item>
> +        <item>perm</item>
> +        <item>permissionx</item>
> +        <item>pirqcon</item>
> +        <item>policycap</item>
> +        <item>portcon</item>
> +        <item>rangetransition</item>
> +        <item>role</item>
> +        <item>roleallow</item>
> +        <item>roleattribute</item>
> +        <item>roleattributeset</item>
> +        <item>rolebounds</item>
> +        <item>roletransition</item>
> +        <item>roletype</item>
> +        <item>selinuxuser</item>
> +        <item>selinuxuserdefault</item>
> +        <item>sensitivity</item>
> +        <item>sensitivityalias</item>
> +        <item>sensitivityaliasactual</item>
> +        <item>sensitivitycategory</item>
> +        <item>sensitivityorder</item>
> +        <item>sid</item>
> +        <item>sidcontext</item>
> +        <item>sidorder</item>
> +        <item>true</item>
> +        <item>tunable</item>
> +        <item>tunableif</item>
> +        <item>type</item>
> +        <item>typealias</item>
> +        <item>typealiasactual</item>
> +        <item>typeattribute</item>
> +        <item>typeattributeset</item>
> +        <item>typebounds</item>
> +        <item>typechange</item>
> +        <item>typemember</item>
> +        <item>typepermissive</item>
> +        <item>typetransition</item>
> +        <item>unordered</item>
> +        <item>user</item>
> +        <item>userattribute</item>
> +        <item>userattributeset</item>
> +        <item>userbounds</item>
> +        <item>userlevel</item>
> +        <item>userprefix</item>
> +        <item>userrange</item>
> +        <item>userrole</item>
> +        <item>validatetrans</item>
> +    </list>
> +
> +    <list name="function">
> +        <item>blockinherit</item>
> +        <item>call</item>
> +        <item>in</item>
> +        <item>macro</item>
> +    </list>
> +

I am not sure it adds a lot to have these as separate colors.

Also, when call is used as a permission, it is highlighted. It would
be nice if that could be fixed.

Thanks,
Jim

> +    <list name="operators">
> +        <item>and</item>
> +        <item>dom</item>
> +        <item>domby</item>
> +        <item>eq</item>
> +        <item>incomp</item>
> +        <item>neq</item>
> +        <item>not</item>
> +        <item>or</item>
> +        <item>range</item>
> +        <item>xor</item>
> +    </list>
> +
> +    <!-- list of "magic" functions or values -->
> +    <list name="builtins">
> +        <item>*</item>
> +        <item>all</item>
> +        <item>dccp</item>
> +        <item>false</item>
> +        <item>h1</item>
> +        <item>h2</item>
> +        <item>l1</item>
> +        <item>l2</item>
> +        <item>object_r</item>
> +        <item>r1</item>
> +        <item>r2</item>
> +        <item>r3</item>
> +        <item>sctp</item>
> +        <item>self</item>
> +        <item>t1</item>
> +        <item>t2</item>
> +        <item>t3</item>
> +        <item>tcp</item>
> +        <item>true</item>
> +        <item>u1</item>
> +        <item>u2</item>
> +        <item>u3</item>
> +        <item>udp</item>
> +
> +        <!--
> +            Excluded because they lead to a lot of false-positives
> +        <item>allow</item>
> +        <item>any</item>
> +        <item>char</item>
> +        <item>deny</item>
> +        <item>dir</item>
> +        <item>file</item>
> +        <item>glblub</item>
> +        <item>high</item>
> +        <item>low-high</item>
> +        <item>low</item>
> +        <item>pipe</item>
> +        <item>reject</item>
> +        <item>socket</item>
> +        <item>source</item>
> +        <item>symlink</item>
> +        <item>target</item>
> +        <item>task</item>
> +        <item>trans</item>
> +        <item>xattr</item>
> +        -->
> +    </list>
> +    <highlighting>
> +        <contexts>
> +            <context name="Normal" attribute="Normal" lineEndContext="#stay">
> +                <DetectChar attribute="Brackets" context="BlockStart" char="("/>
> +
> +                <DetectChar attribute="Comment" context="Comment" char=";"/>
> +            </context>
> +            <context name="BlockStart" attribute="Normal" lineEndContext="#stay">
> +                <keyword attribute="Keyword" context="Block" String="keywords_blockstart"/>
> +                <keyword attribute="Function" context="Block" String="function"/>
> +                <keyword attribute="Operator" context="Block" String="operators"/>
> +
> +                <DetectChar attribute="Comment" context="Comment" char=";"/>
> +            </context>
> +            <context name="Block" attribute="Normal" lineEndContext="#stay">
> +                <keyword attribute="Builtin" context="#stay" String="builtins"/>
> +
> +                <DetectChar attribute="Comment" context="Comment" char=";"/>
> +                <DetectChar attribute="String" context="String" char="&quot;"/>
> +
> +                <DetectChar attribute="Brackets" context="BlockStart" char="("/>
> +                <DetectChar attribute="Brackets" context="#pop" char=")"/>
> +            </context>
> +
> +            <!-- single line comment -->
> +            <context name="Comment" attribute="Comment" lineEndContext="#pop"></context>
> +
> +            <!-- string / name -->
> +            <context name="String" attribute="String" lineEndContext="#stay">
> +                <RegExpr attribute="Char" context="#stay" String="#\\."/>
> +
> +                <!-- allow escaping " or similiar -->
> +                <HlCStringChar attribute="String Char" context="#stay"/>
> +
> +                <DetectChar attribute="String" context="#pop" char="&quot;"/>
> +            </context>
> +        </contexts>
> +        <itemDatas>
> +            <itemData name="Normal" defStyleNum="dsNormal" />
> +            <itemData name="Keyword" defStyleNum="dsKeyword"/>
> +            <itemData name="Function" defStyleNum="dsFunction"/>
> +            <itemData name="Operator" defStyleNum="dsOperator"/>
> +            <itemData name="Builtin" defStyleNum="dsBuiltIn"/>
> +
> +            <itemData name="Comment" defStyleNum="dsComment"/>
> +
> +            <itemData name="String" defStyleNum="dsString"/>
> +            <itemData name="String Char" defStyleNum="dsSpecialChar"/>
> +        </itemDatas>
> +    </highlighting>
> +    <general>
> +        <comments>
> +            <comment name="singleLine" start=";"/>
> +        </comments>
> +        <keywords casesensitive="1" weakDeliminator="."/>
> +    </general>
> +</language>
> --
> 2.30.0
>
