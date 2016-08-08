Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u78I5MRE012289
 for <selinux@tycho.nsa.gov>; Mon, 8 Aug 2016 14:05:22 -0400
From: "Parker, Michael D." <Michael.D.Parker@ga.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: RE: --EXTERNAL--Any way to label /proc/self/mem with a different type
 then the process type.
Date: Mon, 8 Aug 2016 18:04:58 +0000
Message-ID: <44c7d76803e84bacacdfe03c448d4ac6@ASGEXCPWP01.ga.com>
References: <8f97fb23-65b5-bef5-bbae-f6139a2766f4@redhat.com>
In-Reply-To: <8f97fb23-65b5-bef5-bbae-f6139a2766f4@redhat.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hmmmm......
The permission on /proc/self/mem is 0600 with the owner being the process username and its group.
In checking Centos 6.8 and 7.2 and Fedora 24 all with current patching, I find that I cannot read /proc/self/mem by either the owner (me) or root for any process. 
But interestingly I can write to it but do not understand the ramifications of that action.
I am running targeted / enforcing SELinux on all three but I see no avc problems in the audit.log for the read.

I am wondering what the use case for writing to /proc/self/mem is?

***** ***** *****
Michael D. Parker
General Atomics - EMS
Michael.d.parker@ga.com  <<<<< NOTE: Remember to include my middle initial >>>>>
+1 858 964 6675 / Office 86-1319
16969 Mesamint Street / San Diego / CA / 92127

************************************************************************
CONFIDENTIALITY NOTICE: This communication is intended to be confidential to the 
person(s) to whom it is addressed.  If you are not the intended recipient or the agent of the 
intended recipient or if you are unable to deliver this communication to the intended 
recipient, you must not read, use or disseminate this information.  If you have received 
this communication in error,please advise the sender immediately by telephone and delete 
this messageand any attachments without retaining a copy.
*************************************************************************


-----Original Message-----
From: Selinux [mailto:selinux-bounces@tycho.nsa.gov] On Behalf Of Daniel J Walsh
Sent: Monday, August 08, 2016 10:42 AM
To: SELinux <selinux@tycho.nsa.gov>
Subject: --EXTERNAL--Any way to label /proc/self/mem with a different type then the process type.

I have been requested by some container people to make this only readable not writable to prevent certain types of attacks on the

kernel.  No idea if this is a good idea or not.

_______________________________________________
Selinux mailing list
Selinux@tycho.nsa.gov
To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
