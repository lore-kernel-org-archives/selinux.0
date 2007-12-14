MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: help with an avc denial
Date: Fri, 14 Dec 2007 14:01:17 -0800
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD02773CBC@blums0008.bluelnk.net>
References: <FB39F4E77226B448BC1388D3BE4E00CD02773CB8@blums0008.bluelnk.net> <1197661487.31325.175.camel@moss-spartans.epoch.ncsc.mil> <1197666740.31325.224.camel@moss-spartans.epoch.ncsc.mil>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Friday, December 14, 2007 1:12 PM
> To: Clarkson, Mike R (US SSA)
> Cc: selinux@tycho.nsa.gov
> Subject: Re: help with an avc denial
> 
> On Fri, 2007-12-14 at 14:44 -0500, Stephen Smalley wrote:
> > On Fri, 2007-12-14 at 11:31 -0800, Clarkson, Mike R (US SSA) wrote:
> > > I'm running RHEL 5.1 with the mls policy.
> > >
> > > I'm getting an avc denial that I can't get past. Here are the
entries
> > > from the audit log:
> > >
> > > type=AVC msg=audit(1197658847.835:9499): avc:  denied  { create }
for
> > > pid=20432 comm="touch" name="tmp.log"
> > > scontext=sysadm_u:sysadm_r:sysadm_t:s0-s4:c0.c255
> > > tcontext=sysadm_u:object_r:audit_log_t:s0-s4:c0.c255 tclass=file
> >
> > A file should be single level, not ranged.
> 
> which is enforced by a mls constraint.  However, the allow rule was
also
> likely missing from the original policy since audit logs should only
be
> accessible to the security or audit administrator, not the system
admin,
> depending on your config.  Which would explain why audit2why would
> report a missing allow rule first.  But if you added the allow rule
via
> a loadable module and then tried again, it should have reported that a
> constraint was violated at that point.

OK. My problem was that I had a range transition rule that specified a
range for the file. Enforcing that files are single level eliminates the
ability to use mlsrangedobject on them, which is applied via the
mls_file_writable_within_range interface in mls.if (poorly named given
that it can't work on ordinary files). I've used this for directories
before but not files I guess. It's similar to mlstrustedobject, except
that it can be applied to a range rather than all levels as
mlstrustedobject does.

Is there a good reason for forcing files to be at a single level? My
thought was that for certain audit logs (or other files for that
matter), I may want to enforce that only processes within a certain
range be allowed to write to those files. Mlstrustedobject provides that
capability, except that the following mls constraint eliminates it for
ordinary files, symbolic links, and pipes:
	# make sure these file classes are "single level"
	mlsconstrain { file lnk_file fifo_file } { create relabelto }
		( l2 eq h2 );

> 
> >
> > > type=SYSCALL msg=audit(1197658847.835:9499): arch=c000003e
syscall=2
> > > success=no exit=-13 a0=7fff74eceb5c a1=941 a2=1b6 a3=328dd4b0ac
> items=0
> > > ppid=12410 pid=20432 auid=11000 uid=11000 gid=4500 euid=11000
> suid=11000
> > > fsuid=11000 egid=4500 sgid=4500 fsgid=4500 tty=pts3 comm="touch"
> > > exe="/bin/touch" subj=sysadm_u:sysadm_r:sysadm_t:s0-s4:c0.c255
> > > key=(null)
> > >
> > >
> > > Here is what audit2allow returns:
> > > #============= sysadm_t ==============
> > > # src="sysadm_t" tgt="audit_log_t" class="file", perms="create"
> > > # comm="touch" exe="" path=""
> > > allow sysadm_t audit_log_t:file create;
> > >
> > > I have entered that exact allow rule into my policy to no effect.
> > >
> > > Audit2why indicates that the reason for the above audit log avc
denial
> > > is a missing allow rule, as opposed to a constraint problem.
> > >
> > > Any help would be greatly appreciated.
> > > Thanks
> > >
> > >
> > > --
> > > This message was distributed to subscribers of the selinux mailing
> list.
> > > If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with
> > > the words "unsubscribe selinux" without quotes as the message.
> --
> Stephen Smalley
> National Security Agency




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
