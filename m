Message-ID: <4AA6F6C2.6040200@ak.jp.nec.com>
Date: Wed, 09 Sep 2009 09:28:50 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>
Subject: Re: Limitations in modular policy
References: <4AA5AB73.6050306@ak.jp.nec.com> <1252423223.13634.389.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1252423223.13634.389.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2009-09-08 at 09:55 +0900, KaiGai Kohei wrote:
>> Is there any good reason why the current modular policy doesn't, cannot
>> or shouldn't support to contain definitions of object classes and its
>> access vectors except for the base policy?
> 
> The class and permission values are determined based on declaration
> ordering.  There are no ordering guarantees among modules, and thus any
> order dependent statements have to go into the base module presently.

In other word, it is not impossible to define experimental classes and
permissions within policy modules, as long as we can guarantee the order
of existing classes and permissions.

Since the class and permission values for kernel object classes are
defined in the base policy module as ABI, we can define their values
independently from the order of module linking. (The base policy is
the first base as literal.)

# BTW, it may be a time to consider whether the kernel also should lookups
# object classes and permissions by their names on policy loading, or not.

However, it is not my intention to take an experimental works which need
more than several months, so it may be necessary to replace the base policy
module to support these classes and permissions for a while.

> Even for modern userspace object managers that dynamically look up the
> class and permission values, we don't yet have a way to atomically roll
> them over to a new set of values upon a policy reload, which could
> easily happen upon module removal or insertion if they are declared in
> individual modules.  I think we'd have to extend avc_reset() to also
> call flush_class_cache() to force rediscovery of the class/permission
> values from selinuxfs and to then call selinux_set_mapping() with the
> original security_class_mapping (to which we would have to save a
> reference upon the earlier selinux_set_mapping call) to re-create the
> mapping.  It would have to be done while holding the AVC lock.

It does not seem to me a difficult matter, because it can be resolved
with updating libselinux.
One possible trouble is a case when an application uses the result of
string_to_security_class() permanently across the policy reloading.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
