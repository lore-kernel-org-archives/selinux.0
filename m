Subject: Re: changes in ~2.6.13 break postfix policy?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Erich Schubert <erich@debian.org>
Cc: Russell Coker <russell@coker.com.au>, James Morris <jmorris@namei.org>,
   SELinux@tycho.nsa.gov
In-Reply-To: <20051104183551.GC2837@legolas.drinsama.de>
References: <1131106145.28236.7.camel@wintermute.xmldesign.de>
	 <1131111969.23420.208.camel@moss-spartans.epoch.ncsc.mil>
	 <20051104183551.GC2837@legolas.drinsama.de>
Content-Type: text/plain
Date: Fri, 04 Nov 2005 14:02:04 -0500
Message-Id: <1131130924.23420.326.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-11-04 at 19:35 +0100, Erich Schubert wrote:
> Hi,
> > between 2.6.12 and 2.6.13 AFAIK.   Do you see the behavior with a 2.6.12
> > kernel as well?
> 
> I can't tell for sure where I see it. Actually I just noticed that I
> don't see it on the main mailserver, which is running 2.6.13 currently.
> So it must be related to something else on the systems... :-(
> But that might be due to that system running in enforcing mode.
> 
> Postfix is that of debian stable. Init is that of debian unstable.
> 
> On the system where I can observe the problem for sure, I upgraded from
> a self-compiled 2.6.8 to 2.6.13 (as of debian experimental) then to 2.6.14
> (as of debian unstable). The problem appeared after 2.6.8

Hmm...Russell reported a similar problem on 29 Oct about new sock_file
audit messages with recent kernels on Debian, but said he has not seen
the same behavior on Fedora.  Only SELinux-related patch in the Fedora
kernel (canonicalize getxattr) shouldn't be relevant, and is now in
Linus' -git tree for 2.6.15.  Where might one be able to obtain the
patches included in the Debian kernel?  Any direct use of sock_alloc()
is suspect; everything needs to use sock_create(), sock_create_kern(),
or sock_create_lite() in order to pick up the proper security
initialization of the socket.

Note to James:  Fedora kernel includes a patch that re-exports
sock_alloc and uses it for tux (linux-2.6-tux.patch), so that is broken,
although IIRC, you said that tux is fundamentally broken for SELinux
anyway.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
