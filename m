Subject: RE: pipefs issue
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Cc: Chad Sellers <csellers@tresys.com>, selinux@tycho.nsa.gov,
        Darrel Goeddel <dgoeddel@TrustedCS.com>
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD01DBEFD6@blums0008.bluelnk.net>
References: <C2849B7E.223EB%csellers@tresys.com>
	 <FB39F4E77226B448BC1388D3BE4E00CD01DBEFD6@blums0008.bluelnk.net>
Content-Type: text/plain
Date: Thu, 31 May 2007 16:18:24 -0400
Message-Id: <1180642704.3340.385.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-05-31 at 13:02 -0700, Clarkson, Mike R (US SSA) wrote:
> Thanks for the info on the 3 pipes that Java creates. I had a feeling
> that this is what was going on, but I'm still confused on one point. The
> c++ executable is not writing anything to stdout or stderr, it writes
> it's output to a file. The AVC messages below indicate that the import_t
> domain (the c++ executable) is attempting to write to the pipe. Is there
> some implicit writing that occurs between the processes?

SELinux checks permissions when a file descriptor is opened, inherited
across execve or received via local IPC, so you will see attempted
accesses at those times even if the descriptor is never actually used
for a read or write.  In this case, the pipe descriptors are inherited
across execve and checked at that time (and closed and replaced with
descriptors to the null device if access is denied).  So if you don't
actually need to allow the accesses, you can just add dontaudit rules to
suppress the audit messages and SELinux will silently remap those
descriptors to /dev/null for you.

> Also, it looks like SELinux is not allowing me to write up. Is that
> standard? The BLP model typically allows writing up. 

Many MLS systems don't allow writing up without privilege (as that
allows a low process to potentially corrupt high data), and the default
mls constraints in SELinux policy are written that way.  You of course
can change them in your policy/mls file if you want, and just use Type
Enforcement to provide integrity protection.

> The only mls attribute that I've seen that addresses writing up is
> mlsfilewritetoclr, which looks like it allows writing to the high end of
> a process range. Is that correct?

mlsfilewritetoclr is for writing up to your high/clearance, while
mlsfilewrite allows arbitrary writing (up or down) by the process, and
mlstrustedobject allows any process to write to the object.

mlsfilewriteinrange looks a bit odd to me.

Again, these can be customized to your needs.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
