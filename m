Subject: Re: Policy mods in last nights refpolicy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov, SELinux-dev@tresys.com,
   Ivan Gyurdiev <ivg2@cornell.edu>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1132148928.12540.33.camel@moss-spartans.epoch.ncsc.mil>
References: <437907D7.8090002@cornell.edu>
	 <1132054159.5415.282.camel@moss-spartans.epoch.ncsc.mil>
	 <1132055891.5415.305.camel@moss-spartans.epoch.ncsc.mil>
	 <4379E4D1.2010900@redhat.com>
	 <1132063930.5415.364.camel@moss-spartans.epoch.ncsc.mil>
	 <4379EFBE.8070202@redhat.com>  <1132069967.24234.159.camel@sgc>
	 <1132148928.12540.33.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 09:18:23 -0500
Message-Id: <1132150703.3425.14.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-11-16 at 08:48 -0500, Stephen Smalley wrote: 
> On Tue, 2005-11-15 at 10:52 -0500, Christopher J. PeBenito wrote:
> > Also, now that people are going to be using refpolicy, we're going to
> > have to start bumping the module versions in the policy_module()
> > statements when changes are made, so that modules can be upgraded
> > correctly.  Currently the modules are set to 1.0.  After a little
> > thought, it seems like it would be better if we go to x.y.z for
> > versioning: bump z for each changed module when committing to
> > sourceforge; bump y for each changed module when releasing; bump x for
> > major design changes to the module.  Does this seem like a reasonable
> > versioning scheme?
> 
> To what extent are the module-internal version numbers useful?
> Versus the usual versioning of the policy packages (in which case you
> have a single version for the base policy package plus independent
> versions for any policy modules packaged separately).  Why can't the
> versioning just be handled via rpm in the usual manner - why does
> libsemanage need to deal with ensuring that we don't upgrade to an
> "older" module version?

Just to note:  I understand the notion of having per-module version
numbers for modules that are built separately, but I'm not clear on
whether it is useful to have those version numbers as part of the module
state and checked by libsemanage versus just having them used as the
basis for the version number for the rpm package containing the module.
For example, if I build the httpd policy module as a separate package
and it has a module version of 1.1, I'd expect to use that version for
the package version (plus a release number, so httpd-policy-1.1-1), just
as we currently use the policy version number for the corresponding
policy package today.  But the policy version number (or likewise for
any other component, like the libsemanage version number) is not part of
the policy's state and is only used by the package management software.
It seems like there is potential for conflict here between libsemanage
and rpm, e.g. user runs rpm --oldpackage -Uvh httpd-policy-1.0-1, but
semodule fails due to the libsemanage checking (perhaps not if we always
do semodule -i, but you get the idea).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
