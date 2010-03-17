Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2HHc3oK007081
	for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2010 13:38:03 -0400
Received: from mail-px0-f176.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o2HHbfqf008867
	for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2010 17:37:41 GMT
Received: by pxi6 with SMTP id 6so817224pxi.18
        for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2010 10:38:01 -0700 (PDT)
From: Bill Chimiak <wch1m1@gmail.com>
To: selinux@tycho.nsa.gov
Subject: vmplayer problems on FC12
Date: Wed, 17 Mar 2010 13:37:07 -0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201003171337.08718.w.chimiak@ieee.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am having problems getting vmplayer (VMware Player) 
to run on Fedora Core 12.  Any suggestions?

Here are the Raw Audit Messages:

node=localhost type=AVC msg=audit(1268701051.828:64): avc: denied { search } 
for pid=5187 comm="portrelease" name="vmware" dev=sdd1 ino=30236681 
scontext=unconfined_u:system_r:portreserve_t:s0 
tcontext=unconfined_u:object_r:vmware_file_t:s0 tclass=dir

node=localhost type=SYSCALL msg=audit(1268701051.828:64): arch=40000003 
syscall=5 success=no exit=-13 a0=bfd83dc0 a1=0 a2=0 a3=8 items=0 ppid=5179 
pid=5187 auid=500 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 
tty=pts7 ses=4 comm="portrelease" exe="/sbin/portreserve" 
subj=unconfined_u:system_r:portreserve_t:s0 key=(null)


The selinux troubleshooter gives this additional info:
Summary
SELinux is preventing /sbin/portreserve "search" access on /opt/vmware.

Additional Information
Source Context: unconfined_u:system_r:portreserve_t:s0
Target Context: unconfined_u:object_r:vmware_file_t:s0
Target Objects: /opt/vmware [ dir ]
Source:         portrelease
Source Path:    /sbin/portreserve
Port:           <Unknown>
Host:   host
Source RPM Packages:    portreserve-0.0.4-3.fc12
Target RPM Packages:
Policy RPM:     selinux-policy-3.6.32-99.fc12
Selinux Enabled:
TruePolicy Type:        targeted
Enforcing Mode: Enforcing
Plugin Name:    catchall
Host Name:      darc
Platform:       Linux darc 2.6.32.9-70.fc12.i686.PAE #1 SMP Wed Mar 3 04:57:21 
UTC 2010 i686 athlon
Alert Count:    8
First Seen:     Mon 15 Mar 2010 08:57:31 PM EDT
Last Seen:      Mon 15 Mar 2010 08:57:31 PM EDT
Local ID:       6abf0814-f80f-4d9d-a67a-e5d87bed660e


-- 
William J. Chimiak
Laboratory for Telecommunication Sciences 
8080 Greenmead Drive,  College Park, MD 20740
301-422-5217

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
