Message-ID: <4C10ECF5.7050206@gmail.com>
Date: Thu, 10 Jun 2010 06:47:33 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
Subject: Re: [PATCH]security:policydb.h Fix a space with "SE Linux"
References: <1276121526-10620-1-git-send-email-justinmattock@gmail.com>	 <alpine.LRH.2.00.1006100941561.17313@tundra.namei.org>	 <4C1029CF.3040209@gmail.com> <1276173423.25808.27.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1276173423.25808.27.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 06/10/2010 05:37 AM, Stephen Smalley wrote:
> On Wed, 2010-06-09 at 16:54 -0700, Justin P. Mattock wrote:
>> On 06/09/2010 04:42 PM, James Morris wrote:
>>> On Wed, 9 Jun 2010, Justin P. Mattock wrote:
>>>
>>>> Fix the space between "SE Linux", to match the other
>>>> definitions of "SELinux", in the system.
>>>>
>>>>    Signed-off-by: Justin P. Mattock<justinmattock@gmail.com>
>>>
>>> NAK, please look at how this is used.
>>>
>>
>> ahh.. I thought this was printk ing things
>> into dmesg.. but it's not it's a strlen.
>
> That string is part of the header of the binary policy file.  You can't
> change it without breaking compatibility.  It has always been that way
> in mainline Linux 2.6, and predates that in the SELinux code (circa
> 2002).
>

I did see, where it's being called
but while looking at the code, I didn't
get what it was doing(to the most part)

then after really looking at strlen
it's(like what you had said)
the header of the binary file or
the string length

so to change this would breaks
lots of things!!("great just
what I need"..)

thanks for looking at this.

Justin P. Mattock


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
