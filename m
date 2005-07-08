Message-ID: <42CEAE9E.5090902@redhat.com>
Date: Fri, 08 Jul 2005 12:49:34 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: gyurdiev@redhat.com, Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux <SELinux@tycho.nsa.gov>
Subject: libsemod????
References: <1120744424.514.23.camel@celtics.boston.redhat.com>	 <1120826367.19035.26.camel@moss-spartans.epoch.ncsc.mil>	 <1120830443.17407.15.camel@celtics.boston.redhat.com>	 <1120831505.19035.70.camel@moss-spartans.epoch.ncsc.mil> <1120833363.17407.30.camel@celtics.boston.redhat.com>
In-Reply-To: <1120833363.17407.30.camel@celtics.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Why are we creating more libraries?  What benefit does the added 
complexity give us?  Why not just have one library for policy file 
management and one for selinux management?  A developer using these 
libraries in the future is not going to care about selinux/sepol/semod.  
He wants to build an selinux aware app he will probably want to link to 
libselinux.

 ls -l /lib/libse*
-rwxr-xr-x  1 root root  77192 Jun 29 16:08 /lib/libselinux.so.1
-rwxr-xr-x  1 root root 135140 Jul  7 07:15 /lib/libsepol.so.1

Are these libraries too large.  I do not want to add additional packages 
just for libraries.

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
