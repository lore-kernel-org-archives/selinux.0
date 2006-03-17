Subject: Re: Bug in the semanage user management code or genhomedircon?
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20060317071114.GA7357@thorium.jmh.mhn.de>
References: <20060316204512.GB30979@hydrogenium.cip.ifi.lmu.de>
	 <4419E07F.4090508@cornell.edu>  <20060317071114.GA7357@thorium.jmh.mhn.de>
Content-Type: text/plain
Date: Fri, 17 Mar 2006 07:46:46 -0500
Message-Id: <1142599606.14284.89.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-03-17 at 08:11 +0100, Thomas Bleher wrote:
> * Ivan Gyurdiev <ivg2@cornell.edu> [2006-03-16 23:53]:
> > 
> > >What am I doing wrong?
> > >  
> > Can you let me know what you see with the following policycoreutils 
> > patch, when you try the same thing (do semanage user -l, should show the 
> > labeling prefix for each user).
> 
> OK, this seems to show the problem:
> # semanage user -l
> 
>                 Labeling   MLS/       MLS/
> SELinux User    Prefix     MCS Level  MCS Range                      SELinux Roles
> 
> root            user       s0         s0-s0:c0.c255                  system_r sysadm_r staff_r
> staff_u         user       s0         s0-s0:c0.c255                  sysadm_r staff_r
> sysadm_u        user       s0         s0-s0:c0.c255                  sysadm_r
> system_u        user       s0         s0-s0:c0.c255                  system_r
> user_u          user       s0         s0                             user_r
> 
> Where is the labeling prefix set? Or better, where can I change it?

It is supplied by an auxiliary file, users_extra, that is now an
optional part of the policy module package format, to provide an
explicit mapping from SELinux users to labeling prefixes.  The original
genhomedircon was (improperly) making assumptions about the significance
of the ordering of roles in the policy/users file (as that ordering had
no inherent meaning to SELinux and was lost upon policy compilation) and
naturally also required access to that source file, whereas it now uses
libsemanage to access an explicit mapping file supplied with the policy.

# cat /etc/selinux/mls/modules/active/users_extra
user user_u prefix user;
user staff_u prefix staff;
user sysadm_u prefix sysadm;
user root prefix sysadm;

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
