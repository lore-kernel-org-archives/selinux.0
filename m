Subject: Re: making progress...a few comments..
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: Mark Shakespeare <mshakes@llnl.gov>, SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1075391927.13803.98.camel@colossus.columbia.tresys.com>
References: <p06020408bc3db651f5a5@[128.115.96.64]>
	 <1075391927.13803.98.camel@colossus.columbia.tresys.com>
Content-Type: text/plain
Message-Id: <1075392482.21044.108.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 29 Jan 2004 11:08:02 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-01-29 at 10:58, Karl MacMillan wrote:
> If it works
> with checkpolicy, please send me the policy.conf because that version of
> seaudit should handle anything that checkpolicy does with the exception
> of the two new features that Steve just added ('-' and typealias).

Dan already added the type exclusion ('-') support to his checkpolicy
package and it is being used by his policy package to exclude shadow_t
from certain sets.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
