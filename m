Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA1GhWXZ027534
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 11:43:32 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA1GgCCC011231
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 16:42:12 GMT
Subject: Re: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>, James Morris <jmorris@redhat.com>
In-Reply-To: <418662EE.5090001@trustedcs.com>
References: <4182959B.4080503@trustedcs.com>
	 <20041029211809.GJ8897@lkcl.net> <20041030090603.GK8897@lkcl.net>
	 <1099315214.21386.13.camel@moss-spartans.epoch.ncsc.mil>
	 <20041101141025.GZ8897@lkcl.net>  <418662EE.5090001@trustedcs.com>
Content-Type: text/plain
Message-Id: <1099327182.21386.125.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 01 Nov 2004 11:39:42 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-11-01 at 11:23, Darrel Goeddel wrote:
> I have looked back on the threads involving smbd and famd and it does indeed 
> seem that dynamic transitions may help to bring those applications to a 
> "SELinux-aware" state.  For instance, famd would be able to transition from its 
> "standard domain" to a domain which would have the same file access as the user. 
>   Once in this domain, it would be able to leverage the kernel's access 
> decisions because they will computed against the access rights of the user's 
> type.  I am not really familiar with the architecture and the specific problems 
> of the daemons, so I don't want to throw out any specific advice on using 
> dynamic transitions to SELinuxify the programs.

- Note that you would want to use a derived domain, e.g. smbd_user_t,
rather than the user domain itself, so that you could convey the same
file permissions (likely via a shared macro) without conveying any other
permissions associated with the user domain or exposing the smbd process
to other processes in the user domain.  No need for a fsuid equivalent;
you can just use a derived domain and appropriate macros to convey the
right subset of permissions.

- In Fedora, gamin (http://www.gnome.org/~veillard/gamin) was created as
a replacement for famd that is more SELinux-friendly; you get one daemon
per user or per session rather than system-wide.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
