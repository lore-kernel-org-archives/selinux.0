Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h99E0GWt025530
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2003 10:00:16 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h99E0D0p022490
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2003 14:00:13 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h99E0Dr7022487
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2003 14:00:13 GMT
Subject: Re: init
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200310080111.50210.russell@coker.com.au>
References: <200310080111.50210.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1065708008.8181.219.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 09 Oct 2003 10:00:08 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-10-07 at 11:11, Russell Coker wrote:
> We have been having a discussion of initrd etc.  There is some great 
> opposition to modifying the initrd because it's something that no-one wants 
> changed much (for a variety of support reasons).  Also some systems do not 
> support initrd's (EG the Sun/Cobalt Qube/RaQ hardware which has a Linux 
> kernel in the BIOS which can read an Ext2/Ext3 file system and load a kernel 
> - they never wrote code for loading an initrd).

While I'm willing to concede the point, I would like to note that
performing the policy load from an initrd (or initramfs) has the
advantage of allowing a security-enhanced boot loader to verify the
kernel and policy before kernel startup.

> An idea that came up was to modify init so that it would do the following:

Note that Magosanyi Arpad previously posted to the list a similar
solution that he implemented by renaming the real /sbin/init and
replacing it with a small program that exec'd a shell script to perform
the policy load and then executed the real init program.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
