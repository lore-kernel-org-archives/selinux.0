Subject: Re: installation from scratch problems
From: Stephen Smalley <sds@tycho.nsa.gov>
To: vin@netwosix.org
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1169207960.8700.19.camel@zeroKnowledge>
References: <1169207960.8700.19.camel@zeroKnowledge>
Content-Type: text/plain
Date: Fri, 19 Jan 2007 07:48:50 -0500
Message-Id: <1169210930.22731.478.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-01-19 at 12:59 +0100, Vincenzo Ciaglia wrote:
> Hello, i'm Vincenzo Ciaglia. 
> 
> I'm the main developer of Linux Netwosix, a server and security oriented
> GNU/Linux LFS distribution. I was really impressed to the power of
> SELinux so I'd like to give to the next releases the complete support to
> SELinux, for this reason i'm already working on that. I have a good
> knowledge in selinux policy writing but no experiences with "from
> scratch installation".
> 
> So, i have compiled the latest kernel with "Socket and Networking
> Security Hooks" and other "Security Models". Of course with the Ext[3]
> extended attributes and Ext[3] Security Labels options. 
> Everything is ok.
> 
> After that, i have downloaded the userland packages from the NSA
> website.
> 
> I succesfully compiled the "libsepol-1.14". 
> 
> So i tried to compile the "libselinux-1.32" but i get these errors:
> 
> --------------
> matchpathcon.lo: In function `set_matchpathcon_flags':
> matchpathcon.c:(.text+0x187): undefined reference to `___tls_get_addr'

The current libselinux depends on thread local storage (tls) support,
which exists in glibc 2.4.  See the link below for a workaround patch
used by the Debian folks:
http://marc.theaimsgroup.com/?l=selinux&m=115807948020898&w=2

Also, I would tend to suggest updating to stable branch that we just
created in the sourceforge svn repo, as that will be the basis for the
next nsa.gov/selinux stable release.  But that won't change the
situation wrt to tls support.  

$ svn co https://selinux.svn.sourceforge.net/svnroot/selinux/branches/stable/1_0 selinux-stable

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
