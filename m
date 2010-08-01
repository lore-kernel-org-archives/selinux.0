Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o71GMJOp015839
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2010 12:22:19 -0400
Received: from mail-gy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o71GMPW7019837
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2010 16:22:25 GMT
Received: by gyf1 with SMTP id 1so1333524gyf.12
        for <selinux@tycho.nsa.gov>; Sun, 01 Aug 2010 09:22:16 -0700 (PDT)
Message-ID: <4C559F31.4070404@gmail.com>
Date: Sun, 01 Aug 2010 12:22:09 -0400
From: Ralph Blach <chipper19522@gmail.com>
MIME-Version: 1.0
To: Dominick Grift <domg472@gmail.com>
CC: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: semanage
References: <4C4F77D6.1080700@chipblach.net> <AANLkTin+L3kZFqLzsy8ioQze7nD3Vf45C+TPrcAYnm38@mail.gmail.com> <4C559624.6040709@gmail.com> <4C559A84.4060004@gmail.com>
In-Reply-To: <4C559A84.4060004@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

To be specific, I want to run sshd on port 443, and not port 22, because
of all the hackers probe port 22.

port 443 looks like httpd traffic and therefore is not really supicious.

That is what I need to achieve so i need to modify the corenetwork
module to do this.

How is this done and where is the source for the core network module?

Thanks

Chip



On 08/01/2010 12:02 PM, Dominick Grift wrote:
> On 08/01/2010 05:43 PM, Ralph Blach wrote:
>> I have discovered that ports 443 and 22 are in module tcp.
>>
>> How do i rewrite module tcp so that I can configure as I want it.
>>
>> Where do I find module tcp?
>>
>> I did a semanage port -l | grep 22 and module tcp was listed.
>> I did the same for port 443
>>
>> Thanks
> 
> ports are declared (defined) in the corenetwork module. This module is
> part of the base module. modules that are part of the base module are
> not listed with semodule -l.
> 
> What exactly do you want to achieve? If you are specific about your
> requirements we can try to help you implement it.
> 
>> Chip
>>
>> On 07/27/2010 08:29 PM, Jason Axelson wrote:
>>> On Tue, Jul 27, 2010 at 2:20 PM, Ralph Blach <chipper19522@gmail.com> wrote:
>>>> how do I use semanage to list the policy modules.
>>
>>> Hi Chip,
>>
>>> Perhaps you are looking for "semodule -l"? That will list out all the
>>> installed policy modules (besides base).
>>
>>> Jason
>>
>>
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
> 
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJMVZ8vAAoJEI46azFTGsehivYP/2OongqEYeroMPognxG7nTcc
cbqWlFI32xSIwVhAWNqioSg5eWA5AN6vDnN43q4AL64UqVe4mwl6IF9/4ydhpJwc
xCvje3g5At+FCjHy6mx1yi56Zm7E2gI1pR4I0Gsrxdqk0WWlGbbhs8Dz84dSjKWH
3B12jW43sw/kyzHhR+AbLGlA+oU5TA1hTOSmTkuwOjQoWqQtYnc5nsXzX8uBvd1Z
MLCTNQ0ZkNjPvSAbp3qqA+9I1Bavytq2900rUMm861ui+HrTLpBt7+qkf8NomNVF
xmQ64Lcb7VKFOVdSCV+PmfUQBIdw4/LS9thB8/o3avy/1+hHclaVYrYxjgxjOPfB
budsoVBRM6Q5QwKJL+d+oYdklGimtZv+wAfvBxveQ4vdjXePHmTAtiQ6reY6JBwa
vGqq7O/sKStyErB/BCeDASdQCgxkJwFZMw11z2OTDQrdVH+7H6Szq3a+O4SpZ59Z
zNrsJ4CQU6d/dgf9Jy29SS1zCaEBoWTcEbVKp2RV4dXRAYkf58FpIEKD3PZkkE4F
0/GJSHuXvek1PGlR1PyJ84T2CHnXBsYbKGXG4DKISwd/SzPj3rLkIRRqX7n31dSU
d8phXUdCyG9SJZC0ew6IE5PM8NQoCTV+tHakhLyK2HJXUr887bddxd+6VPtlSwBF
fJtEe6w6Iy1qIRxnJaLP
=PE3f
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
