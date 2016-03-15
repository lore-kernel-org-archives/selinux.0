Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u2FEJmvV031731
 for <selinux@tycho.nsa.gov>; Tue, 15 Mar 2016 10:19:48 -0400
Message-ID: <56E819F9.70605@virtuozzo.com>
Date: Tue, 15 Mar 2016 17:19:37 +0300
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
MIME-Version: 1.0
To: Seth Forshee <seth.forshee@canonical.com>
CC: Andy Lutomirski <luto@amacapital.net>, "Eric W. Biederman"
 <ebiederm@xmission.com>, <devel@openvz.org>, Serge Hallyn
 <serge.hallyn@canonical.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 <linux-security-module@vger.kernel.org>,
 <linux-mtd@lists.infradead.org>, <selinux@tycho.nsa.gov>,
 <linux-fsdevel@vger.kernel.org>, Konstantin Khorenko
 <khorenko@virtuozzo.com>, Pavel Emelyanov <xemul@virtuozzo.com>
Subject: Re: [PATCH] fs: remove excess check for in_userns
References: <1451930639-94331-4-git-send-email-seth.forshee@canonical.com>
 <1458043740-14229-1-git-send-email-ptikhomirov@virtuozzo.com>
 <20160315134545.GB27754@ubuntu-xps13>
In-Reply-To: <20160315134545.GB27754@ubuntu-xps13>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



On 03/15/2016 04:45 PM, Seth Forshee wrote:
> On Tue, Mar 15, 2016 at 03:09:00PM +0300, Pavel Tikhomirov wrote:
>> If in_userns returns false mnt_may_suid also returns false, and we
>> will reach second(removed) if-check only in case it does not trigger,
>> so remove it.
>
> We had a somewhat lengthy discussion previously where one of the
> conclusions was that we'd have that check in both places even though
> it's redundant. Iirc the reason was that though they're doing the same
> test they're doing so to answer different questions, so we should have
> the test in both places (or something along those lines).

Ok, that is reasonable. But from my POW the edge between the meaning of 
those checks is quiet blurred.

Thanks!

>
> Thanks,
> Seth
>

-- 
Best regards, Tikhomirov Pavel
Software Developer, Virtuozzo.
