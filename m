Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA22470
	for <selinux@tycho.nsa.gov>; Mon, 11 Mar 2002 12:44:19 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA12865
	for <selinux@tycho.nsa.gov>; Mon, 11 Mar 2002 17:43:17 GMT
Received: from adams.patriot.net (IDENT:root@adams.patriot.net [209.249.176.2])
        by jazzband.ncsc.mil  with ESMTP id RAA12861 for <selinux@tycho.nsa.gov>; Mon, 11 Mar 2002 17:43:17 GMT
Received: from localhost (pgreene@localhost)
	by adams.patriot.net (8.10.1/8.10.1) with ESMTP id g2BHiHo16061
	for <selinux@tycho.nsa.gov>; Mon, 11 Mar 2002 12:44:17 -0500
Date: Mon, 11 Mar 2002 12:44:17 -0500 (EST)
From: Paul Greene <pgreene@patriot.net>
To: <selinux@tycho.nsa.gov>
Subject: Trouble with Selinux install
Message-ID: <Pine.LNX.4.30.0203111242410.9199-100000@adams.patriot.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



I tried installing Selinux for the first time yesterday and have been
having a little trouble.

The kernel compile all seemed to go well; I didn't get any error messages.

However, when I went to boot the system, I selected "selinux" from the
lilo boot menu, the message "Loading selinux ...." came up, but then the
system rebooted, and came back around again to the lilo prompt. I don't
have any trouble getting into the standard kernel, but if I try to get
into the selinux kernel, the system just reboots again.

There's no obvious errors logged in /var/log/boot.log.

The RedHat version is 7.1; I used the LSM sources tarball, version 2.4,
"Option 1 - Everything in one Part".

One possibility that came to mind was the CPU type. The system is a
Pentium 166 w/ 64 megs of RAM; the only option for CPU type in .config was
for a Pentium III.

My lilo.conf file is listed below.

Paul Greene

______________________

boot=/dev/hda
map=/boot/map
install=/boot/boot.b
prompt
timeout=50
message=/boot/message
linear
default=linux

image=/boot/vmlinuz-2.4.2-2
        label=linux
        read-only
        root=/dev/hda6

image=/boot/vmlinuz-2.4.17-selinux
        label=selinux
        read-only
        root=/dev/hda6




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
