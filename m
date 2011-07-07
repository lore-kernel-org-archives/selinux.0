Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p67DJrYl025302
	for <selinux@tycho.nsa.gov>; Thu, 7 Jul 2011 09:19:53 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p67DJpt0007647
	for <selinux@tycho.nsa.gov>; Thu, 7 Jul 2011 13:19:52 GMT
Received: from athena.localnet (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 411C118083
	for <selinux@tycho.nsa.gov>; Thu,  7 Jul 2011 23:18:43 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: context NFS mounts
Date: Thu, 7 Jul 2011 23:19:14 +1000
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201107072319.14792.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

# mount TEST:/bin /mnt/tmp2 -o context=rjc:object_r:user_tmp_t:s0
# mount TEST:/sbin /mnt/tmp -o context=rjc:object_r:user_tmp_t:s0:c1
mount.nfs: an incorrect mount option was specified

It seems that if a server named TEST exports two NFS mount points from the 
same filesystem (in this case /bin and /sbin both being on the root fs) then I 
can't have one NFS client mount them both with different SE Linux contexts.

As I have subtree_check enabled on the server and the server doesn't export / 
it seems to me that there is no good reason for not allowing this.  If 
everything works as desired the result SHOULD be the same as if I had separate 
filesystems for /bin and /sbin.

Should we consider this a bug or at least a missing feature?

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
