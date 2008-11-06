Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mA6HJiRM008155
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2008 12:19:44 -0500
Received: from mail.magitekltd.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mA6HJhEm002367
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2008 17:19:44 GMT
Subject: Re: restorecon / matchpathcon
From: LC Bruzenak <lenny@MagitekLtd.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <49132254.2040600@redhat.com>
References: <1225987455.7321.37.camel@homeserver>
	 <49131CD7.7070204@redhat.com> <1225989929.7321.39.camel@homeserver>
	 <49132254.2040600@redhat.com>
Content-Type: text/plain
Date: Thu, 06 Nov 2008 11:19:42 -0600
Message-Id: <1225991982.7321.48.camel@homeserver>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks Dan, I think that works:

[root@hugo ICM]# find `pwd`  | xargs  matchpathcon -Vq
[root@hugo ICM]#  echo $?
123
[root@hugo ICM]# restorecon -rv `pwd`
restorecon reset /var/opt/jcdx/ICM/Labeled context
system_u:object_r:jcdx_icm_var_t:s0->system_u:object_r:jcdx_icm_var_t:s15:c0.c1023
[root@hugo ICM]# find `pwd`  | xargs  matchpathcon -Vq
[root@hugo ICM]#  echo $?
0

-- 
LC (Lenny) Bruzenak
lenny@magitekltd.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
