Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h99IT5Wt028029
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2003 14:29:05 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h99IT20p018974
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2003 18:29:02 GMT
Received: from sjtu.edu.cn (mailhost.shnet.edu.cn [202.112.26.54])
	by jazzswing.ncsc.mil  with ESMTP id h99ISxr7018962
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2003 18:29:01 GMT
Message-ID: <001c01c38e94$4d20e010$5d38a8c0@lky>
From: "lky" <lky77@sjtu.edu.cn>
To: "Tom" <tom@lemuria.org>
Cc: "SELINUX" <SELinux@tycho.nsa.gov>
References: <000e01c38dbb$d9841a60$5d38a8c0@lky> <20031008211705.F14104@lemuria.org>
Subject: Re: policy configuration problems
Date: Fri, 10 Oct 2003 02:32:36 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Check if the binaries are labelled correctly, i.e. do something like:
> 
> ls --context /usr/sbin/xinetd 
> (or wherever it is installed in redhat)
> 
> it should be system_u:system_r:inetd_exec_t if I remember correctly. If
> it's the generic :sbin_t then no transition happens.
> 
> same for the other programs.

Absolutely right! The file contexts aren't labelled correctly. After make relabel and append some allow rules the most programes run within their own domains and denied messages have been eliminated. Thanks!
------------------------------------------------------------------------
Another problem:
 I want to use webmin to configure the system remotely,but now the webmin daemon still run within the initrc_t domain. I didn't find the .te and .fc files under the policy/domain/program and /policy/file_context/ directories. Should I have to create a new domain and a new .fc file for the program?  I think it's fairly hard for me because webmin is a complicated program and I'm not very family with it. Is there any easier way I can take or can I add the webmin program to an existing domain? 
-------------------------------------------------------------------------
Another question:
I'm not sure about my policy configuration steps.After changing the policy I take the following steps:
1.make reload
2.create the initrd-xx.img file
3.reboot
4.make relabel
5.reboot
Is this the only way if I want to reboot with the new policy? Can I omit the 4 and 5 steps if I just move up the .te file from the unused directory and add some allow permissions? I don't know clearly when I must use "make relabel".
Thanks a lot!


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
