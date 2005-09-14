Subject: Re: New ideas on implementation on libsetrans.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   Darrel Goeddel <dgoeddel@TrustedCS.com>, SELinux <SELinux@tycho.nsa.gov>,
   Nalin Dahyabhai <nalin@redhat.com>
In-Reply-To: <4327425F.8050805@redhat.com>
References: <43271BDA.3060403@redhat.com> <43272C09.3050105@trustedcs.com>
	 <43272E92.4060400@redhat.com>
	 <1126641222.29303.235.camel@moss-spartans.epoch.ncsc.mil>
	 <432730B2.8090005@redhat.com>
	 <1126641983.29303.249.camel@moss-spartans.epoch.ncsc.mil>
	 <43273782.7070600@redhat.com>
	 <1126643563.2940.6.camel@moss-spartans.epoch.ncsc.mil>
	 <4327425F.8050805@redhat.com>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 09:39:34 -0400
Message-Id: <1126705174.12299.64.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-09-13 at 17:19 -0400, Daniel J Walsh wrote:
> Ok I succumb, but we will go back to original implementation of 
> libsetrans for now, and require anyone wishing to change the behaviour 
> to replace our version with their own.  so dlopen(libsetrans.so.1) will 
> work.
> 
> Eventually our version of libsetrans will use a UDS interface to talk to 
> a long running daemon.

Ok.  Do you agree that libselinux should be dlopen'ing libsetrans.so
(and thus using the symlink that already exists under /usr/lib to
whatever the latest version is under /lib) rather than specifically
dlopen'ing libsetrans.so.0 as it does now?  Of course, it may not matter
in practice as I can't see the interface ever changing (at least in a
way that requires bumping the .so version), but it seems cleaner.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
