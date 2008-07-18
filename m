Message-ID: <4880D23E.8070207@redhat.com>
Date: Fri, 18 Jul 2008 13:26:22 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@tycho.nsa.gov
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux <selinux@tycho.nsa.gov>
Subject: Re: [refpolicy] Patch: Create non_security_file_type attribute
References: <1214592935.2888.11.camel@moss-lions.epoch.ncsc.mil>	 <1216390554.21191.147.camel@gorn>	 <1216395738.26625.45.camel@moss-lions.epoch.ncsc.mil>	 <1216396152.21191.163.camel@gorn> <1216397010.26625.53.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1216397010.26625.53.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

James Carter wrote:
> On Fri, 2008-07-18 at 11:49 -0400, Christopher J. PeBenito wrote:
>> On Fri, 2008-07-18 at 11:42 -0400, James Carter wrote:
>>> On Fri, 2008-07-18 at 10:15 -0400, Christopher J. PeBenito wrote:
>>>> On Fri, 2008-06-27 at 14:55 -0400, James Carter wrote:
>>>>> This patch eliminates the expansion of the file_type attribute (due to
>>>>> the "-" set operation) for the *_non_security interfaces by creating a
>>>>> non_security_file_type attribute.
>>>>>
>>>>> On my system the resulting binary policy is almost 20% smaller.  The
>>>>> difference is so large because there are over 1000 types labeled with
>>>>> the file_type attribute.
>>>> I'm hesitant to attach non_security_file_type to the files_type
>>>> attribute, since its not clear to me that it makes conceptual sense.
>>> The primary goal here is a smaller binary policy.  But it still makes
>>> sense conceptually to me because the security_file_type attribute is
>>> never used by itself as far as I can tell.  It is always used as
>>> {file_type-security_file_type}.
>>>
>>>>   In
>>>> fact a sediff of the policy reveals that auidtd_log_t gains
>>>> non_security_file_type while it already has security_file_type, which
>>>> results in rule additions with this patch added.
>>> That's not good.  There are only a handful of types labeled with
>>> security_file_type, I don't know how I missed that.  Sorry.
>>>
>>> The following line is the problem: files_mountpoint(auditd_log_t).
>>> So, a files_mountpoint_security interface would have to be created.
>>>
>>> It's not a big deal to me.  If there is no interest in creating a
>>> non_security_file_type attribute, I won't pursue this any farther.
>> I think the binary policy size savings is a good enough reason to pursue
>> it.  Brainstorming for a second, another way to address this problem
>> would be to change how checkpolicy handles negations.  It could make a
>> new attribute with the resultant type set from the negation;
> 
> It would need to make sure that the resultant set is not already covered
> by an attribute, or much of the value would be lost.
> 
>>  however,
>> that might be bad for analysis since an attribute would magically appear
>> out of nowhere.
> 
> You already have that problem when analyzing a binary policy, since the
> attribute names aren't preserved.
> 
Speaking of which, I thought we were looking into adding that back in?

It could help out tools like audit2why...

Constraint violation, go though list of all attributes and see if one
fixes the problem.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkiA0j4ACgkQrlYvE4MpobOKMACaAmk9NZvQJIhgNlztBARgLlxL
dL8An0PPozwFr1hf0QRncfpWQvZuKd1A
=C4Bl
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
