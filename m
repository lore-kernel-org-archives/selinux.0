Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o47KHkMa029183
	for <selinux@tycho.nsa.gov>; Fri, 7 May 2010 16:17:46 -0400
Received: from mxout-08.mxes.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o47INrWb008131
	for <selinux@tycho.nsa.gov>; Fri, 7 May 2010 18:23:53 GMT
Message-ID: <20100507192427.9mwu09kubk0w44o0@legacy.mxes.net>
Date: Fri, 07 May 2010 19:24:27 +0100
From: Martin Orr <martin@martinorr.name>
To: selinux@tycho.nsa.gov, sysvinit-devel@nongnu.org
Cc: 580272@bugs.debian.org
Subject: sysvinit 2.88 and SELinux policy
MIME-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	format="flowed"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

With sysvinit 2.88 my SELinux policy is not loaded on boot; with 
sysvinit 2.87 everything worked fine.  I am running Debian; my 
initramfs mounts /proc but does not know about SELinux.

Here are the two pieces of code:

Old code:
    if (getenv("SELINUX_INIT") == NULL && !is_selinux_enabled()) {
            putenv("SELINUX_INIT=YES");
            if (selinux_init_load_policy(&enforce) == 0 ) {
                    execv(myname, argv);
            } else {
                    if (enforce > 0) {
                            /* SELinux in enforcing mode but 
load_policy failed */
                            /* At this point, we probably can't open 
/dev/console, so log() won't work */
                            printf("Unable to load SELinux Policy. 
Machine is in enforcing mode. Halting now.\n");
                            exit(1);
                    }
            }
    }


New code:
    if (getenv("SELINUX_INIT") == NULL) {
      const int rc = mount("proc", "/proc", "proc", 0, 0);
      if (is_selinux_enabled() > 0) {
        putenv("SELINUX_INIT=YES");
        if (rc == 0) umount2("/proc", MNT_DETACH);
        if (selinux_init_load_policy(&enforce) == 0) {
          execv(myname, argv);
        } else {
          if (enforce > 0) {
            /* SELinux in enforcing mode but load_policy failed */
            /* At this point, we probably can't open /dev/console, so 
log() won't work */
            fprintf(stderr,"Unable to load SELinux Policy. Machine is 
in enforcing mode. Halting now.\n");
            exit(1);
          }
        }
      }
      if (rc == 0) umount2("/proc", MNT_DETACH);
    }

The differences here are that the new code ensures that /proc is 
mounted, and !is_selinux_enabled() becomes (is_selinux_enabled() > 0).

I think the change was due to this:
http://thread.gmane.org/gmane.comp.security.selinux/13320
(is_selinux_enabled() returns -1 if /proc not mounted).

I am not clear what the purpose of this is_selinux_enabled() check is: 
is it to avoid loading policy if policy has already been loaded by the 
initramfs, or is it to find out whether the system has been configured 
to use SELinux?

If it is the first, then I think the test should be put back to 
!is_selinux_enabled() - since init ensures /proc is mounted that should 
work with or without an initramfs.

If it is the second, then is_selinux_enabled() can't tell you that 
because it only returns 1 after a policy has been loaded.

Best wishes,
Martin



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
