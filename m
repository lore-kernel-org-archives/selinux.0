Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jBHFMaXf010875
	for <selinux@tycho.nsa.gov>; Sat, 17 Dec 2005 10:22:36 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jBHFLg0i015958
	for <selinux@tycho.nsa.gov>; Sat, 17 Dec 2005 15:21:42 GMT
Message-ID: <43A42D3A.1090907@redhat.com>
Date: Sat, 17 Dec 2005 10:22:34 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: New strategy for enableaudit.
References: <43A4182B.9000402@redhat.com> <43A42F09.8080204@cornell.edu>
In-Reply-To: <43A42F09.8080204@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
> Daniel J Walsh wrote:
>> I have added enableaudit to Rules.modular to create a base.conf 
>> without audit rules.
>>
>> Then in the Fedora spec file I create a regulare base.pp and a 
>> enableaudit.pp.
>> I ship both in the RPM.
>>
>> Now the user can execute
>>
>> semodule -b /usr/share/selinux/targeted/enableaudit.pp
>>
>> To turn off the dontaudit rules.
>>
> What about audit rules in modules...
>
This is only a short term solution until we get boolean support for 
dontaudit rules.  But modules could do the same thing.   This
gives me the ability to debug problems being covered by dontaudit rules 
for now though.

Dan

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
