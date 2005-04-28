Subject: Re: Is there a SELinux tutorial for ISVs ?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Davide Bolcioni <dbolcioni@3di.it>,
   fedora-selinux-list@redhat.com, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1114709532.8548.69.camel@localhost.localdomain>
References: <426F8B45.8070509@3di.it>
	 <pan.2005.04.27.23.10.29.993659@navi.cx> <42709B74.4000508@3di.it>
	 <42710736.2020001@redhat.com>
	 <1114709532.8548.69.camel@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Date: Thu, 28 Apr 2005 13:51:33 -0400
Message-Id: <1114710693.6708.237.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-04-28 at 19:32 +0200, Lorenzo Hernández García-Hierro
wrote:
> I've been thinking on it when working on the SELinux deployment within
> Ubuntu Linux, and binary policies are something pretty handy for binary
> packages-based distributions, among the general benefit they provide.
> 
> I might be able to work on something, but I would like to know first how
> many people is interested in this and how many of them would be able to
> contribute to it in the long term.

Tresys Technology already has a working implementation of binary policy
modules, including a module abstraction with a dependency model, a
compiler for generating such modules, and a linker for linking them
together with a "base module".  Planned for upstreaming after FC4.  See
their prior posts to the selinux list or their web site for info.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
