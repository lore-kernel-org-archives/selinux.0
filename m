Subject: Re: Shell redirection and denials
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        SE Linux <selinux@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <470B8EF7.5030102@redhat.com>
References: <1191870537.14569.23.camel@localhost.localdomain>
	 <470B8EF7.5030102@redhat.com>
Content-Type: text/plain
Date: Tue, 09 Oct 2007 12:55:13 -0400
Message-Id: <1191948913.24970.135.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-10-09 at 10:23 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Karl MacMillan wrote:
> > One of Dan's constant sources of avcs is something like:
> > 
> > /usr/sbin/my_confined_app > some_file
> > 
> > Because the file is created by the shell, opened, and the FD handed to
> > the application avcs can occur on read and write.
> > 
> > Getting rid of these via policy is next to impossible - the destination
> > file type is usually governed by the directory and we don't actually
> > want to allow that access directly to the confined application. I'd like
> > to see if there is some other way to get rid of these denials.
> > 
> > I see two possible solutions:
> > 
> > 1) Make the shell create and pass a descriptor to a pipe to the
> > application - the shell itself would read / write to the file. This
> > seems, to me, to more accurately reflect how we want to enforce the
> > permissions.
> > 
> > 2) Allow applications to confer access by passing the file descriptor
> > (more like capabilities). This more closely matches how Unix actually
> > works and, of course, is a huge source of vulnerabilities. Allowing this
> > type of scheme just for shells might not be that bad.
> > 
> > Has either of these been investigated? 1 seems pretty simple - is there
> > something I'm missing here (perhaps the redirection should outlast the
> > shell lifetime?).
> > 
> > Karl
> > 
> 
> The biggest source of AVC's that I see reported is the handing off of
> open file descriptors.  Mainly terminal descriptors.  Any app that
> redirects STDIN/STDERR to a random file location, by opening a file and
> handing the descriptor, generates avc messages that cause unexpected
> behavior.
> 
> service XYZ start >> /tmp/my.log
> 
> Will almost always cause avc's and worse no output to my.log.  This
> causes sysadmins to go nuts, and it makes no sense to them.
> 
> Applications, like rpm, hal, udev, system-config-*, testing tools, any
> tools that restarts an init script all do this kind of thing.  As we
> move to additional confined user domains and define additional terminal
> types this problem proliferates.
> 
> The problem is SELinux is preventing READ/WRITE, and does not even look
> at Open.  I understand that from a security lock down point of view this
> is a big security consideration.  But I believe most sysadmins would
> want to prevent their locked down domain to OPEN files in random
> location, but if the domains, are handed an OPEN file descriptor from
> another process then they should be allowed to READ/WRITE to that OPEN
> Descriptor no matter where it is.
> 
> So a confined domain could talk to the terminals that were handed to it
> but could not open random other terminals.
> 
> This is by far the biggest source of dontaudit's allowed in the policy
> sources and ends up preventing us from seeing real potential
> subversions, where a confined app actually tries to open and talk to
> random terminals or the console.

I understand the motivation, but merely dropping checks entirely on
inheritance and transfer of descriptors means that we have no control
over the propagation of access rights, which is important for confining
malicious and flawed programs.

Splitting the permissions such that we check one set of permissions
(e.g. open_read, open_write) at open-time and a different set of
permissions on transfer and/or use (read, write) would allow the policy
writer to allow or dontaudit only the latter while denying w/audit the
former.

If we wanted to specifically control the ability to give a descriptor to
another task (vs. the ability to receive/inherit/use it), we'd need
another hook, as we currently only hook the receive side.  Then you
could have distinct transfer_read, transfer_write permissions governing
who could propagate a descriptor separate from read, write permissions
governing who could inherit/receive/use it.  

> Another side effect I often see is that apps tend to do a getcwd when
> they start.  I do not know if this is a standard C/libc activity the way
> apps are coded or maybe something about the way bash is coded, but this
> ends up generating lots of  AVC messages.
> 
> If you look at the confined domains, almost all of them have a
> dontaudit $1 sysadm_home_dir_t:dir search_dir_perms;
> 
> Because any sysadm who "su -" ends up in the /root homedir and if he
> does a service APP restart.  That APP ends up generating and AVC.
> 
> I happened to be sitting in a unconfined_tmp_t directory today, when I
> started vpnc and boom, setroubleshoot is telling me vpnc_t tried to read
> unconfined_tmp_t.

That's a different issue - it isn't an operation on an open file
descriptor, and we can't distinguish it from any other lookup at least
presently.  Actually though sys_getcwd() shouldn't trigger a permission
check at all.  Traditional userland getcwd() would need to search the
directory.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
