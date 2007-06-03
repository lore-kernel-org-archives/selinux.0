Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l531KCw5032277
	for <selinux@tycho.nsa.gov>; Sat, 2 Jun 2007 21:20:12 -0400
Received: from mu-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l531KA6D013647
	for <selinux@tycho.nsa.gov>; Sun, 3 Jun 2007 01:20:11 GMT
Received: by mu-out-0910.google.com with SMTP id i10so1249640mue
        for <selinux@tycho.nsa.gov>; Sat, 02 Jun 2007 18:20:10 -0700 (PDT)
Message-ID: <f71a82820706021820m34d5da17n56dcb312a061a988@mail.gmail.com>
Date: Sun, 3 Jun 2007 10:20:09 +0900
From: "Shintaro Fujiwara" <shintaro.fujiwara@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Can't login in F7 strict
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello.

I'm trying to work out on F7 strict policy.
My server is now FC6, so I'm trying to change it 7.

I yum installed every selinux related packages.
I made localaudit.pp typing
#audit2allow -i /var/log/audit/audit.log -m localaudit > localaudit.te
at /usr/share/selinux/devel
#semodule -i localaudit.pp
violation reported by libsepol.chek_assertions

local_login_t local_login_t:netlink_audit_socket { nlmsg_relay };
local_login_t local_login_t:capability { audit_write };
local_login_t local_login_t:capability { audit_control };

So,I commented those lines on localaudit.te including require brace.
This time I succeeded installing localaudit.pp.

I restarted my machine setting Enforcing/strict.
During the startup process, I could see Keymap had failed.
I can't login from console.
I typed like a US key not jp106, still I can't.

You made strict policy not logging in from console?
What should I do?


homepage http://intrajp.no-ip.com/
SELinux Forum JP http://intrajp.no-ip.com/xoops
SELinux Wiki JP http://intrajp.no-ip.com/pukiwiki
my blog JP http://intrajp.no-ip.com/nucleus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
