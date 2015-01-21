Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t0L4SPBa007310
 for <selinux@tycho.nsa.gov>; Tue, 20 Jan 2015 23:28:25 -0500
From: "Minear, Spencer" <Spencer_Minear@mcafee.com>
To: "SELinux (selinux@tycho.nsa.gov)" <selinux@tycho.nsa.gov>
Subject: What did I do wrong?
Date: Wed, 21 Jan 2015 04:28:17 +0000
Message-ID: <2cd599239cf54fb0956fa8de9f849c6b@MIVEXUSR1N02.corpzone.internalzone.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Wonder if someone could give me a pointer to what my policy file is missing that would result in the /sys/fs/selinux/user API not providing a context when the sshd process context is written to that API?  I can see the behavior in a strace capture.  I believe that the action is  a call from sshd to the security_compute_user entry in libselinux.

On a clean working system with the available default policy sshd writes in the sshd process's context and reads back the context that is ultimately applied to the shell process started by sshd.

Obviously I'm missing something or not including some critical information into the policy but I haven't been able to find any documentation that describes what goes on behind the scenes of this API.

Spence Minear

 
