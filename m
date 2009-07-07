Subject: Re: [Patch 2/2 v4] libsemanage: maintain disable dontaudit state
 between handle commits
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Christopher Pardy <cpardy@redhat.com>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <4A535E80.3040502@redhat.com>
References: <4A4B656D.1030004@redhat.com>  <4A4B874E.8020402@redhat.com>
	 <1246467842.13464.192.camel@moss-pluto.epoch.ncsc.mil>
	 <4A4B9FA8.1040606@redhat.com> <4A4C168C.2040900@redhat.com>
	 <4A4C17D1.3060208@redhat.com>
	 <1246538797.13464.277.camel@moss-pluto.epoch.ncsc.mil>
	 <4A4CBC6C.5090709@redhat.com>
	 <1246544004.13464.299.camel@moss-pluto.epoch.ncsc.mil>
	 <4A4CC469.3050805@redhat.com>
	 <1246545328.13464.317.camel@moss-pluto.epoch.ncsc.mil>
	 <4A4CD320.2090706@redhat.com>
	 <1246554554.13464.356.camel@moss-pluto.epoch.ncsc.mil>
	 <4A51ED89.8010001@redhat.com>  <4A51EEA5.4070802@redhat.com>
	 <1246888018.28321.23.camel@moss-pluto.epoch.ncsc.mil>
	 <1246888326.28321.26.camel@moss-pluto.epoch.ncsc.mil>
	 <4A520D47.4040708@redhat.com> <4A52100C.3010302@redhat.com>
	 <4A523652.2040603@redhat.com> <4A524C27.7020601@redhat.com>
	 <4A535240.1000900@redhat.com>
	 <1246976446.28321.228.camel@moss-pluto.epoch.ncsc.mil>
	 <4A535E80.3040502@redhat.com>
Content-Type: text/plain
Date: Tue, 07 Jul 2009 10:53:25 -0400
Message-Id: <1246978405.28321.241.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-07-07 at 10:41 -0400, Christopher Pardy wrote:
> On 07/07/2009 10:20 AM, Stephen Smalley wrote:
> > On Tue, 2009-07-07 at 09:48 -0400, Christopher Pardy wrote:
> >> Currently any changes made to the policy which require committing a handle cause dontaudit rules to be disabled. This is confusing, and frustrating for users who want to edit policy with dontaudit rules turned off. This patch allows semanage to remember the last state of the dontaudit rules and apply them as default whenever a handle is created. Additionally other functions may check for the file semanage creates to determine if dontaudit rules are turned on. This knowledge can be useful for tools like SETroubleshoot which may want to change their behavior depending on the state of the dontaudit rules. In the event that a the file cannot be created the dontaudit rules dont change and errors are set.
> >>  
> >> Signed-off-by: Christopher Pardy <cpardy@redhat.com>
> > 
> > As before:
> > 1.  Move the logic to initialize the flag from semanage_handle_create()
> > to semanage_direct_connect() after the semanage_access_check() call.
> > 2.  Justify why we need to call set_disable_dontaudit_flag() from
> > semanage_commit() - it should have been initialized upon connect and can
> > only change upon semanage_set_disable_dontaudit() and thus should
> > already be correct.  If we truly do need it, move to
> > semanage_direct_commit(), but explain why first please - I don't see the
> > rationale (better yet, test without it and demonstrate that it doesn't
> > work otherwise!).
> 
> 1. If I do that then the disable_dontaudit handle will not be
> correctly set when the handle is created and the
> semanage_get_disable_dontaudit value will be wrong. More importantly
> it may change when semanage_connect() is called. That behavior would
> be incorrect.

Why?  semanage_connect() has to be called before you first access the
file store.  No other file in the file store is even read up until that
time.  And, no, it cannot be changed before semanage_connect() is called
- that has to happen before you do anything else.

> 2. We must call set_disable_dontaudit_flag() following a commit
> because although the flag will correctly represent the changes made
> via libsemanage any changes via libsepol will not be reflected. I'll
> move this call to semanage_direct_commit().

The application doesn't get the libsepol handle and can't affect it
directly.  The libsepol handle is private to libsemanage.  It can't
happen.   Really.

You might try listening to the people who have been maintaining the code
for a long time, you know...

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
