Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6NEQGC3016142
	for <selinux@tycho.nsa.gov>; Mon, 23 Jul 2007 10:26:16 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6NEQESG006612
	for <selinux@tycho.nsa.gov>; Mon, 23 Jul 2007 14:26:14 GMT
Message-ID: <46A4BA6C.4060709@mentalrootkit.com>
Date: Mon, 23 Jul 2007 10:25:48 -0400
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Shintaro Fujiwara <shintaro.fujiwara@gmail.com>
CC: Karl MacMillan <kmacmill@redhat.com>, selinux <selinux@tycho.nsa.gov>
Subject: Re: There is a bug in checkmodule that is driving me nuts
References: <46A11983.5090405@redhat.com>	 <1184970504.14677.6.camel@localhost.localdomain> <f71a82820707202120h46791ea4xaeef58248a8c346b@mail.gmail.com>
In-Reply-To: <f71a82820707202120h46791ea4xaeef58248a8c346b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Shintaro Fujiwara wrote:
> Hello,
>
> Can I ask what policyrep is ?
> Is that policy-generating project on going or wat ?
>

Separate branch to rework the selinux policy compiler. It includes a 
library for representing policies (hence the name policyrep) that is 
useful for policy compilation, analysis, and generation. You can view 
the code at:

http://selinux.svn.sourceforge.net/viewvc/selinux/branches/policyrep/

Karl

> Thanks.
>
> 2007/7/21, Karl MacMillan <kmacmill@redhat.com>:
>>
>> On Fri, 2007-07-20 at 16:22 -0400, Daniel J Walsh wrote:
>> > The compiler is mistakenly seeing a
>> >
>> > gen_requires {
>> >        type  xguest_gnome_home_t;
>> > }
>> >
>> > As a redefinition of the type
>> >
>> >  /usr/bin/checkmodule -M -m guest.tmp -o 
>> guest.mod/usr/bin/checkmodule:
>> > loading policy configuration from guest.tmp
>> > policy/modules/users/guest.te:4:ERROR 'duplicate declaration of
>> > type/attribute' at token ';' on line 55020:
>> >         type xguest_gnome_home_t;
>> > #line 4
>> > /usr/bin/checkmodule:  error(s) encountered while parsing 
>> configuration
>> >
>> > The problem is the gen_requires happens before the declaration.
>> >
>> > The type is being declared in  a template file.
>>
>> For better or discarding of requires upon hitting a declaration isn't
>> like to be fixed (when the require is first).
>>
>> I have an alternative suggestion - remove all of the requires from the
>> policy and use an sepolgen-based pre-processor to add them back in until
>> the policyrep work is done. That will ease the migration and can be done
>> far more easily than fixing the current compiler.
>>
>> Karl
>>
>>
>> -- 
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to 
>> majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.
>>
>
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
