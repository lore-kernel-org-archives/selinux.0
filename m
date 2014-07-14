Message-ID: <1405359198.661.50.camel@x220.localdomain>
Subject: Re: [RFC] Source Policy, CIL, and High Level Languages
From: Dominick Grift <dominick.grift@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Date: Mon, 14 Jul 2014 19:33:18 +0200
In-Reply-To: <53C40E8D.8070006@tycho.nsa.gov>
References: <53BD9646.6030303@tresys.com>
 <1404975079.31209.11.camel@x220.localdomain> <53C01CDD.80407@tresys.com>
 <53C409C3.3010602@tycho.nsa.gov> <53C40B13.9030907@tycho.nsa.gov>
 <53C40E8D.8070006@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: SELinux List <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2014-07-14 at 13:08 -0400, Stephen Smalley wrote:
> On 07/14/2014 12:53 PM, Stephen Smalley wrote:
> > On 07/14/2014 12:48 PM, Stephen Smalley wrote:
> >> On 07/11/2014 01:20 PM, Steve Lawrence wrote:
> >>> On 07/10/2014 02:51 AM, Dominick Grift wrote:
> >>>> On Wed, 2014-07-09 at 15:21 -0400, Steve Lawrence wrote:
> >>>>> In January, we sent an RFC [1] to update userspace to integrate CIL
> >>>>> [2] and source policy. And in April, we sent an updated RFC [3] which
> >>>>> added support for high level languages and a tool to convert policy
> >>>>> package (pp) files to CIL. After getting some good feedback, we have
> >>>>> made some more changes, mostly to maintain ABI compatibility. The
> >>>>> major changes made since the last patchset are:
> >>>>
> >>>> <snip>
> >>>>
> >>>> I just spent a few hours playing with this and i am impressed.
> >>>>
> >>>> Everything i tested just works.
> >>>>
> >>>> What did i test?
> >>>>
> >>>> 1. disabling/enabling existing modules
> >>>> 2. toggling booleans with semanage
> >>>> 3. adding and removing port and file contexts with semanage
> >>>> 4. adding/removing a policy module with semodule, checkmodule,
> >>>> semodule_package
> >>>> 5. adding/removing a (cil) policy module with semodule
> >>>> 6. associating a (new) user with staff_t identity
> >>>>
> >>>> Comments?
> >>>>
> >>>> if i do restorecon -R -v -F /home it resets contexts *every* time (from
> >>>> s0 to s0-s0). No noticable side effects because of this
> >>>>
> >>>
> >>> We recently pushed a fix to CIL that fixes the issue with how CIL
> >>> generates file contexts. It now removes the high level if it is the same
> >>> as the low level.
> >>
> >> So, if I revert my system to stock F20 (yum reinstall checkpolicy*
> >> libsepol* libsemanage* libselinux* policycoreutils*
> >> selinux-policy-targeted) , then re-install from the integration branch
> >> as per your instructions and run the migration script, then attempt to
> >> ssh into the system, sshd says "Unable to get valid context for sds" and
> >> the connection is closed.  dmesg shows:
> >> systemd[1]: SELinux policy denies access.
> >>
> >> Can you merge #next to #integration so we get the more detailed
> >> information on unknown classes/perms?
> >>
> >> I'm guessing a reboot will clear the problem again (since systemd will
> >> then remap the class from name to value at boot against the current
> >> policy).  But ideally this wouldn't be necessary.
> > 
> > Hmmm....a reboot did not clear it.  All logins, local or remote,
> > disabled for non-root.
> 
> This seems to be a labeling problem; saw denials on attempts to read
> seusers with semanage_store_t.  But restorecon -Rv /etc/selinux/targeted
> restored it to selinux_config_t.
> 

In my experience this is probably not related to the event "systemd[1]:
SELinux policy denied access."

I may be wrong but I do not believe systemd prints those messages if it
is not directly related to systemd.

SSHD (and other login programs) might be (trying to) dbus chat to
systemd logind, and systemd logind needs to be able to "start" the
session manager. (although that should not prevent the login)

So i think there are two issue here. The labeling issue, which prevents
the login, and the issue that causes systemd to print "systemd[1]:
SELinux denied access."

I might be wrong...
