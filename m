Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2GDG3Rb019668
	for <selinux@tycho.nsa.gov>; Tue, 16 Mar 2004 08:16:04 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i2GDEI6Q023623
	for <selinux@tycho.nsa.gov>; Tue, 16 Mar 2004 13:14:18 GMT
Received: from moss-lions.epoch.ncsc.mil (moss-lions.epoch.ncsc.mil [144.51.25.4])
	by jazzswing.ncsc.mil  with ESMTP id i2GDEI5t023620
	for <selinux@tycho.nsa.gov>; Tue, 16 Mar 2004 13:14:18 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2GDG2jE015793
	for <selinux@tycho.nsa.gov>; Tue, 16 Mar 2004 08:16:02 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id i2GDG2Tp015791
	for selinux@tycho.nsa.gov; Tue, 16 Mar 2004 08:16:02 -0500
Subject: Re: Updated Release
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1079116499.9107.292.camel@moss-huskies>
References: <1079116499.9107.292.camel@moss-huskies>
Content-Type: text/plain
Message-Id: <1079442962.15678.25.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 16 Mar 2004 08:16:02 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-03-12 at 13:34, Howard Holm wrote: 
> The SELinux web site <http://www.nsa.gov/selinux/> including the mail
> list archive has been updated. OpenPGP signatures are now available for
> released code. The site includes a new release of the SELinux prototype.
> Experimental SELinux NFS code has been made available. The base kernel


The experimental SELinux NFS patch consists of both a kernel patch and 
userland patches.  The userland patches include a patch to mount adding
a selinuxnfs filesystem type, a xattr mount option, and a selinux mount
option.  There is also has a patch to exportfs to add a selinux export
option.  See the README in the nfs-usr archive for instructions.

The SELinux NFS patch modifies NFS v3 and the SELinux module.  Some of
the modifications:
1.  The client can get and set extended attributes on the server.  (Not
limited to just security.selinux attributes.)
2.  The client labels the security contexts of the selinuxnfs inodes
with the security context received from the server.
3.  The client sends the security context of the process to the server.
4.  The server uses the security context of the process on the client to
make security decisions.
5.  More permission checking on the client and the server.  (Ex.  Not
bypassing access calls to server if it is not an open or access.)

There are still the following limitations:
1.  The client and server need to have essentially the same policy.
2.  The client does not revalidate the security contexts for the NFS
inodes.  If the security context on the server is changed or from
another client, it will not be reflected on the client.  If the change
is made on the client, then the client and server will have the correct
context.  I am currently working on a fix for this.
3.  The fs create context is not currently passed to the server, so it
depends on the client to set the context after the fact, widening the
window where the file exists in the default type.  I am also currently
working on a fix for this.
4.  Due to caching by the client, there is a strong dependence on the
client to enforce the policy; the server can only directly mediate the
initial request for data before it is cached and is also limited by the
protocol.

Note that this patch does not address the RPC socket creation issue
encountered by Stephen Tweedie of Red Hat; addressing that also requires
a separate patch for sock_create.
  
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
