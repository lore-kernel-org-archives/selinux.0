Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sAOFFFmp000616
 for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2014 10:15:15 -0500
Received: by mail-oi0-f50.google.com with SMTP id a141so6791059oig.9
 for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2014 07:15:13 -0800 (PST)
MIME-Version: 1.0
Sender: sven.j.vermeulen@gmail.com
In-Reply-To: <20141124112636.GA6200@e145.network2>
References: <5463658D.7050702@tresys.com>
 <CAPzO=NwooMT-tcgLQOCd7gUdy-8eu67=tTVwuWz0pLOpw8eAnA@mail.gmail.com>
 <20141124112636.GA6200@e145.network2>
Date: Mon, 24 Nov 2014 16:15:13 +0100
Message-ID: <CAPzO=NyHcEdpQN9iVwEC5LXtYzWjaK0jajz2tFG3pf+-HXqDaA@mail.gmail.com>
Subject: Re: SELinux Userspace Release: 20140826-rc6
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Nov 24, 2014 at 12:26 PM, Dominick Grift <dac.override@gmail.com> wrote:
>> Now, I tried to remove the "object_r" role from one of my test VMs but
>> that totally screwed up the image (system froze, and reboot failed).
>> I'm not sure if I'm allowed to remove it or not now. If I should, I'll
>> investigate it further and see if I can get denials or other
>> information from it.
>
> object_r should be associated with all security identitiers i believe (including selinux user identities)
>
> What you are seeing is expected, and you should not try to remove it

The downside is that with the 2.3 utilities, mentioning "object_r" fails:

~# semanage user -m -R "object_r sysadm_r system_r" root
ValueError: object_r must be an SELinux role:
Valid roles: staff_r, sysadm_r, system_r, unconfined_r, user_r

But with 2.4, not mentioning "object_r" while manipulating the user
definition results in the failure.

That makes it confusing for administrators that need to manage SELinux
systems where one set uses 2.3 userspace and another uses 2.4.
Especially those that use configuration management utilities like salt
or puppet, as those will now need to add in logic to find out if
"object_r" is already in the list or not and update accordingly.

Wkr,
  Sven Vermeulen
