Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1EFHiL9000652
	for <selinux@tycho.nsa.gov>; Mon, 14 Feb 2005 10:17:44 -0500 (EST)
Subject: Re: shm denials
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: ivg2@cornell.edu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1108222744.23018.5.camel@cobra.ivg2.net>
References: <1108222744.23018.5.camel@cobra.ivg2.net>
Content-Type: text/plain
Message-Id: <1108393789.15437.53.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 14 Feb 2005 10:09:50 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2005-02-12 at 10:39, Ivan Gyurdiev wrote:
> audit(1108172859.969:0): avc:  denied  { execute } for  pid=17617
> comm=ut2004-bin path=/SYSV00000000 (deleted) dev=tmpfs ino=46366738
> scontext=user_u:user_r:user_t tcontext=user_u:object_r:user_tmpfs_t
> tclass=file
> 
> audit(1108172873.539:0): avc:  denied  { write execute } for  pid=17617
> comm=ut2004-bin path=/SYSV00000000 (deleted) dev=tmpfs ino=38338560
> scontext=user_u:user_r:user_t
> tcontext=system_u:object_r:xdm_xserver_tmpfs_t tclass=file

The attempt to execute is odd; might be due to a legacy binary and the
present read-implies-execute logic in the kernel.  There is some
discussion of changing the kernel to pass the original protection to
SELinux rather than the modified one, so that SELinux will only check
the protection requested by the application and legacy binaries won't
trigger these denials.

> audit(1108185116.592:0): avc:  denied  { write } for  pid=18105
> comm=bubble3d path=/SYSV00000000 (deleted) dev=tmpfs ino=38338560
> scontext=user_u:user_r:user_t
> tcontext=system_u:object_r:xdm_xserver_tmpfs_t tclass=file

There are rules in the policy allowing read access for user domains and
x client program domains to this type, to support shared memory
communication with X as an optimization.  I would have expected the
writes to occur to a shared memory object created by the user domain / x
client domain (and thus labeled with user_tmpfs_t) that would then be
read by X, but this seems to be a direct write to the shared memory
object created by X.  I would expect the application to fall back to the
slower IPC-based communication mechanism if this fails, so it shouldn't
be fatal, but someone might want to assess the risk posed by allowing it
(e.g. can a user domain / x client domain corrupt X by such direct
writing to a shared memory object created by X).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
