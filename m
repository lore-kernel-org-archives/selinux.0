Subject: Re: Patch setfiles to only warn if add_remove fails to lstat on
 user initiated excludes.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1249934593.2422.77.camel@moss-pluto.epoch.ncsc.mil>
References: <4A803935.3040407@redhat.com>
	 <1249934593.2422.77.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 10 Aug 2009 16:12:10 -0400
Message-Id: <1249935130.2422.82.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-08-10 at 16:03 -0400, Stephen Smalley wrote:
> On Mon, 2009-08-10 at 11:13 -0400, Daniel J Walsh wrote:
> > Currently in F12 if you have file systems that root can not read
> > 
> > # restorecon -R -v /var/lib/libvirt/
> > Can't stat directory "/home/dwalsh/.gvfs", Permission denied.
> > Can't stat directory "/home/dwalsh/redhat", Permission denied.
> > 
> > After patch
> > 
> > # ./restorecon -R -v /var/lib/libvirt/
> 
> But if you were to run
> ./restorecon -R /home/dwalsh
> that would try to descend into .gvfs and redhat, right?
> 
> I think you want instead to ignore the lstat error if the error was
> permission denied and add the entry to the exclude list so that
> restorecon will not try to descend into it.  It is ok to exclude a
> directory to which you lack permission.  Try this:

Also, why limit -e to only directories?  Why not let the user exclude
individual files if they choose to do so?  In which case we could drop
the mode test altogether, and possibly drop the lstat() call altogether?
Or if you truly want to warn the user about non-existent paths, then
take the lstat() and warning to the 'e' option processing in main()
instead of doing it inside of add_exclude().

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
