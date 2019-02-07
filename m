Return-Path: <SRS0=93oN=QO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E99DC169C4
	for <selinux@archiver.kernel.org>; Thu,  7 Feb 2019 02:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138A0218D3
	for <selinux@archiver.kernel.org>; Thu,  7 Feb 2019 02:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfBGCb3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Feb 2019 21:31:29 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:61161 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfBGCb3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Feb 2019 21:31:29 -0500
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x172UUxi002092;
        Thu, 7 Feb 2019 11:30:30 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp);
 Thu, 07 Feb 2019 11:30:30 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x172UUOe002088;
        Thu, 7 Feb 2019 11:30:30 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id x172UUG6002087;
        Thu, 7 Feb 2019 11:30:30 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201902070230.x172UUG6002087@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [PATCH] LSM: Allow syzbot to ignore =?ISO-2022-JP?B?c2VjdXJpdHk9IHBh?=
 =?ISO-2022-JP?B?cmFtZXRlci4=?=
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        syzbot <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com>,
        tyhicks@canonical.com, John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        SELinux <selinux@vger.kernel.org>,
        Russell Coker <russell@coker.com.au>,
        Laurent Bigonville <bigon@debian.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>
MIME-Version: 1.0
Date:   Thu, 07 Feb 2019 11:30:30 +0900
References: <8f48e1d0-c109-f8a9-ea94-9659b16cae49@i-love.sakura.ne.jp> <0d23d1a5-d4af-debf-6b5f-aaaf698daaa8@schaufler-ca.com>
In-Reply-To: <0d23d1a5-d4af-debf-6b5f-aaaf698daaa8@schaufler-ca.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Casey Schaufler wrote:
> On 2/6/2019 2:23 AM, Tetsuo Handa wrote:
> > But as I update the documentation ( https://tomoyo.osdn.jp/2.6/chapter-3.html.en#3.6 ),
> > I came to think that we should ignore security= parameter when lsm= parameter is specified.
> >
> > Currently, it is possible to enable TOMOYO and only one of SELinux/Smack/AppArmor. Therefore,
> > it is possible to disable only TOMOYO by specifying security=selinux when we want to enable
> > only SELinux, by specifying security=smack when we want to enable only Smack, by specifying
> > security=apparmor when we want to enable only AppArmor. That is, we can use security= parameter
> > in order to specify the other LSM module which should not be disabled.
> >
> > But when it becomes possible to enable TOMOYO and more than one of SELinux/Smack/AppArmor,
> > we will no longer be able to selectively disable one LSM module using security= parameter, for
> > security= parameter is intended for specifying only one LSM module which should be enabled.
> > That is, we will need to use lsm= parameter in order to selectively disable LSM modules.
> 
> Yes. That is correct. The existing behavior of security= is maintained.

But the existing behavior of CONFIG_DEFAULT_SECURITY is not maintained.
This might cause a problem like

  commit e5a3b95f581da62e2054ef79d3be2d383e9ed664
  Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
  Date:   Sat Feb 14 11:46:56 2009 +0900

      TOMOYO: Don't create securityfs entries unless registered.

      TOMOYO should not create /sys/kernel/security/tomoyo/ interface unless
      TOMOYO is registered.

for Ubuntu users because Ubuntu kernels are built with

  CONFIG_SECURITY_SELINUX=y
  CONFIG_SECURITY_SMACK=y
  CONFIG_SECURITY_TOMOYO=y
  CONFIG_SECURITY_APPARMOR=y
  CONFIG_SECURITY_YAMA=y
  CONFIG_DEFAULT_SECURITY="apparmor"

. Due to CONFIG_DEFAULT_SECURITY="apparmor", majority of Ubuntu users are enabling
only AppArmor without explicitly specifying "security=apparmor".

Currently default CONFIG_LSM setting is

  "yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"

but Ubuntu kernels would have to be built with non-default CONFIG_LSM setting like

  "yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo"

in order to make sure that AppArmor is by default chosen for the LSM_FLAG_EXCLUSIVE module.

Now that TOMOYO becomes a !LSM_FLAG_EXCLUSIVE module, not specifying "security=apparmor" will
automatically enable TOMOYO. And majority of Ubuntu users will unexpectedly encounter TOMOYO
messages. But removing "tomoyo" from CONFIG_LSM setting in order to save majority of Ubuntu
users from unexpectedly encountering TOMOYO messages also has a problem; Ubuntu users who want
to enable only TOMOYO from LSM_FLAG_LEGACY_MAJOR modules can specify "security=tomoyo", but
Ubuntu users who want to enable TOMOYO and one of SELinux,Smack,AppArmor (including syzbot)
will have to explicitly specify "lsm=" because "security=" can't allow enabling multiple
LSM_FLAG_LEGACY_MAJOR modules.

> The new behavior of lsm= is provided to allow general handling of a list
> of security modules. It uses the same form of data as CONFIG_LSM.
> 
> > Then, I think that it is straightforward (and easier to manage) to ignore security= parameter
> > when lsm= parameter is specified.
> 
> That reduces flexibility somewhat. If I am debugging security modules
> I may want to use lsm= to specify the order while using security= to
> identify a specific exclusive module. I could do that using lsm= by
> itself, but habits die hard.

"lsm=" can be used for identifying a specific exclusive module, and Ubuntu kernels would
have to use CONFIG_LSM (or "lsm=") for identifying the default exclusive module (in order
to allow enabling both TOMOYO and one of SELinux,Smack,AppArmor at the same time).

Since "security=" can't be used for selectively enable/disable more than one of
SELinux,Smack,TOMOYO,AppArmor, I think that recommending users to migrate to "lsm=" is the
better direction. And ignoring "security=" when "lsm=" is specified is easier to understand.
