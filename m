Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r3OKMM0L030372
	for <selinux@tycho.nsa.gov>; Wed, 24 Apr 2013 16:22:22 -0400
Message-ID: <51783EFC.8050607@schaufler-ca.com>
Date: Wed, 24 Apr 2013 13:22:20 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Paul Moore <paul@paul-moore.com>
CC: LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>, SE Linux <selinux@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Eric Paris <eparis@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v13 0/9] LSM: Multiple concurrent LSMs
References: <5176ABB7.5080300@schaufler-ca.com> <5176B0F6.7080506@schaufler-ca.com> <3554062.6nBMExN24s@sifl>
In-Reply-To: <3554062.6nBMExN24s@sifl>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 4/24/2013 11:57 AM, Paul Moore wrote:
> On Tuesday, April 23, 2013 09:04:06 AM Casey Schaufler wrote:
>> Subject: [PATCH v13 0/9] LSM: Multiple concurrent LSMs
>>
>> Change the infrastructure for Linux Security Modules (LSM)s from a
>> single vector of hook handlers to a list based method for handling
>> multiple concurrent modules.
>>
>> The "security=" boot option takes a comma separated list of LSMs,
>> registering them in the order presented. The LSM hooks will be
>> executed in the order registered. Hooks that return errors are
>> not short circuited. All hooks are called even if one of the LSM
>> hooks fails. The result returned will be that of the last LSM
>> hook that failed.
> ...
>
>> The NetLabel, XFRM and secmark facilities are restricted to use
>> by one LSM at a time. This is due to limitations of the underlying
>> networking mechanisms. The good news is that viable configurations
>> can be created. The bad news is that the complexity of configuring
>> a system is necessarily increased.
> I know we had a good discussion about this a while back and I just wanted to 
> hear from you about this current patchset; how does the labeled networking LSM 
> assignment work?  Is it first-come-first-served based on the 'security=' 
> setting?

It's explicitly set in security/Kconfig. The problem with
first-come-first-serve is that the LSMs don't actually register
in the order specified, either at build time or boot time.
Further, until the init phase is complete, you don't know which
LSMs are actually going to register. That, and I promised Tetsuo
I wouldn't go out of my way to prevent late module loading in
the future.

I could do order checking on module registration and take
the networking component away from an LSM that registered
earlier, but with a larger order number I suppose.

The default configuration gives xfrm and secmark to SELinux
and NetLabel to Smack. If Smack is not included NetLabel goes
to SELinux. When LSMs using any of these facilities are added
in the future we'll have to negotiate the defaults.

An interesting aside that may be relevant is that the error
condition behavior makes it advisable to have the LSM you care
about most go last. If the networking components were strictly
FCFS you might have to chose an ordering you might not want for
other reasons.

It would be possible to have a boot time specification for
the networking components if you think it's important. I do
worry about making it excessively complicated. I'd be much more
concerned if more LSMs used the networking components.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
