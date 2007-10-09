Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l99G5Qc0004202
	for <selinux@tycho.nsa.gov>; Tue, 9 Oct 2007 12:05:26 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l99G5JuG013235
	for <selinux@tycho.nsa.gov>; Tue, 9 Oct 2007 16:05:19 GMT
Message-ID: <470B8EF7.5030102@redhat.com>
Date: Tue, 09 Oct 2007 10:23:51 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Shell redirection and denials
References: <1191870537.14569.23.camel@localhost.localdomain>
In-Reply-To: <1191870537.14569.23.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Karl MacMillan wrote:
> One of Dan's constant sources of avcs is something like:
> 
> /usr/sbin/my_confined_app > some_file
> 
> Because the file is created by the shell, opened, and the FD handed to
> the application avcs can occur on read and write.
> 
> Getting rid of these via policy is next to impossible - the destination
> file type is usually governed by the directory and we don't actually
> want to allow that access directly to the confined application. I'd like
> to see if there is some other way to get rid of these denials.
> 
> I see two possible solutions:
> 
> 1) Make the shell create and pass a descriptor to a pipe to the
> application - the shell itself would read / write to the file. This
> seems, to me, to more accurately reflect how we want to enforce the
> permissions.
> 
> 2) Allow applications to confer access by passing the file descriptor
> (more like capabilities). This more closely matches how Unix actually
> works and, of course, is a huge source of vulnerabilities. Allowing this
> type of scheme just for shells might not be that bad.
> 
> Has either of these been investigated? 1 seems pretty simple - is there
> something I'm missing here (perhaps the redirection should outlast the
> shell lifetime?).
> 
> Karl
> 

The biggest source of AVC's that I see reported is the handing off of
open file descriptors.  Mainly terminal descriptors.  Any app that
redirects STDIN/STDERR to a random file location, by opening a file and
handing the descriptor, generates avc messages that cause unexpected
behavior.

service XYZ start >> /tmp/my.log

Will almost always cause avc's and worse no output to my.log.  This
causes sysadmins to go nuts, and it makes no sense to them.

Applications, like rpm, hal, udev, system-config-*, testing tools, any
tools that restarts an init script all do this kind of thing.  As we
move to additional confined user domains and define additional terminal
types this problem proliferates.

The problem is SELinux is preventing READ/WRITE, and does not even look
at Open.  I understand that from a security lock down point of view this
is a big security consideration.  But I believe most sysadmins would
want to prevent their locked down domain to OPEN files in random
location, but if the domains, are handed an OPEN file descriptor from
another process then they should be allowed to READ/WRITE to that OPEN
Descriptor no matter where it is.

So a confined domain could talk to the terminals that were handed to it
but could not open random other terminals.

This is by far the biggest source of dontaudit's allowed in the policy
sources and ends up preventing us from seeing real potential
subversions, where a confined app actually tries to open and talk to
random terminals or the console.



Another side effect I often see is that apps tend to do a getcwd when
they start.  I do not know if this is a standard C/libc activity the way
apps are coded or maybe something about the way bash is coded, but this
ends up generating lots of  AVC messages.

If you look at the confined domains, almost all of them have a
dontaudit $1 sysadm_home_dir_t:dir search_dir_perms;

Because any sysadm who "su -" ends up in the /root homedir and if he
does a service APP restart.  That APP ends up generating and AVC.

I happened to be sitting in a unconfined_tmp_t directory today, when I
started vpnc and boom, setroubleshoot is telling me vpnc_t tried to read
unconfined_tmp_t.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHC473rlYvE4MpobMRAq2sAKCl5+icAs3Yz42TeEOJrYdmChsZVQCg3tZi
o3ppR6kJaECaGU+sIVifvCE=
=PNLZ
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
