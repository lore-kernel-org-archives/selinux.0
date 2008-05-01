Subject: Re: [RFC][PATCH v2] selinux: support deferred mapping of contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@parisplace.org>
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <7e0fb38c0805010746r4e43b640h1eee1b542763b022@mail.gmail.com>
References: <1209588984.25678.389.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.64.0805010853300.2731@us.intercode.com.au>
	 <1209639872.25678.409.camel@moss-spartans.epoch.ncsc.mil>
	 <1209642084.25678.418.camel@moss-spartans.epoch.ncsc.mil>
	 <7e0fb38c0805010746r4e43b640h1eee1b542763b022@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 01 May 2008 11:01:01 -0400
Message-Id: <1209654061.25678.467.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-05-01 at 10:46 -0400, Eric Paris wrote:
> On Thu, May 1, 2008 at 7:41 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >
> >
> >  On Thu, 2008-05-01 at 07:04 -0400, Stephen Smalley wrote:
> >  > On Thu, 2008-05-01 at 09:06 +1000, James Morris wrote:
> >  > > On Wed, 30 Apr 2008, Stephen Smalley wrote:
> >  > >
> >  > > > As discussed in:
> >  > > > http://marc.info/?t=120837952900003&r=1&w=2
> >  > > > the ability to permit package managers and similar programs to set down
> >  > > > unknown file contexts is still desired/required, not only for putting
> >  > > > policy modules in packages but also for enabling build systems to create
> >  > > > images of different distro releases with different policies w/o
> >  > > > requiring all of the types to be defined in the build host policy.
> >  > > >
> >  > >
> >  > > Does this solve all known issues for this case?  e.g. what if a script
> >  > > needs to be run by RPM on a file it just created ?  Does that ever happen?
> >  >
> >  > If required, I believe that can be addressed by allowing rpm_script_t
> >  > the ability to execute (along with create, read, and write) an
> >  > unlabeled_t file.  And note that this only happens when the file's type
> >  > is only defined by the policy module within the package itself (for
> >  > policy-modules-in-packages) or when the file's type is not defined by
> >  > the build host's policy (for buildsys), whereas the most common
> >  > executable types are all defined in the base policy and will typically
> >  > be present in the build host policy as well.
> >  >
> >  > It isn't a perfectly general solution, of course.
> >  >
> >  > An alternative approach would be for rpm to load policy at least
> >  > defining the types first before setting down the files, which was our
> >  > original preference, but that wasn't viewed as workable by the distro
> >  > folks.  It might be easier if we had a specific SELinux kernel interface
> >  > (i.e. another selinuxfs node) that permitted adding types w/o performing
> >  > a complete policy reload.
> >
> >  ...except that adding new types affects attributes, and attribute
> >  expansion still happens in part in userspace (e.g. for file_type
> >  -shadow_t expressions), and attributes aren't preserved in the kernel's
> >  types symtab.  So it isn't straightforward to support such direct
> >  additions at the kernel interface presently.
> 
> In the case of adding types merely for the purposes of having them
> defined but not including any allow rules around them I don't see this
> an issue.  Is there a problem with 'lightweight' types which you can
> push in via some new mechanism but which are basically useless for
> anything other than validation of existence?  If you want a real type
> with allow rules you have to load it in a real policy load?
> 
> Just not sure attribute expansion has to stop this line of thought.
> Although the original patch does seem to solve all the problems in a
> manor that requires a lot less changes everywhere else.

We need more than validation of existence in order for them to be useful
- we need to allow them to be associated with the filesystem type in
which they will be created, we need to allow rpm's domain to be able to
create and access them, etc.  Which would fall out naturally if we can
push them along with attribute declarations (e.g. file_type) that would
automatically expand in existing allow rules to permit association and
access to occur.  We are perhaps halfway there already since we do
preserve allow rules in attribute form in the kernel in policy.20 and
later, but only in the simplest case (e.g. allow rpm_t file_type:file
all_file_perms; gets pushed down directly without requiring userland
expansion, but allow rpm_t { file_type -specialprotectedtype }:file
all_file_perms; is still preexpanded by the policy toolchain).  But we
don't (yet) preserve the attribute names in the kernel symtabs.  I would
like to introduce that support as well, but it doesn't solve the entire
problem, see below.

Independent of the type definition issue, there is the mcs vs. mls or
non-mls/mcs vs mls/mcs cases to consider for buildsys, which is even
more complex than being able to define a type - now we have to deal with
additional or missing context fields altogether.

So I think the ability to set down a completely uninterpreted label is
likely needed here, which is what the current patch supports.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
