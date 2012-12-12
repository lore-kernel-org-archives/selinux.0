Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBCHCDab023985
	for <selinux@tycho.nsa.gov>; Wed, 12 Dec 2012 12:12:14 -0500
Message-ID: <1355332292.3527.48.camel@localhost>
Subject: Re: [PATCH v10] LSM: Multiple concurrent LSMs
From: Eric Paris <eparis@redhat.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        john.johansen@canonical.com, keescook@chromium.org
Date: Wed, 12 Dec 2012 12:11:32 -0500
In-Reply-To: <50C8B919.2060102@schaufler-ca.com>
References: <50C65DE2.5090909@schaufler-ca.com>
	   <201212112128.ADI26010.OQJVLOFSOFtHMF@I-love.SAKURA.ne.jp>
	   <50C751D3.60409@schaufler-ca.com>
	   <201212122159.CEC09839.HMOFtQFLJSVFOO@I-love.SAKURA.ne.jp>
	   <50C8A757.3050907@schaufler-ca.com> <1355327754.3527.37.camel@localhost>
	  <50C8AFD1.1070905@schaufler-ca.com> <1355330026.3527.44.camel@localhost>
	 <50C8B919.2060102@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-12-12 at 09:04 -0800, Casey Schaufler wrote:
> On 12/12/2012 8:33 AM, Eric Paris wrote:

> Yes, thank you.
> 
> I'm headed in what I hope is a simpler direction. I have added
> two files into securityfs:
> 
> 	/sys/kernel/security/lsm     - a comma separated list of LSMs
> 	/sys/kernel/security/present - the presented LSM
> 
> I have also added LSM identified files in /proc/.../attr:
> 
> 	/proc/.../attr/current
> 	/proc/.../attr/selinux.current
> 	/proc/.../attr/apparmor.current
> 	/proc/.../attr/keycreate
> 	/proc/.../attr/selinux.keycreate
> 
> SELinux applications and libraries can use simple logic to determine
> what to do:
> 
> 	if /sys/kernel/security/lsm does not contain "selinux"
> 		Stop! No SELinux here!
> 	if /sys/kernel/security/present does not contain "selinux"
> 		Use selinux.current
> 	else
> 		Use current if you like.

So if I use legacy tools for SELinux and Apparmor with a stacking
kernel, they will both load policy and get things started.  How would a
legacy userspace know not to load it?  But then they will both
use /proc/self/attr/current even though only one of them owns it.  So we
get this half and half where one of them is enforcing a policy, but it
can't actually really work...  Maybe we just don't care.  I'm ok with
that answer.  If you don't update userspace, don't build your kernel
that way   :)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
