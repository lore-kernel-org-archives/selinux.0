Subject: Re: Re:Re: about ss
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yao <yffbrave@163.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <23980a51.520f.12ed66596db.Coremail.yffbrave@163.com>
References: <1300456978.25429.29.camel@moss-pluto>
	 <3030f704.11efc.12ec66a93b9.Coremail.yffbrave@163.com>
	 <23980a51.520f.12ed66596db.Coremail.yffbrave@163.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 21 Mar 2011 08:29:42 -0400
Message-ID: <1300710582.29422.12.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2011-03-21 at 11:11 +0800, Yao wrote:
> At 2011-03-18，"Stephen Smalley" <sds@tycho.nsa.gov> wrote:
> >The original security server code was developed for another OS
> >(Fluke/Flask) and then ported to Linux.  There are a small number of
> >fundamental dependencies on the runtime environment, like memory
> >allocation, logging/auditing, locking, etc.  Over time, the security
> >server code in Linux has become increasingly "nativized" for Linux so
> >you may find further dependencies in the current code.
> >
> so, it's hard to modify ss to make it self-contained, right?

No, the ss is already reasonably self-contained (modulo the runtime
environment dependencies that any piece of software would have, like
memory allocation, locking, logging, etc) and I pointed you to alternate
versions of the security server code that are even more self-contained
if you have difficulty leveraging the Linux kernel version.  The OSKit
in particular was carefully designed to explicitly identify all
dependencies on the runtime environment.

> I just wonder if there is a security module without invoking kernel function but to support flask, though kernel data is permitted...
> Is AppArmor fit to my desire?

SELinux is architected in such a manner that its policy engine, the
security server, is well encapsulated behind a general security
interface, and thus the security server is not tightly coupled to the
OS.  AppArmor and other Linux security modules lack such an architecture
and thus are more tightly coupled to Linux.

It is hard to answer your question though without understanding how you
want to use the security server.  If you just want to use it from an
application running on Linux, then KaiGai is correct - you can just use
the libselinux interfaces to invoke the security server.  If you want to
port it to some other OS, then the libsepol or OSKit versions may be a
better starting point.  You may find that there is already a port to the
OS of interest.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
