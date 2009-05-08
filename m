Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n48B3imm026153
	for <selinux@tycho.nsa.gov>; Fri, 8 May 2009 07:03:44 -0400
Received: from mail-fx0-f164.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n48B3hsM026032
	for <selinux@tycho.nsa.gov>; Fri, 8 May 2009 11:03:43 GMT
Received: by fxm8 with SMTP id 8so1556764fxm.18
        for <selinux@tycho.nsa.gov>; Fri, 08 May 2009 04:03:42 -0700 (PDT)
Message-Id: <4D851E45-B2C0-4392-872A-CC329013FC73@gmail.com>
From: Sebastian Pfaff <sebastian.pfaff@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: does this picture reflect the basics of the current selinux architecture?
Date: Fri, 8 May 2009 13:03:40 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hello,

i created a picture about the selinux architecture some weeks ago, atm  
i'm not sure if everything is right within this picture. it would be  
nice, when someone could give me some proposals on how to improve /  
change / correct the picture. until now i found several pictures in  
papers (for example in USENIX papers) and magazines, but most of them  
differ slightly so i don't know which is right. Some of them are very  
old, so i don't know if i can trust them.

I know that "my" picture doesn't show everything, the intention is to  
only show the basics.

If you need additional please let me know. Any help is greatly  
appreciated. tnx in advance.

LINK TO PICTURE:

http://4.bp.blogspot.com/_OR3mMHaW6Iw/SgP9K42jAVI/AAAAAAAAAAU/i-bFA7iNkOA/s1600-h/sel_1_eng.png




(SOME) FURTHER INFORMATION:

BTW: a good online resource to the topic:
http://www.ibm.com/developerworks/linux/library/l-selinux/

and here (excerpt of book "Operating Systems Security" by T. Jaeger):
http://books.google.com/books?id=P4PYPSv8nBMC&printsec=frontcover#PPA127,M1

and here:
http://www.redhat.com/docs/manuals/enterprise/RHEL-4-Manual/selinux-guide/selg-chapter-0013.html
and here:
http://www.centos.org/docs/5/html/5.1/Deployment_Guide/s1-SELinux-overview.html

and here about LSM (Linux Security Modules: General Security Support  
for the Linux Kernel):
http://www.usenix.org/event/sec02/full_papers/wright/wright.pdf

german speaking ppl can find some limited information here (p. 231):
http://people.redhat.com/tscherf/articles/SELinux/selinux.pdf

and here (excerpt of book "SELinux & AppArmor" by Ralf Spenneberg (p.  
139), which seems to show the FLASK thing):
http://www.os-t.de/PDFs_SELinux/2363_Kap_11.pdf

Many other pics (in older papers) seems to rely mainly on FLASK  
architecture, i'm not sure if these pics reflect the current situation  
with selinux.

--
Sebastian Pfaff





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
