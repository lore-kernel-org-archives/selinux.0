Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mBAFus50016164
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2008 10:56:54 -0500
Received: from smtp104.prem.mail.sp1.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id mBAFurKM003576
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2008 15:56:54 GMT
Message-ID: <493FE6B9.1010403@schaufler-ca.com>
Date: Wed, 10 Dec 2008 07:56:41 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>, erahul29@yahoo.com,
        selinux@tycho.nsa.gov
Subject: Re: Non root user cannot execute semanage, semodule
References: <829347.35568.qm@web50202.mail.re2.yahoo.com>	 <493EDD04.4050909@redhat.com>  <493F5F8E.1080303@schaufler-ca.com> <1228916392.23307.6.camel@localhost.localdomain>
In-Reply-To: <1228916392.23307.6.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
>> No - here we are running programs that do not expect to have any special
>> privileges beyond their caller.

Yes, you would have to make the programs CAP aware, and in any case ...

>>   And semanage is a python script.
>>     

The Orange Book educated mind boggles. You're right. Bad idea. Never mind.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
