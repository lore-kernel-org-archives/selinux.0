Subject: Re: strange policy loading problem
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <201003041200.10019.russell@coker.com.au>
References: <201003031018.38030.russell@coker.com.au>
	 <1267621594.3436.19.camel@moss-pluto.epoch.ncsc.mil>
	 <201003041200.10019.russell@coker.com.au>
Content-Type: text/plain
Date: Thu, 04 Mar 2010 10:05:43 -0500
Message-Id: <1267715143.23761.93.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-03-04 at 12:00 +1100, Russell Coker wrote:
> On Thu, 4 Mar 2010, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > - make sure CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX is not set,
> 
> It's not.
> 
> > - what are the versions of libsepol, libsemanage, and glibc
> 
> ii  libc6                                   2.10.2-6                   
> Embedded GNU C Library: Shared libraries
> ii  libc6-dbg                               2.10.2-6                   
> Embedded GNU C Library: detached debugging s
> ii  libc6-dev                               2.10.2-6                   
> Embedded GNU C Library: Development Librarie
> ii  libc6-i386                              2.10.2-6                   GNU C 
> Library: 32-bit shared libraries for A
> ii  libsemanage-common                      2.0.42-1                   Common 
> files for SELinux policy management l
> ii  libsemanage1                            2.0.42-1                   SELinux 
> policy management library.
> ii  libsepol1                               2.0.40-2                   SELinux 
> library for manipulating binary secu
> 
> The latest in Debian/Testing.

Interesting.  Does it happen with 2.6.31 too?  2.6.33?
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
