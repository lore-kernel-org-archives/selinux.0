From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux@tycho.nsa.gov
Subject: load_policy with latest strict policy
Date: Thu, 14 Apr 2005 20:40:46 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_wikXCuaN76kCe3D"
Message-Id: <200504142040.48997.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_wikXCuaN76kCe3D
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch is needed to allow load_policy to detect SE Linux.  Without 
this access it claims to be running on a non-SE system and refuses to do 
anything.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_wikXCuaN76kCe3D
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- core_macros.te.old	2005-04-14 19:12:06.000000000 +1000
+++ core_macros.te	2005-04-14 19:12:22.000000000 +1000
@@ -361,6 +361,7 @@
 # Get the selinuxfs mount point via /proc/self/mounts.
 allow $1 proc_t:dir search;
 allow $1 proc_t:lnk_file read;
+allow $1 proc_t:file { getattr read };
 allow $1 self:dir search;
 allow $1 self:file { getattr read };
 # Access selinuxfs.

--Boundary-00=_wikXCuaN76kCe3D--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
