Message-ID: <459E7BA2.1050109@redhat.com>
Date: Fri, 05 Jan 2007 11:24:02 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Klaus Weidner <klaus@atsec.com>, Joshua Brindle <jbrindle@tresys.com>,
        James Antill <jantill@redhat.com>,
        Linda Knippers <linda.knippers@hp.com>,
        redhat-lspp <redhat-lspp@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [redhat-lspp] Re: [PATCH 2/3] Re: MLS enforcing PTYs,	sshd,	and
 newrole
References: <20070105033311.GA24315@w-m-p.com>	 <6FE441CD9F0C0C479F2D88F959B015886CA28F@exchange.columbia.tresys.com>	 <20070105040119.GB24315@w-m-p.com> <1168012584.18961.161.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1168012584.18961.161.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

newrole patch. for checking securetty.


diff --exclude-from=exclude --exclude POTFILES.in --exclude='*.po' 
--exclude='*.pot' -N -u -r nsapolicycoreutils/newrole/newrole.c 
policycoreutils-1.33.8/newrole/newrole.c
--- nsapolicycoreutils/newrole/newrole.c        2007-01-04 
17:01:41.000000000 -0500
+++ policycoreutils-1.33.8/newrole/newrole.c    2007-01-05 
11:17:36.000000000 -0500
@@ -733,6 +734,7 @@
                                        security_context_t *new_context,
                                        int *preserve_environment)
 {
+       int i;                  /* index for open file descriptors */
        int flag_index;         /* flag index in argv[] */
        int clflag;             /* holds codes for command line flags */
        char *role_s = NULL;    /* role spec'd by user in argv[] */
@@ -741,6 +743,8 @@
        char *level_s = NULL;   /* level spec'd by user in argv[] */
        char *range_ptr = NULL;
        security_context_t new_con = NULL;
+       security_context_t tty_con = NULL;
+       int securetty=0;
        context_t context = NULL; /* manipulatable form of new_context */
        const struct option long_options[] = {
                {"role", 1, 0, 'r'},
@@ -793,6 +797,18 @@
                                        "specified\n"));
                                return -1;
                        }
+                       for (i=0; i < 3; i++) {
+                               securetty=0;
+                               if (fgetfilecon(i,&tty_con) >= 0) {
+                                       securetty = 
(selinux_check_securetty_context(tty_con) == 1);
+                                       freecon(tty_con);
+                               }
+                               if (!securetty) {
+                                       fprintf(stderr, "Error: you are 
not allowed to change levels on a non secure terminal\n");
+                                       return -1;
+                               }
+                       }
+
                        level_s = optarg;
                        break;
                default:


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
