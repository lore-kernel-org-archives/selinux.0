Subject: Re: Added is_context_configurable function
From: Colin Walters <walters@redhat.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1105539555.22495.28.camel@moss-spartans.epoch.ncsc.mil>
References: <41E2FEF4.5070604@redhat.com>
	 <1105456934.20566.52.camel@moss-spartans.epoch.ncsc.mil>
	 <41E3FAF4.2060109@redhat.com>
	 <1105473610.20566.123.camel@moss-spartans.epoch.ncsc.mil>
	 <1105481440.24748.22.camel@nexus.verbum.private>
	 <1105539555.22495.28.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 12 Jan 2005 10:48:03 -0500
Message-Id: <1105544883.10150.17.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-01-12 at 09:19 -0500, Stephen Smalley wrote:
> On Tue, 2005-01-11 at 17:10, Colin Walters wrote:
> > I've said this before, but I don't like the idea of having to edit
> > file_contexts whenever I want to change the labels.  I feel that the 
> > on-disk version should be canonical, and the file_contexts only used for
> > system initialization.
> 
> That is also my view.  However, if people are going to run setfiles or
> restorecon at runtime to check or set contexts (which is current
> practice in Fedora), then we do need a way to distinguish legitimate
> customizations from what are essentially bugs in the policy 

Right.

> Two questions:
> 1) Is it sufficient to identify legitimate customizations based solely
> on the TE type of the file?  

Actually, thinking about this a bit: probably not.  On my system I have
several times changed the SELinux user identity component of file
contexts from the default system_u to e.g. foo_u.  The reason is that
the constraints prevent a user from relabeling a file unless the SELinux
user matches.  So a list of alternate types would not be sufficient in
this case.

> If not, what other information should be
> taken into account, irrespective of whether this is done via
> file_contexts or via a different config file?

It seems the SELinux uid, for one.  Also perhaps whether or not the
pathname is part of the standard filesystem.  There seems to me to be a
difference between a very well known file such as /etc/shadow being
mislabeled according to file_contexts versus an unknown path such
as /apps/web/blah.

> 2) Is it feasible for the policy writer to identify all such TE types a
> priori in the policy without covering such a large set as to make
> setfiles/restorecon completely useless by default?

My intuition is yes.  I think there's a clear difference between types
such as httpd_staff_script_ro_t and dhcpd_var_run_t.  The latter is very
much like an implementation detail, something sysadmins generally should
never have to change.  Dan identified a reasonable starting set in his
initial patch.

>  If not, what
> mechanism will be provided to allow users/admins to easily mark
> additional types without conflicting with future policy updates?

Hmm.  This seems to me to be another instance of the whole general
problem of maintaining a policy source delta.  Right now we essentially
don't support it.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
