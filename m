Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3C5pmtA027102
	for <selinux@tycho.nsa.gov>; Tue, 12 Apr 2005 01:51:48 -0400 (EDT)
Received: from gw.linuon.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3C5jg4G021134
	for <selinux@tycho.nsa.gov>; Tue, 12 Apr 2005 05:45:43 GMT
Received: from [192.168.0.101] (pc-1.linuon.co.jp [192.168.0.101])
	by gw.linuon.co.jp (8.13.1/8.13.1) with ESMTP id j3C5mNUk004530
	for <selinux@tycho.nsa.gov>; Tue, 12 Apr 2005 14:48:25 +0900
Message-ID: <425B6127.3060808@linuon.com>
Date: Tue, 12 Apr 2005 14:48:23 +0900
From: Junji Kanemaru <linux@linuon.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: dhcpd policy settings
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I have problem with dhcpd that it seems some recent policy update
has affected dhcpd runtime environment.
dhcpd gets avc permission error when dhcpd accesses to 
/var/lib/dhcpd.leases.  The dmesg says:

audit(1113209633.019:0): avc:  denied  { search } for  
pid=5585 exe=/usr/sbin/dhcpd name=lib dev=dm-0 ino=1409026 
scontext=root:system_r:dhcpd_t tcontext=system_u:object_r:home_root_t
tclass=dir

So I quick looked into policy setting and found there's a type setting
in /etc/selinux/targeted/src/policy/file_contexts/file_contexts that
/var/lib is set to 'system_u:object_r:home_root_t' but 'dhcpd.te' doesn't
have permission to traverse 'home_root_t:dir'...
I added permission 'allow dhcpd_t home_root_t:dir { getattr search };' to
'dhcpd.te', the error has gone. 
But I'm not really sure if I did right thing or not, I'd like to hear from 
SELinux gurus if it is OK with this fix or there's some security exploit with
my fix, or there's complete fix...
Please enlighten me.

Thanks,

-- Junji

-- 
Junji Kanemaru
Linuon Inc.
Tokyo Japan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
