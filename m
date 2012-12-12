Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBCH48Ah023381
	for <selinux@tycho.nsa.gov>; Wed, 12 Dec 2012 12:04:08 -0500
Message-ID: <50C8B919.2060102@schaufler-ca.com>
Date: Wed, 12 Dec 2012 09:04:25 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        john.johansen@canonical.com, keescook@chromium.org,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v10] LSM: Multiple concurrent LSMs
References: <50C65DE2.5090909@schaufler-ca.com>   <201212112128.ADI26010.OQJVLOFSOFtHMF@I-love.SAKURA.ne.jp>   <50C751D3.60409@schaufler-ca.com>   <201212122159.CEC09839.HMOFtQFLJSVFOO@I-love.SAKURA.ne.jp>   <50C8A757.3050907@schaufler-ca.com> <1355327754.3527.37.camel@localhost>  <50C8AFD1.1070905@schaufler-ca.com> <1355330026.3527.44.camel@localhost>
In-Reply-To: <1355330026.3527.44.camel@localhost>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/12/2012 8:33 AM, Eric Paris wrote:
> On Wed, 2012-12-12 at 08:24 -0800, Casey Schaufler wrote:
>> On 12/12/2012 7:55 AM, Eric Paris wrote:
>>> On Wed, 2012-12-12 at 07:48 -0800, Casey Schaufler wrote:
>>>
>>> How about asking every LSM to implement a new 'enable' function.  If the
>>> LSM is not 'present' only the new 'enable' function can be used.  If the
>>> LSM is present either the legacy enable function every LSM uses today or
>>> the new enable function can be used.  Thus even if you build the kernel
>>> with stacking, you cannot enable a non-present LSM unless the tools have
>>> been updated.
>> I'm sorry, but I am having trouble understanding what you're suggesting.
> I'm believing every LSM has some mechanism by which it is 'enabled' at
> run time.  With SELinux that mechanism is loading policy.  If you don't
> load policy SELinux will not enforce anything.  I'm assuming something
> similar exists for others.  Tell me if I'm wrong.
>
> We know that legacy tools will break on an LSM if it is not
> CONFIG_SECURITY_PRESET (or equivalent 'first in list').  I'm calling
> this first LSM the 'present' LSM.
>
> Legacy tools also will attempt to enable their LSM using the current
> enabling interface.  For SELinux this is /sys/fs/selinux/load
>
> Thus if as part of stacking we implement a new enabling interface for
> each LSM and disable the legacy enabling mechanism when the LSM is not
> present we make sure that new kernels can't get into the half and half
> situation with old userspace.
>
> Legacy 'enable' interface is /sys/fs/selinux/load
> New enabling interface could be /sys/fs/selinux/new_load
>
> In SELinux present mode, they would do the exact same thing.  In SELinux
> non-present mode we could disable /sys/fs/selinux/load and only allow
> new_load.  Thus old userspace cannot 'enable' SELinux on a new kernel
> when it won't work.
>
> Make any more sense?
>
Yes, thank you.

I'm headed in what I hope is a simpler direction. I have added
two files into securityfs:

	/sys/kernel/security/lsm     - a comma separated list of LSMs
	/sys/kernel/security/present - the presented LSM

I have also added LSM identified files in /proc/.../attr:

	/proc/.../attr/current
	/proc/.../attr/selinux.current
	/proc/.../attr/apparmor.current
	/proc/.../attr/keycreate
	/proc/.../attr/selinux.keycreate

SELinux applications and libraries can use simple logic to determine
what to do:

	if /sys/kernel/security/lsm does not contain "selinux"
		Stop! No SELinux here!
	if /sys/kernel/security/present does not contain "selinux"
		Use selinux.current
	else
		Use current if you like.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
