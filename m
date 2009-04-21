Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3LC1976016951
	for <selinux@tycho.nsa.gov>; Tue, 21 Apr 2009 08:01:09 -0400
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3LC0urL002602
	for <selinux@tycho.nsa.gov>; Tue, 21 Apr 2009 12:00:56 GMT
Message-ID: <49EDB564.301@redhat.com>
Date: Tue, 21 Apr 2009 08:00:36 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Alexey S <selinux@udmvt.ru>
CC: Bandan Das <bandan.das@stratus.com>, selinux <selinux@tycho.nsa.gov>,
        "Johnson, Richard" <Richard.Johnson@stratus.com>
Subject: Re: genhomedircon errors with NIS
References: <1240253643.7743.78.camel@BSD.mno.stratus.com> <49ECC813.5050403@redhat.com> <1240256165.7743.92.camel@BSD.mno.stratus.com> <49ECD200.8000104@redhat.com> <20090421095354.GG9889@ruber.office.udmvt.ru>
In-Reply-To: <20090421095354.GG9889@ruber.office.udmvt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 04/21/2009 05:53 AM, Alexey S wrote:
> On Mon, Apr 20, 2009 at 03:50:24PM -0400, Daniel J Walsh wrote:
>> On 04/20/2009 03:36 PM, Bandan Das wrote:
>>> ...
>> genhomedircon on RHEL5 is a python script so you can edit it and have it
>> exit on start or ignore /h
>>
>> But if we update policycoreutils, you changes would get overwritten.
>>
>> I believe this works but I never tried it.
>>
>> Add the following to /etc/selinux/semanage.conf and it will use the
>> alternate script instead of the standard
>>
>>
>> [genhomedircon]
>> path = /usr/local/sbin/genhomedircon_modified args = -t $@
>> [end]
>>
>>
>>
>>
>> [genhomedircon]
>> path = /usr/bin/true args = -t $@
>> [end]
>>
>> would cause it to always succeed and do nothing.  ( I think.)
> Wouldn't it be better to not try to autogenerate the list of directories to be labeled
> with home_root_t ?
> Why is that impossible to generate that list once and save it somewhere in /etc/ and allow
> sysadmin to edit that list to suit his needs?
> Make the first autogeneration loud and verbose and document that config everywhere.
> You can't guess every possible system's configuration anyway.
>
Actually I am working on removing genhomedircon all together in the 
upstream.  I would like to force the admins to tell us where the home 
directories for each machine are located.

http://danwalsh.livejournal.com/27571.html

THe semantics of figuring out what a Home dir is and where to put labels 
is very difficult and prone to error, as you are seeing.  So having the 
admin tell us with perhaps a tool to help them would be better then the 
current situation.  But this is for RHEL6 and RHEL5 is not likely to change.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
