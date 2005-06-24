Subject: RE: Alternative user management approach
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <1119639668.12865.141.camel@moss-spartans.epoch.ncsc.mil>
References: <200506241836.j5OIaJqc018526@gotham.columbia.tresys.com>
	 <1119639668.12865.141.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 24 Jun 2005 15:21:54 -0400
Message-Id: <1119640914.31852.87.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-24 at 15:01 -0400, Stephen Smalley wrote:
> On Fri, 2005-06-24 at 14:36 -0400, Karl MacMillan wrote:
> > Which will be done by login processes through libselinux. Haven't looked, but it
> > may not even need an api change.
> 
> get_ordered_context_list(3) and friends.  login and su use
> get_ordered_context_list(3) via pam_selinux.
> Most other programs just use get_default_context(3), which is
> implemented internally via get_ordered_context_list(3), just taking the
> first one.  sshd also uses get_default_context_with_role(3) if a role
> was specified, which just takes the first one with a matching role if it
> exists.
> 
> In each case, the input is just the Linux username, and it returns the
> security context(s) to use for the user's process.  You'd have to
> internally determine the group set if you wanted to base decisions on
> that as well.

So... would this be accomplished by changing security_compute_user
to map between DAC uid and selinux uid before writing
to /selinux/user ?

Where would the remap occur...



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
