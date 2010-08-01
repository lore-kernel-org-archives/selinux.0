Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o71L6Dhc030457
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2010 17:06:13 -0400
Received: from mail-yw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o71L6Kr3014626
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2010 21:06:20 GMT
Received: by ywh2 with SMTP id 2so1348138ywh.12
        for <selinux@tycho.nsa.gov>; Sun, 01 Aug 2010 14:06:10 -0700 (PDT)
Message-ID: <4C55E1BF.8060407@gmail.com>
Date: Sun, 01 Aug 2010 17:06:07 -0400
From: Ralph Blach <chipper19522@gmail.com>
MIME-Version: 1.0
To: Dominick Grift <domg472@gmail.com>
CC: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: semanage
References: <4C4F77D6.1080700@chipblach.net> <AANLkTin+L3kZFqLzsy8ioQze7nD3Vf45C+TPrcAYnm38@mail.gmail.com> <4C559624.6040709@gmail.com> <4C559A84.4060004@gmail.com> <4C559F31.4070404@gmail.com> <4C55A265.6090606@gmail.com> <4C55A3B2.8020207@gmail.com> <4C55A44F.4030803@gmail.com>
In-Reply-To: <4C55A44F.4030803@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ok, you said

cat <<D_G >mysshd.te

is D_G a file someplace?

Thanks

Chip


On 08/01/2010 12:43 PM, Dominick Grift wrote:
> On 08/01/2010 06:41 PM, Dominick Grift wrote:
>> On 08/01/2010 06:35 PM, Dominick Grift wrote:
>>> On 08/01/2010 06:22 PM, Ralph Blach wrote:
>>>> To be specific, I want to run sshd on port 443, and not port 22, because
>>>> of all the hackers probe port 22.
>>>>
>>>> port 443 looks like httpd traffic and therefore is not really supicious.
>>>>
>>>> That is what I need to achieve so i need to modify the corenetwork
>>>> module to do this.
>>>>
>>>> How is this done and where is the source for the core network module?
>>>
>>> Try this:
>>>
>>> mkdir ~/mysshd; cd ~/mysshd;
>>>
>>> cat <<D_G >mysshd.te
>>> policy_module(mysshd, 1.0.0)
>>> gen_require(`
> 
>>> type shorewall_t;
> 
> And this needs to be ..
> 
> type sshd_t;
> 
> .. instead
> 
>>> ')
>>> corenet_tcp_bind_http_ports(sshd_t)
>>> D_G
>>>
>>> That custom policy module should allow sshd to bind tcp sockets to http
>>> ports (including tcp:443)
>>
>> Ofcourse you also have to build and install the custom module:
>>
>> ( below is how that is done in Fedora (RHEL5 requires that you also
>> install selinux-policy-devel to build a module)
>>
>> make -f /usr/share/selinux/devel/Makefile mysshd.pp
>> sudo semodule -i mysshd.pp
>>
>>
>>>
>>> You can find source policy in the source package for your policy.
>>>
>>> Here is the policy browser from upstream:
>>> http://oss.tresys.com/projects/refpolicy/browser
>>>
>>>
>>>> Thanks
>>>>
>>>> Chip
>>>>
>>>>
>>>>
>>>> On 08/01/2010 12:02 PM, Dominick Grift wrote:
>>>>> On 08/01/2010 05:43 PM, Ralph Blach wrote:
>>>>>> I have discovered that ports 443 and 22 are in module tcp.
>>>>>>
>>>>>> How do i rewrite module tcp so that I can configure as I want it.
>>>>>>
>>>>>> Where do I find module tcp?
>>>>>>
>>>>>> I did a semanage port -l | grep 22 and module tcp was listed.
>>>>>> I did the same for port 443
>>>>>>
>>>>>> Thanks
>>>>
>>>>> ports are declared (defined) in the corenetwork module. This module is
>>>>> part of the base module. modules that are part of the base module are
>>>>> not listed with semodule -l.
>>>>
>>>>> What exactly do you want to achieve? If you are specific about your
>>>>> requirements we can try to help you implement it.
>>>>
>>>>>> Chip
>>>>>>
>>>>>> On 07/27/2010 08:29 PM, Jason Axelson wrote:
>>>>>>> On Tue, Jul 27, 2010 at 2:20 PM, Ralph Blach <chipper19522@gmail.com> wrote:
>>>>>>>> how do I use semanage to list the policy modules.
>>>>>>
>>>>>>> Hi Chip,
>>>>>>
>>>>>>> Perhaps you are looking for "semodule -l"? That will list out all the
>>>>>>> installed policy modules (besides base).
>>>>>>
>>>>>>> Jason
>>>>>>
>>>>>>
>>>>
>>>>> --
>>>>> This message was distributed to subscribers of the selinux mailing list.
>>>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
>>>>> with
>>>>> the words "unsubscribe selinux" without quotes as the message.
>>>>
>>>>
>>>>
>>>
>>
>>
> 
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJMVeG9AAoJEI46azFTGsehSwMP/10gXSM8CaVLzRndSJCKNeIy
KdT3bQ01SyxgjH8rmkELyovRczMMOb1gUfjs0yYLuPnZ5G6z+m9mQKGD22kAnYU2
lwB6X0jTaP4XSQuXMBleBFPqISNBUz90lKd2xRleVY+1lnaok9i1cOJDrkdJbKFm
5PZpFGnODpp83lrtZgAB2dTBvYWDDVuCdePo6524Q7fAroygRNrrXDerFfPPDll1
CiP7dqiuodJbe5njT/avFFTYJuCWuoY1Z0mS7HiRinHRGJtjI6PAIa7i7ESHyWKz
BT9WQHljroU/b6O4jUREEZgcFRKtGCmEO2RZLGeTkg/ci5Yz9533q6fk9P63XgfY
ink/JxGyO4HMoEvu+2yEG2OPtd1fP3TfPs9o/6mSo+fWmLvlO4arey2QtuMOrpQN
OERbdwBjv/pvsLi6K89AQcCVLAtHiYQOqTcmXJJXwZ1tjSUvUyr3s9rNNdnh5zYT
CuW4/sq70Vxc0zxHXqLPj5dfvEp1W3sRAmfrMAySatpJGa0h7wORaIWKz04mOZ0q
5T6so0oQmHUvmpWB3SzWsz93Ve1/wjM1Q2o8RQnZoUeiJp1Ga/tAN9UioT+iuF+U
A2lTXXUH0Bancoah54JrHGxKf09qdCOKe5P8z7xKpW0bIoQQAYVdUgtXyzTuaMGg
r6PDIN5xDjUOQvjaiBmL
=hNcN
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
