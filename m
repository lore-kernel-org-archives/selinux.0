Subject: Re: su and context
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ted X Toth <txtoth@gmail.com>
Cc: Michael C Thompson <thompsmc@us.ibm.com>, selinux@tycho.nsa.gov
In-Reply-To: <45D1EC89.8040902@gmail.com>
References: <45CDEDEE.4050205@gmail.com>  <45D09836.5060007@us.ibm.com>
	 <1171299200.5265.34.camel@moss-spartans.epoch.ncsc.mil>
	 <45D1EC89.8040902@gmail.com>
Content-Type: text/plain
Date: Tue, 13 Feb 2007 11:56:07 -0500
Message-Id: <1171385767.3242.73.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-13 at 10:51 -0600, Ted X Toth wrote:
> Stephen Smalley wrote:
> > On Mon, 2007-02-12 at 10:39 -0600, Michael C Thompson wrote:
> >   
> >> Ted X Toth wrote:
> >>     
> >>> Why doesn't my context change when I 'su' to a different user?
> >>>       
> >> I'm pretty sure su isn't SELinux aware like newrole is -- not 
> >> investigated the source enough to save 100%, but pretty sure.
> >>
> >> Is there a reason why you would want it to affect your context?
> >>
> >> DAC and MAC are not intended to be related I thought.
> >>     
> >
> > The behavior has actually changed over time; you'll find discussions
> > about it in the mailing list archives.  The original SELinux kept su
> > separate from security context changes.  Earlier versions of Fedora (and
> > RHEL 4) integrated them (via pam_selinux) in an effort to provide
> > greater transparency, but this caused its own set of problems (e.g. use
> > of su from init scripts, losing continuity of context across su when you
> > want it for roles and levels).  More recent versions of Fedora (and RHEL
> > 5) split them back out again.  One might add an option to su to support
> > simultaneous newrole, but you don't want it by default.
> >
> >   
> My concern was that when I su I may have a context which is invalid for 
> the user. What I was thinking was that my context should be the default 
> for the user I've su'd to as defined in default_contexts.

The Linux uid and the SELinux security context don't have to be linked
together and you generally don't want them linked except when a new
login session is created, as you want to preserve context for the
lifetime of the session.  When you su to root to perform an admin
action, you don't want to lose your level and role information and
always switch to a single role and level for root.

su'ing to a user isn't the same as logging in as that user; from an
accountability and label preservation POV, the actions should remain
traceable to (and limited by the label of) the original user.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
