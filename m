Subject: Re: A couple of patches to setfiles.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1097000679.3878.132.camel@moss-spartans.epoch.ncsc.mil>
References: <415E9107.4030900@redhat.com>
	 <1097000679.3878.132.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1097001163.3878.134.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 05 Oct 2004 14:32:43 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-10-05 at 14:24, Stephen Smalley wrote:
> You want to log always?  Should be based on an option, like the existing
> verbose option, and you likely only want to log if !only_changed_user as
> with the verbose case.

Actually, there is already a -o option to log to a specified file.  Why
add syslog calls as well?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
