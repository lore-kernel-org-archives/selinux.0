From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: strange policy loading problem
Date: Thu, 4 Mar 2010 12:00:09 +1100
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <201003031018.38030.russell@coker.com.au> <1267621594.3436.19.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1267621594.3436.19.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201003041200.10019.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 4 Mar 2010, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> - make sure CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX is not set,

It's not.

> - what are the versions of libsepol, libsemanage, and glibc

ii  libc6                                   2.10.2-6                   
Embedded GNU C Library: Shared libraries
ii  libc6-dbg                               2.10.2-6                   
Embedded GNU C Library: detached debugging s
ii  libc6-dev                               2.10.2-6                   
Embedded GNU C Library: Development Librarie
ii  libc6-i386                              2.10.2-6                   GNU C 
Library: 32-bit shared libraries for A
ii  libsemanage-common                      2.0.42-1                   Common 
files for SELinux policy management l
ii  libsemanage1                            2.0.42-1                   SELinux 
policy management library.
ii  libsepol1                               2.0.40-2                   SELinux 
library for manipulating binary secu

The latest in Debian/Testing.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
