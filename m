Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4JCLoI4002815
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 08:21:50 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4JCLSQj025827
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 12:21:28 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h4JCLRxS025824
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 12:21:27 GMT
Subject: Re: Creating a new lsm function
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Torsten Knodt <tk-selinux@datas-world.de>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200305181856.22022.tk-selinux@datas-world.de>
References: <200305181856.22022.tk-selinux@datas-world.de>
Content-Type: text/plain
Message-Id: <1053346904.4729.954.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 19 May 2003 08:21:46 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2003-05-18 at 12:50, Torsten Knodt wrote:
> I'd like to create two new function's, which fill a buffer with lsm 
> informations about an interface/ a socket. Both will simply give back the 
> context. Also, for this two, a function will return a title for these fields.
> These function will be used to print out these informations in /proc/net/tcp, 
> ... to be read by net-tools.
> 
> Can someone give me a hint, where this has to be implemented to be independent 
> of the used security module?

If you simply want to export the context of a socket to userspace, the
old SELinux API supports that via getsockname_secure or fstat_secure. 
The new 2.5 SELinux API could support it via fgetxattr or possibly
getsockopt, but we are presently only focused on the process attribute,
file attribute, and security policy APIs in 2.5.

If you want to extend the LSM hook interface so that
net/ipv4/tcp_ipv4.c:tcp_get_info can invoke a LSM hook to obtain a
string representation of the security information that can be included
in /proc/net/tcp, then you would do that by adding hook interface
definitions to include/linux/security.h, dummy hook functions to
security/dummy.c, SELinux implementations of those hook functions to
security/selinux/hooks.c, and code that calls the hooks and uses the
returned strings to net/ipv4/tcp_ipv4.c:tcp_get_info.
    
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
