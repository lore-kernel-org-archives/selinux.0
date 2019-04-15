Return-Path: <SRS0=LFc9=SR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A68CC10F0E
	for <selinux@archiver.kernel.org>; Mon, 15 Apr 2019 16:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323152075B
	for <selinux@archiver.kernel.org>; Mon, 15 Apr 2019 16:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="sQ+q2tJm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfDOQUW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:20:22 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35942 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbfDOQUW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Apr 2019 12:20:22 -0400
Received: by mail-lj1-f193.google.com with SMTP id r24so16279430ljg.3
        for <selinux@vger.kernel.org>; Mon, 15 Apr 2019 09:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tIscj88JWhUlWGaOUbWep6Fxk/RNUpqE77V622mzieE=;
        b=sQ+q2tJmJwJU87sVKVqKhBKhxY9tA81AupZ3yW+jPZxQR1POnRmZlyVmtC/axko/9U
         Ji7ttO2gdmpM9o7YfiFB9DxonW6ihzbb/6nHBgis+m/fW4HMTF+tO5OGiMqczu9vfROq
         MFt54TF/NqKWF0kACxnNY9U4T5eONB052oyqUvL75ik0njU9YLW63XfvkmKFdd/W+5u/
         0x/aoDu1RZaXn/Ic73WLlrZx4nmMkQIp3ieD1kUd3/1RvQSw6REKgZ+k6DsZm6ml/j4n
         by52zaMkLhMw7ZPayHsQTJMYoesajWreIZqEpsOEHYfh88JSKITCSk1qtzgIs8ETHuWr
         ZAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tIscj88JWhUlWGaOUbWep6Fxk/RNUpqE77V622mzieE=;
        b=iMh+9esDtqdtCYqzKmFUmWgaH2FllCO6lf8bQnquB+6ZiHlOsU+XlUl0aljKpputNk
         FeeSAy4ZF7irJZJ2wbJYwCcvQkTjYzce8tpnwAsyxRsUL0V1WjrtPSJls75PwPTjV5NC
         3Gp3DwWPJYXMNftf93LPj2KQYeCETka/Qr03LqTOyFREFJL7uSFR05l9yOTmhvy6GsHB
         G2CqRRXQTPJW0ULRuTuJ0cjLjLKh/BXi/FwZVd+MsF3il5V6LAGh5ZqrO9ySRKF98Ca/
         YHf4NpZwlh+Y8rXF3PHbcPmLzF9XFvCQcpC99ePnYO6xkRYIHx52Z4sqRTwMPs7vioHL
         36YA==
X-Gm-Message-State: APjAAAX+g55NPUpo/F/KZ/DNlvDLYa1LjhlIbaeno518JWxOxRWXmesf
        YZnHZTqQ5kW1XUgzmC58dO2yzX5tX7GzO1nmU9lS
X-Google-Smtp-Source: APXvYqx7P/9DhU7VuBwkVOgcy7wOxzDz6FKVQmK0zIH9hTbaZ0ygJsjuUhzpe37HsFAfJfAacjMAt3prdWMn/nlMAaI=
X-Received: by 2002:a2e:4e12:: with SMTP id c18mr20887094ljb.3.1555345219849;
 Mon, 15 Apr 2019 09:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <6e4428ca-3da1-a033-08f7-a51e57503989@huawei.com>
 <b1575d02-fd88-65e6-2f16-70a96985087e@schaufler-ca.com> <20190415134331.GC22204@redhat.com>
 <CAHC9VhQ7ihqU0K57ctwzoHq0t0QVJPKiQQZn5TXB1FUqsvOSEQ@mail.gmail.com> <20190415150520.GA13257@redhat.com>
In-Reply-To: <20190415150520.GA13257@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 15 Apr 2019 12:20:08 -0400
Message-ID: <CAHC9VhSk1_fWooexHK0+5cKum55qTvj3uv5sRE=aJ4mv2GHJZg@mail.gmail.com>
Subject: Re: kernel BUG at kernel/cred.c:434!
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        "chengjian (D)" <cj.chengjian@huawei.com>, neilb@suse.com,
        Anna.Schumaker@netapp.com, keescook@chromium.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        viro@zeniv.linux.org.uk,
        "Xiexiuqi (Xie XiuQi)" <xiexiuqi@huawei.com>,
        Li Bin <huawei.libin@huawei.com>, yanaijie@huawei.com,
        peterz@infradead.org, mingo@redhat.com,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 15, 2019 at 11:05 AM Oleg Nesterov <oleg@redhat.com> wrote:
> On 04/15, Paul Moore wrote:
> >
> > On Mon, Apr 15, 2019 at 9:43 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > > Well, acct("/proc/self/attr/current") doesn't look like a good idea, but I do
> > > not know where should we put the additional check... And probably
> > > "echo /proc/self/attr/current > /proc/sys/kernel/core_pattern" can hit the
> > > same problem, do_coredump() does override_creds() too.
> > >
> > > May be just add
> > >
> > >         if (current->cred != current->real_cred)
> > >                 return -EACCES;
> > >
> > > into proc_pid_attr_write(), I dunno.
> >
> > Is the problem that do_acct_process() is calling override_creds() and
> > the returned/old credentials are being freed before do_acct_process()
> > can reinstall the creds via revert_creds()?  Presumably because the
> > process accounting is causing the credentials to be replaced?
>
> Afaics, the problem is that do_acct_process() does override_creds() and
> then __kernel_write(). Which calls proc_pid_attr_write(), which in turn calls
> selinux_setprocattr(), which does another prepare_creds() + commit_creds();
> and commit_creds() hits
>
>         BUG_ON(task->cred != old);

Gotcha.  In the process of looking at the backtrace I forgot about the
BUG_ON() at the top of the oops message.

I wonder what terrible things would happen if we changed the BUG_ON()
in commit_creds to simple returning an error an error code to the
caller.  There is a warning/requirement in commit_creds() function
header comment that it should always return 0.

-- 
paul moore
www.paul-moore.com
