Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oAUIQWB3009897
	for <selinux@tycho.nsa.gov>; Tue, 30 Nov 2010 13:26:32 -0500
Received: from mail-ey0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id oAUIQUui021613
	for <selinux@tycho.nsa.gov>; Tue, 30 Nov 2010 18:26:30 GMT
Received: by eyb6 with SMTP id 6so2989108eyb.12
        for <selinux@tycho.nsa.gov>; Tue, 30 Nov 2010 10:26:29 -0800 (PST)
Message-ID: <4CF541D1.70802@gmail.com>
Date: Tue, 30 Nov 2010 19:26:25 +0100
From: Dominick Grift <domg472@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: analysing optional policy
References: <201011262055.01924.russell@coker.com.au>	 <1291131374.1328.25.camel@moss-lions.epoch.ncsc.mil>	 <4CF52A19.6070704@gmail.com> <1291140706.1328.47.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1291140706.1328.47.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/30/2010 07:11 PM, James Carter wrote:
> On Tue, 2010-11-30 at 17:45 +0100, Dominick Grift wrote:
> On 11/30/2010 04:36 PM, James Carter wrote:
>>>> On Fri, 2010-11-26 at 20:55 +1100, Russell Coker wrote:
>>>>> I'm having a problem with optional policy not being used when I think it 
>>>>> should.
>>>>>
>>>>> Is it possible to use apol to get information on optional policy for .pp files 
>>>>> so I can try to work out why it doesn't get enabled?
>>>>>
>>>>>                 unconfined_run_to(depmod_t, depmod_exec_t)
>>>>>
>>>>> In the Debian policy I have the above in an optional section of base.pp but 
>>>>> for reasons that I don't understand it's not being loaded (both tests and 
>>>>> running apol on policy.24 show this).
>>>>>
>>>>> I've inspected the contents of base.conf and they appear to be OK.
>>>>>
>>>>> Any suggestions of other tools to analyse this will be appreciated.
> 
> This may not be applicable here but do double check the module. I have
> experienced similar issues where optional policy blocks were not loaded,
> without any errors shown.
> 
>> Not being defined is not an error in an optional block, it just means
>> the optional block is not to be used.
> 
>> It is expected that there will be a lot of unused optional blocks if
>> only some modules are being used.  Reporting everything not defined
>> would not be helpful in this case.
> 
>> This behavior of silently removing optional blocks can, however, cause
>> real errors to be missed.

Yes now i remember what happened:

1. i have a per_role_template that had a type in the require section
that i removed. The per role template was called in an optional policy
block.

2. Because the template required a type that did not exist, it was not
used because it was called in an optional policy block.

3. Then later i found out about the required type that didnt exist and i
removed that from the require block of the per role template, and that
is when other errors were exposed in the per role template.

After fixing those , all was well.

An unlikely chain of events but it can happen and can be pretty
confusing. (atleast it was to me. Took me a view hours to troubleshoot :)


> 
>  I remember once requiring a type that did not
> exist. Compiler did not complain but some particular policy was not loaded.
> 
> When this happens to me, i check syntax of all policy, check that all
> used types exist and that there are no typos in types and other policy
> in the particular module (in this case modutils and or unconfined). In
> my erperience it is usually due to a syntax error or some other error in
> the module.
> 
> Other issues i have had with optional policy is for example attributes
> not being within scope or incorrectly nesting of optional policy.
> 
> But, i believe in both latter cases, the compiler or installer will
> complain about duplicate declaration or not within scope.
> 
> So in my experience, i suspect there is an error in your policy that the
> compiler did not catch.
> 
> What may help troubleshoot your issue is to try compiling and loading
> the policy without the optional tags. In some cases that may expose
> things errors.
> 
> These issues suck and can take ages to track down. The compiler is often
> not very helpful in these instances either.
> 
> Basically all you can do is keep checking the involved modules for any
> errors i believe.
> 
> I have been fighting with optional policy for quite some time, and i
> have blamed optional policy for a lot of things. But since i figured out
> how it works and how to nest optional policy i found out that it
> actually makes sense. It can be complicated but usually not with
> confining the system layer. When confining the user space, then nesting
> optional policy becomes a big issue.
> 
>>>>
>>>> Is this with the policy found in
>>>> selinux-policy-src_0.2.20100524-4_all.deb?  I don't see
>>>> unconfined_run_to being used in that policy.
>>>>
>>>> It looks like modutils is part of base, so depmod_t and depmod_exec_t
>>>> should be defined.  But there is a requires statement at the top of
>>>> modutils for "bool secure_mode_insmod".  Is secure_mode_insmod in the
>>>> policy?
>>>>
> 
>>
- --
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkz1QdAACgkQMlxVo39jgT8TtgCgsr6eKlqN0LCcwC5/3tcanjY2
NxIAoKFWqesRFBg8dAsIGsuuL6hg0AD0
=E0DG
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
