Subject: Re: Fwd: adding a new security class
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Xavier Toth <txtoth@gmail.com>
Cc: SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <cadfc0e40804170855q25d3e24fw61fa1a45b874c98@mail.gmail.com>
References: <cadfc0e40804161540u2c8796dcr99f67dc7c1aba33d@mail.gmail.com>
	 <48073FC6.6040908@redhat.com>
	 <cadfc0e40804170600g610fb3fdy2f7f416d4d7849ff@mail.gmail.com>
	 <1208438080.18883.361.camel@moss-spartans.epoch.ncsc.mil>
	 <cadfc0e40804170720q56eb623bn22dc7b7af31f671c@mail.gmail.com>
	 <1208442613.18883.386.camel@moss-spartans.epoch.ncsc.mil>
	 <cadfc0e40804170822n2ff34af1lcc92aa2c0a1cfff2@mail.gmail.com>
	 <1208446196.18883.394.camel@moss-spartans.epoch.ncsc.mil>
	 <cadfc0e40804170855q25d3e24fw61fa1a45b874c98@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 17 Apr 2008 11:59:03 -0400
Message-Id: <1208447943.18883.396.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-04-17 at 10:55 -0500, Xavier Toth wrote:
> I installed the corresponding selinux-policy-devel rpm. I see
> references to my class in
> /usr/share/selinux/devel/include/support/all_perms.spt Any other ideas
> on what to look at?

(don't top-post, and don't trim the cc list, please)

At this point I need to see a copy of the .te file and the precise
output from the failed build.

> On Thu, Apr 17, 2008 at 10:29 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >
> >  On Thu, 2008-04-17 at 10:22 -0500, Xavier Toth wrote:
> >  > I appended the class declaration to the security_classes files.
> >  >
> >  > I have installed the new policy and libselinux. However now when
> >  > trying to use this new class in a te file the build fails with an
> >  > 'unknown class' error. Do I need to rebuild any other packages before
> >  > I can use this class? I tried rebuilding checkpolicy but that didn't
> >  > help.
> >
> >  Rebuilding checkpolicy isn't necessary.  In fact, you don't even really
> >  need the rebuilt libselinux if using the dynamic object class/permission
> >  discovery support, since that will map the class and permission strings
> >  to values via the kernel's selinuxfs interface.
> >
> >  I'm guessing that you are trying to build a policy module using the
> >  policy headers provided by the Fedora policy rather than the ones
> >  provided by your rebuilt policy, and those headers lack the new
> >  definitions.
> >
> >
> >  >
> >  > On Thu, Apr 17, 2008 at 9:30 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >  > >
> >  > >  On Thu, 2008-04-17 at 09:20 -0500, Xavier Toth wrote:
> >  > >  > If the new security class is a userspace object manager related class
> >  > >  > do I still need to rebuild the kernel?
> >  > >
> >  > >  No.  You should find that the regenerated kernel headers are no
> >  > >  different, as they no longer include userspace classes (if annotated as
> >  > >  such in the security_classes file).
> >  > >
> >  > >  I assume though that you are adding your new class to the end of the
> >  > >  security_classes list.  Inserting a class before an existing one can
> >  > >  perturb the values of the existing classes, which isn't a good idea
> >  > >  (forbidden for kernel classes and any userspace object managers that use
> >  > >  the old libselinux API; permissible for new userspace object classes
> >  > >  when they use the dynamic class/permission discovery support but can
> >  > >  still break running applications until we have support for remapping
> >  > >  upon reload there).
> >  > >
> >  > >  --
> >  > >
> >  > >
> >  > > Stephen Smalley
> >  > >  National Security Agency
> >  > >
> >  > >
> >  --
> >
> >
> > Stephen Smalley
> >  National Security Agency
> >
> >
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
