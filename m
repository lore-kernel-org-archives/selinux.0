Message-ID: <36282A1733C57546BE392885C0618592080BFA@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@tcs-sec.com>
To: "SE Linux (E-mail)" <SELinux@tycho.nsa.gov>
Subject: minor structure usage bug
Date: Tue, 30 Mar 2004 15:56:53 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


We found the sk_free_security() function incorrectly types ssec to a
task_security_struct instead of sk_security_struct. This has no current
impact as the magic element is the top of each structure.

--- hooks.c.dist        2004-03-30 14:25:05.000000000 -0600
+++ hooks.c     2004-03-30 14:25:31.000000000 -0600
@@ -271,7 +271,7 @@
 
 static void sk_free_security(struct sock *sk)
 {
-       struct task_security_struct *ssec = sk->sk_security;
+       struct sk_security_struct *ssec = sk->sk_security;
 
        if (sk->sk_family != PF_UNIX || ssec->magic != SELINUX_MAGIC)
                return;


_______________________________________________________________
Chad Hanson				mailto:chanson@tcs-sec.com
Trusted Computer Solutions		Phone: 217-384-0028 x12
121 W Goose Alley			Fax: 217-384-0288
Urbana IL 61801



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
