Date: Wed, 2 Apr 2003 13:17:36 -0700
From: "L. Dean Risinger Jr." <deanr@acl.lanl.gov>
To: SELinux@tycho.nsa.gov
Cc: kbintz@lanl.gov
Subject: Possible bug in build for scsi
Message-ID: <20030402131736.A795@acl.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Problem: Apparent bug in build system for scsi

Machine: Compaq SP700 dual Pentium 3 with adaptec scsi drive

OS: Redhat Linux 8.0 with kernel 2.4.18smp

SELinux version: 2.4 LSM-based Prototype

SELinux Configuration: Default, with the addition of support for the
ext3 filesystem.  Trying to build kernel 2.4.20

Steps followed:  
      unzipped/untarred source into /root

      cd /root/selinux
      cd module
      make insert

      cd /root/lsm-2.4
      make menuconfig
      make dep
      make 
      make modules
      make install

Error:  

make install terminated during the call to 

     /sbin/installkernel 2.4.20-selinux bzImage /root/lsm-2.4/System.map

with the error "No module sym53c8xx found for kernel 2.4.20-selinux".
Note that the source and .o file exist in 
     
     /root/lsm-2.4/drivers/scsi

and were sucessfully linked into elf_i386.  There are symbols from
sym53c8xx in /root/lsm-2.4/System.map

-- 
        L. Dean Risinger Jr.
        CCS-1, LANL
        llama@lanl.gov
        +1 505 665 4243

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
