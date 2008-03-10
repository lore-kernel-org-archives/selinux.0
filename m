Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2AMMCKr026679
	for <selinux@tycho.nsa.gov>; Mon, 10 Mar 2008 18:22:12 -0400
Received: from smtp108.sbc.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m2AMMBon020127
	for <selinux@tycho.nsa.gov>; Mon, 10 Mar 2008 22:22:11 GMT
Cc: Xavier Toth <txtoth@gmail.com>, SE Linux <selinux@tycho.nsa.gov>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>
Message-Id: <648FB347-1DE1-433D-8299-B4B0EBDD27D8@nall.com>
From: Joe Nall <joe@nall.com>
To: Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <47D596C0.8040201@redhat.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: x fails to start on fc9
Date: Mon, 10 Mar 2008 17:19:48 -0500
References: <cadfc0e40803091236i5ddca650hd81d470109295541@mail.gmail.com> <46514C07-63FC-4CD1-8507-D0799BAE9BF5@nall.com> <47D596C0.8040201@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mar 10, 2008, at 3:14 PM, Daniel J Walsh wrote:
>>
>> #============= initrc_t ==============
>> allow initrc_t mnt_t:dir mounton;
>> allow initrc_t ramfs_t:dir setattr;
> What app is running as initrc_t?


both of those were from rhgb, the X relates ones may be from console- 
kit-daemon

[root@rawhide ~]# ps Zax | grep initrc
system_u:system_r:initrc_t:SystemLow:SystemLow-SystemHigh 2322 ? Ss    
0:01 kerneloops
system_u:system_r:initrc_t:SystemLow:SystemLow-SystemHigh 2357 ? Ssl    
0:00 /usr/sbin/console-kit-daemon

[root@rawhide ~]# ls -Z /usr/sbin/console-kit-daemon
-rwxr-xr-x  root root system_u:object_r:bin_t:SystemLow /usr/sbin/ 
console-kit-daemon

joe


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
