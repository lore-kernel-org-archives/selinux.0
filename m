Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0NGIhjm013831
	for <selinux@tycho.nsa.gov>; Wed, 23 Jan 2013 11:18:43 -0500
Message-ID: <51000D67.3040103@schaufler-ca.com>
Date: Wed, 23 Jan 2013 08:18:47 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
CC: jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, john.johansen@canonical.com, eparis@redhat.com,
        keescook@chromium.org, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v12 3/9] LSM: Multiple concurrent LSMs
References: <50FDD315.7090606@schaufler-ca.com> <201301221009.JDB30838.tFFMVFLOQJSOOH@I-love.SAKURA.ne.jp> <50FDF4FC.1010308@schaufler-ca.com> <201301221623.JIH35408.LFSJQFOFOOHVMt@I-love.SAKURA.ne.jp> <50FEEBE6.80605@schaufler-ca.com> <201301232030.HAH52121.VFtOSLHQFJOOMF@I-love.SAKURA.ne.jp>
In-Reply-To: <201301232030.HAH52121.VFtOSLHQFJOOMF@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 1/23/2013 3:30 AM, Tetsuo Handa wrote:
> Casey, let me confirm what your requirements are.
>
> Confirm 1:
>
>   You can tolerate writing LSM modules as loadable kernel modules. Right?

In the future, hypothetically, yes. Not now. I have exactly
zero interest in fighting the battles that resulted in a static
LSM scheme all over again. I can't even remember which side I
was on last time around. I want to keep the issues of multiple
and loadable LSMs separate and distinct.

> Confirm 2:
>
>   You don't want to allow loading of LKM-based LSM modules which cannot be
>   unloaded safely/cleanly. Right?

That is strictly an issue for loadable modules. The only case I
care about at present is SELinux and reset_security_ops().

> Confirm 3:
>
>   When unloading a LKM-based LSM module, you want to make sure that all
>   resources used by that module are cleaned up. Right?

That is strictly an issues for LKM-based modules, and I have no interest
in encumbering multiple LSM support with the issues of LKM-based modules.

> Confirm 4:
>
>   You consider that requisite mechanisms for LSM framework for supporting
>   LKM-based LSMs are
>
>    (a) "safe unloading" : LKM-based LSM modules can be unloaded safely.
>
>    (b) "clean unloading" : All resources used by LKM-based LSM module can be
>        cleaned up upon unload.
>
>   . Right?

I consider support for LKM-based security modules to be outside the scope
of the work at hand. I have no intention of doing things to make LKM-based
modules more difficult in the future. I also have no intention of going
out of my way to make them easier.

> Confirm 5:
>
>   You want any LSM modules (including LKM-based LSM modules) to manage security
>   blobs using "struct lsm_blob" provided by LSM framework. Right?

I would need to look at a proposal on how LKM-based are supposed to
work before I would answer a question at that depth. I am regrettably
not available for that work presently.

> Confirm 6:
>
>   You want to implement a mechanism which makes it possible to allow LKM-based
>   LSM module to clean up all resources upon unloading. Right?

I am uninterested in LKM-based LSMs at present. I have none of the time, energy
or inclination required to tackle that project. I believe that including LKM-based
LSMs in the multiple concurrent LSM project would significantly increases resistance
to the project's acceptance.

Arguments around, about or including LKM-based LSM support are not
relevant to the task at hand and impede its progress. Please, can
we hold them for later?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
