MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: /etc/selinux/  directory structure...
Date: Wed, 15 Jul 2009 11:25:40 -0400
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D06F02EC0@de01exm68.ds.mot.com>
References: <D06FE0A2807BC145B0D38744789D4F5D06817A56@de01exm68.ds.mot.com> <13D6E9E0302C0E4B9EE667132D21766C02B8342F@ala-mail09.corp.ad.wrs.com> 
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: <selinux@tycho.nsa.gov>
Cc: "Daniel J Walsh" <dwalsh@redhat.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi All,

I work on a product that uses Linux Kernel 2.6.21.  We are 
currently using the following SELinux libs and related package
versions:

checkpolicy      1.33.1
libselinux       2.0.13
libsemanage      2.0.1
libsepol         2.0.3
libsetrans       0.1.18
policycoreutils  2.0.16

I am implementing the "Strict" policy. And so I see the directory
structure on my machine as:  

-------------------------------------------
/etc/selinux/config  
/etc/selinux/restorecond.conf  
/etc/selinux/semanage.conf

/etc/selinux/strict/
/etc/selinux/strict/contexts/
/etc/selinux/strict/modules/
/etc/selinux/strict/policy/
/etc/selinux/strict/setrans.conf
/etc/selinux/strict/seusers

--------------------------------------------


We are moving to a newer Linux version 2.6.27 (that's packaged for us by
a third-party company), and as a result of this newer OS delivery, we
will automatically get moved to the SELinux package version:

checkpolicy      svn2950
libselinux       svn2950
libsemanage      svn2950
libsepol         svn2950
libsetrans       N/A
policycoreutils  svn2950


** My questions are:

1. I see the  /etc/selinux/   directory structure is quite different for
the svn2950 version!  Is it supposed to be that way ?

2. Is the difference in directory structure due to the svn2950 package
version, or is it because of a newer Linux kernel version ? (Linux
2.6.21  vs.  Linux 2.6.27)

3. Is the 'strict' policy supported in this svn2950 version?

4. In the LATEST officially released version(s) of the Selinux packages
from http://userspace.selinuxproject.org/trac/wiki/Releases, is the
/etc/selinux/  directory structure the same as I have described in the
---  block  ---   above, or did it change ?

5. Does the LATEST officially supported versions still support "strict"
policy, or does it only support "targeted" ??

6. Has the concept of "targeted" policy changed since about two years
ago ?

Thanks in advance for all your help.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
