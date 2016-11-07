Subject: Re: Security context of shared libraries
To: mm19827 <mm19827@gmail.com>, selinux@tycho.nsa.gov
References: <f195719b-bab5-6a83-0a13-8d62c077e808@gmail.com>
 <8ff395c1-f0cd-061f-fb26-2bba74eb32d7@tycho.nsa.gov>
 <95ad1d72-8c8c-29eb-531c-e42dd02f6a19@gmail.com>
 <8e4c976b-8608-4331-fe4d-251db6763b0b@tycho.nsa.gov>
 <5abc1601-678f-0d76-e800-789941f5c22b@gmail.com>
 <d20db309-43e4-adcf-04e2-407290d52b93@tycho.nsa.gov>
 <85fa6e4c-9c24-1371-d5a8-332d18015818@gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a2bc0a3f-279d-7748-91c3-771eaff94bae@tycho.nsa.gov>
Date: Mon, 7 Nov 2016 10:25:41 -0500
MIME-Version: 1.0
In-Reply-To: <85fa6e4c-9c24-1371-d5a8-332d18015818@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/07/2016 10:11 AM, mm19827 wrote:
> 
> 
> On 11/07/2016 04:01 PM, Stephen Smalley wrote:
>>
>> I suppose that's true, depending on what it is that you have to allow
>> between foo_t and bar_t, e.g. you can allow foo_t to connect to a bar_t
>> socket or similar without allowing it to connect to unconfined_t
>> sockets.
> Exactly.
> 
>  If you truly want bar_t to be unconfined, you can always just
>> have it call the unconfined_domain() interface in refpolicy, e.g.
>> unconfined_domain(bar_t), and it will inherit all of the unconfined
>> domain rules.
>>
> Thanks for the info.
> It would be great (and this would be my last question), if you could
> give a pointer to a complete documentation of refpolicy macros and
> interfaces - I could find the kernel rules, and that it makes use of m4
> macros, but not a complete documentation.

http://oss.tresys.com/docs/refpolicy/api/

It is generated from the refpolicy sources.

refpolicy  mailing list is a better place to ask questions about
refpolicy, see
http://oss.tresys.com/mailman/listinfo/refpolicy
