Subject: Gdm shut my system down
From: Justin Smith <jsmith@mcs.drexel.edu>
To: SELinux@tycho.nsa.gov
Content-Type: text/plain
Date: 21 Jan 2002 14:43:58 -0500
Message-Id: <1011642238.1618.13.camel@jsmith.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I know GDM is not really approved for use in SELinux, but I tried the
patched version and got the following bizarre problem:

I got everything working, used it for a while and then logged out. When
I left my office, the GDM screen was on the monitor (I turned off the
monitor for the weekend). When I checked the system from home, it was
down.

Now I restarted it and checked the logs:

..................

Jan 18 15:25:28 vorpal gdm(pam_unix)[5736]: session closed for user
jsmith
Jan 18 15:25:28 vorpal gdm[5736]: gdm_slave_xioerror_handler: Fatal X
error - Restarting :0
Jan 18 15:25:28 vorpal gnome-name-server[9333]: input condition is:
0x11, exiting
Jan 18 15:25:31 vorpal modprobe: modprobe: Can't locate module
char-major-81
Jan 18 15:25:36 vorpal gdm[1184]: gdm_child_action: Master halting...
Jan 18 15:25:38 vorpal kernel: 
Jan 18 15:25:38 vorpal kernel: avc:  denied  { write } for  pid=1184
exe=/sbin/init path=/dev/initctl dev=03:01 ino=24199
scontext=system_u:system_r:gdm_t tcontext=system_u:object_r:initctl_t
tclass=fifo_file
Jan 18 15:25:39 vorpal Font Server[1136]: terminating 
Jan 18 15:25:39 vorpal xfs: xfs shutdown succeeded
Jan 18 15:25:40 vorpal gpm: gpm shutdown succeeded
Jan 18 15:25:41 vorpal kernel: 
Jan 18 15:25:41 vorpal kernel: avc:  denied  { unlink } for  pid=995
exe=/usr/sbin/httpd path=/run/httpd.mm.994.sem dev=03:05 ino=304630
scontext=system_u:system_r:httpd_t tcontext=system_u:object_r:var_run_t
tclass=file
Jan 18 15:25:44 vorpal httpd: httpd shutdown succeeded
Jan 18 15:25:44 vorpal sshd[869]: Received signal 15; terminating.
Jan 18 15:25:44 vorpal sshd: sshd -TERM succeeded
Jan 18 15:25:44 vorpal sendmail: sendmail shutdown succeeded


It looks to me as if the system did a normal shut down about 10 seconds
after I logged out (?!).  Unless some student tip-toed into my office
and shut it down from the GDM menu (I was giving both of my classes
online exams that were postponed by this outage), somehow GDM shut the
system down on its own. At least I'm not going to use GDM with SELinux
for a while...

Any ideas?

--



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
