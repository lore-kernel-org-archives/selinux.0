From: "Ed Street" <edstreet@street-tek.com>
To: <russell@coker.com.au>
Cc: "'SELinux'" <SELinux@tycho.nsa.gov>
Subject: RE: apache-ssl mods for Debian
Date: Mon, 12 Apr 2004 16:14:42 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
In-Reply-To: <200404121629.46537.russell@coker.com.au>
Message-Id: <20040412201442.A6A473A4058@abyss.simplyaquatics.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

This time I get the following. 

When I start apache-ssl, run_init /etc/init.d/apache-ssl I get the
following.


avc:  denied  { read } for  pid=12580 exe=/usr/sbin/run_init
path=pipe:[4995] dev= ino=4995 scontext=blacknet:sysadm_r:run_init_t
tcontext=blacknet:sysadm_r:sysadm_su_t tclass=fifo_file

avc:  denied  { getattr } for  pid=12580 exe=/usr/sbin/run_init
path=/proc/12580/mounts dev= ino=824442896
scontext=blacknet:sysadm_r:run_init_t tcontext=blacknet:sysadm_r:run_init_t
tclass=file

avc:  denied  { getattr } for  pid=12581 exe=/sbin/unix_chkpwd
path=/proc/12581/mounts dev= ino=824508432
scontext=blacknet:sysadm_r:sysadm_chkpwd_t
tcontext=blacknet:sysadm_r:sysadm_chkpwd_t tclass=file

avc:  denied  { read } for  pid=12583 exe=/bin/bash name=selinux dev=hda3
ino=1785904 scontext=system_u:system_r:initrc_t
tcontext=system_u:object_r:policy_src_t tclass=lnk_file

avc:  denied  { read } for  pid=12582 exe=/bin/bash name=selinux dev=hda3
ino=1785904 scontext=system_u:system_r:initrc_t
tcontext=system_u:object_r:policy_src_t tclass=lnk_file

avc:  denied  { search } for  pid=12587 exe=/usr/sbin/apache-ssl
name=apache-ssl dev=hda3 ino=2457683 scontext=system_u:system_r:httpd_t
tcontext=system_u:object_r:httpd_exec_t tclass=dir

avc:  denied  { search } for  pid=12588 exe=/usr/sbin/apache-ssl
name=apache-ssl dev=hda3 ino=2457683 scontext=system_u:system_r:httpd_t
tcontext=system_u:object_r:httpd_exec_t tclass=dir

avc:  denied  { search } for  pid=12589 exe=/usr/sbin/apache-ssl
name=apache-ssl dev=hda3 ino=2457683 scontext=system_u:system_r:httpd_t
tcontext=system_u:object_r:httpd_exec_t tclass=dir

avc:  denied  { search } for  pid=12591 exe=/usr/sbin/apache-ssl
name=apache-ssl dev=hda3 ino=2457683 scontext=system_u:system_r:httpd_t
tcontext=system_u:object_r:httpd_exec_t tclass=dir

When I lynx https://localhost/ I get the following.


avc:  denied  { write } for  pid=12592 exe=/usr/sbin/apache-ssl
name=gcache_port dev=hda3 ino=2539552 scontext=system_u:system_r:httpd_t
tcontext=system_u:object_r:var_run_t tclass=sock_file

This is why I used r_dir_file and the exec line, it was the closest match I
could find to what I needed.

Ed

---

Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.656 / Virus Database: 421 - Release Date: 4/9/2004
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
