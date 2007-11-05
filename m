Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA5LXSOl001748
	for <selinux@tycho.nsa.gov>; Mon, 5 Nov 2007 16:33:28 -0500
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lA5LXRU5017189
	for <selinux@tycho.nsa.gov>; Mon, 5 Nov 2007 21:33:27 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1) with ESMTP id lA5LSA18012681
	for <selinux@tycho.nsa.gov>; Mon, 5 Nov 2007 16:28:10 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1/Submit) id lA5LSAZ3012680
	for selinux@tycho.nsa.gov; Mon, 5 Nov 2007 16:28:10 -0500
Date: Mon, 5 Nov 2007 16:28:29 -0500 (EST)
From: Dean Anderson <dean@av8.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, Steve Grubb <sgrubb@redhat.com>,
        Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>
Subject: Re: Decoder for log messages???
In-Reply-To: <1193840770.3983.86.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.44.0711051620330.20094-100000@citation2.av8.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 31 Oct 2007, Stephen Smalley wrote:
> 
> Not a full pathname, no.
> 
> We don't have enough information at the point where we do our permission
> checks to reconstruct a pathname, 

?? These checks are in open or exec. The full pathname should be 
available.

> and such a pathname will always be process-local and not guaranteed to
> be meaningful, stable, or the actual path by which the file was
> accessed.  

?? The filesystem is not process local, except perhaps /proc

> The theory was that the audit subsystem would solve that problem for
> us, and this was true for a period of time until it was "optimized" to
> only collect that information if at least one syscall audit filter was
> put into place.  So to get PATH records, you have to put at least a
> dummy audit filter into place, ala:
> 	/sbin/auditctl -a exit,always -S chroot 
> or put the following at the end of /etc/audit/audit.rules to have it
> take effect always when auditd is started: -a exit,always -S chroot

You can't get out what you don't put in.

		--Dean

> > Can you decode it in 6 months with only a filesystem dump? Because by
> > then one no longer has the file-to-inode-number association and has also
> > lost the device mapper mappings.
> > 
> > 
> > Comment: A log file entry may be reviewed long after the entry was made
> > and after the system that made the entry was destroyed. The destruction
> > of said system may be the reason for reviewing the logs. Since inode
> > numbers change across filesystem restoration, the inode number isn't a
> > permanent identifier. Device numbers and names are also dynamic.  So,
> > once this filesystem is destroyed, the log information is useless.  
> > This is a crack into selinux; the attacker merely has to tamper with a
> > file, and anticipating the log entry, compensates by destroying the
> > filesystem (after a backup).  The log entry is then useless.  The admin
> > knows some file was tampered with, but not which file.  The admin
> > probably has to use the backup because they can't dump months of work
> > and they don't have time to examine each file in a filesystem.
> > 
> > 
> > Comment: Putting a device basename and inode number in a log message
> > does not uniquely identify the file.  Nor is this helpful.  However, if
> > you think that full file names are too long to log (a questionable
> > assumption, but I won't question it now), then one must still uniquely
> > identify the file some other way.  That requires the FULL device path
> > name, and the inode number. (but as above, that isn't permanent 
> > identifier)
> > 
> > 
> > Comment: This problem is in the same nature of problem that backup
> > software often has; they also never seem to fully anticipate the
> > situation of a failure of some sort and what needs to be recovered to
> > make the backup system work well enough to perform a restore.  This
> > makes those systems fragile, and tedious during a failure when such
> > systems are needed most.  Likewise, SELinux was very fragile in this
> > case, because it was impossible or tediously difficult to find the cause
> > of the problem from the log entry.  But we have logs to keep track of
> > history and to identify problems.  Security is generally not improved by
> > obscurity. Obscure and ambiguous messages are harmful in every way
> > possible. Forensic evidence is also harmed.  When there is a security
> > problem, the problem needs to be made plain and permanently,
> > unambiguously described.
> 
> We're not opposed to improving the information, but there are
> constraints in terms of what information is available at the point of
> the avc checks and what makes sense from the kernel's perspective.
> 
> 

-- 
Av8 Internet   Prepared to pay a premium for better service?
www.av8.net         faster, more reliable, better service
617 344 9000   



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
