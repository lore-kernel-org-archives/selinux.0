Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o9A6HTMe024966
	for <selinux@tycho.nsa.gov>; Sun, 10 Oct 2010 02:17:29 -0400
Received: from mail-qw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o9A6HSUn009878
	for <selinux@tycho.nsa.gov>; Sun, 10 Oct 2010 06:17:28 GMT
Received: by qwk4 with SMTP id 4so346959qwk.12
        for <selinux@tycho.nsa.gov>; Sat, 09 Oct 2010 23:17:28 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 9 Oct 2010 23:17:25 -0700
Message-ID: <AANLkTimEezzq9XqJSpO3B4LY3NWQLiD2CN-0Z4Wd764U@mail.gmail.com>
Subject: ERROR 'syntax error' at token ':c' on line 42:
From: Justin Mattock <justinmattock@gmail.com>
To: SE-Linux <selinux@tycho.nsa.gov>, tresys <refpolicy@oss1.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is also hitting when building a module for the policy(below)
basically start the system(opensuse 11.4) then do:

dmesg > dmesg
audit2allow -i dmesg -M Zonemod
compilation failed:
Zonemod.te:42:ERROR 'syntax error' at token ':c' on line 42:
allow auditd_t device_t:chr_file { read write open };
#============= auditd_t ==============
/usr/bin/checkmodule:  error(s) encountered while parsing configuration
/usr/bin/checkmodule:  loading policy configuration from Zonemod.te

ended up copying audit.log, messages, dmesg to another machine to make
the modules
then installed them on the machine that's produces this error, just to
get up and running
in enforcement mode.

let me know what I can do.

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
