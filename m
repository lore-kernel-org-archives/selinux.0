Subject: udp receive
From: Timothy Wood <timothy@hallcomp.com>
To: SELinux <SELinux@tycho.nsa.gov>
Content-Type: text/plain
Date: 03 Jul 2002 09:56:44 -0400
Message-Id: <1025704604.3619.11.camel@phobos>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm getting a recvfrom error for rpc.rquotad when I try to run nfs
services.  I can find a can_udp_send in the rpcd.te but I can not find
anything like can_udp_recv.  Is there anything like this that I need to
assign to the rpc.te in order to allow it to recv udp?

Timothy,


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
