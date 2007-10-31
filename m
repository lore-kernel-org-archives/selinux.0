Subject: Re: Decoder for log messages???
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dean Anderson <dean@av8.com>
Cc: selinux@tycho.nsa.gov, Steve Grubb <sgrubb@redhat.com>,
        Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>
In-Reply-To: <Pine.LNX.4.44.0710262329300.30215-100000@citation2.av8.net>
References: <Pine.LNX.4.44.0710262329300.30215-100000@citation2.av8.net>
Content-Type: text/plain
Date: Wed, 31 Oct 2007 10:26:10 -0400
Message-Id: <1193840770.3983.86.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2007-10-27 at 00:17 -0400, Dean Anderson wrote:
> I removed and reinstalled httpd, and got a bunch of these messages.  
> I'm guessing that dm-0 refers to a devicemapper device (which on my
> system doesn't seem to actually be in use, so I'm left wondering what
> the heck...perhaps a shared device number)

device mapper is used by the logical volume manager.
dmsetup ls?
cat /sys/block/dm-0/dev?

>   I had to disable selinux
> because I couldn't figure out how to fix the problem within a couple
> minutes and needed to put the server back online.

Hmm...well, there's always the option of using audit2allow, although it
is best to understand what you are allowing.

> I think some directory was searched, but have no idea exactly what
> directory. It caused httpd to terminate:
> 
> messages:Oct 26 21:35:03 mallard kernel: audit(1193448902.933:56): avc:  
> denied  { search } for  pid=
> 11594 comm="httpd" name="sparc" dev=dm-0 ino=15699715 
> scontext=root:system_r:httpd_t:s0 tcontext=system_u:object_r:src_t:s0 tclass=dir

So httpd tried to search a directory named "sparc" (with that device and
inode identifiers), and that directory was labeled "src_t", which
suggests that it might be under /usr/src somewhere.

> So can anyone decode this to a full pathname?

Not a full pathname, no.

We don't have enough information at the point where we do our permission
checks to reconstruct a pathname, and such a pathname will always be
process-local and not guaranteed to be meaningful, stable, or the actual
path by which the file was accessed.  The theory was that the audit
subsystem would solve that problem for us, and this was true for a
period of time until it was "optimized" to only collect that information
if at least one syscall audit filter was put into place.  So to get PATH
records, you have to put at least a dummy audit filter into place, ala:
	/sbin/auditctl -a exit,always -S chroot
or put the following at the end of /etc/audit/audit.rules to have it
take effect always when auditd is started:
-a exit,always -S chroot

> Can you decode it in 6 months with only a filesystem dump? Because by
> then one no longer has the file-to-inode-number association and has also
> lost the device mapper mappings.
> 
> 
> Comment: A log file entry may be reviewed long after the entry was made
> and after the system that made the entry was destroyed. The destruction
> of said system may be the reason for reviewing the logs. Since inode
> numbers change across filesystem restoration, the inode number isn't a
> permanent identifier. Device numbers and names are also dynamic.  So,
> once this filesystem is destroyed, the log information is useless.  
> This is a crack into selinux; the attacker merely has to tamper with a
> file, and anticipating the log entry, compensates by destroying the
> filesystem (after a backup).  The log entry is then useless.  The admin
> knows some file was tampered with, but not which file.  The admin
> probably has to use the backup because they can't dump months of work
> and they don't have time to examine each file in a filesystem.
> 
> 
> Comment: Putting a device basename and inode number in a log message
> does not uniquely identify the file.  Nor is this helpful.  However, if
> you think that full file names are too long to log (a questionable
> assumption, but I won't question it now), then one must still uniquely
> identify the file some other way.  That requires the FULL device path
> name, and the inode number. (but as above, that isn't permanent 
> identifier)
> 
> 
> Comment: This problem is in the same nature of problem that backup
> software often has; they also never seem to fully anticipate the
> situation of a failure of some sort and what needs to be recovered to
> make the backup system work well enough to perform a restore.  This
> makes those systems fragile, and tedious during a failure when such
> systems are needed most.  Likewise, SELinux was very fragile in this
> case, because it was impossible or tediously difficult to find the cause
> of the problem from the log entry.  But we have logs to keep track of
> history and to identify problems.  Security is generally not improved by
> obscurity. Obscure and ambiguous messages are harmful in every way
> possible. Forensic evidence is also harmed.  When there is a security
> problem, the problem needs to be made plain and permanently,
> unambiguously described.

We're not opposed to improving the information, but there are
constraints in terms of what information is available at the point of
the avc checks and what makes sense from the kernel's perspective.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
