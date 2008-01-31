Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0VJqMHb009521
	for <selinux@tycho.nsa.gov>; Thu, 31 Jan 2008 14:52:22 -0500
Received: from el-out-1112.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0VJqLDu018706
	for <selinux@tycho.nsa.gov>; Thu, 31 Jan 2008 19:52:21 GMT
Received: by el-out-1112.google.com with SMTP id j27so308195elf.0
        for <selinux@tycho.nsa.gov>; Thu, 31 Jan 2008 11:52:11 -0800 (PST)
Message-ID: <dd18b0c30801311146l626f8c29o1460ef3e5e7682d3@mail.gmail.com>
Date: Thu, 31 Jan 2008 19:46:06 +0000
From: "Justin Mattock" <justinmattock@gmail.com>
To: selinux@tycho.nsa.gov
Subject: shadow
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_17439_3205400.1201808766972"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_17439_3205400.1201808766972
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello; with /etc/shadow what might I be doing wrong; I keep receiving:
libsepol.check_assertion_helper: assertion on line 137107 violated by allow
newrole_t shadow_t:file { read };
libsepol.check_assertion_helper: assertion on line 137107 violated by allow
crond_t shadow_t:file { read};
libsepol.check_assertion_helper: assertion on line 137107 violated by allow
sysadm_sudo_t shadow_t:file { read };

am I not supposed to use newrole in a root terminal! or is this something
else. In my desperation I commented out
/etc/selinux/refpolicy/policy/modules/system/authlogin.te
line 48 : [ #neverallow ~can_read_shadow_passwords shadow_t:file read; ] to
allow my self to newrole login. I dont like messing with any of the
neverallow rules; what am I missing?

                --Justin P. Mattock

------=_Part_17439_3205400.1201808766972
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello; with /etc/shadow what might I be doing wrong; I keep receiving:<br>libsepol.check_assertion_helper: assertion on line 137107 violated by allow newrole_t shadow_t:file { read };<br>libsepol.check_assertion_helper: assertion on line 137107 violated by allow&nbsp; crond_t shadow_t:file { read};<br>
libsepol.check_assertion_helper: assertion on line 137107 violated by allow sysadm_sudo_t shadow_t:file { read };<br><br>am I not supposed to use newrole in a root terminal! or is this something else. In my desperation I commented out /etc/selinux/refpolicy/policy/modules/system/authlogin.te<br>
line 48 : [ #neverallow ~can_read_shadow_passwords shadow_t:file read; ] to allow my self to newrole login. I dont like messing with any of the neverallow rules; what am I missing? <br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --Justin P. Mattock<br>

------=_Part_17439_3205400.1201808766972--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
