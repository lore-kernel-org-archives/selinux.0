Subject: Re: [PATCH] Add users.fc to policy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
   Russell Coker <russell@coker.com.au>
In-Reply-To: <1074878849.27824.211.camel@colossus.columbia.tresys.com>
References: <1074878849.27824.211.camel@colossus.columbia.tresys.com>
Content-Type: text/plain
Message-Id: <1074879269.4931.116.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 23 Jan 2004 12:34:29 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-01-23 at 12:27, Karl MacMillan wrote:
> Attached is a patch that moves the home directory labeling information
> in the policy from file_contexts/types.fc to file_contexts/users.fc. It
> also changes the Makefile to pick up any .fc files in the file_contexts
> directory.

If you look at Dan's policy RPM (as well as our sourceforge CVS tree),
you'll see that the user entries for non-user_r users are now generated
automatically via a script.  The /root entries are still in the base .fc
files, since they are static, but the jadmin example entries have been
removed and if any staff user listed in policy/users will automatically
have appropriate entries created when file_contexts is built.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
