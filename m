Subject: Re: Shell redirection and denials
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Kroum Antov <kroum@voicecho.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        SE Linux <selinux@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <470CF814.5000808@redhat.com>
References: <1191870537.14569.23.camel@localhost.localdomain>
	 <470B8EF7.5030102@redhat.com>
	 <1191948913.24970.135.camel@moss-spartans.epoch.ncsc.mil>
	 <7D474B714E434FEBACADBB6F98F49BFE@HomePC>
	 <1192017616.2687.9.camel@moss-spartans.epoch.ncsc.mil>
	 <470CF814.5000808@redhat.com>
Content-Type: text/plain
Date: Wed, 10 Oct 2007 12:18:52 -0400
Message-Id: <1192033132.2687.63.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-10-10 at 12:04 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Stephen Smalley wrote:
> > On Wed, 2007-10-10 at 00:10 -0700, Kroum Antov wrote:
> >> Dan's suggestion for dropping checks entirely on inheritance and transfer of 
> >> descriptors and do check for OPEN instead
> >> seems to be solid and simple solution.
> >> I don't see any potential security danger in doing this. Once an application 
> >> has the proper rights on a descriptor it can do anything with it anyway. By 
> >> passing the descriptor to other applications and allowing them to work with 
> >> this descriptor without problems there is No security issue with this.
> >> Controlling the Open of the confined applications is sufficient in my 
> >> opinion.
> > 
> > Not if you want to be able to claim that the system enforces mandatory
> > access control.  The ability to leak a descriptor at will (unwittingly
> > or maliciously) to an unauthorized entity violates the principles of
> > mandatory access control.  And SELinux controls on descriptor
> > inheritance have caught any number of unwitting leaks of descriptors by
> > programs.
> > 
> >> Introducing transfer_read and transfer_write permissions will do the work 
> >> too but in my opinion introduces unnecessary complexity to an already 
> >> complex system.
> >>
> >> SElinux has potential beyond the standard security control but these AVC 
> >> denials for file descriptors and ports transfers are greatly limiting the 
> >> SELinux usability.
> >>
> >> I surely would like to see this issue addressed soon.
> > 
> > Splitting the permissions to allow distinctions to be made is ok, but
> > entirely dropping the ability to control propagation of access rights is
> > not.
> > 
> I agree, but we can also use some common sense, there are levels of
> paranoia that differ depending on the context.  Allowing a confined
> domain read/write/use any FD that is handed to them that is connected to
> a terminal, logfile, tmpfile, and not allowing them to open a connection
> to a terminal, tmpfile, logfile is a big step forward.
> 
> Perhaps also allowing them to talk to fifo_file file owned by user but
> not open one.

As far as the kernel mechanism goes, it is just a matter of changing the
open-time checks (selinux_inode_permission) to use a different set of
permissions than the inherit/transfer/use checks
(flush_unauthorized_files, selinux_file_receive,
selinux_file_permission).  Then you can deny open but allow the rest for
whatever file types and classes you want.

That's easy to implement (kernel-side, policy will take more work), but
will require using something like Paul Moore's capability bitmap to
avoid compatibility breakage.

> We can also allow the addition of booleans or changes in policy.  Not ok
> for MLS but ok for Targeted.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
