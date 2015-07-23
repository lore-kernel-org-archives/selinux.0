Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6NIRpkv024565
 for <selinux@tycho.nsa.gov>; Thu, 23 Jul 2015 14:27:51 -0400
Subject: Re: Trouble building a .cil policy from scratch.
To: Steve Lawrence <slawrence@tresys.com>, selinux@tycho.nsa.gov
References: <55B01776.3030308@yahoo.com> <55B0D336.1010406@tresys.com>
From: Dan <dtdevore64@yahoo.com>
Message-ID: <55B1321A.8030408@yahoo.com>
Date: Thu, 23 Jul 2015 14:27:38 -0400
MIME-Version: 1.0
In-Reply-To: <55B0D336.1010406@tresys.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Yeah I have checked out that pdf and was wondering which one was right 
because I was going back and forth with the wiki but thanks for 
clarifying it has the up to date info.

On 07/23/2015 07:42 AM, Steve Lawrence wrote:
> On 07/22/2015 06:21 PM, Dan wrote:
>> Hey guys, I've been reading the documentation of CIL language and have
>> been practicing writing policies from scratch and have come across a
>> problem. Here is what I have so far(which is just a simple example):
>>
>> (type myapp_t)
>> (role object_r)
>> (role staff_r)
>> (roletype object_r myapp_t)
>> (typeattribute domain)
>> (typeattributetypes domain (myapp_t))
>>
>>
>> (type myapp_exec_t)
>> (roletype object_r myapp_exec_t)
>> (typeattribute domain)
>> (typeattributetypes domain (myapp_exec_t))
>>
>>
>>
>> Now I know I need other stuff to build this module completely like SID,
>> access vectors, etc, but I'm stuck because it doesn't recognize the
>> "typeattributetypes" statement. It just spits out the error as an
>> unknown keyword which I don't know why I would because I'm pretty sure I
>> used it right, but I'm still learning. Any info would be awesome. Thanks
>> guys.
>>
> typeattributetypes is an old statement that no longer exists. It was
> renamed to typeattributeset. The CIL documentation on the wiki is pretty
> out of date. I'd recommend just looking at the docs in the secilc
> directory in the selinux userspace repo. Running make in secilc/docs
> will create an html and pdf version of the documentation, which should
> be pretty up to date.
>
