Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2UJrQOh014524
 for <selinux@tycho.nsa.gov>; Mon, 30 Mar 2015 15:53:27 -0400
From: "Minear, Spencer" <Spencer_Minear@mcafee.com>
To: "SELinux (selinux@tycho.nsa.gov)" <selinux@tycho.nsa.gov>
Subject: Interpreter name reported in AVC comm field
Date: Mon, 30 Mar 2015 19:51:57 +0000
Message-ID: <91685a974f164d458eda1aa6d18c769b@MIVEXUSR1N02.corpzone.internalzone.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I have the following problem with adding SE Linux control to and existing system that makes it hard to interpret the policy deny audits.  

My specific issue is a system that makes use of a significant number programs that are really just shell scripts or python scripts.  For example say that /bin/XYZ starts with '#!/usr/bin/python'.   The first action of starting the XYZ program is to exec /bin/XYZ.  If there is a policy violation at this point in time the AVC audit will show the comm as "XYZ".  Thus making it easy to figure out which program one should be looking at.  However shortly after the program is started the kernel sees the reference to the interpreter at the start of the file and then it goes off and exec's /usr/bin/python.  After that point if a policy problem occurs the AVC audit comm field now contains "python" .    Given that there can be lots of python programs running at one time, it makes it quit difficult to determine what program is triggering the problem.

I did run into the same problem in another system that I've worked on a lot over the years.  In that case we addressed the problem by making a simple change in the kernel exec processing so the policy audit would provide the initial command name, which we viewed as being the more useful information, not the "last exec'd" interpreter name.  I have not looked at the Linux kernel code to assess the issues or to see if it may or may not be amenable to this type of change.  

Figure I'd ask to see if it has ever been considered.  If I'm really lucky there maybe a flag that that can be turned on that would allow me to change the behavior or maybe there are reasons why it was never done, or was deemed a bad thing to do. 

Spence
