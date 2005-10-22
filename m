Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9MLleNs026034
	for <selinux@tycho.nsa.gov>; Sat, 22 Oct 2005 17:47:40 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9MLiKK1028373
	for <selinux@tycho.nsa.gov>; Sat, 22 Oct 2005 21:44:21 GMT
Subject: pegasus
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Sat, 22 Oct 2005 17:45:23 -0400
Message-Id: <1130017523.10739.83.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

While converting the pegasus policy over to reference policy, I came
across this peculiar use types and rules:

type pegasus_conf_exec_t, file_type, exec_type, sysadmfile;

rw_dir_create_file(pegasus_conf_exec_t, pegasus_conf_t)

This is the only use of pegasus_conf_exec_t, and is obvious that it
doesn't have an effect.  There is a pegasus_conf_t, but it also is a
file_type, used for the configuration files.  My guess is that the
original intention was to make a domain for pegasus configuration
programs, but it went awry.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
