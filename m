Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3C7XTtA027505
	for <selinux@tycho.nsa.gov>; Tue, 12 Apr 2005 03:33:29 -0400 (EDT)
Received: from gw.linuon.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3C7RL4G022140
	for <selinux@tycho.nsa.gov>; Tue, 12 Apr 2005 07:27:22 GMT
Message-ID: <425B780B.20605@linuon.com>
Date: Tue, 12 Apr 2005 16:26:03 +0900
From: Junji Kanemaru <linux@linuon.com>
MIME-Version: 1.0
To: Junji Kanemaru <linux@linuon.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: dhcpd policy settings
References: <425B6127.3060808@linuon.com>
In-Reply-To: <425B6127.3060808@linuon.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Well this is self reply though, I kinda found the reason that what caused
the problem. I have created my daemon's home in /var/lib/my_daemon
and it caused file_context to have setting home_root_t:dir for /var/lib.
I'm going to create file context settings for my daemon.

Sorry for the bandwith,

-- Junji

Junji Kanemaru wrote:
> Hi,
> 
> I have problem with dhcpd that it seems some recent policy update
> has affected dhcpd runtime environment.
> dhcpd gets avc permission error when dhcpd accesses to 
> /var/lib/dhcpd.leases.  The dmesg says:
> 
> audit(1113209633.019:0): avc:  denied  { search } for  
> pid=5585 exe=/usr/sbin/dhcpd name=lib dev=dm-0 ino=1409026 
> scontext=root:system_r:dhcpd_t tcontext=system_u:object_r:home_root_t
> tclass=dir
> 
> So I quick looked into policy setting and found there's a type setting
> in /etc/selinux/targeted/src/policy/file_contexts/file_contexts that
> /var/lib is set to 'system_u:object_r:home_root_t' but 'dhcpd.te' doesn't
> have permission to traverse 'home_root_t:dir'...
> I added permission 'allow dhcpd_t home_root_t:dir { getattr search };' to
> 'dhcpd.te', the error has gone. 
> But I'm not really sure if I did right thing or not, I'd like to hear from 
> SELinux gurus if it is OK with this fix or there's some security exploit with
> my fix, or there's complete fix...
> Please enlighten me.
> 
> Thanks,
> 
> -- Junji
> 

-- 
Junji Kanemaru
Linuon Inc.
Tokyo Japan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
