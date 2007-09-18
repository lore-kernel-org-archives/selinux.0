Message-ID: <46F03EC1.3010900@tycho.nsa.gov>
Date: Tue, 18 Sep 2007 17:10:25 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov, jmorris@namei.org,
        Steve G <linux_4ever@yahoo.com>
Subject: Re: [PATCH -v2] kernel: selinux: policy selectable handling of	unknown
 classes and perms
References: <1189695931.3391.46.camel@localhost.localdomain> <1190132935.14037.8.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1190132935.14037.8.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2007-09-13 at 11:05 -0400, Eric Paris wrote:
>> Allow policy to select, in much the same way as it selects MLS support,
>> how the kernel should handle access decisions which contain either
>> unknown classes or unknown permissions in known classes.  The three
>> choices are
>>
>> 0 - Deny unknown security access. (default)
>> 2 - reject loading policy if it does not contain all definitions
>> 4 - allow unknown security access
>>
>> The policy's choice is exported (with a value of 0,2,4) to userspace
>> through /selinuxfs/handle_unknown 
> 
> Eamon, does this userspace interface work for you to use in the
> userspace AVC?  Do you want the integer value like this or would you
> prefer the "reject", "deny", or "allow" string that is displayed by the
> kernel in its log message at load policy time?
> 

Numeric values are fine, but the tristate is a little cumbersome.  Would 
it be possible to split this into two boolean files, one reporting 
zero/one for "don't reject/reject" and one reporting zero/one for 
"allow/deny"?

Also, I quickly scanned the patch and I didn't see any netlink code.  I 
need a netlink notification delivered to userspace when the values 
change.  This could be added to the policyload message, or a new 
separate message type, or both.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
