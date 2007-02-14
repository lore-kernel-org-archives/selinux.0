Date: Wed, 14 Feb 2007 12:38:16 -0500
Subject: Re: [RFC] Ability to allow undefined permissions and classes -v2
From: Chad Sellers <csellers@tresys.com>
To: Eric Paris <eparis@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>
CC: <selinux@tycho.nsa.gov>
Message-ID: <C1F8B338.1D171%csellers@tresys.com>
In-Reply-To: <1171387714.10871.22.camel@localhost.localdomain>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 2/13/07 12:28 PM, "Eric Paris" <eparis@redhat.com> wrote:

> On Tue, 2007-02-13 at 07:27 -0500, Stephen Smalley wrote:
>> On Mon, 2007-02-12 at 14:43 -0500, Eric Paris wrote:
>>> I do still have a problem.  I don't really understand the 'inherits'
>>> ideas and so I'm not sure how to pad my p->undefined_perms[tclass] with
>>> permissions which are missing in policy due to an incorrect or missing
>>> inherits statement.  If this approach seems good and reasonable I will
>>> try to better understand how I can glean those bits from
>>> validate_classes() and I will also move this to use config flags and
>>> have multiple options on how to handle policies.
>> 
>> Missing or incorrect inherits clause should remain fatal, I'd say - it
>> is too substantive a change to the class definition to expect a running
>> kernel to adapt.  Classes that inherit a common definition pick up their
>> initial set of permission bits from that common definition, such that
>> those bits are uniform across those classes and can be checked by a
>> single permission check (e.g. for common file or socket checks).  But as
>> soon as you remove or change them, in addition to removing all of those
>> inherited permissions, you will have disturbed the values of any
>> subsequent class-specific permissions.
> 
> ATM one of the inherits checking paths is non-fatal in validate_classes
> I'll spend some time to understand it and either make it fatal or figure
> out how to fill my table correctly
>
This non-fatal path covers the simple case where there is an extra
permission in the kernel defined common that is not in the policy defined
common inherited by class foo. Note that the policy will still fail to load
if the class has any additional defined permissions, as those additional
permission values will be disturbed so the check on those permissions will
fail. So, the only corner case policy that could pass this non-fatal path
would be one in which all classes inheriting the common in question did not
add any additional permissions of their own.

Chad Sellers


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
