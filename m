Subject: Re: [Patch 2/2 v7] libsemanage: maintain disable dontaudit state
 between handle commits
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Christopher Pardy <cpardy@redhat.com>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <1246990657.28321.282.camel@moss-pluto.epoch.ncsc.mil>
References: <4A5386C0.8070802@redhat.com>
	 <1246989452.28321.277.camel@moss-pluto.epoch.ncsc.mil>
	 <1246990001.28321.281.camel@moss-pluto.epoch.ncsc.mil>
	 <1246990657.28321.282.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 07 Jul 2009 14:32:14 -0400
Message-Id: <1246991534.28321.283.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-07-07 at 14:17 -0400, Stephen Smalley wrote:
> On Tue, 2009-07-07 at 14:06 -0400, Stephen Smalley wrote:
> > On Tue, 2009-07-07 at 13:57 -0400, Stephen Smalley wrote:
> > > On Tue, 2009-07-07 at 13:32 -0400, Christopher Pardy wrote:
> > > > Currently any changes made to the policy which require committing a handle cause dontaudit rules to be re-enabled. This is confusing, and frustrating for users who want to edit policy with dontaudit rules turned off. This patch allows semanage to remember the last state of the dontaudit rules and apply them as default whenever a handle is connected. Additionally other functions may check for the file semanage creates to determine if dontaudit rules are turned on. This knowledge can be useful for tools like SETroubleshoot which may want to change their behavior depending on the state of the dontaudit rules. In the event that a the file cannot be created a call to commit will fail.
> > > >    
> > > > Signed-off-by: Christopher Pardy <cpardy@redhat.com>
> > > 
> > > Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
> > > 
> > > I'll fix up the duplicate diff (you have a spelling correction that was
> > > already committed) and clean up a couple of minor things when I commit
> > > it along with the libsepol and semodule patches.
> > 
> > Oops.  I made a mistake - semanage_fname() is only the file suffix.
> > I'll switch it to use semanage_path(SEMANAGE_TMP,
> > SEMANAGE_DISABLE_DONTAUDIT).
> 
> Final version of the patch.

Merged in libsepol 2.0.37, libsemanage 2.0.33, and policycoreutils 2.0.67.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
