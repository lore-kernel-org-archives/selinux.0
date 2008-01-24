Date: Thu, 24 Jan 2008 16:12:43 -0500
Subject: Re: Deprecating setlocaldefs, preservebools support in libselinux
From: Chad Sellers <csellers@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <method@manicmethod.com>
CC: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Daniel J Walsh <dwalsh@redhat.com>, <selinux@tycho.nsa.gov>
Message-ID: <C3BE697B.53D44%csellers@tresys.com>
In-Reply-To: <1201208845.21288.165.camel@moss-spartans.epoch.ncsc.mil>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 1/24/08 4:07 PM, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:

> 
> On Thu, 2008-01-24 at 16:02 -0500, Joshua Brindle wrote:
>> Stephen Smalley wrote:
>>> I'd still like to deprecate setlocaldefs support and preservebools
>>> support in libselinux in the trunk (i.e. libselinux 2.x).  I posted
>>> patches for completely removing such support a long while ago, but those
>>> particular patches would require an ABI change (as they include API
>>> removal) and thus I held off on them, but we could also take the more
>>> intermediate approach of just turning off the functionality by default
>>> in libselinux without disturbing the ABI.
>>> 
>>> As a refresher, setlocaldefs support refers to the support for pulling
>>> in local boolean and user definitions at policy load time w/o managed
>>> policy, i.e. the approach used in RHEL4 and Fedora 3 and 4 (but not in
>>> Fedora 5 and later or RHEL5).  By default, libselinux still checks for
>>> such definitions and patches them into the in-memory policy at load time
>>> unless /etc/selinux/config has SETLOCALDEFS=0.  I'd like to make
>>> SETLOCALDEFS=0 the default in the trunk and require SETLOCALDEFS=1
>>> in /etc/selinux/config to enable the old behavior.
>>> 
>>> preservebools support refers to the support for preserving active
>>> boolean values across a policy reload by having libselinux patch the
>>> active values into the in-memory policy at policy load time.  As of
>>> Linux 2.6.22 and later, this is now handled automatically by the kernel
>>> as part of the policy reload and isn't needed in userspace.  I'd like to
>>> also disable this by default in libselinux and perhaps allow it to be
>>> enabled via some /etc/selinux/config setting.
>>> 
>>> Thoughts?
>>>   
>> 
>> I'm fine saying its deprecated but CLIP currently uses an updated
>> toolchain for both RHEL5 and RHEL4 (adds policy management capabilities
>> to RHEL4) so removing the boolean preservation functionality would be
>> detrimental. setlocaldefs isn't used very often afaik but we sometimes
>> build systems where the use of 'managed policy' is objected to, in which
>> case the only way to add users is via users.local. With this in mind
>> we'll just have to be careful when upgrading the CLIP toolchain not to
>> use a version that eventually removes this support.
> 
> When you say "uses an updated toolchain", do you mean that it replaces
> the system libraries or just that it uses a private copy of the updated
> userland for managing and generating the kernel policy file?  If the
> former, then yes, this means that you'd have to at least set values
> in /etc/selinux/config to enable the legacy behavior, but if the latter,
> then it shouldn't affect you at all - init and load_policy would still
> use the system libselinux library for loading the policy, and thus still
> have the legacy behavior.

It replaces the system libraries. That's the only way to get certain
functionality (such as local users on RHEL4).

Chad


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
