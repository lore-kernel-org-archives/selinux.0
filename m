Date: Thu, 22 Oct 2009 14:54:24 -0400
Subject: Re: [PATCH] libselinux: Export reset_selinux_config()
From: Chad Sellers <csellers@tresys.com>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: <selinux@tycho.nsa.gov>, <method@manicmethod.com>, <slawrence@tresys.com>
Message-ID: <C70622A0.AB862%csellers@tresys.com>
In-Reply-To: <4AE0A9C1.6070908@tycho.nsa.gov>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/22/09 2:51 PM, "Eamon Walsh" <ewalsh@tycho.nsa.gov> wrote:

> On 10/20/2009 11:21 AM, Chad Sellers wrote:
>> In integrating SELinux policy into rpm, we have a need to be
>> able to reset the configuration data (e.g. policy type) loaded
>> into libselinux. These values are currently loaded lazily by a
>> number of different functions (e.g. matchpatchcon_init()).
>> Since we are changing rpm to install policy, including initial
>> base policy, we need to be able to reload these configuration
>> items after the policy has been installed.
>> 
>> reset_selinux_config() already exists and is used by
>> selinux_init_load_policy() for a similar reason, but it is not
>> exported. This was probably intentionaly since it is not thread
>> safe at all. That said, rpm needs to do the same thing. This
>> patch makes the function public, and places a warning in the
>> header comment that it is not thread safe.
>> 
>> Signed-off-by:  Chad Sellers <csellers@tresys.com>
>>   
> 
> 
> FWIW, I plan to take a look at broader locking and thread-safety issues
> in libselinux.
> 
That sounds great.

Thanks,
Chad


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
