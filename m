Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h35GlRI4010383
	for <selinux@tycho.nsa.gov>; Sat, 5 Apr 2003 11:47:27 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h35GhlOv021241
	for <selinux@tycho.nsa.gov>; Sat, 5 Apr 2003 16:43:47 GMT
Received: from horkos.telenet-ops.be (horkos.telenet-ops.be [195.130.132.45])
	by jazzswing.ncsc.mil  with ESMTP id h35GhkY1021238
	for <selinux@tycho.nsa.gov>; Sat, 5 Apr 2003 16:43:47 GMT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by horkos.telenet-ops.be (Postfix) with SMTP id 2FFD083BFA
	for <selinux@tycho.nsa.gov>; Sat,  5 Apr 2003 18:47:10 +0200 (CEST)
Received: from kabel.telenet.be (D5775F15.kabel.telenet.be [213.119.95.21])
	by horkos.telenet-ops.be (Postfix) with ESMTP id ACCF583C9D
	for <selinux@tycho.nsa.gov>; Sat,  5 Apr 2003 18:46:59 +0200 (CEST)
Date: Sat, 5 Apr 2003 18:46:54 +0200
From: Kurt Roeckx <Q@ping.be>
To: selinux@tycho.nsa.gov
Subject: sshd problem.
Message-ID: <20030405164654.GA3200@ping.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If I run run_init /etc/init.d/ssh start it fails to start, even in
permissive mode.  I have no idea why it fails, I see nothing in
the logs.

If I run strace -f run_init /etc/init.d/ssh start, it starts
without problems, which currently seems to be the only way I can
make it start properly.

Note that it starts up properly when it boots.

I'm using Bryan May's version on debian woody.

run_init strace -f /etc/init.d/ssh start shows this at the end:

[pid  6267] fstat64(0, {st_mode=S_IFIFO|0600, st_size=0, ...}) =
0
[pid  6267] read(0, "/etc/init.d/ssh: /usr/sbin/sshd:"..., 32768)
= 51
[pid  6267] read(0, "", 32768)          = 0
[pid  6267] close(1)                    = 0
[pid  6267] _exit(1)                    = ?
[pid  6265] <... wait4 resumed> [WIFEXITED(s) && WEXITSTATUS(s)
== 1], 0, NULL)
= 6267
[pid  6265] wait4(-1, [WIFEXITED(s) && WEXITSTATUS(s) == 1], 0,
NULL) = 6266
[pid  6265] rt_sigprocmask(SIG_BLOCK, [CHLD TTOU], [CHLD], 8) = 0
[pid  6265] rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) = 0
[pid  6265] rt_sigprocmask(SIG_BLOCK, [CHLD], [CHLD], 8) = 0
[pid  6265] rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) = 0
[pid  6265] rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) = 0
[pid  6265] rt_sigaction(SIGINT, {0x807a900, [], SA_RESTORER,
0x400826b8}, {0x806e2f8, [], SA_RESTORER, 0x400826b8}, 8) = 0
[pid  6265] close(3)                    = -1 EBADF (Bad file
descriptor)
[pid  6265] rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
[pid  6265] --- SIGCHLD (Child exited) @ 0 (0) ---
[pid  6265] wait4(-1, 0xbffff620, WNOHANG, NULL) = -1 ECHILD (No
child processes)
[pid  6265] sigreturn()                 = ? (mask now [])
[pid  6265] _exit(1)                    = ?
<... wait4 resumed> [WIFEXITED(s) && WEXITSTATUS(s) == 1], 0,
NULL) = 6265
rt_sigprocmask(SIG_BLOCK, [CHLD TTOU], [CHLD], 8) = 0
rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [CHLD], 8) = 0
rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
wait4(-1, 0xbffff738, WNOHANG, NULL)    = -1 ECHILD (No child
processes)
sigreturn()                             = ? (mask now [])
rt_sigaction(SIGINT, {SIG_DFL}, {0x806e2f8, [], SA_RESTORER,
0x400826b8}, 8) = 0rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
_exit(0)                                = ?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
