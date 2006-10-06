Date: Fri, 06 Oct 2006 18:19:10 -0400
Subject: Re: [PATCH 2/4] Remove current validation mechanism
From: Chad Sellers <csellers@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: <selinux@tycho.nsa.gov>
Message-ID: <C14C4E9E.1846B%csellers@tresys.com>
In-Reply-To: <1160168868.20202.41.camel@moss-spartans.epoch.ncsc.mil>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/6/06 5:07 PM, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:

> On Fri, 2006-10-06 at 16:09 -0400, Chad Sellers wrote:
>> plain text document attachment (remove_validation.diff)
>> This patch removes the current object class and permission validation
>> code, as it makes it impossible to add, remove, or change object
>> classes and permissions on a running system.
> 
> nit:  It is possible to add object classes and permissions to a running
> system, as long as they don't disturb existing values (i.e. as long as
> they are added at the end).
> 
Yes, that's true. So, I should have just said change and remove.

>>  Note that this validation code is replaced in the fourth patch of
>> this set, but I removed it completely here to make the patches more
>> readable.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
