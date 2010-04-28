Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3SImFaq029691
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 14:48:15 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id o3SIn4dF002515
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 18:49:04 GMT
Message-ID: <4BD882DC.9070803@tresys.com>
Date: Wed, 28 Apr 2010 14:47:56 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Karl MacMillan <kmacmillan@tresys.com>, SELinux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: refpolicy is missing on lots of hits with audit2allow -R.
References: <4BCC69C0.5040502@redhat.com>	 <l2s10143821004200737t683832efu28214c95b3e156c@mail.gmail.com>	 <4BCF05D3.5090700@redhat.com>	 <u2q10143821004211853jea20406bz355fc111cd449c47@mail.gmail.com>	 <4BD0513C.40403@redhat.com>	 <q2s10143821004220729z2e39b1fdqe16997df0cee0574@mail.gmail.com>	 <w2q10143821004221216j96faf709w8b702c67835197d6@mail.gmail.com>	 <4BD1B843.1030805@redhat.com>	 <n2g10143821004280725qcf3ebaf8n44eb53504aa32feb@mail.gmail.com>	 <4BD85592.10201@redhat.com> <g2r10143821004281053vdc0263bfh605a3e3cc19f7571@mail.gmail.com> <4BD87A97.9010309@tresys.com> <4BD88010.9050906@redhat.com>
In-Reply-To: <4BD88010.9050906@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 04/28/2010 02:12 PM, Joshua Brindle wrote:
>> Karl MacMillan wrote:
>>> On Wed, Apr 28, 2010 at 11:34 AM, Daniel J Walsh<dwalsh@redhat.com>
>>> wrote:
>> <snip>>
>>>> I would argue that
>>>>
>>>> allow X etc_t:file read;
>>>> allow X configfile:file read;
>>>>
>>>> Should be weighted equivalently if etc_t is a configfile or only
>>>> slightly heavier, and just because etc_runtime_t or some other random
>>>> types are configfile does not mean we need to add weight.
>>>>
>> I'm going to weigh in here even though policy isn't normally my thing.
>>
>> I am very against reducing distance based on attribute match over
>> individual unrelated types. allow X configfile:file read should be the
>> exact same distance as having an allow rule for every type in configfile
>> in the interface, otherwise you have inconsistent behavior and are
>> rewarding interfaces that are overly broad.
>>
> I agree but the question is on an AVC that needs
>
> allow $1 etc_t:file read;
>
>
> Which is a better match
>
> allow $1 configfile:file read;
>
> Or
>
> allow $1 etc_t:file { read write };
>
>> The reason for using sepolgen is to find the best match, not the most
>> broad, if we wanted that we could make sepolgen 1000% less complicated
>> and just return allow domain filetype:file *;
>>
>> I suppose there is a fundamental difference in the use of the tool, the
>> people I know that use it use it to find the best match, the way you
>> want to use it is to fix the denial any way possible. These 2 usages
>> conflict and we can't have people thinking they are making secure policy
>> when in fact they aren't.
>>
>
> Thats Bullshit.  I am trying to get the best match.  The example I
> showed earlier the tool was getting way off, because it did not take
> into effect attributes.  The access returned for a getattr was to allow
> the domain to delete the file.
>

Fair enough. It seems like it would work as expected if interfaces were 
relatively side effect free though (eg., files_read_etc_files shouldn't 
have the side effect of reading all config files, perhaps a new 
interface called files_read_config_files should be used instead).

I guess the big problem is that without looking at the interface (and 
unraveling all the interface calls within) the user can't actually 
determine what the matched interfaces do.

I agree with Karl about penalizing exec and delete though, even though 
exec really isn't necessary to execute something, all you need is read 
access.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
