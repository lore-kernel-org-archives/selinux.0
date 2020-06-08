Return-Path: <SRS0=NH41=7V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319F7C433DF
	for <selinux@archiver.kernel.org>; Mon,  8 Jun 2020 16:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B3272078C
	for <selinux@archiver.kernel.org>; Mon,  8 Jun 2020 16:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z22bRGFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730476AbgFHQYC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Jun 2020 12:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730434AbgFHQYB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Jun 2020 12:24:01 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655F6C08C5C2
        for <selinux@vger.kernel.org>; Mon,  8 Jun 2020 09:24:00 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id n70so1660407ota.5
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2020 09:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ufZTOBhVdCN9ppc/A6Ye8aPXY3zKuXnjTwGgxX121Mo=;
        b=Z22bRGFRCTDNUIzaNvZruWbHMZaT6kMxfgZpPkA3XpcoTVDScOpNDslDuY/vf9WfND
         1sUhHgYBdjd5dTN+7xpb0OkUQogZV7otyuK75QOybUP7ihUji8vrsRqxeBHKQM7REe96
         y6WceC8aLVV9LhrCTUpBa/3se2OAInwVxxXoaBOXnOMiAeokwYrVBrcBBEqkTfW0hWAg
         A5B8DcVMvx7QJGuFBxXoxJuxxEarCK/dnKZOR+g+ZDyMqA/xpd3hp9aPmJbH/uZgyOT8
         raQlrxoZw3YDfiLdxCUOzH9Y46hFLqQbGFTvbfL4l0HGIa/F5Th0FIRcaljlgNjHbQtf
         q6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ufZTOBhVdCN9ppc/A6Ye8aPXY3zKuXnjTwGgxX121Mo=;
        b=mT5UOBKKx5ad3HpWKsX7K970RdQRhgtNXT9gXherdKrwyU4b5nmAgJuDS3qRdofhKi
         /XDbkzpc0DNV8pIIDfwNoZ6SvO6Vv5hXtqVuRww7fdxkuFVaDlWbvEsGEcdaJTcYDfuz
         l+GWsra51/iLezxNzwCvjUEjgdIkALBMvhNNuHoZswPFlwQ6PhMEQfB19Biv+t4PWLxv
         W5lWqaf/qB6drVgLEAGV5FrvE5fHeqT8Hp64ocnn/N3IBwnXVwqUTUzksqxNYhXTvKwX
         k9mMlTb4SHajwD4uIqqmaeH4GtktIsHXhtQ4CMIKPKtcJUWEmr+AVlzxQF8xnfExwvHT
         yVfQ==
X-Gm-Message-State: AOAM532pe4+/MS7SK+0JqUFV2g0fdbTlyUrRVNA1TBMhXnyD/oYwolxU
        L7wfzzV8w04njlbNTWmYcoIenXuss8xAM4Ke4zs=
X-Google-Smtp-Source: ABdhPJxB6S5zMgcMUej/69NwtKC3tdI3/Na06LHfPGTIHxgGFzAbofOFIrHvvzOIOQ2qEjpzkea1510gFRWS0SykeXg=
X-Received: by 2002:a05:6830:18da:: with SMTP id v26mr18745522ote.135.1591633439830;
 Mon, 08 Jun 2020 09:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200608121823.109113-1-plautrba@redhat.com>
In-Reply-To: <20200608121823.109113-1-plautrba@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 8 Jun 2020 12:23:49 -0400
Message-ID: <CAEjxPJ7TVrfWbgaYY+Li+83dsoZ8Xd+umYp4OvkKCEdqpv_DPA@mail.gmail.com>
Subject: Re: [PATCH] python/sepolicy: Use xml.etree.ElementTree.Element.iter()
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 8, 2020 at 8:19 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> xml.etree.ElementTree.Element.getiterator() was deprecated since Python 3.2 and
> dropped in Python 3.9
>
> Fixes:
> Verify sepolicy interface -c -i works ... Traceback (most recent call last):
>   File "/usr/bin/sepolicy", line 691, in <module>
>     args = parser.parse_args(args=parser_args)
>   File "/usr/lib64/python3.9/argparse.py", line 1819, in parse_args
>     args, argv = self.parse_known_args(args, namespace)
>   File "/usr/lib64/python3.9/argparse.py", line 1852, in parse_known_args
>     namespace, args = self._parse_known_args(args, namespace)
>   File "/usr/lib64/python3.9/argparse.py", line 2043, in _parse_known_args
>     positionals_end_index = consume_positionals(start_index)
>   File "/usr/lib64/python3.9/argparse.py", line 2020, in consume_positionals
>     take_action(action, args)
>   File "/usr/lib64/python3.9/argparse.py", line 1929, in take_action
>     action(self, namespace, argument_values, option_string)
>   File "/usr/lib64/python3.9/argparse.py", line 1208, in __call__
>     subnamespace, arg_strings = parser.parse_known_args(arg_strings, None)
>   File "/usr/lib64/python3.9/argparse.py", line 1852, in parse_known_args
>     namespace, args = self._parse_known_args(args, namespace)
>   File "/usr/lib64/python3.9/argparse.py", line 2061, in _parse_known_args
>     start_index = consume_optional(start_index)
>   File "/usr/lib64/python3.9/argparse.py", line 2001, in consume_optional
>     take_action(action, args, option_string)
>   File "/usr/lib64/python3.9/argparse.py", line 1929, in take_action
>     action(self, namespace, argument_values, option_string)
>   File "/usr/bin/sepolicy", line 216, in __call__
>     interface_dict = get_interface_dict()
>   File "/usr/lib/python3.9/site-packages/sepolicy/interface.py", line 149, in get_interface_dict
>     for i in m.getiterator('interface'):
> AttributeError: 'xml.etree.ElementTree.Element' object has no attribute 'getiterator'
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  python/sepolicy/sepolicy/interface.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/python/sepolicy/sepolicy/interface.py b/python/sepolicy/sepolicy/interface.py
> index 7d4ebd7ecdba..bdffb770f364 100644
> --- a/python/sepolicy/sepolicy/interface.py
> +++ b/python/sepolicy/sepolicy/interface.py
> @@ -146,12 +146,12 @@ def get_interface_dict(path="/usr/share/selinux/devel/policy.xml"):
>              tree = xml.etree.ElementTree.fromstring(xml_path)
>          for l in tree.findall("layer"):
>              for m in l.findall("module"):
> -                for i in m.getiterator('interface'):
> +                for i in m.iter('interface'):
>                      for e in i.findall("param"):
>                          param_list.append(e.get('name'))
>                      interface_dict[(i.get("name"))] = [param_list, (i.find('summary').text), "interface"]
>                      param_list = []
> -                for i in m.getiterator('template'):
> +                for i in m.iter('template'):
>                      for e in i.findall("param"):
>                          param_list.append(e.get('name'))
>                      interface_dict[(i.get("name"))] = [param_list, (i.find('summary').text), "template"]
> --
> 2.26.2
>
