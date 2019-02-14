Return-Path: <SRS0=aI9x=QV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB3BC10F04
	for <selinux@archiver.kernel.org>; Thu, 14 Feb 2019 15:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7717218FF
	for <selinux@archiver.kernel.org>; Thu, 14 Feb 2019 15:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550159340;
	bh=Apy3WZrTaORV91GwmuPe+dXuyI76e2RQQsNucF7fU04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XMp45lxSolmYi1Pg9fgTTqpH2FyHee5yJgubRDds1/f2Q0F/Y5VitdADDsqkDHAb/
	 tA+zNTkt2bJDltFlvQjH1ca/EFJmqQ99+TyBWhKgfBWATlVEXNdQphx22QE4Gaqted
	 fSWajlCO/0iF9WvQrRs6FyTKTEB5ckIn+IxaXCBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395299AbfBNPs7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:48:59 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:33122 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbfBNPs6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Feb 2019 10:48:58 -0500
Received: by mail-yb1-f193.google.com with SMTP id w2so2576673ybi.0;
        Thu, 14 Feb 2019 07:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H1vaG4lbn//YMArK7XlmO3NIV3f5VUk/MYabxdaBpSo=;
        b=sPaCPNbL5Ig+MrLwKloQBMLA9ybpDjQyX0kxaNystuwtVuiDF2ZiSOSuMS7rlZ6wjM
         hiyHYcBCOlc5qiS+oy6qXA3ng8HgTMxTl+PY8aA5bpOvMdws+zJbzu2ThvuNNMjVgGLy
         Pp1mMnsr5ImUKjmE1P7Hldzk4INOhtV1aKpa7lYNKawiayaDRikiIJ5JGMYjBQSmVy3s
         SxuliMj+gRKx5CWiwkWjE4vOdatJYpBtM+ihxlZP0uj1pLv3jgEc5uEOXemEIpt+gbhl
         QQLYHpLBSyoiEXuc5YX/KRbofiStYiQ4dXKkeNi64d3la+RzSZzQwTB9/nq6iQO0UkiV
         LfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=H1vaG4lbn//YMArK7XlmO3NIV3f5VUk/MYabxdaBpSo=;
        b=NTe2Vu0ADA1CuEl53PD8LzCBnCMpRuD0x4ZU5OP+VB6D9tHxHADBxr7mAGW/JoMOG9
         UL7tOuqduwXJQbaSD6RfxpIu+6OB5JWiKsFcAUPDpi4+I+azogR0a3A+4xlVDTcaOHCF
         PxKU5XUULPpAUrIt+UiWnQGzWUEa+RRCmiHVgqeDZf99RAl20FrOj5DjV1IrA4RPJ3LN
         Qpz78QfPBOX1B49AYrkucovC6jARkE3NKu9erjopG7u57c+tHPsjBljwnJeAX6qAURPb
         v4QW6xEDGufsj/aPXZTyRdBZeUX+pCskIip6F3uSBK8rzxoM5Hr9bOI3admdA+et63kF
         Y2DQ==
X-Gm-Message-State: AHQUAuYDWQuPRZW3KIlo+sTLKzzCtrwS2lvHE+9hgCh5o0Km47tvMJiw
        QcLTZf5sFahwwBgecg11+eE=
X-Google-Smtp-Source: AHgI3IbfT1Sd7b5f6JeeLyJpmHGxyEEfr1pFv4STNua9xVUQd/D+fbjVyIQR7qll2C0CPlQVRmlAOg==
X-Received: by 2002:a25:37cb:: with SMTP id e194mr3629505yba.329.1550159337578;
        Thu, 14 Feb 2019 07:48:57 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::6:94e8])
        by smtp.gmail.com with ESMTPSA id o4sm983433ywe.102.2019.02.14.07.48.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 07:48:56 -0800 (PST)
Date:   Thu, 14 Feb 2019 07:48:54 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v6 5/5] kernfs: initialize security of newly created nodes
Message-ID: <20190214154854.GO50184@devbig004.ftw2.facebook.com>
References: <20190214095015.16032-1-omosnace@redhat.com>
 <20190214095015.16032-6-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214095015.16032-6-omosnace@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 14, 2019 at 10:50:15AM +0100, Ondrej Mosnacek wrote:
> +static int kernfs_node_init_security(struct kernfs_node *parent,
> +				     struct kernfs_node *kn)

Can we skip the whole thing if security is not enabled?

Thanks.

-- 
tejun
