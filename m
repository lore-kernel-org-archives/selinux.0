Subject: Re: Proposed change to install
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <41D1A19D.8000704@redhat.com>
References: <41D00FE7.2070203@redhat.com>
	 <1104158005.15615.84.camel@moss-spartans.epoch.ncsc.mil>
	 <41D1A19D.8000704@redhat.com>
Content-Type: text/plain
Message-Id: <1104259387.21391.103.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 28 Dec 2004 13:43:07 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-12-28 at 13:10, Daniel J Walsh wrote:
> Could add check to see if matchpathcon is failing for something other 
> than EPERM, which maybe should be reported???

EACCES would be the common case, for processes that cannot read
file_contexts.  ENOENT is another possible frequent case, for files that
match no entry or match <<none>> (if we change matchpathcon to return -1
with errno ENOENT for that case).  The only other error (and the only
one worth reporting) might be ENOMEM for memory allocation failures.

> Sounds good, that way we don't need to check.

Or check for ENOENT and ignore the error in that case.  That is likely
what we will want for restorecon once matchpathcon handles <<none>>
internally.

> +static int setdefaultfilecon(const char *path) {

Might as well make this void and not return any error code as the caller
doesn't use it anyway.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
