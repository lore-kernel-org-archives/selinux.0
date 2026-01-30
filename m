Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81C621CC62
	for <selinux@vger.kernel.org>; Fri, 30 Jan 2026 20:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769805988; cv=none; b=s4j9MuEVRDxfnv5uRTJ0e51V0Oq/q/K7ta0pIJCxktQp+zSZkn5pRKgWYuUHkWlWesxXzwNvJbl25kTA+zIxrEO4OVGDkedo8X2ZmO0P7fbKh7zFE+e1W84GzXxO6Y2ftIyKuXOiVsLYeZgPps7SL6UWr1/YIPPRbb7KA6nB10k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769805988; c=relaxed/simple;
	bh=gKYgQtiEHcb1l051rxA9XgpTtx8jk8Fdj2tp05yP1LY=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=n5n9E6kihPDrbq8/0GBjG/4y7qf8twgvQzg8NwCgsvJrA22bMjNgtH3506QY5yhMFqcsd17/vGIaxkAWND0K0Vl52RTptNHx6JUtuf/Fhy48ZTyjOzJ6xIuxH/82h/39ARvqi3oAwxxlzfHtDJJZjwELPpNcpav89umsfgkJm6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Z6cV8u14; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Z6cV8u14"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50146483bf9so28097981cf.3
        for <selinux@vger.kernel.org>; Fri, 30 Jan 2026 12:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769805986; x=1770410786; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vNyj4sHhLOs9rUPZT8b2NWGHrJLblXB8m2ZUSLzKXbk=;
        b=Z6cV8u14E0Z1H7oueGCAQEIAc9grjry2AUihFxXNUMK4F/jhEEB1YZjcQMPbMy6tRw
         +HLR7f/QBmKQGmqnTOcg8IStkJdHFnCtperU9iH7RzXA5DST8J3mBn68Vbzec2f0/NjS
         zLvPG1kGVk1RuX14LVJVS+xexq0jz6IndHKeNrcgPUhWyB1AL83oKlKN2JbsdB6Tdqo9
         YRcyR9+0mRCu/wilaMNOCCI2B5G5ZSVMiRK7WNHaYyYioIJR+CTw5VyWWgxk7ZkvrrY4
         sh3OzhnQC3VbLXrmFWPtTZvbhm5Wol9J7jly0oDL9fjrAkHu/INck94mhoeL6Z46IoZc
         DHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769805986; x=1770410786;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNyj4sHhLOs9rUPZT8b2NWGHrJLblXB8m2ZUSLzKXbk=;
        b=lZ2eptCaep4IPOxq7Qj2uqOJwkOGAL8S40JSj1LBeuSi/X/O3tFJTdJ5eb2+5CKnCf
         RAswoopvhwGkdpEXklzvYleC+tpiBeLIiCJOoztkVilW2LJVlbXo/tGiqkNX+DmPfRkV
         3zincT+o9chZNjqUdizFYSpLOAfwzS4/Lo8nGg7seurzAWvGnKpKdm/la18QKYm9cQqq
         5izoox1JuLbNjNWXSm2m060f6hTvh8X1CAG8Pz+gRTZ5tXyHtzu2ij5Rn+8sKvm7WolW
         UjewKvvkTqgZ/TH7o922DrwYMtx7hN6HscpjYl8K7sqYMvIBrvNh2pgaqT2lvL5DXsWJ
         7FMg==
X-Forwarded-Encrypted: i=1; AJvYcCUbHCjSQm8+oV+7Ul4M2PklWyy9aaFBeP3QDQQatNocfVchlHfIiBSKaDJQMwEa52R1F2t5rhY3@vger.kernel.org
X-Gm-Message-State: AOJu0YzB1Q8VlnqI4h+6pWged0dWRARd1QxAgAMN3+bCOmUuBYXOjlJ/
	V6uIIT0nhzHDoVhJu75qL/P+bn4PQ66SdKFPpFoxgvEMaNoBg84t0gDC1valV1iV0A==
X-Gm-Gg: AZuq6aKaEaUlBquvPSW6gAddSh0vXkYbbtksXI4RDYa/h0LeZLB/tOMdEO7tU6gFGQl
	M3EaqRp9/09d4MapkLiTBugymapOaQJHqsmRZwP/tGupbyJtNnyYERqk4lHI6JlreIkkOyP2rSV
	WTe/Buob9nVUxTpaPhWvMtDYHVOt2AJD2JPa+pfkcXl5oJmNPD1b4T+21hDufI/PBvr/VZSTXwf
	UpSir7D9km667CMrsTXCV8eDzT3NLOLh8eQPwpQ8LbSJsqdgWuPQP/xu8O1wc+Qqd0fqfZwlIvm
	QgvofDu1P9/Ir2SQHoBVKNvwkSkfEISyKbMbPyn1EWm0T3fZQ5WKIcDZtLm+WPv8J4OAQHmFGF8
	3kG2RQDTWjwY9wSK6ZwpdBpztDSze0HeT/sONLkVA1VkIO2PLNZ2HuJE7BXWT2FpiRSpm1b6ZxS
	NwrXMTtznb9OJcSBf+6EYLZiIlG18nhB0UCpr3sLBsXR8Z01udBXys7nbC
X-Received: by 2002:a05:622a:113:b0:501:3cd1:7c60 with SMTP id d75a77b69052e-505d2154e71mr54562851cf.19.1769805985750;
        Fri, 30 Jan 2026 12:46:25 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50337bbbf8csm61652071cf.28.2026.01.30.12.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 12:46:24 -0800 (PST)
Date: Fri, 30 Jan 2026 15:46:23 -0500
Message-ID: <5893d15993a809a3b1b80deb0c27bf1e@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260130_1451/pstg-lib:20260130_1451/pstg-pwork:20260130_1451
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] selinux: prevent truncation of status map
References: <20260130171140.90966-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260130171140.90966-1-cgoettsche@seltendoof.de>

On Jan 30, 2026 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> Currently the SELinux status map can be truncated, given the necessary
> permissions, leading to foreign user space processes getting a bus error
> (SIGBUS) while concurrently making use of the status map.
> For example systemd can be killed that way, see [1].
> 
> Override the setattr inode handler and check for O_TRUNC in the open
> handler to prevent truncations.
> 
> Link [1]: https://github.com/systemd/systemd/issues/37349
> 
> Closes: https://github.com/SELinuxProject/selinux/issues/475
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/selinuxfs.c | 43 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 896acad1f5f7..df079a35a02d 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -214,10 +214,30 @@ static const struct file_operations sel_handle_unknown_ops = {
>  	.llseek		= generic_file_llseek,
>  };
>  
> +static int sel_setattr_handle_status(struct mnt_idmap *idmap,
> +				     struct dentry *dentry,
> +				     struct iattr *iattr)
> +{
> +	/* Prevent truncation to avoid raising SIGBUS */
> +	if (iattr->ia_valid & ATTR_SIZE)
> +		return -EINVAL;

Do we want this as -EINVAL or -EPERM?  However, see my comments below
about how to handle the ATTR_SIZE case.

> +	return simple_setattr(idmap, dentry, iattr);
> +}
> +
> +static const struct inode_operations sel_handle_status_iops = {
> +	.setattr	= sel_setattr_handle_status,
> +};
> +
>  static int sel_open_handle_status(struct inode *inode, struct file *filp)
>  {
> -	struct page    *status = selinux_kernel_status_page();
> +	struct page *status;
>  
> +	/* Prevent truncation to avoid raising SIGBUS */
> +	if (filp->f_flags & O_TRUNC)
> +		return -EINVAL;

Same as above, should this be -EPERM?

> +	status = selinux_kernel_status_page();
>  	if (!status)
>  		return -ENOMEM;
>  
> @@ -1980,7 +2000,6 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
>  		[SEL_CHECKREQPROT] = {"checkreqprot", &sel_checkreqprot_ops, S_IRUGO|S_IWUSR},
>  		[SEL_REJECT_UNKNOWN] = {"reject_unknown", &sel_handle_unknown_ops, S_IRUGO},
>  		[SEL_DENY_UNKNOWN] = {"deny_unknown", &sel_handle_unknown_ops, S_IRUGO},
> -		[SEL_STATUS] = {"status", &sel_handle_status_ops, S_IRUGO},
>  		[SEL_POLICY] = {"policy", &sel_policy_ops, S_IRUGO},
>  		[SEL_VALIDATE_TRANS] = {"validatetrans", &sel_transition_ops,
>  					S_IWUGO},
> @@ -1995,6 +2014,26 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
>  	if (ret)
>  		goto err;
>  
> +	/* Create "status" separately to assign a custom inode_operations */
> +	{
> +		ret = -ENOMEM;
> +
> +		dentry = d_alloc_name(sb->s_root, "status");
> +		if (!dentry)
> +			goto err;
> +		inode = new_inode(sb);
> +		if (!inode) {
> +			dput(dentry);
> +			goto err;
> +		}
> +		inode->i_mode = S_IFREG | 0444;
> +		simple_inode_init_ts(inode);
> +		inode->i_fop = &sel_handle_status_ops;
> +		inode->i_op = &sel_handle_status_iops;
> +		inode->i_ino = SEL_STATUS;
> +		d_add(dentry, inode);
> +	}

I worry a little about duplicating and open coding the per-file loop from
simple_fill_super(), I can see things slowly getting out of sync and bad
things happening.  Unfortunately, I don't see anything in libfs that would
allow us to supply our own inode_operations either.

What do you think about using selinux_inode_setattr() as shown below,
would this work?

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index feda34b18d83..8e4374f22a18 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -106,6 +106,7 @@
 #include "netlabel.h"
 #include "audit.h"
 #include "avc_ss.h"
+#include "selinuxfs.h"
 
 #define SELINUX_INODE_INIT_XATTRS 1
 
@@ -3291,6 +3292,12 @@ static int selinux_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
                        return 0;
        }
 
+       if (inode->i_sb->s_magic == SELINUX_MAGIC) {
+               int rc = selinuxfs_inode_setattr(idmap, inode, iattr);
+               if (rc)
+                       return rc;
+       }
+
        if (ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID |
                        ATTR_ATIME_SET | ATTR_MTIME_SET | ATTR_TIMES_SET))
                return dentry_has_perm(cred, dentry, FILE__SETATTR);
diff --git a/security/selinux/include/selinuxfs.h b/security/selinux/include/selinuxfs.h
new file mode 100644
index 000000000000..f5e6da02833b
--- /dev/null
+++ b/security/selinux/include/selinuxfs.h
@@ -0,0 +1,2 @@
+int selinuxfs_inode_setattr(struct mnt_idmap *idmap, struct inode *inode,
+                            struct iattr *iattr);
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 896acad1f5f7..5af5e1dee743 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -43,6 +43,7 @@
 #include "objsec.h"
 #include "conditional.h"
 #include "ima.h"
+#include "selinuxfs.h"
 
 enum sel_inos {
        SEL_ROOT_INO = 2,
@@ -1954,6 +1955,20 @@ static struct dentry *sel_make_swapover_dir(struct super_block *sb,
        return dentry;  // borrowed
 }
 
+int selinuxfs_inode_setattr(struct mnt_idmap *idmap, struct inode *inode,
+                           struct iattr *iattr)
+{
+       switch (inode->i_ino) {
+       case SEL_STATUS:
+               if (iattr->ia_valid & ATTR_SIZE)
+                       return -EPERM;
+       default:
+               break;
+       }
+
+       return 0;
+}

--
paul-moore.com
