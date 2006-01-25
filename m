Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0PGjEXf011604
	for <selinux@tycho.nsa.gov>; Wed, 25 Jan 2006 11:45:14 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0PGjCvt022384
	for <selinux@tycho.nsa.gov>; Wed, 25 Jan 2006 16:45:12 GMT
Message-ID: <43D7AB15.8020204@redhat.com>
Date: Wed, 25 Jan 2006 11:45:09 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: apparent bug in setrans
References: <200601241431.25155.russell@coker.com.au>
In-Reply-To: <200601241431.25155.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> $ runcon -l s0:c1.c3 id
> uid=500(rjc) gid=500(rjc) groups=500(rjc) context=rjc:system_r:unconfined_t
>
>   
I am getting
 runcon -l s0:c1.c7 id
uid=0(root) gid=0(root) 
groups=0(root),1(bin),2(daemon),3(sys),4(adm),6(disk),10(wheel) 
context=user_u:system_r:unconfined_t:s0:c1.c7
 rpm -q libsetrans
libsetrans-0.1.18-1


> Above is the result of running id on a fairly recent rawhide machine.  It 
> appears that there's a bug in setrans which maps everything to "" if it can't 
> find a name.
>
> I'm currently finishing my paper for the SE Linux Symposium and then I've got 
> to work on a tutorial for LCA in a few days.  I'll schedule fixing this bug 
> for the weekend if no-one else beats me to it.
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
