Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EB4308F33
	for <selinux@vger.kernel.org>; Thu, 19 Feb 2026 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771508238; cv=pass; b=dkSpExGDxP67QPbUWrHdg+svRMG/92all7cQ9HLvBBQrmSzkF7i3cD4JSGAVa+8bv9Q9Qkq9CJpTcYrDIrNvvd8agRG07qZtaW77AMbED7n8RFwB/to8m01gOV9k2ECsTdDdrjQAQOuR+wrkgZewyetQdjwEKLieam5yvYpPbm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771508238; c=relaxed/simple;
	bh=GmHo0NCL4ge/ErKlzJei0vodTI2hTzHGWFJJ3MMTDoQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rqWtTSyr2JXMn9KmVyKo1CEc32eCHeKzDvi7eoVoEQ2GmWbGDctypS5FrBMVm0jdM6fkvSqzXijrm6fN3CiBG9U5vJzT9vz84X9MHukUwfRowvRddC0etxebO93n4yV7b02qfR1ghKjSFIrdevMa3MJ8vLR1hWAzNaYFOvNfdHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=RPRXF583; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RPRXF583"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64adabaafd6so823529d50.0
        for <selinux@vger.kernel.org>; Thu, 19 Feb 2026 05:37:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771508236; cv=none;
        d=google.com; s=arc-20240605;
        b=hdaZsNuo72SchrTtcjHoBGyB2XNDczM9s8t/IcbTWj27TFN3rsn8A20yI//BOHzK15
         e9DT7AyrnQRAfIGXucFKWSi689u256KdeFMBAy8UDoWqj+Tc2wbOdaW1V03oonfZd32D
         RcwhxibAgQbYyin9/+6f0wFGmFjtbI499wa/SSmNZJnSKD75i4/MKZgPyZhCPhFiaIni
         VuTJZN5l2hbNHCGQaAWWzB0HqRLWAqhWJ6x7Y7F9YGKs9eP9NuD+IuAp8GjGXpJhMRWY
         Lu+cqzxG0ZW63QrMVWMvq6H8r3Z40yEZYX9ClcLcQYQ8k9NwzP/pbPVOKis89F14Qot8
         b63A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=tcesM3lSjBahtXo0LHg5TOyW8wOpWKXFGTMFHZPHM9w=;
        fh=ftTQKdqRjWOmeAcT8OgcDf5lb31uFstuAg/7ODeUOfs=;
        b=l2vukAP06MxP6ZjZl6TYawEcHMyDtXCtUrpUFFfIrnAdwpAyPzowx5VqnOAgKXRupw
         WGVjwCPQOxE2SQzL7XwJ1TE4DVVmCBivtSKciIIVEiLBTh7XA/MGsHqhfm6GKYgnQPbh
         seUrwVqgDtcNWMWcdprjn34DsmO1xryzjnCjo3mjHdxvOaDEMOd6eMCU2gVzRdJLm/2A
         7fqSA990hS6CivUYvaNP/EgDhteKW2azemDMI+kcfMvgwa4SiHYjgZZsNKCtiiiTHx7z
         r79pg8bz+s7el0rk/0nTqI2l8g2YHmOHwIvlRmNDKpr11wLRwb8KK98eSKwEN1Nn+15d
         EqCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1771508236; x=1772113036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tcesM3lSjBahtXo0LHg5TOyW8wOpWKXFGTMFHZPHM9w=;
        b=RPRXF583zjUr9kLpSn9lofJHTsCiKArrm9nlvx8scRT7K19BqfhgT1h+pnZ8x8ZDgh
         OGtm6RYI3mNfBnrcW7HR5XlB6jPvMsIleRIeBuYV/11A717OJuOOdv0zFJH2YntOSQdM
         PmHdi46hywlf9WY8+8aSjZJC+dhUS+OPj70fAkWtj021T4e/9fnB7OXVCmCCSJYg4AIv
         2BMvjB1zoF98quvTTrhHito2SL41gT9+x2Upjn/rpd4j5cRbCNnkicokiHTk8fitJN8p
         xsRbXw3Wd4FBllEOgsFAln/mqSOC9YX4cVtnPQ8beh68VzxTW7LhY8D5k8H1ZpNjcU0O
         nGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771508236; x=1772113036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcesM3lSjBahtXo0LHg5TOyW8wOpWKXFGTMFHZPHM9w=;
        b=xKrDHKgBKFCtSoHuy/vDxWrSQRviTQxRDb0Y98z7lrvXOQJ1zV7/CD/tj4FIE4kGcx
         PKgDGDwyNdRAZWzcD2uQtPxRwUBoaOlNlZ776iRX6nsqyk8RGlEZ3yV22uypJJAhu36D
         6UdH3VI6ZWwakRYFvrfbYPb0gkrH6/c5Op3RW5BlS4R4YiWWFyOsPy038nFTwf7oXlzm
         dOW+FCw+OhLX5CYngphQo/kSIA+N1Ox8vipfnbIoLT7bbLWIqqSgcV2WjhGjEHTJglVo
         tH/zcIQxG8heiCmEHruQv8lX13H+bOF4lx8cGtF8VNhyEgpFvPhRVUSOdBsMYaZmdgl0
         UEqQ==
X-Gm-Message-State: AOJu0YyLzCID0hzIAuFzKFWhiRbZZ5ijGD2pN/wUs/z+p1oNsAo8bT75
	XMwuR/l+8A9WBPAT2NeL+svE07NbCz1iSjnqoc1dv0+RujgihVymLpZg+T+pDyRENfpoJpTSkN2
	6Slvvy2zgcJpRTQuBzG+yq+dch2kShIA=
X-Gm-Gg: AZuq6aLv/AEjrPxiuIYbklH60+uhbJFi8NWUs8g+zE8IcqmE1g9xvn+DDR3eczprSAt
	dLtplq7H6mCoWemARd6EoeQOciSDcfCPVLliUB8Nz6Y5+y6PJ/iBascXvipu0D8doeT4ONJSgZ9
	4yL4v4gF6yOA7Z/YahQXn9LLB6MPu2cf2NGZEw2GMCSJix+mr2GK9kGckqXiE8DeLvYbZpoDW1K
	6dMSId/0TUwgQXsf3fipWDZXTfuY+QtpjsirogzeDARTNjYIi6y+U29asBjY0WgqFF5vVXoGD7F
	1zB9
X-Received: by 2002:a05:690e:11c9:b0:644:60d9:8649 with SMTP id
 956f58d0204a3-64c556dc612mr4509989d50.88.1771508236398; Thu, 19 Feb 2026
 05:37:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Thu, 19 Feb 2026 14:37:05 +0100
X-Gm-Features: AZwV_QhEG-Dbyjabvuwr7JbE0kl4wjXOO6wTvaJKJoCU6g6GjPFeSI54b6DzZ8U
Message-ID: <CAJ2a_Df6GOirF8TnNWTqNMpdWLHgjT9_v7G-PiL4e7LU2nr1PA@mail.gmail.com>
Subject: Generic approach to avoid truncation of file on pseudo fs
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: SElinux list <selinux@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

SELinux offers a memory mapping for userspace for status changes via
the pseudo file /sys/fs/selinux/status.
Currently this file can be truncated by a privileged process, leading
to other userland processes getting signalled a bus error (SIGBUS).
This affects for example systemd [1].
I proposed a targeted fix [2], overriding the inode setattr handler
and filtering O_TRUNC on open.

Is there there a general solution how to prevent truncation of pseudo
files backed up by real memory?
Are there more ways a file can be truncated that should be handled?


If there is no generic way would the following patch be acceptable?

 diff --git a/fs/libfs.c b/fs/libfs.c

index 9264523be85c..76f7fec136cb 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1089,6 +1089,7 @@ int simple_fill_super(struct super_block *s,
unsigned long magic,
               }
               inode->i_mode =3D S_IFREG | files->mode;
               simple_inode_init_ts(inode);
+               inode->i_op =3D files->iops;
               inode->i_fop =3D files->ops;
               inode->i_ino =3D i;
               d_make_persistent(dentry, inode);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 04ceeca12a0d..9f1a9f0a9b48 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3225,7 +3225,7 @@ extern const struct file_operations simple_dir_operat=
ions;
extern const struct inode_operations simple_dir_inode_operations;
extern void make_empty_dir_inode(struct inode *inode);
extern bool is_empty_dir_inode(struct inode *inode);
-struct tree_descr { const char *name; const struct file_operations
*ops; int mode; };
+struct tree_descr { const char *name; const struct file_operations
*ops; int mode; const struct inode_operations *iops; };
struct dentry *d_alloc_name(struct dentry *, const char *);
extern int simple_fill_super(struct super_block *, unsigned long,
                            const struct tree_descr *);


and then adding the hook would just be

-               [SEL_STATUS] =3D {"status", &sel_handle_status_ops, S_IRUGO=
},
+               [SEL_STATUS] =3D {"status", &sel_handle_status_ops,
S_IRUGO, &sel_handle_status_iops},


Best regards,
       Christian G=C3=B6ttsche


Link [1]: https://github.com/systemd/systemd/issues/37349
Link [2]: https://lore.kernel.org/selinux/20260130171140.90966-1-cgoettsche=
@seltendoof.de/
