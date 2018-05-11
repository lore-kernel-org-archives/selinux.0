Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4B0wZZr002374
 for <selinux@tycho.nsa.gov>; Thu, 10 May 2018 20:58:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC02.oob.disa.mil (Postfix) with SMTP id 40hsCt1PPTz2Sj4X
 for <selinux@tycho.nsa.gov>; Fri, 11 May 2018 00:58:34 +0000 (UTC)
Received: from UPBD19PA04.eemsg.mil (unknown [192.168.18.5])
 by UPDCF3IC02.oob.disa.mil (Postfix) with ESMTP id 40hsCs5Zxzz2Sj4J
 for <selinux@tycho.nsa.gov>; Fri, 11 May 2018 00:58:33 +0000 (UTC)
To: LSM <linux-security-module@vger.kernel.org>,
 LKLM <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
 "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
 John Johansen <john.johansen@canonical.com>,
 Kees Cook <keescook@chromium.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 James Morris <jmorris@namei.org>
References: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <f226eb00-8103-90cf-640c-e6911004efcf@schaufler-ca.com>
Date: Thu, 10 May 2018 17:58:26 -0700
MIME-Version: 1.0
In-Reply-To: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 00/23] LSM: Full security module stacking
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 5/10/2018 5:30 PM, Casey Schaufler wrote:
> Subject: [PATCH 00/23] LSM: Full security module stacking
>
>
Git tree: git://github.com/cschaufler/lsm-stacking.git#stacking-4.18
