Message-ID: <4909FD84.2050906@redhat.com>
Date: Thu, 30 Oct 2008 14:31:32 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: LC Bruzenak <lenny@MagitekLtd.com>, SE-Linux <selinux@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: semanage help
References: <1224727612.14755.244.camel@homeserver>	 <1224766402.28867.4.camel@moss-spartans.epoch.ncsc.mil>	 <4900A0C8.9050200@redhat.com>	 <1224779343.28867.60.camel@moss-spartans.epoch.ncsc.mil>	 <4900B01C.4070206@redhat.com> <1224782298.14755.267.camel@homeserver>	 <4900B461.7090509@redhat.com>	 <1224784833.2879.2.camel@moss-spartans.epoch.ncsc.mil>	 <1224787273.14755.282.camel@homeserver> <1224787700.3974.163.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1224787700.3974.163.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Thu, 2008-10-23 at 13:41 -0500, LC Bruzenak wrote:
>> On Thu, 2008-10-23 at 14:00 -0400, Stephen Smalley wrote:
>>> On Thu, 2008-10-23 at 13:29 -0400, Daniel J Walsh wrote:
>>>> LC Bruzenak wrote:
>>>>> On Thu, 2008-10-23 at 13:10 -0400, Daniel J Walsh wrote:
>>>>> ...
>>>>>> On Rawhide it seems to work
>>>>>>
>>>>>> # /usr/sbin/semanage fcontext -a -t prelude_spool_t -r s0:c0.c1023
>>>>>> '/var/spool/prelude(/.*)?'
>>>>>> # restorecon -R -v /var/spool/prelude/
>>>>>> restorecon reset /var/spool/prelude context
>>>>>> system_u:object_r:prelude_spool_t:s0->system_u:object_r:prelude_spool_t:s0:c0.c1023
>>>>>>
>>>>>>
>>>>>> So I will patch policycoreutils.
>>>>>>
>>>>> Thanks Dan!
>>>>>
>>>>> LCB.
>>>>>
>>>> Of course this is totally not intuitive to the user.
>>>>
>>>> He really wants to modify and existing fcontext so he needs to add a new
>>>> conflicting one.
>>>>
>>>> This command should really be fixed to check if an exising global or
>>>> local exist,
>>>>
>>>> if a local exists it should modify if a global exists it should add.
>>> I think semanage port handles that situation correctly.  __modify uses
>>> the _exists interface to check existence (whether in policy or local),
>>> and uses the modify_local interface to update (which internally will
>>> fall back to an add if not already locally defined).
>>>
>> It didn't seem to work this way with the patch - I could only add it
>> (then modify):
> 
> I was saying that it works that way for semanage port already (not
> fcontext), so Dan can use that as an example of how to make it work for
> fcontext.
> 
>> [root@v1 ~]# /usr/sbin/semanage fcontext -m -t prelude_spool_t -r s0:c0.c1023 '/var/spool/prelude(/.*)?'
>> /usr/sbin/semanage: File context for /var/spool/prelude(/.*)? is not defined
>>
>> [root@v1 ~]# rpm -qv policycoreutils
>> policycoreutils-2.0.57-5.fc10.i386
>>
>> [root@v1 ~]# /usr/sbin/semanage fcontext -a -t prelude_spool_t -r s0:c0.c1023 '/var/spool/prelude(/.*)?'
>> [root@v1 ~]# /usr/sbin/semanage fcontext -m -r s0:c0.c1022 '/var/spool/prelude(/.*)?'
>>
>> - and so far restorecon works as expected.
>>
>> So to me it seems like the man page needs updating if this behavior is
>> desired (only local fcontext changes allowed). Seems fine to me; only
>> thing is the last one in the list wins I guess, vice only last-occurring
>> duplicates displayed.:
>>
>> [root@v1 ~]# /usr/sbin/semanage fcontext -l | grep prelude
>> ...
>> /var/spool/prelude(/.*)?                           all files          system_u:object_r:prelude_spool_t:s0 
>> ...
>> /var/spool/prelude(/.*)?                           all files          system_u:object_r:prelude_spool_t:s0:c0.c1022 
>>
>> Main thing for me is that it works so I can resume testing.
>> Thanks again!
>>
>> LCB.
>>
I believe policycoreutils-2.0.57-9.fc10 has the syntax correct now.

Please try it out.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkkJ/YQACgkQrlYvE4MpobMEcgCfcGlQlXNgRlmjZovc+xyeLFMR
NaIAn1UBc36XD+hkhB1ycd0xgiqFNFkG
=es5X
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
