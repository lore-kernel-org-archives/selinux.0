Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9OCDYgj003311
	for <selinux@tycho.nsa.gov>; Wed, 24 Oct 2007 08:13:34 -0400
Received: from wa-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l9OCDXjT022726
	for <selinux@tycho.nsa.gov>; Wed, 24 Oct 2007 12:13:34 GMT
Received: by wa-out-1112.google.com with SMTP id k22so208806waf
        for <selinux@tycho.nsa.gov>; Wed, 24 Oct 2007 05:13:30 -0700 (PDT)
Message-ID: <9d1b82480710240513v269f8075yee754ada43ffca60@mail.gmail.com>
Date: Wed, 24 Oct 2007 17:43:30 +0530
From: Pravin <shindepravin@gmail.com>
To: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov
Subject: userspace Process Classifier based on SELinux Security Contexts for CPUSET, ELSA and Containers
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

We are trying to solve the problem that, resource management solutions
like CPUSET and Containers do need manual process classification into
virtual filesystem provided by them as an interface. Also this
classification needs to use PID of a process, so the classification
can be done only after process is created. And this classification is
not persist ant as if process is restarted then PID changes and it
needs to be re-classified again.

To solve above problem we are working on an idea of using SELinux
security contexts as persistent tokens for classification of
processes. Unlike PID of a process, SELinux security context does not
change when process is restarted or machine is rebooted. So, if we can
write rules using on these security contexts, then automatic process
classification can be done entirely from userspace.

We are using connectors for receiving notifications from kernel about
events (ie. fork, exec, id change(uid, gid, suid), exit) in process
management. We check the security context of process using system call
"getpidcon" after system calls like fork and exec. and we use this
security context to classify the process by comparing this security
context against the security-contexts provided by
system-administrators for classification. These rules provided by
system administrators can be used to classify processes in respective
class of CPUSET or containers.
We also provide wild-character support in security context matching.

We are using SELinux security context because they are persistent,
flexible and configurable.
For more reasons,
http://pcss.sourceforge.net/faq.html

Please refer the diagrams at http://pcss.sourceforge.net and
http://pcss.sourceforge.net/pcss_cpuset.html for architecture of the design.

The code for application which will work with CPUSET is hosted on
sourceforge site.
http://pcss.sourceforge.net/pcss-cpuset.tar
This code is not very extensively tested, so there may be some problems with it.

We have also applied similar solution to ELSA (Enhanced Linux System Accounting)
http://elsa.sourceforge.net/

We are also working on using it for classification for containers.
Currently work is
 not yet over for containers.

We are looking forward for some feedback/criticism about the Idea,
architecture of the solution and the code.
We think that it will be helpful in reducing the burden of system
administrators as it uses
all existing infrastructure to provide automatic classification
solutions for different applications which need them.

-- 
Regards,
Pravin Shinde
http://pcss.sourceforge.net

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
