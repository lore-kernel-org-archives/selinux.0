Message-ID: <20030813075008.81593.qmail@web13702.mail.yahoo.com>
Date: Wed, 13 Aug 2003 00:50:08 -0700 (PDT)
From: shravan kumar <shravanincosmos@yahoo.com>
Subject: Installation Problem
To: SELinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-8853002-1060761008=:81541"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-8853002-1060761008=:81541
Content-Type: text/plain; charset=us-ascii

I have problem in Installation of SE Linux at Red Hat 9 Linux. Please help.
 
Details are :
 
I downloaded linux-2.5-selinux-2003071106.tgz ( containing linux-2.5.74 kernel and selinux) option1 for downloading.
 
While compiling the kernel , I am getting error messages :
 
on doing # make modules
               make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
               CC [M]  drivers/char/riscom8.o
               In file included from drivers/char/riscom8.c:51: 
              drivers/char/riscom8.h:85: field `tqueue' has incomplete type
              drivers/char/riscom8.h:86: field `tqueue_hangup' has incomplete type   
              drivers/char/riscom8.c:84: warning: type defaults to `int' in declaration of   
             `DECLARE_TASK_QUEUE'
              drivers/char/riscom8.c:84: warning: parameter names (without types) in           function  declaration
              drivers/char/riscom8.c:135: confused by earlier errors, bailing out
               make[2]: *** [drivers/char/riscom8.o] Error 1
              make[1]: *** [drivers/char] Error 2 
              make: *** [drivers] Error 2
 
---------------------------------------------------
 
I used:
 
gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)
GNU Make version 3.79.1
 
 
 


---------------------------------
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
--0-8853002-1060761008=:81541
Content-Type: text/html; charset=us-ascii

<DIV>I have problem in Installation of SE Linux at Red Hat 9 Linux. Please help.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Details are :</DIV>
<DIV>&nbsp;</DIV>
<DIV>I downloaded linux-2.5-selinux-2003071106.tgz ( containing linux-2.5.74 kernel and selinux) option1 for downloading.</DIV>
<DIV>&nbsp;</DIV>
<DIV>While&nbsp;compiling the kernel , I am getting&nbsp;error messages :</DIV>
<DIV>&nbsp;</DIV>
<DIV>on doing # make modules</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CC [M]&nbsp; drivers/char/riscom8.o<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; In file included from drivers/char/riscom8.c:51:&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;drivers/char/riscom8.h:85: field `tqueue' has incomplete&nbsp;type</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drivers/char/riscom8.h:86: field `tqueue_hangup' has incomplete type&nbsp;&nbsp;&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  drivers/char/riscom8.c:84: warning: type defaults to `int' in declaration of &nbsp;&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  `DECLARE_TASK_QUEUE'</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drivers/char/riscom8.c:84: warning: parameter names (without types) in&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;function&nbsp;&nbsp;declaration<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;drivers/char/riscom8.c:135: confused by earlier errors, bailing out<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;make[2]: *** [drivers/char/riscom8.o] Error 1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; make[1]: *** [drivers/char] Error 2&nbsp;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; make: *** [drivers] Error 2</DIV>
<DIV>&nbsp;</DIV>
<DIV>---------------------------------------------------</DIV>
<DIV>&nbsp;</DIV>
<DIV>I used:</DIV>
<DIV>&nbsp;</DIV>
<DIV>gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)<BR>GNU Make version 3.79.1</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV><p><hr SIZE=1>
Do you Yahoo!?<br>
<a href="http://us.rd.yahoo.com/evt=10469/*http://sitebuilder.yahoo.com">Yahoo! SiteBuilder</a> - Free, easy-to-use web site design software
--0-8853002-1060761008=:81541--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
