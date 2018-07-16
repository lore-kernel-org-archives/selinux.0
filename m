Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w6GJnQOn032039
 for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2018 15:49:27 -0400
To: James Morris <jmorris@namei.org>
Cc: LSM <linux-security-module@vger.kernel.org>,
 LKLM <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
 "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
 John Johansen <john.johansen@canonical.com>,
 Kees Cook <keescook@chromium.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 "Schaufler, Casey" <casey.schaufler@intel.com>
References: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
 <alpine.LRH.2.21.1807170453400.18292@namei.org>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <c189ed40-4b8e-de1a-6917-273fdad207c0@schaufler-ca.com>
Date: Mon, 16 Jul 2018 12:49:18 -0700
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1807170453400.18292@namei.org>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v1 00/22] LSM: Full security module stacking
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 7/16/2018 11:53 AM, James Morris wrote:
> On Mon, 16 Jul 2018, Casey Schaufler wrote:
>
>> LSM: Full security module stacking
>>
>> I'm calling this v1 not because it's the first version
>> I've put out but because it's the first version I'm getting
>> serious external pressure to get upstream. 
> >From whom?

S.A.R.A. , Ubuntu and a couple lesser embedded projects I'm working with.
