Subject: Re: setsebool and togglesebool patch
From: Karl MacMillan <kmacmillan@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Fri, 05 Nov 2004 13:23:29 -0500
Message-Id: <1099679009.20150.150.camel@pham.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This was truncated by the list mail server - full message below.

Karl

-------- Forwarded Message --------
> From: Karl MacMillan <kmacmillan@tresys.com>
> To: Steve G <linux_4ever@yahoo.com>
> Cc: SELinux List <SELinux@tycho.nsa.gov>
> Subject: Re: setsebool and togglesebool patch
> Date: Fri, 05 Nov 2004 10:20:19 -0500
> On Thu, 2004-11-04 at 11:41 -0800, Steve G wrote:
> > Hi,
> > 
> > I've been reviewing the tools distributed in Fedora and have a patch that makes a
> > few changes. Booleans have a transaction-like interface. But the tools do not do
> > a rollback if they blow up in the middle of something. For example, suppose I
> > type in a list of 4 apache booleans I want to toggle, but make a typo in one. 3
> > of them will get set. Until I correct it, apache would be running with one bool
> > in the opposite state.
> > 
> > Also, setsebool is used by scripts to set the state of a boolean to a particular
> > value. As its stands, it is not done in a transactional way because it does not
> > take a list of name/value pairs. So, there can be a race as parts of a program
> > get the boolean changed.
> > 
> 
> Unfortunately, this race isn't avoided entirely with your approach -
> there is no guarantee that only one instance of the tools is running and
> of course other processes can be toggling the booleans directly
> via /selinux. Even if two processes are changing orthogonal booleans, a
> commit by one of the processes in the middle of the other's transaction
> can cause an inconsistent state.
> 
> The full solution seems to require a locking scheme in the tools and
> policy that only allows changing of booleans by the tools. This policy
> could be:
> 
> 1) only giving the domain for the tools the security.setbool permission.
> 2) making the tools a user-space object manager that enforces the fine-
> grained permissions on setting booleans.
> 3) controlling setting booleans by other domains through
> execute/type_transition for the tools and permissions on the boolean
> files.
> 
> This puts a lot of trust in the tools - they would be enforcing the
> permissions on changing individual bools, which like all policy changes
> is a powerful privilege.
> 
> > Also, an audit record is written by the kernel saying ALL the current values
> > during a commit, but you don't have a good way of seeing only the changes that
> > were made by a user.
> > 
> 
> This was a deliberate design choice to make certain that determining the
> state of all of the policy booleans didn't require more than one log
> message. Otherwise, it would not really be possible to determine the
> overall state (especially because the policy load message doesn't print
> the state of the booleans). It seems more important to know that overall
> state, but I agree that this is sometimes not what you want. Your
> approach of logging from userspace tools is probably sufficient, but of
> course it only works if the tools are used (ignoring the suggestions
> above). Maybe the kernel could print out both what changed and the
> current state.
> 
> 
> > I've attempted to fix these issues with the attached patch.
> > 
> > togglesebool is updated to do the following:
> > 
> > * It is now all or nothing. Meaning that it toggles all booleans passed or 
> > none at all.
> > * It logs to syslog what was done and by whom.
> > 
> 
> Whom means linux username, SELinux username, process type, a
> combination?
> 
> > In order to make the rollback code simple, I needed a change to src/booleans.c  
> > so that it would reject anything except 0 or 1.
> > 
> > setsebool had more changes. Rather than review the patch, you might apply it and
> > then review the resulting code. setsebool is used by a configuration 
> > tool to write all booleans to memory. The config tool then writes them to disk. 
> > So, it was updated to do the following:
> > 
> > * It now takes lists of booleans and treats them in an all or nothing manner. 
> > All get set or none at all.
> > * It takes a -P option to tell it to write the configuration to disk
> 
> Does this mean the policy or the boolean configuration? This gives these
> tools a lot of power that wasn't there before. You are essentially
> requiring that setsebool have permission to change any bool, or if you
> are writing the policy to disk permission to change anything. Also, is
> there a corresponding policy for the new tool variants? Before they
> intentionally ran in the callers domain to naturally let the ability to
> change bools be governed by the calling domain. Now, unless some policy
> is written for setsebool, all of the calling domains would need to be
> given permission to change the config file and/or policy (and therefore
> any bool).
> 
> > * It logs to syslog what was changed and by whom.
> > * Preserves the old syntax. Scripts using it as 'setsebool bool value' will 
> > continue to work.
> > 
> > I also updated all affected man pages to document the new syntax.
> > 
> 
> This is work that needs to be done and I'm glad that you are tackling
> it. Unfortunately, it seems to me that the full solution requires some
> more engineering.
> 
> Karl
> 
> > Thanks,
> > -Steve Grubb
> > 
> > 
> > 		
> > __________________________________ 
> > Do you Yahoo!? 
> > Check out the new Yahoo! Front Page. 
> > www.yahoo.com 
> > 
-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
