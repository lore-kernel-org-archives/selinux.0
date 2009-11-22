Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nAMDO6w3007722
	for <selinux@tycho.nsa.gov>; Sun, 22 Nov 2009 08:24:06 -0500
Received: from web87005.mail.ird.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id nAMDQDWR002493
	for <selinux@tycho.nsa.gov>; Sun, 22 Nov 2009 13:26:13 GMT
Message-ID: <587686.20145.qm@web87005.mail.ird.yahoo.com>
Date: Sun, 22 Nov 2009 13:24:04 +0000 (GMT)
From: RICHARD HAINES <richard_c_haines@btinternet.com>
Subject: SELinux document - any use!!!
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've been putting an SELinux document together as I've been learning SELinux and thought it may be useful for others so I've added a GNU document license and installed it on the following site for download:

http://www.freetechbooks.com/efiles/selinuxnotebook/The_SELinux_Notebook_The_Foundations.pdf

http://www.freetechbooks.com/efiles/selinuxnotebook/notebook-source-1.0.0-1.tar.gz

The supporting notebook-source-1.0.0-1.tar.gz file contains some examples to build a simple message filter that are explained in the Notebook. 

These samples are based on a policy similar to the 'Make Dummy Policy' in the 2.6.28 kernel scripts section. I've also used tools like apol, sechecker etc. to investigate the policy.

I've also been through all the:

 1) SELinux configuration files and documented them (well those that are in the Fedora 10 distro  and I'll add the "Configuring libsemanage to invoke a policy checker" in the next release).

 2) SELinux language statements and updated them to reflect policy version 23 with examples from the Reference Policy source.

There is also other SELinux information that may or may not be useful, so if anyone wants the document source for their own use let me know (it's written with openoffice.org and is an ODT file).

I plan to keep the document updated as I use SELinux so if you have any corrections let me know (as there are bound to be errors somewhere).

Regards
Richard Haines




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
