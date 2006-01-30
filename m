Subject: Re: [SEMANAGE] Pass fname argument to all file-backed dbases
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <43DBB31D.1090802@cornell.edu>
References: <43DBB31D.1090802@cornell.edu>
Content-Type: text/plain
Date: Mon, 30 Jan 2006 15:15:55 -0500
Message-Id: <1138652155.7076.175.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2006-01-28 at 11:08 -0700, Ivan Gyurdiev wrote:
> ... so we can easily configure it in one place, and instantiate those 
> multiple times on different files if necessary (which it will be 
> shortly, in the seuser case).

Merged as of libsemanage 1.5.19.
> 
> Ok, so I've switched to a 64-bit system, and the first thing I see is 
> that everything gets installed in the completely wrong place until I 
> export LIBDIR/SHLIBDIR to point to lib64. Is this normal, or should the 
> Makefile do something about that?

.spec file has:
make DESTDIR="${RPM_BUILD_ROOT}" LIBDIR="${RPM_BUILD_ROOT}%{_libdir}" SHLIBDIR="${RPM_BUILD_ROOT}/%{_lib}" install install-pywrap

Not sure whether the Makefile should be smarter about it or just
continue deferring to the invoker of make.

> The second thing I see is a bunch of warnings, which I'll be tracking 
> down soon...

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
