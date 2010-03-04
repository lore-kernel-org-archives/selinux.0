Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o24Iehgu017553
	for <selinux@tycho.nsa.gov>; Thu, 4 Mar 2010 13:40:43 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o24IeNt1004987
	for <selinux@tycho.nsa.gov>; Thu, 4 Mar 2010 18:40:24 GMT
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o24IefiR019626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 4 Mar 2010 13:40:42 -0500
Received: from localhost.localdomain (vpn-11-235.rdu.redhat.com [10.11.11.235])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o24IefTG016987
	for <selinux@tycho.nsa.gov>; Thu, 4 Mar 2010 13:40:41 -0500
Message-ID: <4B8FFEA9.9090800@redhat.com>
Date: Thu, 04 Mar 2010 13:40:41 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: I think this might be a bug.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If I have a program that calls setfscreatecon on a directory that has a 
transition, the transition rule wins.  I think the setfscreatecon should 
win.

Sandbox creates a .sandboxRANDOM directory in the current working 
directory with setfscreatecon, If I do this in ~dwalsh  It does not 
work.  If I do it in ~dwalsh/.sandbox or /tmp or any directory other 
then my homedir toplevel it works.

Here is a python script that shows the behaviour

#!/usr/bin/python
from tempfile import mkdtemp
import selinux, os
selinux.setfscreatecon("staff_u:object_r:sandbox_x_file_t:s0:c1")
homedir = mkdtemp(dir="~/.sandbox", prefix=".sandbox")
print selinux.getfscreatecon()
print homedir



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
