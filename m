Message-Id: <200209031647.QAA25434@jazzband.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: can_exec_read macro
Date: Tue, 3 Sep 2002 18:45:43 +0200
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi !

What is the difference between this tow macros: can_exec and  
can_exec_read? I see none. 
Both use the rx_file_perms macro. And in my opinion is the second read in 
can_exec_read unnecessary. The rx_file_perms macro contains it.

We should change it. Or?

Carsten


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
