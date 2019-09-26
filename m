Return-Path: <SRS0=fLGi=XV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE3FC4360C
	for <selinux@archiver.kernel.org>; Thu, 26 Sep 2019 21:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7508E2075D
	for <selinux@archiver.kernel.org>; Thu, 26 Sep 2019 21:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfIZV7Q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Sep 2019 17:59:16 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:57531 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfIZV7P (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Sep 2019 17:59:15 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 91ACF5612C9
        for <selinux@vger.kernel.org>; Thu, 26 Sep 2019 23:59:11 +0200 (CEST)
Received: by mail-ot1-f46.google.com with SMTP id y39so518723ota.7
        for <selinux@vger.kernel.org>; Thu, 26 Sep 2019 14:59:11 -0700 (PDT)
X-Gm-Message-State: APjAAAVAtEaOIkQVpLwYVQfY4t/EutKiTNHZ727J4f9jEulV0a/Xwkug
        6Y/r830U+OVwhMAzfqcTJnAf2gzurxnlamGVdt8=
X-Google-Smtp-Source: APXvYqxhV5VK5P2aD8u0rxn87hz1JLfamjsxNCA9XBgJPgL4Iy1zNRoEJfqAjCMS0y4lLYVYAYiFzq1A7JF64qaEp2w=
X-Received: by 2002:a9d:3463:: with SMTP id v90mr708372otb.29.1569535150554;
 Thu, 26 Sep 2019 14:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190926125218.22958-1-sds@tycho.nsa.gov>
In-Reply-To: <20190926125218.22958-1-sds@tycho.nsa.gov>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 26 Sep 2019 23:58:59 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=ntt2dH6PN3tMQMdw99x4dpU3eRoAd62W4Fqgkvt5Lb5g@mail.gmail.com>
Message-ID: <CAJfZ7=ntt2dH6PN3tMQMdw99x4dpU3eRoAd62W4Fqgkvt5Lb5g@mail.gmail.com>
Subject: Re: [PATCH] python/sepolicy: call segenxml.py with python3
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Sep 26 23:59:12 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 26, 2019 at 2:52 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/61
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  python/sepolicy/sepolicy/interface.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/python/sepolicy/sepolicy/interface.py b/python/sepolicy/sepolicy/interface.py
> index 583091ae18aa..b1b39a492d73 100644
> --- a/python/sepolicy/sepolicy/interface.py
> +++ b/python/sepolicy/sepolicy/interface.py
> @@ -196,7 +196,7 @@ def get_xml_file(if_file):
>          from subprocess import getstatusoutput
>      basedir = os.path.dirname(if_file) + "/"
>      filename = os.path.basename(if_file).split(".")[0]
> -    rc, output = getstatusoutput("python /usr/share/selinux/devel/include/support/segenxml.py -w -m %s" % basedir + filename)
> +    rc, output = getstatusoutput("/usr/bin/python3 /usr/share/selinux/devel/include/support/segenxml.py -w -m %s" % basedir + filename)
>      if rc != 0:
>          sys.stderr.write("\n Could not proceed selected interface file.\n")
>          sys.stderr.write("\n%s" % output)

Considering that Python's "command" module was removed in Python 3
(according to https://docs.python.org/2/library/commands.html), and
that Python 3's subprocess.getstatusoutput() supports using a list of
arguments instead of a string, it seems better to change this code to
something like:

    from subprocess import getstatusoutput
    basedir = os.path.dirname(if_file)
    filename = os.path.basename(if_file).split(".")[0]
    rc, output = getstatusoutput(["python3",
"/usr/share/selinux/devel/include/support/segenxml.py", "-w", "-m",
os.path.join(basedir, filename)])

The code that I suggest is not compatible with Python 2 (which does
not support using list of arguments). Therefore, doing so makes
sepolicy really Python-3 only. I do not consider this to be an issue,
but others may prefer to wait for 3.0 to be released before dropping
support for Python 2 completely.

By the way, the current code is quite misleading because ("%s" % a +
b) is interpreted as (("%s" % a) + b), not ("%s" % (a + b)).
Thankfully the "%s" is at the end of the format string, but if you
want to keep Python 2 compatibility, I suggest adding parentheses
somewhere.

Nicolas

