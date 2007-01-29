Subject: Re: missing avc message field names
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <20070129150941.41400.qmail@web51505.mail.yahoo.com>
References: <20070129150941.41400.qmail@web51505.mail.yahoo.com>
Content-Type: text/plain
Date: Mon, 29 Jan 2007 10:13:02 -0500
Message-Id: <1170083582.8720.70.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-01-29 at 07:09 -0800, Steve G wrote:
> >I don't think it is "impossible", but it would require updating of e.g.
> >audit2allow, audit2why, madison/sepolgen, setroubleshoot and seaudit
> >(setools).
> 
> At some point, I'm hoping all those tools can migrate to this new API. This is to
> insulate them from other changes that are coming like zlib compression and/or
> binary formats.
> 
> >Are you proposing changing the raw kernel output format as well, or just
> >the auditd-generated output format?
> 
> The audit daemon shouldn't really do any changing. It really should just log
> exactly what it gets. If we agree that this can be changed, what we could do is
> wait until the next kernel development cycle and then make this change (this
> allows for some migration time). I can special case the avc message for a while
> so there is some backwards compatibility.

I think backward compatibility support would be necessary for some time,
given the established use of the current format in various
distributions.

> >The 4th field could be called "result=".  It has two possible values,
> >"denied" or "granted".
> 
> That could possibly conflict with syscall auditing which has the same field. You
> could be in permissive mode and have denied by syscall reports success. Maybe
> "ares", "avcres", "decision", "dec"? Any other suggestions?
> 
> >The 6th field could be called "perms=".
> 
> That name is already taken also. "aperms=" ?

Why do you need to de-conflict the field names when they occur in
different types of records (AVC vs. SYSCALL)?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
