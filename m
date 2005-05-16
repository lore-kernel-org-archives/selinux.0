Subject: Re: ls -Z on non-SE machine
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SELinux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <200505162148.38650.russell@coker.com.au>
References: <200505151921.23171.russell@coker.com.au>
	 <1116243084.28782.12.camel@moss-spartans.epoch.ncsc.mil>
	 <200505162148.38650.russell@coker.com.au>
Content-Type: text/plain
Date: Mon, 16 May 2005 08:36:19 -0400
Message-Id: <1116246979.28782.61.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-05-16 at 21:48 +1000, Russell Coker wrote:
> It's true that libselinux functionality required by ls can work on a non-SE 
> machine.  However in that case when coreutils is compiled for non-SE systems 
> ls will not have such functionality.  I believe that it would be best to have 
> the "ls -Z" functionality on systems without libselinux.

Not sure that this is a real issue; distros have seemed willing to
accept libselinux as part of the base system, much like libattr/libacl.
If they weren't, then we'd have to revisit the patches anyway to allow
dlopen'ing of libselinux so that they could ship a single coreutils
binary package that could support either SELinux or non-SELinux, as
noted previously by Luke.

> There is already code in coreutils to manage xattrs, can some of that be 
> re-used?

I think that there is code for preserving attributes, and in the case of
ls, code for indicating whether the file has attributes via a simple
flag in the mode string, but I don't think they include code for
displaying attributes in ls - I think they require you to run a separate
utility to display the attributes like getfattr or getfacl.  SELinux is
distinctive in the level of direct integration.  And in the case of
preserving attributes, SELinux tends to do it differently (via
setfscreatecon) so that the attributes are set down when the file is
created rather than later.

> The MLS issue is compelling, this change will do.

Yes, I think just removing the is_selinux_enabled() test is sane in the
case of ls.   Might be more problematic for programs like cp where they
are using SELinux-specific interfaces like setfscreatecon.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
