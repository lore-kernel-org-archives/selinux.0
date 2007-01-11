Subject: Re: newrole patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45A3B064.1090103@redhat.com>
References: <45A3B064.1090103@redhat.com>
Content-Type: text/plain
Date: Thu, 11 Jan 2007 12:35:16 -0500
Message-Id: <1168536916.7993.376.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-01-09 at 10:10 -0500, Daniel J Walsh wrote:
> Only uses file descriptor = 0
> 
> Reads securetty_context file for matches

Corrected version (to match the return value convention) merged in
policycoreutils 1.33.12.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
