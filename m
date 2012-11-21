Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qALKUtNw002806
	for <selinux@tycho.nsa.gov>; Wed, 21 Nov 2012 15:30:55 -0500
Message-ID: <50AD39E4.5060307@schaufler-ca.com>
Date: Wed, 21 Nov 2012 12:30:28 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
CC: jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, john.johansen@canonical.com, eparis@redhat.com,
        keescook@chromium.org, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v8 1/2] LSM: Multiple concurrent LSMs
References: <50ABE35B.7060103@schaufler-ca.com> <201211212258.IEI34810.FOMOOSLJQFFHVt@I-love.SAKURA.ne.jp>
In-Reply-To: <201211212258.IEI34810.FOMOOSLJQFFHVt@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/21/2012 5:58 AM, Tetsuo Handa wrote:
> Casey Schaufler wrote:
>> I have not tried to
>> reintroduce LSMs as loadable modules, in spite of the
>> vigor with which it has been requested. I see that as
>> work for another day, and a seperate battle to fight.
> Please respond to
>
>   Subject: [PATCH 0/5] Allow LKM-based LSM modules.
>   Date: Mon, 19 Nov 2012 22:57:28 +0900
>
> posted to LSM-ML if somebody has objections. ;-)

I really have to keep focus on the stacking aspects. I still
want to get something right rather than trying to get all possible
scenarios.

>> The current implementation of reset_security_ops() is
>> not up to the rigors required of a real load/unload
>> mechanism.
> Why don't you move commoncap calls from each LSM to common path?

This could be done in general, but there are three cases where it
can't be done:

mmap_addr
	AppArmor and Smack specify cap_mmap_addr as the hook.
	SELinux explicitly wants its check first for audit.
capget
	AppArmor replaces cap_capget with its own logic.
	SELinux does its own check before the cap call.
bprm_secure_exec
	AppArmor does a trivial check before the cap call
	Smack does a trivial check after the cap call.
	SELinux does a non-trivial check before the cap call.

How about if I change all the cases except for these three
so that they do your suggested cap_call fail-and-bail. That
will include changing the LSM hooks.

For security_mmap_addr I can do a special case of calling the cap hook
last, and only if there's no outstanding denial. AppArmor and Smack
use the cap_mmap_addr hook as their own. That could be removed.

For security_capget the existing behavior is necessary. This really
is a replacement hook. AppArmor and SELinux may conflict fatally here.

For security_bprm_secure_exec the same sort of special case used in
security_mmap_addr, with the cap call last should work.

I will look at pulling the list_empty cap_call out and fixing
the LSMs to go along with a fail-and-bail cap_call where appropriate.

Anyone want to offer suggestions on the possible conflict between
SELinux and AppArmor on the capget hooks? I mean something more
useful than disallowing the combination.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
