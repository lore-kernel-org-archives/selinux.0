From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: patch for new domains
Date: Mon, 20 Jan 2003 01:22:48 +0100
References: <200301200121.20459.russell@coker.com.au>
In-Reply-To: <200301200121.20459.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_YF0K+XK8J1nIGwS"
Message-Id: <200301200122.48897.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_YF0K+XK8J1nIGwS
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, 20 Jan 2003 01:21, Russell Coker wrote:
> I've attached a patch with policy for Perdition, nessus, nsd, and UML. 
> Also it has a new file auth-net.te with the policy for doing network
> authentication (LDAP etc).

The attached patch is also needed for UML.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_YF0K+XK8J1nIGwS
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="new2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="new2.diff"

diff -ruwN /tmp/policy/macros/user_macros.te policy/macros/user_macros.te
--- /tmp/policy/macros/user_macros.te	2002-12-03 15:56:47.000000000 +0100
+++ policy/macros/user_macros.te	2003-01-18 15:13:04.000000000 +0100
@@ -133,6 +133,7 @@
 ifdef(`crontab.te', `crontab_domain($1)')
 ifdef(`ssh.te', `ssh_domain($1)')
 ifdef(`irc.te', `irc_domain($1)')
+ifdef(`uml.te', `uml_domain($1)')
 ifdef(`clamav.te', `user_clamscan_domain($1)')
 ifdef(`fingerd.te', `fingerd_macro($1)')
 

--Boundary-00=_YF0K+XK8J1nIGwS--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
