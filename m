Subject: Re: audit2allow long options
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <43971BB4.6020408@redhat.com>
References: <1133971559.2366.40.camel@moss-spartans.epoch.ncsc.mil>
	 <43971BB4.6020408@redhat.com>
Content-Type: text/plain
Date: Thu, 08 Dec 2005 13:01:33 -0500
Message-Id: <1134064893.2366.268.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-12-07 at 12:28 -0500, Daniel J Walsh wrote:
> Missing comma caused the problem.
> 
> Update patch for policycoreutils to fix the problem as well as add an 
> enhanced version of chcat to allows manipulation of
> file categories.

Thanks, merged final version of chcat along with audit2allow fix and
restorecon -r support as of policycoreutils 1.29.1.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
