Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8RMWN3h028708
 for <selinux@tycho.nsa.gov>; Thu, 27 Sep 2018 18:32:23 -0400
To: James Morris <jmorris@namei.org>
Cc: LSM <linux-security-module@vger.kernel.org>,
 SE Linux <selinux@tycho.nsa.gov>, LKLM <linux-kernel@vger.kernel.org>,
 John Johansen <john.johansen@canonical.com>,
 Kees Cook <keescook@chromium.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>, =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?=
 <mic@digikod.net>, Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
 <5360cd42-5827-58af-515c-6e1ded1d9154@schaufler-ca.com>
 <alpine.LRH.2.21.1809280813270.8410@namei.org>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <84719272-fb62-76b6-b2fd-f0c36d49707d@schaufler-ca.com>
Date: Thu, 27 Sep 2018 15:32:15 -0700
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1809280813270.8410@namei.org>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v4 04/19] SELinux: Remove cred security blob
 poisoning
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 9/27/2018 3:13 PM, James Morris wrote:
> On Fri, 21 Sep 2018, Casey Schaufler wrote:
>
>> The SELinux specific credential poisioning only makes sense
>> if SELinux is managing the credentials. As the intent of this
>> patch set is to move the blob management out of the modules
>> and into the infrastructure, the SELinux specific code has
>> to go. The poisioning could be introduced into the infrastructure
>> at some later date.
> If it's useful, it should be incorporated into core LSM, otherwise that's 
> a regression for SELinux

When I discussed this code with David Howells he indicated
that it was primarily used for debugging the original shared
credential implementation and that is was not especially
valuable any longer. If someone thinks it is valuable we
should consider doing it in the infrastructure for all the
blobs, not just the credential.
