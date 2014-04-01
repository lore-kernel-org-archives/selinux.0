Message-ID: <533AF23E.5070809@tycho.nsa.gov>
Date: Tue, 01 Apr 2014 13:07:10 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: kim.lawson-jenkins@nrl.navy.mil, selinux@tycho.nsa.gov
Subject: Re: Labelling problems with a user directly running an application
 in a confined domain
References: <026a01cf4db2$9524fb60$bf6ef220$@nrl.navy.mil>
 <533AD77B.3070107@tycho.nsa.gov>
 <02a201cf4dcc$692b5b70$3b821250$@nrl.navy.mil>
In-Reply-To: <02a201cf4dcc$692b5b70$3b821250$@nrl.navy.mil>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

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
> staff_u when removing the unconfined domain, so I didn't remove unconfined
> _r for all of the SELinux users.  Should I remove unconfined_r for staff_u?

That doesn't make sense.  Can you cite this blog?

> Here is the output of semanage login -l
> 
> Login Name            SELinux User
> __default__           staff_u
> appuser                    appuser_u
> root                            staff_u
> system_u                system_u
> 
> Thanks for a response.

I expect you would need to update or remove all references to
unconfined_u, unconfined_r, and unconfined_t from your semanage
login/user mappings and from any of the
/etc/selinux/$SELINUXTYPE/contexts files before deleting the unconfined
module.

Is there a reason you aren't just using the mls policy if you want to
avoid the unconfined module?
