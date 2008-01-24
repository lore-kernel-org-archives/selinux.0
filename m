Subject: Re: I am more worried about open then read and write, SELinux
	needs open access checks.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <964182.26945.qm@web51502.mail.re2.yahoo.com>
References: <964182.26945.qm@web51502.mail.re2.yahoo.com>
Content-Type: text/plain
Date: Thu, 24 Jan 2008 15:43:38 -0500
Message-Id: <1201207418.21288.144.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-01-24 at 10:48 -0800, Steve G wrote:
> > I would like to propose that we add one or more avc's to deal with
> > opening a file.  open or open_read open_write.  
> 
> 
> There are situations where apps should only do an open_append to make sure they don't erase anything. syslog, auditd, apache are a few apps that come to mind.

Just to clarify:
- SELinux already distinguishes append vs. write (checks append
permission if opened with O_APPEND and checks write if you later try to
clear via fcntl).
- I only expect us to add a single "open" permission to control whether
a process can directly open a given file at all, not distinct
"open_read", "open_write", "open_append" permissions.  The usual
read/write/append permissions will still get checked, both at open time
and upon inheritance/transfer (and rechecked on read/write if the
process or file label has changed or the policy has changed), but those
are separate checks.  The purpose of the new "open" check being proposed
is to allow the policy writer to distinguish direct open of a file from
inheriting it from another process.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
