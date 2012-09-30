Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q8UHmagF019171
	for <selinux@tycho.nsa.gov>; Sun, 30 Sep 2012 13:48:36 -0400
Received: by vbbfc21 with SMTP id fc21so5433808vbb.12
        for <selinux@tycho.nsa.gov>; Sun, 30 Sep 2012 10:48:04 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 30 Sep 2012 19:48:04 +0200
Message-ID: <CAPzO=NydFKroZ5_+_3NK1QYcn37QqAaDeSMW+7NGjc==iFKZQQ@mail.gmail.com>
Subject: run_init change in latest policycoreutils
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi guys,

For Gentoo, I've been using run_init for things like:

~# run_init rc-service vixie-cron start

This rc-service script (labeled bin_t) acts not that different from
Redhat's service script, like:

~# run_init service vixie-cron start

Up until policycoreutils 2.1.10, this worked just fine. However, with
policycoreutils 2.1.13, I get the following error:

~# run_init rc-service vixie-cron start
Authenticating root.
execvp: Permission denied

The "Authenticating root." is normal. The execvp error isn't. I get
the following denial, but I don't think this is the cause of the error
(mainly because it worked previously):

Sep 30 19:44:02 testsys kernel: [20516.783063] type=1400
audit(1349027042.720:264): avc:  denied  { entrypoint } for  pid=20672
comm="run_init" path="/sbin/rc-service" dev="vda1" ino=2373161
scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:bin_t
tclass=file

Between 2.1.10 and 2.1.13, the following change was made to the run_init code:

--- policycoreutils-2.1.10/run_init/run_init.c  2011-12-21
18:46:04.000000000 +0100
+++ policycoreutils-2.1.13.pristine/run_init/run_init.c 2012-09-29
11:08:41.267304041 +0200
@@ -406,6 +406,13 @@
                        new_context);
                exit(-1);
        }
+       if (! access("/usr/sbin/open_init_pty", X_OK)) {
+               if (execvp(argv[1], argv + 1)) {
+                       perror("execvp");
+                       exit(-1);
+               }
+               return 0;
+       }
        /*
         * Do not execvp the command directly from run_init; since it would run
         * under with a pty under sysadm_devpts_t. Instead, we call
open_init_tty,

I'm assuming this is the cause of the failure, but I'm not sure why.
The /usr/sbin/open_init_pty binary is labeled initrc_exec_t, and
sysadm_t has the necessary rights to it (plus I'm running this as
root, so DAC should be OK too). Can anyone shed any lights to this?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
