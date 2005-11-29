Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jATEj7MA015057
	for <selinux@tycho.nsa.gov>; Tue, 29 Nov 2005 09:45:07 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jATEfMPZ023509
	for <selinux@tycho.nsa.gov>; Tue, 29 Nov 2005 14:41:22 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id jATEfMKB019903
	for <selinux@tycho.nsa.gov>; Tue, 29 Nov 2005 09:41:22 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id jATEfMV25038
	for <selinux@tycho.nsa.gov>; Tue, 29 Nov 2005 09:41:22 -0500
Message-ID: <438C689B.2040900@redhat.com>
Date: Tue, 29 Nov 2005 09:41:31 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>, redhat-lspp <redhat-lspp@redhat.com>
Subject: semanage utiliy is in policycoreutils.  login (selinux user mappings)
 and user is working somewhat.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

semanage(8)                                                        
semanage(8)

NAME
       semanage - SELinux Policy Management tool

SYNOPSIS
       semanage   OBJECTTYPE   [-admsrh]   OBJECT 
       semanage  login  [-admsrh]  login_name
       semanage user [-admsrh] selinux_name
       semanage port [-admth] port_number

       This tool is used to manage configuration of the SELinux policy

DESCRIPTION
       This manual page describes the semanage program.
       This tool is used to manage configuration of SELinux Policy.   
You  can
       configure  SELinux User Mappings, SELinux Port Mappings, SELinux 
Users.

OPTIONS
                       -a, --add

       Add a OBJECT record NAME -d, --delete

       Delete a OBJECT record NAME -h, --help

       display this message -l, --list

       List the OBJECTS -m, --modify

       Modify a OBJECT record NAME -r, --range

       MLS/MCS Security Range -s, --seuser

       SELinux user name -t, --type

       SELinux Type for the object -v, --verbose

       verbose output

AUTHOR
       This man page was written by Daniel Walsh <dwalsh@redhat.com>.


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
