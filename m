Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4ILsjRb005768
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 17:54:45 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4ILsgAR000703
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 21:54:42 GMT
Received: from smtp803.mail.ukl.yahoo.com (smtp803.mail.ukl.yahoo.com [217.12.12.140])
        by jazzband.ncsc.mil  with SMTP id i4ILsfHn000699 for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 21:54:42 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.130.181.235 with poptime)
  by smtp803.mail.ukl.yahoo.com with SMTP; 18 May 2004 20:56:17 -0000
Received: from highfield ([192.168.0.223]:32791 helo=lkcl.net)
	by lkcl.net with esmtp (Exim 4.24 #1)
	id 1BQBg7-000831-5b
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 20:59:11 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BQBah-00028z-6E
	for selinux@tycho.nsa.gov; Tue, 18 May 2004 20:53:35 +0000
Date: Tue, 18 May 2004 20:53:35 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: avc messages occuring that aren't getting into dmesg or syslog
Message-ID: <20040518205335.GE7348@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

okay, next step: i have the discover package installed on my system,
and i believe that some avc messages are occurring that aren't going
into the logs.

i'm trying dmesg to capture them, see what happens.

the hotplug ones are particularly bugging me:

	allow hotplug_t sysctl_net_t:file { write };

is banned under the policy verification rules.

and these:

assertion on line 94076 violated by allow initrc_t etc_t:dir { setattr };
assertion on line 94076 violated by allow mount_t etc_t:dir { mounton };

which is this assertion at line 94076:

# Verify that only appropriate domains can write to /etc (IE mess with
# /etc/passwd)
neverallow {domain -auth_write -etc_writer -unconfined_t } etc_t:dir ~{
read getattr lock search ioctl add_name remove_name write };

clues, anyone?

l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
