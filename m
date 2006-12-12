Subject: Re: matchpathcon() for arbitrary subjects
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Matt Anderson <mra@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <457F0145.7020305@hp.com>
References: <457F0145.7020305@hp.com>
Content-Type: text/plain
Date: Tue, 12 Dec 2006 14:40:21 -0500
Message-Id: <1165952421.998.100.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-12-12 at 14:21 -0500, Matt Anderson wrote:
> I'm trying to get the CUPS print server to print to a file on the file
> system.  In order to do this in a usable way I want to be able to query
> the SELinux security server as to what the type of a file would be for a
> given directory.  This is essentially what matchpathcon() does, and I
> can get that to work.
> 
> The part I'm having trouble with is I'm making this call from cupsd with
> the context of system_u:system_r:cupsd_t:SystemHigh and getting a
> response for that type.  I'd like to make the call from that context,
> but asking the server what the result would be for a given user's
> context (such as user_u:user_r:user_lpr_t:SystemLow) is this possible
> with some other existing function?

matchpathcon() doesn't consult the security server; it just performs
pathname matching against the file contexts configuration, which
expresses the install-time labeling information for initially labeling
files when they are installed from an external source (like a package)
or for restoring them to those initial labels.  Thus, it isn't relative
to a subject in any way.  It is only used by applications, not the
kernel.

security_compute_create() is an interface to the security server for
computing a runtime labeling decision based on a subject label, a
related object label (e.g. parent directory), and an object class (e.g.
SECCLASS_FILE).  An internal form of this interface is used by the
kernel to determine how to label newly created files by default.

But I'm not entirely clear on what you are trying to do here - you want
the cups daemon to write to a file that will then be accessible to the
client which requested the print job?  In a possibly user (or otherwise
untrusted)-writable directory?  That begs for security problems.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
