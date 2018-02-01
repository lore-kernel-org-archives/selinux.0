Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w11GRrp7022532
 for <selinux@tycho.nsa.gov>; Thu, 1 Feb 2018 11:27:53 -0500
Received: by mail-pf0-f193.google.com with SMTP id y26so15692432pfi.10
 for <selinux@tycho.nsa.gov>; Thu, 01 Feb 2018 08:20:16 -0800 (PST)
To: Paul Moore <paul@paul-moore.com>
Cc: linux-kernel@vger.kernel.org, Paul Moore <paul@linuxfoundation.org>,
 Greg KH <gregkh@linuxfoundation.org>, Eric Dumazet <edumazet@google.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
 "Serge E . Hallyn" <serge@hallyn.com>, stable <stable@vger.kernel.org>,
 James Morris <jmorris@namei.org>
References: <20180201153708.63506-1-salyzyn@android.com>
 <CAHC9VhSdR9UGpYhod5xhA76EbSKHzTW5rEiYWMovC0t6gfowig@mail.gmail.com>
From: Mark Salyzyn <salyzyn@android.com>
Message-ID: <5fb5622d-e58b-c174-3d5c-bfe55569b88e@android.com>
Date: Thu, 1 Feb 2018 08:20:13 -0800
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSdR9UGpYhod5xhA76EbSKHzTW5rEiYWMovC0t6gfowig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH v2] general protection fault in sock_has_perm
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/01/2018 08:00 AM, Paul Moore wrote:
> On Thu, Feb 1, 2018 at 10:37 AM, Mark Salyzyn <salyzyn@android.com> wrote:
>> In the absence of commit a4298e4522d6 ("net: add SOCK_RCU_FREE socket
>> flag") and all the associated infrastructure changes to take advantage
>> of a RCU grace period before freeing, there is a heightened
>> possibility that a security check is performed while an ill-timed
>> setsockopt call races in from user space.  It then is prudent to null
>> check sk_security, and if the case, reject the permissions.
>>
>> . . .
>> ---[ end trace 7b5aaf788fef6174 ]---
>>
>> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
>> Signed-off-by: Paul Moore <paul@linuxfoundation.org>
> No, in the previous thread I gave my ack, not my sign-off; please be
> more careful in the future.  It may seem silly, especially in this
> particular case, but it is an important distinction when things like
> the DCO are concerned.
>
> Anyway, here is my ack again.
>
> Acked-by: Paul Moore <paul@paul-moore.com>
>
Ok, both Greg KH and yours should be considered Acked-By. Been 
overstepping this boundary for _years_. AFAIK Signed-off-by is still 
pending from Stephen Smalley <sds@tycho.nsa.gov> before this can roll in.

Lesson lurned

-- Mark
