Message-ID: <002401c14595$5d1a8fb0$68026c85@ilios104>
From: "Yuichi Nakamura" <ynakam@ori.hitachi-sk.co.jp>
To: "SELinuxML" <SELinux@tycho.nsa.gov>
Cc: <ynakam@ori.hitachi-sk.co.jp>
Subject: I can ' t use named on LSM-based Prototype. Why?
Date: Tue, 25 Sep 2001 16:40:35 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I found that named(bind 9.1.0) didn't work on SELinux(LSM-based Prototype)
even if the kernel was flask development mode.

Named doesn't response to nslookup.

I can use other services(httpd,sendmail,ftpd).
And,Named works on usual Linux(2.4.3,2.4.9) and on original SELinux
prototype.

I installed SELinux (LSM-based Prototype) as development mode in RH7.1.
And the kernel configration option is following,
CONFIG_NETFILTER="Y"
CONFIG_CAPABILITIES ="N"
CONFIG_SELINUX="Y"
CONFIG_LSM_IP="Y".

The  startup log of named is following.
--------------------------------------------------------
Sep 25 15:11:54 myhost named[797]: starting BIND 9.1.0 -u named
Sep 25 15:11:54 myhost named[797]: using 1 CPU
Sep 25 15:11:54 myhost named: named startup succeeded
Sep 25 15:11:54 myhost named[801]: loading configuration from
'/etc/named.conf'
Sep 25 15:11:54 myhost named[801]: the default for the 'auth-nxdomain'
option is now 'no'
Sep 25 15:11:54 myhost named[801]: no IPv6 interfaces found
Sep 25 15:11:54 myhost named[801]: listening on IPv4 interface lo,
127.0.0.1#53

Sep 25 15:11:54 myhost named[801]: could not listen on UDP socket:
permission denied

Sep 25 15:11:54 myhost named[801]: creating IPv4 interface lo failed;
interface ignored
Sep 25 15:11:54 myhost named[801]: listening on IPv4 interface eth0,
133.xxx.x.75#53

Sep 25 15:11:54 myhost named[801]: could not listen on UDP socket:
permission denied

Sep 25 15:11:54 myhost named[801]: creating IPv4 interface eth0 failed;
interface ignored
Sep 25 15:11:54 myhost named[801]: not listening on any interfaces
-------------------------------------------------------------

Why named doesn't work on LSM based prototype?

Did I miss kernel configuration or else?

Please tell me.

-------------------------------------
Yuichi Nakamura
Hitachi Software Engineering Co.,Ltd.
ynakam@ori.hitachi-sk.co.jp





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
