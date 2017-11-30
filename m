Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vAU3GTX9025729
 for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2017 22:16:29 -0500
To: James Morris <james.l.morris@oracle.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
 selinux@tycho.nsa.gov, LSM <linux-security-module@vger.kernel.org>
References: <alpine.LFD.2.20.1711292113350.7808@localhost>
 <4d73f839-7a86-6edc-b44b-e296bd5947c2@schaufler-ca.com>
 <alpine.LFD.2.20.1711301130330.17322@localhost>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <ae2e71e4-c366-5a1e-9fd6-4de944f4a158@schaufler-ca.com>
Date: Wed, 29 Nov 2017 19:16:17 -0800
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.20.1711301130330.17322@localhost>
Content-Type: text/plain; charset=utf-8
Subject: Re: [BUG] kernel stack corruption during/after Netlabel
 error
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


On 11/29/2017 4:31 PM, James Morris wrote:
> On Wed, 29 Nov 2017, Casey Schaufler wrote:
>
>> I see that there is a proposed fix later in the thread, but I don't see
>> the patch. Could you send it to me, so I can try it on my problem?
> Forwarded off-list.

The patch does fix the problem I was seeing in Smack.

>
> Interestingly, I didn't see the KASAN output email from Stephen here.
>
>
