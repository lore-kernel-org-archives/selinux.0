Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1MN8DHU006819
 for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2018 18:08:13 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC04.oob.disa.mil (Postfix) with SMTP id 3znVQ12k3Pz63cG
 for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2018 23:08:09 +0000 (UTC)
Received: from UPBD19PA01.eemsg.mil (unknown [192.168.18.2])
 by UPDCF3IC04.oob.disa.mil (Postfix) with ESMTP id 3znVQ11CSTz62qW
 for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2018 23:08:09 +0000 (UTC)
Received: by mail-lf0-f68.google.com with SMTP id l191so9792671lfe.1
 for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2018 15:08:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <161ba1d60d8.2781.85c95baa4474aabc7814e68940a78392@paul-moore.com>
References: <20180220191527.14307-1-richard_c_haines@btinternet.com>
 <20180221143345.GA3888@localhost.localdomain>
 <161ba1d60d8.2781.85c95baa4474aabc7814e68940a78392@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 22 Feb 2018 18:08:05 -0500
Message-ID: <CAHC9VhSnPku5SYnNkyUqvi46OpzPZKbJf+fxeCR0y3ym0zcMYA@mail.gmail.com>
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: selinux@tycho.nsa.gov, netdev@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 Vlad Yasevich <vyasevich@gmail.com>, nhorman@tuxdriver.com,
 Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, casey@schaufler-ca.com,
 James Morris <jmorris@namei.org>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH V7 2/4] sctp: Add ip option support
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Feb 21, 2018 at 3:45 PM, Paul Moore <paul@paul-moore.com> wrote:
> On February 21, 2018 9:33:51 AM Marcelo Ricardo Leitner <marcelo.leitner@gmail.com> wrote:
>> On Tue, Feb 20, 2018 at 07:15:27PM +0000, Richard Haines wrote:
>>> Add ip option support to allow LSM security modules to utilise CIPSO/IPv4
>>> and CALIPSO/IPv6 services.
>>>
>>> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>>
>> LGTM too, thanks!
>>
>> Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
>
> I agree, thanks everyone for all the work, review, and patience behind this patchset!  I'll work on merging this into selinux/next and I'll send a note when it's done.

I just merged the four patches (1,3,4 from the v6 patchset, 2 from the
v7 patchset) in selinux/next and did a quick sanity test on the kernel
(booted, no basic SELinux regressions).  Additional testing help is
always appreciated ...

* git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
* https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git

-- 
paul moore
www.paul-moore.com
