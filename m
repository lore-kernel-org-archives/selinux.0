Subject: Forwarding X connections using ssh
From: Justin Smith <jsmith@mcs.drexel.edu>
To: SELinux@tycho.nsa.gov
Content-Type: text/plain
Date: 27 Mar 2002 12:56:22 -0500
Message-Id: <1017251782.2102.12.camel@jsmith.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am using the latest release (2.4.18) of SELinux with no patches
(beyond the bare release) and 

OpenSSH_3.1p1, SSH protocols 1.5/2.0, OpenSSL 0x0090602f
(with the sshd on the remote machine provided by SELinux)

 and have a problem forwarding X connections.

Whenever I log in to a remote machine that is in enforcing mode
I get the message

Last login: Wed Mar 27 12:36:49 2002 from
pool-141-158-41-46.phil.east.verizon.net
/usr/X11R6/bin/xauth:  timeout in locking authority file
/home/jsmith/.Xauthority


and X connections are not authorized. When the remote machine is in
permissive mode, there's no problem.

The STRANGE thing is that there are no error messages from the kernel
(so I can't modify the security policy to allow this).

When I do this in verbose mode, I get the messages:
debug2: x11_get_proto /usr/X11R6/bin/xauth list :0.0 2>/dev/null
debug1: Requesting X11 forwarding with authentication spoofing.
debug1: channel request 0: x11-req
debug1: channel request 0: shell
debug1: fd 3 setting TCP_NODELAY
debug2: callback done
debug1: channel 0: open confirm rwindow 0 rmax 32768
debug2: channel 0: rcvd adjust 131072


Any suggestions will be greatly appreciated!

-- 
______________________________________________________________________
Time blows wildly against my door       | Justin R. Smith
Stirring discarded sorrows      	| Department of Mathematics and
Like dead leaves of summers past        |     Computer Science
Memories of forgotten lore          	| Drexel University
Making way for new tomorrows         	| Philadelphia, PA 19104
New hopes, new fears,                   |
         and new ways that last         | Office: (215) 895-1847
URL: http://vorpal.mcs.drexel.edu       | Fax:    (215) 895-1582



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
