Message-ID: <43D0EECB.4060703@cornell.edu>
Date: Fri, 20 Jan 2006 07:08:11 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: russell@coker.com.au, SELinux List <SELinux@tycho.nsa.gov>,
   Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [SEMANAGE] Further bugfixes
References: <43D0383C.8010404@cornell.edu> <200601202321.07517.russell@coker.com.au> <43D0D8E2.2020304@cornell.edu> <43D0EDA1.5070002@redhat.com>
In-Reply-To: <43D0EDA1.5070002@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> -R "user_r sysadm_t secadm_r"
> works or at least should work.
That doesn't match the Usage()... didn't know about it.
Also, try this:

[root@cobra ~]# /usr/sbin/semanage user -a -R "secadm_r sysadm_r" Ivan
[root@cobra ~]# /usr/sbin/semanage user -m -R "user_r system_r" Ivan
[root@cobra ~]# /usr/sbin/semanage user -l

Ivan            s0         s0                             system_r 
sysadm_r user_r secadm_r


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
