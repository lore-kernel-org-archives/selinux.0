Subject: Re: [Fwd: policycoreutils patches]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <461F7D36.2070602@redhat.com>
References: <461F7D36.2070602@redhat.com>
Content-Type: text/plain
Date: Tue, 24 Apr 2007 10:04:56 -0400
Message-Id: <1177423496.24282.138.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-04-13 at 08:53 -0400, Daniel J Walsh wrote:
> Moved audit2allow to sbin to match audit2why.
> 
> Fix chcat to handle case where there are no categories.
> 
> Change fixfiles to run setfiles in quiet mode
> 
> Change genhomedircon to verify context before setting homedir file
> context. This can happen if you have different user types, where one
> type has a homedir file context while another one does not.
> 
> restorecond init script does not return status properly
> 
> Fix output of restorecon.c errors to show correct error message.

Merged, except for the audit2allow -> /sbin change.  Also added a prefix
to the restorecon error message as discussed.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
