Message-ID: <40895691.8000306@redhat.com>
Date: Fri, 23 Apr 2004 13:46:57 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: SELinux@tycho.nsa.gov
Subject: Re: Oddness with password aging and related..
References: <200404162308.i3GN8Bf5000929@turing-police.cc.vt.edu>
In-Reply-To: <200404162308.i3GN8Bf5000929@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following patches have  been added to Fedora Policy

--- policy-1.11.2/domains/program/unused/xdm.te.20040423        
2004-04-23 09:51:22.000000000 -0400
+++ policy-1.11.2/domains/program/unused/xdm.te 2004-04-23 
13:44:39.415634000 -0400
@@ -314,3 +314,4 @@
 # VNC v4 module in X server
 type vnc_port_t, port_type;
 allow xdm_xserver_t vnc_port_t:tcp_socket name_bind;
+allow xdm_t crack_db_t:file { getattr read };


--- policy-1.11.2/domains/program/login.te.20040423     2004-04-23 
09:51:22.000000000 -0400
+++ policy-1.11.2/domains/program/login.te      2004-04-23 
13:44:08.306363328 -0400
@@ -88,6 +88,8 @@
 allow xdm_t $1_login_t:process { signull };
 ')

+allow $1_login_t crack_db_t:file { getattr read };
+


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
