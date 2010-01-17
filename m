Date: Mon, 18 Jan 2010 09:53:33 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, russell@coker.com.au, amworsley@gmail.com,
        Eric Paris <eparis@parisplace.org>, Paul Moore <paul.moore@hp.com>
Subject: Re: [RFC][PATCH v3] selinux: change the handling of unknown
 classes
In-Reply-To: <1263508090.8548.79.camel@moss-pluto.epoch.ncsc.mil>
Message-ID: <alpine.LRH.2.00.1001180953120.27266@tundra.namei.org>
References: <20091218183016.9365.621.stgit@flek.lan>  <1262901683.2821.141.camel@moss-pluto.epoch.ncsc.mil>  <201001080942.33039.paul.moore@hp.com>  <1262972586.13162.47.camel@moss-pluto.epoch.ncsc.mil> <1263508090.8548.79.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 14 Jan 2010, Stephen Smalley wrote:

> Changes:
> - Handle permissive domains consistently by moving up the test for a
> permissive domain.
> - Make security_compute_av_user() consistent with security_compute_av();
> the only difference now is that security_compute_av() performs mapping
> between the kernel-private class and permission indices and the policy
> values.  In the userspace case, this mapping is handled by libselinux.
> - Moved avd_init inside the policy lock.
> 
> Based in part on a patch by Paul Moore <paul.moore@hp.com>.
> 
> Reported-by: Andrew Worsley <amworsley@gmail.com>
> Signed-off-by:  Stephen D. Smalley <sds@tycho.nsa.gov>


Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
