Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BDB320A1B
	for <selinux@vger.kernel.org>; Thu,  4 Sep 2025 17:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008362; cv=none; b=hCfgraIP+KtNkzuTZLEo8aCE1N6SOY98ij+qPEZPdHx3+rEhgI8l3lQgvBO2EN7emFiWYIC1Lvcg0g2XVetuuR72b2aroKLw/rjNxV9jByXsTDez19YCbVKQAkLs2IBiN3RGnJ7Hb6FPM6eU1GcyBzq8s8SV+fzyLXurFtSIcMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008362; c=relaxed/simple;
	bh=zIUzBoqMCs+upPbaW+SMs3OzZCg0Ui90/iMoYugGpcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VBM5nBNopWbuTuo99L8Ubuu8NcD28I+1HXoAAwOBaSZprp1vSx426cPWQwVQ2PcrT/PEtG+VnlbDm8IhTn3b79xoFbxWiK2pOsJrZBf8A1OS7yozfPuuHbr+8y5LI3bY3FCOpCteZfbWy3ea8gKWBogFMXq7gDNejSK2Rii1pys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=So/iaw8n; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="So/iaw8n"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-323266d6f57so1492071a91.0
        for <selinux@vger.kernel.org>; Thu, 04 Sep 2025 10:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757008360; x=1757613160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4wEovec4irSS2AhdcFcIsDZ/T4ifbTabakPGYBIh1g=;
        b=So/iaw8nesXY9P9+e0uQGrdh161TLgza4xvrjT5shKr9021QC6xTBGJpsOLweGWomi
         l1Z0+AYvsHc3dIWaNZRpFkzqBBodi46XwW1Mp7nTpJmqe/di5/aJl5/seC37hLIjsH6z
         4oC+KpkdnPULeR6LH8xeWEl5XVQON5BQ8GhyCGfF5SSXYj4zRF55UWFuDQ1rYgtI3uWs
         IKMBkXbwvlwBnnkr6xnJTICw0m51DI0bjV2t1n3Xhf0zG/VIxPreoBuJDD2QNIMp/AHo
         PLPae7rG3sqtJ+ZtCuv/xhjs+f29HyXCY4JW9hD8njWAlm73MUh5O3RvvZn0/PjdV7OE
         tHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757008360; x=1757613160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4wEovec4irSS2AhdcFcIsDZ/T4ifbTabakPGYBIh1g=;
        b=E66fjRheY/vKE/qVGuBNpeqgCG6m1H5wztOD6dzjFxfWFMz8bSU+YhcVn9aX61kKKr
         YzWkifczGFY5dzZ8wP/Iq1mBUdRYBe9etcM/wqItvUwom3giax+Vv0ItuZVMdFZHTNzA
         /JqATVpIwXUcdSpfaPfXxDZ2ZAIzVuI00WTGLUSd1R1qug8n/RAVBEXrxeLA0ivnHbLG
         Clzqf7SFsF4fHrcQRGVkR4vbIfPzp1ccP67/dt4zfuplefGBhPLpttdiaqhFtXzRGPOJ
         aa3MYVAoI7cE08wfmAlU97suk3qxq0OYRj5nOVS4QZpkwO7TaNRbxQ0E3kqqzAFBWo5e
         /UAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXA/ioHVM/X5OaVOrkgavdo5GXVyx3NAn/kX84tVFlMbqHPccu++IscXgZ2Jwtwm2cYNR8v+2Gg@vger.kernel.org
X-Gm-Message-State: AOJu0YxERpxW05675DlLZ1i6oQqKNBcRquK0DwvOuqosu7phyDBXkpMW
	F3oic00kvW3mbQPXwmoHntVQ7mvpKAJ47uk6XmHtfkjkR8/U/JKNS4uosY1wWahPW3TxiyQNwtH
	89zy0VgVM9S51x0MjDJtqBulduoZjNr0w1m+wlvt3
X-Gm-Gg: ASbGncuDrzUTCZOJWsgKGrDev/00CsNsWyuggWVC2YfjwmbJe3boHr7k2k1k7RtCPG3
	yK6fzprN4fhHdB80ECHD5ZauaBHL/xLJ8/270QcMNbCK5O059rwR22DrXkWlPVXSNq82XZPDofP
	sQjungJPjaHT8TGikunP6MqUHZrQ4vd4f2oLHJ/319hp0AMblMgxeg4ClYP1cv918U3AEL3HBXc
	VyPvicp5TAVMjtTdQ==
X-Google-Smtp-Source: AGHT+IHARERwIOrQzAiha36b5KLgb4mgjkt5iW0JpSJFow8LH+VqRSx10lHb02TqQRnwF0ghmxuhvBrs9ntvdzohquQ=
X-Received: by 2002:a17:90b:3d48:b0:32b:70a7:16da with SMTP id
 98e67ed59e1d1-32b70a71b2fmr8276282a91.20.1757008359843; Thu, 04 Sep 2025
 10:52:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814225159.275901-36-paul@paul-moore.com> <20250814225159.275901-47-paul@paul-moore.com>
 <06a68323-b297-4be7-92eb-c2091207b9f0@canonical.com> <dd03266930a7b219c590c54bb2c210366f8d89a1.camel@huaweicloud.com>
 <e92064a4-06c5-4913-917c-f9aca02378f3@canonical.com> <CAHC9VhQPmF-RCSUjZo-pe1+sWyw5ZGdnD7P0CWb7yXQQoo+92g@mail.gmail.com>
In-Reply-To: <CAHC9VhQPmF-RCSUjZo-pe1+sWyw5ZGdnD7P0CWb7yXQQoo+92g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 4 Sep 2025 13:52:27 -0400
X-Gm-Features: Ac12FXzUqs3EGM9cpy-oy7cir66WjVMKoCa34Q4_quIWr1Hu03-7eQL_aCQUQYE
Message-ID: <CAHC9VhRjQrjvsn65A-TGKKGrVFjZdnPBu+1vp=7w86SOjoyiUw@mail.gmail.com>
Subject: Re: [PATCH v3 11/34] lsm: get rid of the lsm_names list and do some cleanup
To: John Johansen <john.johansen@canonical.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 11:18=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> I'll rework this function, but I'll hold off on posting another
> revision until I hear back on some of the reviews that are still
> pending in case additional edits are needed.

For the curious, here is what it looks like now:

diff --git a/security/inode.c b/security/inode.c
index 43382ef8896e..4813d116fd7c 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -22,6 +22,8 @@
#include <linux/lsm_hooks.h>
#include <linux/magic.h>

+#include "lsm.h"
+
static struct vfsmount *mount;
static int mount_count;

@@ -315,12 +317,49 @@ void securityfs_remove(struct dentry *dentry)
EXPORT_SYMBOL_GPL(securityfs_remove);

#ifdef CONFIG_SECURITY
+#include <linux/spinlock.h>
+
static struct dentry *lsm_dentry;
+
static ssize_t lsm_read(struct file *filp, char __user *buf, size_t count,
                       loff_t *ppos)
{
-       return simple_read_from_buffer(buf, count, ppos, lsm_names,
-               strlen(lsm_names));
+       int i;
+       static char *str;
+       static size_t len;
+       static DEFINE_SPINLOCK(lock);
+
+       /* NOTE: we never free or modify the string once it is set */
+
+       if (unlikely(!str)) {
+               char *str_tmp;
+               size_t len_tmp =3D 0;
+
+               for (i =3D 0; i < lsm_active_cnt; i++)
+                       /* the '+ 1' accounts for either a comma or a NUL *=
/
+                       len_tmp +=3D strlen(lsm_idlist[i]->name) + 1;
+
+               str_tmp =3D kmalloc(len_tmp, GFP_KERNEL);
+               if (!str_tmp)
+                       return -ENOMEM;
+               str_tmp[0] =3D '\0';
+
+               for (i =3D 0; i < lsm_active_cnt; i++) {
+                       if (i > 0)
+                               strcat(str_tmp, ",");
+                       strcat(str_tmp, lsm_idlist[i]->name);
+               }
+
+               spin_lock(&lock);
+               if (!str) {
+                       str =3D str_tmp;
+                       len =3D len_tmp - 1;
+               } else
+                       kfree(str_tmp);
+               spin_unlock(&lock);
+       }
+
+       return simple_read_from_buffer(buf, count, ppos, str, len);
}

--=20
paul-moore.com
