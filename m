Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2V5GilO005403
	for <selinux@tycho.nsa.gov>; Tue, 31 Mar 2009 01:16:44 -0400
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2V5GhaF016893
	for <selinux@tycho.nsa.gov>; Tue, 31 Mar 2009 05:16:43 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n2V5GgQa015946
	for <selinux@tycho.nsa.gov>; Tue, 31 Mar 2009 01:16:42 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n2V5Gh35028292
	for <selinux@tycho.nsa.gov>; Tue, 31 Mar 2009 01:16:43 -0400
Received: from localhost.localdomain (dhcp-1-16.bne.redhat.com [10.64.1.16])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n2V5GeKA032500
	for <selinux@tycho.nsa.gov>; Tue, 31 Mar 2009 01:16:41 -0400
Date: Tue, 31 Mar 2009 15:16:38 +1000
From: Scott Radvan <sradvan@redhat.com>
To: selinux@tycho.nsa.gov
Subject: request for review of httpd-related Boolean definitions
Message-ID: <20090331151638.770627cb@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all,



I am working on a Fedora 11 guide [1] on managing confined services
using SELinux, and I am currently attempting to expand on the
descriptions of the available Booleans. 

Currently looking at the httpd-related Booleans, one I am having
particular problems with is httpd_execmem. I am so far unable to find a
simple description of what this Boolean is and what having it
enabled/disabled actually causes/stops. I have looked at the manpages,
sesearch, semanage and system-config-selinux - none of which say a lot
regarding it, and online resources such as [2] I must admit go largely
over my head! Any brief-ish description of httpd_execmem anybody on this
list can provide would be great.

Further to that, below I have listed the descriptions that I have so
far of each of the httpd-related Booleans. 

I would greatly appreciate any input or review of them at all to ensure
that these brief descriptions are accurate.



o  allow_httpd_anon_write
This Boolean is off by default, allowing httpd only read access to
files labeled with the public_content_rw_t type. Enabling this Boolean
will allow httpd to write to files labeled with the public_content_rw_t
type, such as a public directory containing files for a public file
transfer service. 

o  allow_httpd_mod_auth_ntlm_winbind
This Boolean is off by default. Enabling it will allow access to NTLM
and Winbind authentication mechanisms via the mod_auth_ntlm_winbind
module in httpd. 

o  allow_httpd_mod_auth_pam
This Boolean is off by default. Enabling it will allow access to PAM
authentication mechanisms via the mod_auth_pam module in httpd.

o  allow_httpd_sys_script_anon_write
This Boolean is off by default. It defines whether or not HTTP scripts
are allowed write access to files labeled with the public_content_rw_t
type, as used in a public file transfer service.

o  httpd_builtin_scripting 
This Boolean is on by default, allowing httpd scripting. Having this
Boolean enabled is often required for PHP content.

o  httpd_can_network_connect
This Boolean is off by default, preventing HTTP scripts and modules
from initiating a connection to a network or remote port. Turn this
Boolean on to allow this access. 

o  httpd_can_network_connect_db
This Boolean is off by default, preventing HTTP scripts and modules
from initiating a connection to database servers. Turn this Boolean on
to allow this access. 

o  httpd_can_network_relay
Turn this Boolean on when httpd is being used as a forward or
reverse proxy. 

o  httpd_can_sendmail
This Boolean is off by default, preventing HTTP modules from sending
mail. This can prevent spam attacks should a vulnerability be found in
httpd. Turn this Boolean on to allow HTTP modules to send mail.

o  httpd_dbus_avahi
This Boolean is off by default, denying httpd access to the avahi
service via dbus. Turn this Boolean on to allow this access.

o  httpd_enable_cgi
By default, SELinux prevents httpd from executing CGI scripts. Turn
this Boolean on to allow httpd to execute CGI scripts (CGI scripts must
be labeled with the httpd_sys_script_exec_t type).

o  httpd_enable_ftp_server
Turning this Boolean on will allow httpd to listen on the FTP port and
act as an FTP server. 

o  httpd_enable_homedirs
By default, SELinux prevents httpd from accessing user home
directories. Turn this Boolean on to allow httpd access to user home
directories, for example, /home/*/public_html/. 

o  httpd_execmem
???

o  httpd_ssi_exec
Off by default, this Boolean makes sure that httpd can only execute
shell scripts that have the shell_exec_t type assigned to them.
Enabling this Boolean will allow httpd to execute any script.

o  httpd_tty_comm
This Boolean defines whether or not httpd is allowed access to the
controlling terminal. Usually this access is not required; however in
cases such as configuring an SSL certificate file, terminal access is
required to display and process a password prompt. 

o  httpd_unified
This Boolean is off by default, turning it on will allow all httpd
executables to have full access to all content labeled with http file
context. Leaving it off ensures that one httpd service can not
interfere with another, limiting the opportunity for privilege
escalation vulnerability.

o  httpd_use_cifs 
Turn this Boolean on to allow httpd access to files on CIFS file
systems that are labeled with the cifs_t type, such as file systems
mounted via Samba. 

o  httpd_use_nfs
Turn this Boolean on to allow httpd access to files on NFS file systems
that are labeled with the nfs_t type, such as file systems mounted via
NFS.


All comments are more than welcome! Again, thank you.



[1] - https://fedorahosted.org/managing-confined-services/
[2] - http://people.redhat.com/drepper/selinux-mem.html


Cheers,


-- 
Scott Radvan
Content Author, Platform (Installation and Deployment)
Red Hat APAC (Brisbane) http://www.apac.redhat.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
