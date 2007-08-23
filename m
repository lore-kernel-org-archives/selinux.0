Subject: Re: Question concerning building policy modules
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: jwcart2@tycho.nsa.gov, SELinux <selinux@tycho.nsa.gov>,
        Steve Smalley <sds@epoch.ncsc.mil>
In-Reply-To: <46CC8233.7020605@redhat.com>
References: <1187203804.26375.69.camel@moss-lions.epoch.ncsc.mil>
	 <46CB51E8.5020603@redhat.com>
	 <1187800281.20340.34.camel@moss-lions.epoch.ncsc.mil>
	 <46CC68D4.3070001@redhat.com>
	 <1187802068.20340.46.camel@moss-lions.epoch.ncsc.mil>
	 <46CC8233.7020605@redhat.com>
Content-Type: text/plain
Date: Thu, 23 Aug 2007 09:58:22 -0400
Message-Id: <1187877502.13874.136.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-22 at 14:36 -0400, Daniel J Walsh wrote:
> James Carter wrote:
> > On Wed, 2007-08-22 at 12:48 -0400, Daniel J Walsh wrote:
> >> James Carter wrote:
> >>> On a different note, what is the policy going to be called when the
> >>> difference between strict and targeted is only whether a certain module
> >>> is loaded or not?  Will there only be one policy package?  Or maybe
> >>> there will be policy-mcs and policy-mls packages?
> >>>
> >>>
> >> We will be shipping just targeted policy and allow you to define any
> >> types of users you want.
> >  
> > Steve tells me that the name "targeted" is not going away, since
> > libselinux uses that name as the default policy name.
> > 
> >> Removing the unconfined.pp file will remove
> >> all of the unconfined domains.  As an alternative, you can change the
> >> __default__ to a confined user type and then not allow users to login as
> >> unconfined users.  (I find this much more interesting.)
> > 
> > It is.  
> > Is it working now?  I was under the impression that there were still some issues to be worked out.

I'd say its early beta quality.  I worked around the current set of
toolchain bugs/limitations, which should get fixed by policyrep.  The
issue that I hit with genhomedircon emitting entries with invalid
contexts was fixed in policycoreutils 1.34.8.

> I don't know what you mean by is is working now?  Rawhide-F8/Test1
> policy has my version of the strict/targeted merge.  It supports

Note that its a superset of what is in the refpolicy branch.

> login user types of unconfined_t, sysadm_t, staff_t, user_t as well as
> guest_t (terminal only, least priv user), and xguest_t (Xwindows Least
> Priv user, with Firefox transition)
> 
> As well as super user types logadm_t, webadm_t, auditadm_t.
> 
> I have not tried to remove the unconfined.pp to see what happens.  I
> have removed a lot of unconfined domains in this version of policy.
> (gdm, xdm, ldconfig, modutils, sshd) are all confined now.

I did a diff against the strict policy in trunk and only found one issue
which I've fixed.  The only issue I can see is if you're using ricci, as
in trunk its unconfined even in strict, and in the merged policy its
only unconfined in targeted.  Dan, can you review ricci_modcluster_t?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
