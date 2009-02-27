Message-ID: <49A74EB1.80508@ak.jp.nec.com>
Date: Fri, 27 Feb 2009 11:23:45 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov, Eamon Walsh <ewalsh@tycho.nsa.gov>
Subject: Re: PHP/SELinux: libselinux wrappers
References: <48C61A84.9010001@ak.jp.nec.com>	 <49A63527.2020104@ak.jp.nec.com> <1235659159.13059.91.camel@localhost.localdomain> <49A6ADE2.8040602@redhat.com> <06A6610D4F464D4EBEAFBF2C5F86911EE74492@exchange2.columbia.tresys.com>
In-Reply-To: <06A6610D4F464D4EBEAFBF2C5F86911EE74492@exchange2.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
>> -----Original Message-----
>> From: Daniel J Walsh [mailto:dwalsh@redhat.com]
>>
>> I would rather package this up as part of libselinux, perhaps
>> libselinux-php, rather then make a new package.
> 
> The last time I used PHP (admittedly years ago) most if not all bindings
> were included in the upstream PHP distribution.

At least, most of PHP extensions has php-* naming convension, like:
   php-mysql, php-mbstring, php-ldap, ...

Most of major extensions are distributed as subpackages of php itself,
but some of extensions are not distributed as separated package.
(Please find php-* on the list of Fedora SRPMs.)

I don't think we need to wait for it get merged into the core PHP,
to release php-selinux package.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
