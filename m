Date: Thu, 31 May 2007 14:00:48 -0400
Subject: Re: SELinux userspace infrastructure language
From: Chad Sellers <csellers@tresys.com>
To: Karl MacMillan <kmacmill@redhat.com>, Joshua Brindle <jbrindle@tresys.com>
CC: <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <C2848590.223A5%csellers@tresys.com>
In-Reply-To: <1180633622.3534.78.camel@localhost.localdomain>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 5/31/07 1:47 PM, "Karl MacMillan" <kmacmill@redhat.com> wrote:

> On Thu, 2007-05-31 at 13:35 -0400, Joshua Brindle wrote:
>> Some discussion has started off-list about what language to use for the
>> implementation of the new policy intermediary format and we'd like to
>> bring this discussion into the community to get feedback from users and
>> other developers.
>> 
>> In the policyrep branch we've basically started taking OOisms and
>> pythonisms and reimplementing them in C which is non-ideal.
> 
> No pythonisms that I am aware of (and I have avoided them).
> 
>>  There is
>> also madness behind the string handling in some newer work we are doing.
>> We discussed the possibility of using python or C++ for our libraries so
>> that they are more represenative of the datastructures that are being
>> created elsewhere and being reimplemented in C.
>> 
>> Libsemanage could easily be implemented in pure python, it doesn't do
>> much hard work, libsepol, on the other hand, is used by a lot of
>> external stuff so it's a more difficult sell. It would be nice to
>> potentially use the STL for a lot of the stuff we are doing in libsepol.
>> 
>> Libsemanage need not be rewritten immediately (or at all if not
>> considered a necessity) but the new policy representation work will be
>> happening in the near term so the language chosen for it will
>> immediately be used. This language would be required for any systems
>> with managed policies (eg., using policy modules and semanage) so that
>> is something to be considered.
>> 
> 
> To make this more concrete, there are two basic options (as I see it):
> 
> 1) adopt sepolgen as the new policyrep and implement the policy
> compilers on top of that. The policyrep branch is in some senses a port
> of part of sepolgen.
> 2) Keep going with policyrep, but in C++.
> 
> 1 is less work but harder for cross-language development. 2 is much more
> work, potentially forever.
> 
And don't forget about option 3, which is continue down the C path. This is
the most painful immediate option, but may have less ripple effect among the
users of the library.

Chad


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
