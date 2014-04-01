From: "Kim Lawson-Jenkins" <kim.lawson-jenkins@nrl.navy.mil>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
References: <026a01cf4db2$9524fb60$bf6ef220$@nrl.navy.mil>
 <533AD77B.3070107@tycho.nsa.gov>
In-Reply-To: <533AD77B.3070107@tycho.nsa.gov>
Subject: RE: Labelling problems with a user directly running an application in
 a confined domain
Date: Tue, 1 Apr 2014 13:04:14 -0400
Message-ID: <02a201cf4dcc$692b5b70$3b821250$@nrl.navy.mil>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Reply-To: kim.lawson-jenkins@nrl.navy.mil
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Steven,

Here's the output of semanage user -l

SELinux User                SELinux Roles
appuser_u                   appuser_r
confinedapp_u          user_r, system_r
root                                staff_r, sysadm_r, system_r,
unconfined_r
staff_u                          staff_r, sysadm_r, system_r, unconfined_r
sysadm_u                    sysadm_r
system_u                     system_r unconfined_r
user_u                           user_r


I read on a SELinux-related blog that unconfined_r should be mapped to
staff_u when removing the unconfined domain, so I didn't remove unconfined
_r for all of the SELinux users.  Should I remove unconfined_r for staff_u?

Here is the output of semanage login -l

Login Name            SELinux User
__default__           staff_u
appuser                    appuser_u
root                            staff_u
system_u                system_u

Thanks for a response.

Kim

-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Tuesday, April 01, 2014 11:13 AM
To: kim.lawson-jenkins@nrl.navy.mil; selinux@tycho.nsa.gov
Subject: Re: Labelling problems with a user directly running an application
in a confined domain

On 04/01/2014 09:59 AM, Kim Lawson-Jenkins wrote:
> Hi,
> 
>  
> 
> I'm pretty sure my questions are basic SELinux 101 but I'm having a 
> problem confining an application when a user runs the application 
> directly.  On our system I have removed the unconfined domain and 
> unconfined user.  When the system initializes the confined 
> applications run in the correct confined domains.  However, if I use 
> ssh to access the server, stop an application, and then start the 
> application again, the application will run with the label sshd_t.  I 
> haven't tried starting a confined application from a local console but 
> I'll probably encounter a similar problem.  How should I modify the 
> policy to allow a confined user to execute an application but  also 
> have the application run in the application's confined domain?

If it is running in sshd_t, that suggests a bug in your policy that
prevented sshd from transitioning into a user domain.

When you removed the unconfined domain and user, did you also update your
semanage login and semanage user mappings so that no user is still being
mapped to unconfined_u / unconfined_r?
