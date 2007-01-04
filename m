Subject: Re: Policycoreutils patches
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <1167928118.18961.81.camel@moss-spartans.epoch.ncsc.mil>
References: <459BF062.4050107@redhat.com>
	 <1167928118.18961.81.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 04 Jan 2007 11:49:54 -0500
Message-Id: <1167929394.18961.86.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-01-04 at 11:28 -0500, Stephen Smalley wrote:
> On Wed, 2007-01-03 at 13:05 -0500, Daniel J Walsh wrote:
> > Bunch of patches separated so you can approve/deny them separately.
> > 
> > avc patch Removes optional_policy name from audit2allow
> > 
> > pyver patch removes hardcoding of python version from makefile.  Will 
> > use version of installed python version.
> > 
> > newrole patch to use O_RDWR for terminals to fix more problem.
> > 
> > fixfiles patch fixes a problem with fixfiles was writing "not a tty" to 
> > the current directory when there was no terminal.
> > 
> > seobject patch is somewhat more controversial, but at least parts of it 
> > should be accepted.
> > 
> > - Fixes translation of portions of security context.
> > - Get rid of excess "\n"
> > - Restart mcstrans to relize file changed.
> > - Verify prefix is valid
> > - Modify roles correctly, currently role removal does not work without 
> > this fix.
> 
> One patch per message is better for review and processing.
> 
> I don't think the fixfiles patch does what you think ($1 is the first
> argument, not the exit status of the prior command).
> 
> newrole patch was already acked by Karl, not sure why it hasn't been
> merged.
> 
> I had thought that there was some discussion of generalizing the
> mcstrans restart to a generic pre/post scriptlet
> facility.  /sbin/service and mcstrans are fairly distro-specific, right?
> At least wrap it with some script installed as part of policycoreutils,
> with a default one that does nothing, and then Fedora can ship one that
> does /sbin/service mcstrans restart.
> 
> prefix validity check would ideally happen in libsemanage using
> libsepol; we'd like to avoid making assumptions in seobject about
> particular context values.

Merged everything except for the fixfiles patch and the seobject patch.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
