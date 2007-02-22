Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1MEma4v028941
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2007 09:48:36 -0500
Received: from atlrel7.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1MEns6X009735
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2007 14:49:54 GMT
Received: from smtp1.fc.hp.com (smtp1.fc.hp.com [15.15.136.127])
	by atlrel7.hp.com (Postfix) with ESMTP id 7998734C19
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2007 09:49:53 -0500 (EST)
Message-ID: <45DDACEE.20205@hp.com>
Date: Thu, 22 Feb 2007 09:47:10 -0500
From: Linda Knippers <linda.knippers@hp.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: [PATCH] newrole: fix for newrole hanging on some serial consoles
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


The following patch addresses a problem I experienced with newrole hanging
when run from a serial console when the console is configured using the
default /etc/inittab settings.  newrole would hang when re-opening the
tty device.  This patch causes newrole to mimic the behavior of agetty,
which opens the device with O_NONBLOCK and then turns the bit off before
execing the next program.  Changing /etc/inittab to use the -L option for
agetty will avoid the problem but that solution won't be obvious to anyone
experiencing the problem and it may introduce other issues.

This patch was tested with policycoreutils-newrole-1.33.12-5.el5 on RHEL5 RC1.

-- ljk


--- newrole.c   2007-02-20 13:32:46.000000000 -0500
+++ newrole.c.ljk2      2007-02-20 13:32:39.000000000 -0500
@@ -636,11 +636,12 @@ static int relabel_tty(const char *ttyn,
        }

        /* Re-open TTY descriptor */
-       fd = open(ttyn, O_RDWR);
+       fd = open(ttyn, O_RDWR|O_NONBLOCK);
        if (fd < 0) {
                fprintf(stderr, _("Error!  Could not open %s.\n"), ttyn);
                return fd;
        }
+       fcntl(fd, F_SETFL, fcntl(fd, F_GETFL, 0) & ~O_NONBLOCK);

        if (fgetfilecon(fd, &tty_con) < 0) {
                fprintf(stderr, _("%s!  Could not get current context "
@@ -1127,15 +1128,18 @@ int main(int argc, char *argv[])
                fprintf(stderr, _("Could not close descriptors.\n"));
                goto err_close_pam;
        }
-       fd = open(ttyn, O_RDONLY);
+       fd = open(ttyn, O_RDONLY|O_NONBLOCK);
        if (fd != 0)
                goto err_close_pam;
-       fd = open(ttyn, O_RDWR);
+       fcntl(fd, F_SETFL, fcntl(fd, F_GETFL, 0) & ~O_NONBLOCK);
+       fd = open(ttyn, O_RDWR|O_NONBLOCK);
        if (fd != 1)
                goto err_close_pam;
-       fd = open(ttyn, O_RDWR);
+       fcntl(fd, F_SETFL, fcntl(fd, F_GETFL, 0) & ~O_NONBLOCK);
+       fd = open(ttyn, O_RDWR|O_NONBLOCK);
        if (fd != 2)
                goto err_close_pam;
+       fcntl(fd, F_SETFL, fcntl(fd, F_GETFL, 0) & ~O_NONBLOCK);

        /*
         * Step 5:  Execute a new shell with the new context in `new_context'.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
