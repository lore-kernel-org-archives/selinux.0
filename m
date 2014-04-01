From: "Kim Lawson-Jenkins" <kim.lawson-jenkins@nrl.navy.mil>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
References: <026a01cf4db2$9524fb60$bf6ef220$@nrl.navy.mil>
 <533AD77B.3070107@tycho.nsa.gov>
 <02a201cf4dcc$692b5b70$3b821250$@nrl.navy.mil>
 <533AF23E.5070809@tycho.nsa.gov>
In-Reply-To: <533AF23E.5070809@tycho.nsa.gov>
Subject: RE: Labelling problems with a user directly running an application in
 a confined domain
Date: Tue, 1 Apr 2014 13:42:06 -0400
Message-ID: <02a801cf4dd1$b31e3a40$195aaec0$@nrl.navy.mil>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Reply-To: kim.lawson-jenkins@nrl.navy.mil
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Stephen,

See answers below...

-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Tuesday, April 01, 2014 1:07 PM
To: kim.lawson-jenkins@nrl.navy.mil; selinux@tycho.nsa.gov
Subject: Re: Labelling problems with a user directly running an application
in a confined domain

On 04/01/2014 01:04 PM, Kim Lawson-Jenkins wrote:
> Steven,
> 
> Here's the output of semanage user -l
> 
> SELinux User                SELinux Roles
> appuser_u                   appuser_r
> confinedapp_u          user_r, system_r
> root                                staff_r, sysadm_r, system_r,
> unconfined_r
> staff_u                          staff_r, sysadm_r, system_r, unconfined_r
> sysadm_u                    sysadm_r
> system_u                     system_r unconfined_r
> user_u                           user_r
> 
> 
> I read on a SELinux-related blog that unconfined_r should be mapped to 
> staff_u when removing the unconfined domain, so I didn't remove 
> unconfined _r for all of the SELinux users.  Should I remove unconfined_r
for staff_u?

That doesn't make sense.  Can you cite this blog?

http://selinux-mac.blogspot.com/2009/06/selinux-lockdown-part-eight-unconfin
ed.html  



> Here is the output of semanage login -l
> 
> Login Name            SELinux User
> __default__           staff_u
> appuser                    appuser_u
> root                            staff_u
> system_u                system_u
> 
> Thanks for a response.

I expect you would need to update or remove all references to unconfined_u,
unconfined_r, and unconfined_t from your semanage login/user mappings and
from any of the /etc/selinux/$SELINUXTYPE/contexts files before deleting the
unconfined module.

Is there a reason you aren't just using the mls policy if you want to avoid
the unconfined module?

Kim's response - I'm updating a policy for an application that ran on RHEL5
using the then-supported strict policy.  I read that removing the unconfined
domain will make the newer systems operate as the old strict policy, so I
went with this method for updating the policy.  I hadn't heard about using
mls as an alternative to removing the unconfined module.
