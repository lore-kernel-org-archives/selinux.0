Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA2FcQXZ006612
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 10:38:26 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA2FcJAw026799
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 15:38:24 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Patch to make can_network stronger and remove nscd tunable.
Date: Wed, 3 Nov 2004 02:38:18 +1100
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   SELinux <selinux@tycho.nsa.gov>
References: <20041018124332.GA5193@hydrogenium.cip.ifi.lmu.de> <1099406385.31739.77.camel@moss-spartans.epoch.ncsc.mil> <41879EAB.5070300@redhat.com>
In-Reply-To: <41879EAB.5070300@redhat.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_qn6hBc6wQTfNja1"
Message-Id: <200411030238.18205.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_qn6hBc6wQTfNja1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 3 Nov 2004 01:50, Daniel J Walsh <dwalsh@redhat.com> wrote:
> I can change daemon_core_domain to define domain types with
> nscd_client_domain,

How about doing something like the attached patch first.

Then you can enable nscd access for the daemon attribute.  This means that 
someone who wants to restrict nscd access (customisations by a user or 
changes that we make later on) can use { daemon -whatever }.

Also we could potentially have another attribute not_nscd_client_domain which 
can be used to instantiate a daemon which should not have nscd access.

When making changes of this nature we don't want to make it unreasonably 
difficult to remove access for domains that should not have it, and we also 
want to keep the policy as simple as possible as ease of reading the policy 
is (IMHO) a very major factor in keeping the quality high.  I believe that a 
change such as I suggest meets these goals well and has no disadvantages.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_qn6hBc6wQTfNja1
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- /usr/src/se/policy/macros/global_macros.te	2004-10-14 10:10:03.000000000 +1000
+++ macros/global_macros.te	2004-11-03 02:32:03.000000000 +1100
@@ -269,7 +269,7 @@
 # Author:  Russell Coker <russell@coker.com.au>
 #
 define(`daemon_core_rules', `
-type $1_t, domain, privlog $2;
+type $1_t, domain, privlog, daemon $2;
 type $1_exec_t, file_type, sysadmfile, exec_type;
 
 role system_r types $1_t;
--- /usr/src/se/policy/attrib.te	2004-11-02 21:17:55.000000000 +1100
+++ attrib.te	2004-11-03 02:33:36.000000000 +1100
@@ -44,6 +44,10 @@
 # init to kill all processes.
 attribute domain;
 
+# The daemon attribute identifies domains for system processes created via
+# the daemon_domain, daemon_base_domain, and init_service_domain macros.
+attribute daemon;
+
 # The privuser attribute identifies every domain that can 
 # change its SELinux user identity.  This attribute is used 
 # in the constraints configuration.  NOTE:  This attribute

--Boundary-00=_qn6hBc6wQTfNja1--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
