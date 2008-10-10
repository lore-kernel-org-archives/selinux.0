Date: Fri, 10 Oct 2008 05:07:44 +0000 (GMT)
From: korkishko Tymur <k.tymur@samsung.com>
Subject: Genfscon 'dash' issue
To: SELinux@tycho.nsa.gov
Reply-to: k.tymur@samsung.com
Message-id: <18500085.31951223615264682.JavaMail.weblogic@epml14>
MIME-version: 1.0
MIME-version: 1.0
Content-type: text/plain; charset=windows-1252
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello! 

I have Linux kernel 2.6.26 with a patch from NSA that allows genfscon support of security contexts for directories/files (others than / ). 
I use genfscon to label files/directories on cramfs filesystem(read-only filesystem) that does not support xattr. 

It seems that current genfscon implementation does not support “–“(dash) in path names. If I try to compile policy containing this line: 
genfscon          cramfs /usr/sbin/an-app           user_u:system_r:my_app_t 

I will get an syntax error from checkpolicy aboutusing “– “ (dash) in the path:
ERROR ‘invalid type app’ at token ‘genfscon’ on line... 

So, could you please suggest a way to fix theissue with “– “ (dash) and genfscon? 

Unfortunately, it is not possible to change “–“(dash) to “_” (underbar) in path names.  

Kindest regards,
Tymur Korkishko
 
 
 
 
 
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
