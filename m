Return-Path: <SRS0=UzQU=QG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF47C282DA
	for <selinux@archiver.kernel.org>; Wed, 30 Jan 2019 17:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17FE0218A3
	for <selinux@archiver.kernel.org>; Wed, 30 Jan 2019 17:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548868158;
	bh=rRDlg5lormqPFVbKv7aiL3qSgD7IxXF/tI+zS6Gp8TQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zxZ1QCEy+2EG5NAC/F0C8FZVwrCrZEyVrys3amgl5AOT5usyx+a2PHPAGoAzhW1kg
	 wnZUC8wHsGgCSeQ3QJHH0PkSbf0dInxSrKSjmZLi6aBwEN0Z4GSTD0PBL9XK5EA+eV
	 DrG02vgcWdurt509jmZGyOdgRu82V5/nPXisA/0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732400AbfA3RJQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:09:16 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:41356 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732390AbfA3RJQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Jan 2019 12:09:16 -0500
Received: by mail-yb1-f193.google.com with SMTP id n6so99748ybg.8;
        Wed, 30 Jan 2019 09:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fV5393vsqnrEoYDVfVdAQON49yYFXCXoPJiHHf0IuH8=;
        b=YAIEi+6Mb6MG0CaXAD/XUMi1GuURGS8V8ipb6gKrZTpqmKpwjo5XeWu1klTa9Zi1HA
         iCZlbQUjvSR7qi6q/Q7yA/EUnSd1SCzwkj/l2thn1hS5OiAvujvu65pvm4+L5t0xgUFm
         WvHwE2XBNe4mw8tLyh92ha6bPLmkBiVHSeDa+0KNA/kuz2PT/F34prikKMqa+YHwoWZw
         W54o1N0DVLIklFwZ8zpDyqZql4K2JWfdhwOo5VFIVlHbpnMZgQQBDWh29+AapLerT4Po
         p1Z4duSCHOrK++6Sf+JDgCagvYId8e0ghTVwNF5eu9DILEkPVRHTPQEjG2sElgHS63nu
         mgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fV5393vsqnrEoYDVfVdAQON49yYFXCXoPJiHHf0IuH8=;
        b=l1xXUTNcuvHHYqGXs+3Np3sRnkKnDu2x7USajSBTkLzAl9F5ohiTg8xpDwjI6XrIOa
         uVkhXViTAVIlDjOEpDaDef3dDzsgY/ydJED37BJgrzlExJwMFW89vyIQ4d0Ulc/7IegT
         CoOq3JRMdzMqyQSaLvOVMnSHNvCyaCARWNDtJfDdMS4JBjtdtGykWXMMxFcqTx3buHRG
         OmYX+2dgs8jGVfvT/EaJISH8H2IXKGHjxI+F9sS9VI6n7x4n7wx2DboIBYSxF51DPOyJ
         KZ27Zbxb7kT7TlWaEefSsgh+Y+lrwUZcPSb9GFS4eHzfePoCrXGa8zKy8hc+DT9WC/Pp
         wbYA==
X-Gm-Message-State: AJcUukddyjeoaZNKEarHirBCZK40GRHfPmDPZj/sOMIO21I8AZ4J4sDe
        kYmC06zbObOd62v5YU3al6VAdZV1
X-Google-Smtp-Source: ALg8bN7ZBJnrE+R1Q6VmuPLROFUV/Vj8frLhuFV0RbNYRAbv12gxaGqSkTQBg2N48ifYIA+E1ivIDw==
X-Received: by 2002:a25:aa73:: with SMTP id s106mr29976014ybi.519.1548868154595;
        Wed, 30 Jan 2019 09:09:14 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:e55d])
        by smtp.gmail.com with ESMTPSA id z74sm804287ywz.51.2019.01.30.09.09.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 09:09:13 -0800 (PST)
Date:   Wed, 30 Jan 2019 09:09:11 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v3 5/5] kernfs: initialize security of newly created nodes
Message-ID: <20190130170911.GZ50184@devbig004.ftw2.facebook.com>
References: <20190130114150.27807-1-omosnace@redhat.com>
 <20190130114150.27807-6-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130114150.27807-6-omosnace@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

On Wed, Jan 30, 2019 at 12:41:50PM +0100, Ondrej Mosnacek wrote:
> @@ -673,6 +698,12 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
>  			goto err_out3;
>  	}
>  
> +	if (parent) {
> +		ret = kernfs_node_init_security(parent, kn);
> +		if (ret)
> +			goto err_out3;
> +	}

So, doing this unconditionally isn't a good idea.  kernfs doesn't use
the usual dentry/inode because there are machines with 6, even 7 digit
number of kernfs nodes and some of them even failed to boot due to
memory shortage.  Please don't blow it up by default.

Thanks.

-- 
tejun
