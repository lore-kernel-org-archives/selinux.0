Subject: Re: Proposed change to install
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: kwade@redhat.com
Cc: SELinux <SELinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1104246827.4370.6.camel@erato.phig.org>
References: <41D00FE7.2070203@redhat.com>
	 <1104158005.15615.84.camel@moss-spartans.epoch.ncsc.mil>
	 <1104246827.4370.6.camel@erato.phig.org>
Content-Type: text/plain
Message-Id: <1104249590.21391.56.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 28 Dec 2004 10:59:50 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-12-28 at 10:13, Karsten Wade wrote:
> OTOH, not having some error to work with makes it more difficult to
> troubleshoot, in the case where labeling is desired but the user doesn't
> have permission to label.  Something that conveys this:
> 
> "Error - labeling the file(s) foo, bar, baz failed.  Either SELinux is
> not installed, is not an option, or you do not have permissions to
> label.  If you think this is an error, contact your system
> administrator."

Not really an option when this relabeling is attempted by default and is
quite likely to fail in many cases.  If the user explicitly requested
labeling (e.g. via the existing -P or -Z options to install), then it is
reasonable and desirable to warn them upon failure.  But for a behavior
that is always enabled and has a fair likelihood of failure, such an
error message will generate far too much noise and produce more user
confusion than it will help.

Note BTW that the patch as posted was broken with respect to the
existing -P and -Z options and must at least be fixed in that regard.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
