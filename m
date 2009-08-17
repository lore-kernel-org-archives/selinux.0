Subject: Re: Not quite MLS.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: rob myers <rob.myers@gtri.gatech.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1250285426.3588.87.camel@rxm-581b.stl.gtri.gatech.edu>
References: <1250285426.3588.87.camel@rxm-581b.stl.gtri.gatech.edu>
Content-Type: text/plain
Date: Mon, 17 Aug 2009 07:40:52 -0400
Message-Id: <1250509252.3629.84.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-08-14 at 17:30 -0400, rob myers wrote:
> I would like to create a login that has access to one category at the
> highest sensitivity level, but in another category only has access at a
> lower sensitivity level.  For example, on a system where SystemHigh is
> s0-s3:c0.c3, one login could be defined as something similar to:
> s0-s1:c0.c3, s2:c2.c3, s3:c3, while another login could be defined as
> s0-s2:c0.c3, s3:c0.c2 .
> 
> Am I correct that MLS policy cannot support this scenario?
> 
> Is this possible under any old, current, or developmental SELinux
> policy?
> 
> Would it be possible to write such a policy with the existing SELinux
> user/kernel land?
> 
> Thanks for any pointers,

I'm not clear on what you are trying to achieve, but I think the answer
is that you would have to modify at least the userland and possibly the
kernel logic for what you describe.

At present, the kernel policy configuration specifies a default level
and a (single) range for each SELinux user identity defined in the
policy.  It also defines what categories can be associated with what
sensitivities, so that you could specify that e.g. c3 can only ever be
associated with s3, although the current refpolicy merely automatically
generates a list of all categories for each sensitivity.

The userland configuration specifies a SELinux user and a (single) range
for each Linux user / login.  That range has to be a subset of the one
authorized for the SELinux user.  That lets you specify subranges for
individual Linux users without having to define each of them within the
kernel policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
