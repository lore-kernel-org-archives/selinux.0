Date: Wed, 22 Apr 2009 17:08:07 -0400
Subject: Re: Help with python seobject.loginRecords
From: Chad Sellers <csellers@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>
CC: Joe Nall <joe@nall.com>, SELinux List <selinux@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>
Message-ID: <C614FF77.A6A74%csellers@tresys.com>
In-Reply-To: <49B90E2D.9010400@redhat.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 3/12/09 9:29 AM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:

> On 03/11/2009 05:00 PM, Stephen Smalley wrote:
>> On Wed, 2009-03-11 at 16:49 -0400, Daniel J Walsh wrote:
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA1
>>> 
>>> Joe Nall wrote:
>>>> On Mar 11, 2009, at 2:35 PM, Daniel J Walsh wrote:
>>>> 
>>>>> On 03/11/2009 12:15 PM, Joe Nall wrote:
>>>>>> I need to add login mappings in python firstboot modules during system
>>>>>> configuration. In my first module a simple:
>>>>>> 
>>>>>> seobject.loginRecords().add(username, "siterep_u",
>>>>>> "SystemLow-SystemHigh")
>>>>>> 
>>>>>> works. In subsequent modules, I get an exception:
>>>>>> 
>>>>>> libsemanage.enter_rw: this operation requires a transaction
>>>>>> libsemanage.enter_rw: could not enter read-write section
>>>>>> Traceback (most recent call last):
>>>>>> File "./t", line 6, in<module>
>>>>>> seobject.loginRecords().add("test3", "sysadm_u", "SystemLow-SystemHigh")
>>>>>> File "/usr/lib64/python2.5/site-packages/seobject.py", line 442, in add
>>>>>> raise error
>>>>>> ValueError: Could not add login mapping for test3
>>>>>> 
>>>>>> What is the right way to do this?
>>>>>> 
>>>>>> joe
>>>>>> 
>>>>>> 
>>>>>> --
>>>>>> This message was distributed to subscribers of the selinux mailing list.
>>>>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
>>>>>> with
>>>>>> the words "unsubscribe selinux" without quotes as the message.
>>>>> Probably an MLS issue.  firtstboot is running in a context that is not
>>>>> allowed to lock/manage selinux.
>>>> I'm installing in permissive and switching to enforcing after firstboot.
>>>> You are correct that firstboot_t doesn't have the policy for all the
>>>> stuff I'm trying to do yet.
>>>> 
>>>>> You probably should exec semanage rather then calling seobject so you
>>>>> could do a transition and not have to give a huge app like first boot
>>>>> the ability to manage security policy.
>>>> That is what is installing right now. I would still like an
>>>> explanation/code snippet of correct usage for future use
>>>> 
>>>> joe
>>>> 
>>>> 
>>> This works on F10 Targeted policy
>>> 
>>> # python -c "import seobject; seobject.loginRecords().add("pwalsh",
>>> "staff_u", "s0")
>>> # python -c 'import seobject; seobject.loginRecords().delete("pwalsh")'
>>> 
>>> Could it be a translation problem?
>> 
>> Try running multiple calls within the same python interpreter.
>> I think seobject.py isn't using libsemanage correctly.  For example, in
>> add(), you do:
>>                         self.begin()
>>                          self.__add(name, sename, serange)
>>                          self.commit()
>> but begin() only ever invokes semanage_begin_transaction() the very
>> first time:
>>         def begin(self):
>>                 if self.transaction:
>>                        return
>>                 rc = semanage_begin_transaction(self.sh)
>> 
>> So after the first commit(), you'll start failing.
>> 
> I think this patch fixes the transaction patch in semanage.

Patch looks good to me.

Acked-by: Chad Sellers <csellers@tresys.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
