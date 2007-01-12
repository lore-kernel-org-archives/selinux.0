Subject: Re: patch for semanage.8
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200701111742.14991.russell@coker.com.au>
References: <200701111742.14991.russell@coker.com.au>
Content-Type: text/plain
Date: Fri, 12 Jan 2007 10:00:19 -0500
Message-Id: <1168614019.7993.483.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-01-11 at 17:42 +1100, Russell Coker wrote:
> The attached patch makes the man page more closely match semanage --help.  
> This is against the latest version in Debian, I haven't checked whether it's 
> needed in rawhide.

Doesn't apply upstream.  Looks like the first hunk is already applied,
the second hunk is not but won't apply cleanly, and the last hunk
contains duplicate information (-P,--prefix already documented at least
in the upstream man page, but prior to -s,--seuser).

Mostly though we just need corrected and expanded examples of usage
IMHO.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
