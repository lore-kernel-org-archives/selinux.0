Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0LKxOgA008755
	for <selinux@tycho.nsa.gov>; Wed, 21 Jan 2009 15:59:24 -0500
Received: from mail-gx0-f20.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0LKxNx3019229
	for <selinux@tycho.nsa.gov>; Wed, 21 Jan 2009 20:59:23 GMT
Received: by gxk13 with SMTP id 13so3642442gxk.18
        for <selinux@tycho.nsa.gov>; Wed, 21 Jan 2009 12:59:22 -0800 (PST)
Message-ID: <49778CA6.70105@gmail.com>
Date: Wed, 21 Jan 2009 12:59:18 -0800
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Joe Nall <joe@nall.com>
CC: SE-Linux <selinux@tycho.nsa.gov>, tresys <refpolicy@oss.tresys.com>
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
O.K. I was able to have run_init work
by changing  system-auth
to common-auth(can't seem to locate system-auth
package);
I think one of the main problems I have is
I don't know how to login as root.(with the newest refpolicy atleast)
how do I do that? or do I just need to have system-auth
in /etc/pam.d setup correctly to use run_init?

regards;

Justin P. Mattock


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
