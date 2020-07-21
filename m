Return-Path: <SRS0=VL4G=BA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AC3C433E6
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 21:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02A98206E3
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 21:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QxWmqUb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgGUVuP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731280AbgGUVuO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Jul 2020 17:50:14 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53752C0619DD
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2020 14:50:14 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id 72so10835897ple.0
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2020 14:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OtXnm3noZBXxKDQT2DLxkK+7Zl0OlFdckYgrPhu/bNI=;
        b=QxWmqUb4mKG2PuotWYPk5fcI5SbheLjPXQNjK35Lvm1Rv0TkWL9JoKot+e9NVXKCjD
         bF2yDtMqkz/MjgDZRxRrGXn8IHqBpE5MhsfMYdLw9ROIFyzGb5thGHNx2S2TsaxXTswb
         JB/Ot61RL6lf9nWssczNzhB3lEhtblNukhlmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OtXnm3noZBXxKDQT2DLxkK+7Zl0OlFdckYgrPhu/bNI=;
        b=kNrszXXnyC86m4Pr9/0tHwDmIR5nGliQkMOruVKbmufXTBEBJ8blek/5q4f7l0g79V
         VQqflMa9G8x8QGm0flK67SyujBURTqsKhNjwl+u7pYVzAppmHh19kwgSwu+ENg5Gigc0
         XLD2T97TD/KcZoK2n98kmnUo8u0nLQbxB7WU1rEax2hqqYsofoxQfkWOgD7UFNujvkIq
         p/BLr3XFMFNwdS+NV6KP+InsXLe4fLoON1ZEMK8yUeb3jNTF2x3SLI1SIiljexcK9WbR
         SyIZZH/v63er77cY94i5b8vNVSYNQTDeNJ+rewQyewkEQW/HzCGTx1X9Wjfu4hk1f7St
         tlKg==
X-Gm-Message-State: AOAM53042dIycEADKqPvV2YIM8UcsIiWZ6x1cXRbmdiTNKXGMpUpFJ/Z
        Xlta2hfXoTMLx3sPX+019m0QUw==
X-Google-Smtp-Source: ABdhPJwThYgowVNirnJUeV2auYuVRnMMUOdvkl7oi/bwggJZNAnaWjQtvFFq/bSqv6h8Tu8fyOWxUQ==
X-Received: by 2002:a17:90a:2749:: with SMTP id o67mr6971010pje.183.1595368213884;
        Tue, 21 Jul 2020 14:50:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j5sm21062058pfa.5.2020.07.21.14.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 14:50:13 -0700 (PDT)
Date:   Tue, 21 Jul 2020 14:50:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/13] fs/kernel_read_file: Remove redundant size argument
Message-ID: <202007211449.E211351@keescook>
References: <20200717174309.1164575-1-keescook@chromium.org>
 <20200717174309.1164575-7-keescook@chromium.org>
 <ec326654-c43b-259c-409c-63929ad5b217@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec326654-c43b-259c-409c-63929ad5b217@broadcom.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 21, 2020 at 02:43:07PM -0700, Scott Branden wrote:
> On 2020-07-17 10:43 a.m., Kees Cook wrote:
> > In preparation for refactoring kernel_read_file*(), remove the redundant
> > "size" argument which is not needed: it can be included in the return
> > code, with callers adjusted. (VFS reads already cannot be larger than
> > INT_MAX.)
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >   drivers/base/firmware_loader/main.c |  8 ++++----
> >   fs/kernel_read_file.c               | 20 +++++++++-----------
> >   include/linux/kernel_read_file.h    |  8 ++++----
> >   kernel/kexec_file.c                 | 13 ++++++-------
> >   kernel/module.c                     |  7 +++----
> >   security/integrity/digsig.c         |  5 +++--
> >   security/integrity/ima/ima_fs.c     |  5 +++--
> >   7 files changed, 32 insertions(+), 34 deletions(-)
> > 
> > diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> > index d4a413ea48ce..ea419c7d3d34 100644
> > --- a/drivers/base/firmware_loader/main.c
> > +++ b/drivers/base/firmware_loader/main.c
> > @@ -462,7 +462,7 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
> >   					     size_t in_size,
> >   					     const void *in_buffer))
> >   {
> > -	loff_t size;
> > +	size_t size;
> >   	int i, len;
> >   	int rc = -ENOENT;
> >   	char *path;
> > @@ -494,10 +494,9 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
> >   		fw_priv->size = 0;
> >   		/* load firmware files from the mount namespace of init */
> > -		rc = kernel_read_file_from_path_initns(path, &buffer,
> > -						       &size, msize,
> > +		rc = kernel_read_file_from_path_initns(path, &buffer, msize,
> >   						       READING_FIRMWARE);
> > -		if (rc) {
> > +		if (rc < 0) {
> >   			if (rc != -ENOENT)
> >   				dev_warn(device, "loading %s failed with error %d\n",
> >   					 path, rc);
> > @@ -506,6 +505,7 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
> >   					 path);
> >   			continue;
> >   		}
> > +		size = rc;
> Change fails to return 0.  Need rc = 0; here.

Oh nice; good catch! I'll fix this.

-- 
Kees Cook
