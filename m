Subject: Re: [PATCH] Add users.fc to policy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
   Russell Coker <russell@coker.com.au>
In-Reply-To: <1074879269.4931.116.camel@moss-spartans.epoch.ncsc.mil>
References: <1074878849.27824.211.camel@colossus.columbia.tresys.com>
	 <1074879269.4931.116.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1074880210.4931.131.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 23 Jan 2004 12:50:11 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-01-23 at 12:34, Stephen Smalley wrote:
> If you look at Dan's policy RPM (as well as our sourceforge CVS tree),
> you'll see that the user entries for non-user_r users are now generated
> automatically via a script.  The /root entries are still in the base .fc
> files, since they are static, but the jadmin example entries have been
> removed and if any staff user listed in policy/users will automatically
> have appropriate entries created when file_contexts is built.

Also, note that there are user home directory entries in some of the
program .fc files, e.g. for files related to specific programs that have
their own type such as $HOME/.ssh and $HOME/.gnupg.  Dan's script
handles these entries as well for staff users, while letting the default
type stay in the program .fc file.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
