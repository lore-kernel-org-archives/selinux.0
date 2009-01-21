Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0LJo2EJ031599
	for <selinux@tycho.nsa.gov>; Wed, 21 Jan 2009 14:50:02 -0500
Received: from yw-out-1718.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0LJl790019966
	for <selinux@tycho.nsa.gov>; Wed, 21 Jan 2009 19:47:07 GMT
Received: by yw-out-1718.google.com with SMTP id 6so1617589ywa.84
        for <selinux@tycho.nsa.gov>; Wed, 21 Jan 2009 11:50:01 -0800 (PST)
Message-ID: <49777C63.7020607@gmail.com>
Date: Wed, 21 Jan 2009 11:49:55 -0800
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Joe Nall <joe@nall.com>
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: run_init confusion
References: <49776DDD.6080306@gmail.com> <6B394862-5019-497D-984C-92A7B936CA1F@nall.com>
In-Reply-To: <6B394862-5019-497D-984C-92A7B936CA1F@nall.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joe Nall wrote:
>
> On Jan 21, 2009, at 12:47 PM, Justin P. Mattock wrote:
>
>> I'm having an issue with run_init.
>> each time I try to restart alsa-utils
>> I get this:
>>
>> name@computer:~$ newrole -r sysadm_r -- -c /usr/sbin/run_init 
>> /etc/init.d/alsa-utils restart
>
> newrole -r sysadm_r -- -c "/usr/sbin/run_init /etc/init.d/alsa-utils 
> restart"
>
> joe
>
>
I think I have something missing.
when adding " "
to the command:
newrole -r sysadm_r -- -c "/usr/sbin/run_init /etc/init.d/alsa-utils 
restart"
I get this:

name@computer:~$ newrole -r sysadm_r -- -c "/usr/sbin/run_init 
/etc/init.d/alsa-utils restart"
Password:
Authenticating name.
run_init: incorrect password for name
authentication failed.
name@computer:~$

I've done passwd as root and as normal user
to make sure, but still same message.

regards;

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
