Message-ID: <4D80DF76.7060802@windriver.com>
Date: Wed, 16 Mar 2011 12:04:06 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Eamon Walsh <ewalsh@tycho.nsa.gov>, SELinux List <selinux@tycho.nsa.gov>,
        Stephen Lawrence <slawrence@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: libselinux version bump past 99
References: <4D76AD1C.8080901@tycho.nsa.gov>	 <4D7EA42A.2030802@windriver.com> <1300191052.17384.3.camel@moss-pluto>
In-Reply-To: <1300191052.17384.3.camel@moss-pluto>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11-03-15 08:10 AM, Stephen Smalley wrote:
> On Mon, 2011-03-14 at 19:26 -0400, Paul Gortmaker wrote:
>> On 11-03-08 05:26 PM, Eamon Walsh wrote:
>>> Libselinux has reached version 2.0.99 and I need to push a bug fix, just checking to make sure 2.0.100 is fine and won't cause any problems e.g. with upgrades.
>>>
>>>
>> On a related note, is there a reason why the shared objects don't
>> track a similar versioning number?    We came across a situation
>> where an internal update added a new dir for libs.   But note the
>> shared objects are hard coded to version 1,  and the old selinux
>> libs just happened to be found 1st.   Which leads to a cryptic
>> internal selinux error message like this:
>>
>> "libsepol.policydb_read: policydb module version 10 does not
>> match my version range 4-8"
>>
>> Granted, this may not be a common problem, but the solution that
>> came to me was to simply let the normal ld.so dynamic library
>> versioning do its job in determining which bins need which libs;
>> something that it is remarkably good at.  :)
> As I understand it, the .so version should only be changed upon an
> incompatible ABI change, not upon implementation changes or compatible

Sure, and the above error message clearly indicates that
this has not been done in the past.   So as I'd hinted at,
the question then becomes when to start implementing
it, if people agree it makes sense to do what every other
library does.

The simplest answer seems to be to align it upon the
next incompatible ABI change you have queued up.
Leaving it hard coded at 1 forever just seems misleading,
and causes errors like the one I showed above.

Thanks,
Paul.

> ABI changes.  And per-symbol versioning seems to be preferred these
> days, as per:
> http://www.akkadia.org/drepper/dsohowto.pdf
>
> See libsemanage.map for an example.
>
> But the question of what policy version is supported by a given release
> of libsepol has nothing to do with its ABI.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
