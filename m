Message-ID: <4A4B9321.5020608@redhat.com>
Date: Wed, 01 Jul 2009 12:47:29 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Christopher Pardy <cpardy@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [Fwd: [Patch] libsemanage: remember and retrieve dontaudit settings]
References: <4A4B656D.1030004@redhat.com> <1246457216.13464.162.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1246457216.13464.162.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 07/01/2009 10:06 AM, Stephen Smalley wrote:
> On Wed, 2009-07-01 at 09:32 -0400, Christopher Pardy wrote:
>> Creates a empty file disable_dontaudit in the polciy directory
>> (/etc/selinux/<policytype>). Checks for the existance of this file to
>> set the sepol disable don't audit upon handle creation. Also provides
>> the function "int semanage_get_disable_dontaudit()" which returns the
>> don't audit property of the current policy.
>>
>> Signed-off-by: Christopher Pardy<cpardy@redhat.com>
>
> Your patch is not correctly generated.  Please read
> http://userweb.kernel.org/~akpm/stuff/tpp.txt
>
> In your description, please explain the rationale for the patch, not
> just what it does - we can discover the latter from reading the code,
> but not the former.
>
> Why do we want this functionality?  Why is it better than the existing
> semodule -DB to disable dontaudit rules and semodule -B to re-enable
> them?
>
He is not changing the behaviour of semodule -DB or semodule -B

His goal is to maintain the state and be able to show the state to a user.

semodule -DB
semodule -i module

Are the dontaudits enabled or disabled?

THey are enabled, which I believe is wrong.

The goal of Chris's patch is to maintain the disable until you execute 
semodule -B

And to be able to show in a gui whether or not you have disabled the 
dontaudit rules.

We talked about his patch and he will be sending another pass at this 
shortly.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
