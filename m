Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2BJZEJD030782
	for <selinux@tycho.nsa.gov>; Wed, 11 Mar 2009 15:35:14 -0400
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2BJZDFt021423
	for <selinux@tycho.nsa.gov>; Wed, 11 Mar 2009 19:35:13 GMT
Message-ID: <49B8126B.9060501@redhat.com>
Date: Wed, 11 Mar 2009 15:35:07 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joe Nall <joe@nall.com>
CC: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: Help with python seobject.loginRecords
References: <1BF3FC9F-9D76-4CF5-B67E-DFE8216038FA@nall.com>
In-Reply-To: <1BF3FC9F-9D76-4CF5-B67E-DFE8216038FA@nall.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/11/2009 12:15 PM, Joe Nall wrote:
> I need to add login mappings in python firstboot modules during system
> configuration. In my first module a simple:
>
> seobject.loginRecords().add(username, "siterep_u", "SystemLow-SystemHigh")
>
> works. In subsequent modules, I get an exception:
>
> libsemanage.enter_rw: this operation requires a transaction
> libsemanage.enter_rw: could not enter read-write section
> Traceback (most recent call last):
> File "./t", line 6, in <module>
> seobject.loginRecords().add("test3", "sysadm_u", "SystemLow-SystemHigh")
> File "/usr/lib64/python2.5/site-packages/seobject.py", line 442, in add
> raise error
> ValueError: Could not add login mapping for test3
>
> What is the right way to do this?
>
> joe
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
Probably an MLS issue.  firtstboot is running in a context that is not 
allowed to lock/manage selinux.

You probably should exec semanage rather then calling seobject so you 
could do a transition and not have to give a huge app like first boot 
the ability to manage security policy.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
