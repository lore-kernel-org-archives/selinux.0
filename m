Subject: Re: strict/targeted merge snag
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>,
        Joshua Brindle <method@manicmethod.com>
In-Reply-To: <1186073552.4015.88.camel@gorn.columbia.tresys.com>
References: <1186069401.4015.81.camel@gorn.columbia.tresys.com>
	 <46B20032.60203@redhat.com>
	 <1186073552.4015.88.camel@gorn.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 02 Aug 2007 16:11:57 -0400
Message-Id: <1186085517.2434.182.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 16:52 +0000, Christopher J. PeBenito wrote:
> On Thu, 2007-08-02 at 12:02 -0400, Daniel J Walsh wrote:
> > Christopher J. PeBenito wrote:
> > > If you're not familiar, the Reference Policy project is in the process
> > > of merging the strict and targeted policies so that they no longer are
> > > build options.  The idea behind this is that a user can incrementally
> > > confine their system until they finally arrive at what is currently
> > > considered the strict policy, without completely replacing the policy.
> > >
> > > The way it works now is that if the unconfined module is not included in
> > > the policy, the policy will be just like the strict policy now.  Once
> > > the unconfined module is inserted, the policy will be similar to the
> > > targeted policy now, with some differences.  Instead of using only one
> > > role for the entire system, the confined roles (staff_r, sysadm_r, etc)
> > > remain, and a new unconfined role is added.  This allows a mix of
> > > confined and unconfined users on the system.  A handfull of domains will
> > > also become unconfined, just like the targeted policy.
> > >
> > > The issue that I just ran into has to do with the file contexts.
> > > Currently most of the per_role_templates() have a corresponding set of
> > > file contexts with HOME_DIR as part of the file specification.  In the
> > > past, this has not been a problem since they are ifdef'ed out on the
> > > targeted policy, and the per_role_templates() are expanded for each of
> > > the user roles in the strict policy.  However, now strict and targeted
> > > are the same policy, so if you map a linux user to unconfined_u,
> > > genhomedircon expands out all of the HOME_DIR lines for unconfined, and
> > > only a couple of the contexts are valid.
> > >
> > > This will also be more of an issue going forward since additional user
> > > roles are desired, and would like the per_role_templates() to be
> > > explicitly called rather than done under the hood, so that the user
> > > roles can be specified with a subset of the available
> > > per_role_templates().
> > >
> > > Thoughts?
> > >
> > >   
> > genhomedircon now checks if the contexts are valid before assiging 
> > them.  So if it
> > thinks you need a xyz_gnome_t and the kernel says that does not exist, 
> > genhomedircon
> > throws it away.  Been that way in Fedora for a while,
> 
> Its not in the stable branch.  Also asking the kernel is not the correct
> solution if libsemanage is working on a policy thats not active.

I see calls to selinux.security_check_context() in current stable and
trunk versions of genhomedircon.  trunk actually has a slightly more
correct form, by checking first whether selinux is even enabled on the
host, although both should be using some kind of semanage->sepol
interface for such checking as you note.  Note sure what the rewrite of
genhomedircon for libsemanage does.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
