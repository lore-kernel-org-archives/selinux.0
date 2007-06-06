Message-ID: <4666E186.4030800@tycho.nsa.gov>
Date: Wed, 06 Jun 2007 12:32:06 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: [PATCH 1/2] libselinux: class and permission mapping support
References: <4666D5E6.508@tycho.nsa.gov> <6FE441CD9F0C0C479F2D88F959B01588BF0563@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588BF0563@exchange.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Eamon Walsh wrote:
>> This provides support for userspace object managers to
>> register a mapping of class and permission values.  After the
>> mapping is registered all libselinux functions that take a
>> security class or permission value must be provided with
>> mapped values instead of the "real," kernel values.
>>
>> Changes from the original interface proposal: No
>> selinux_init() function, just a straight set_mapping()
>> function.  Also, to simplify things the incoming mapping does
>> not include explicit values; the classes and permissions are
>> numbered implicitly by their ordering.  NULL strings are used
>> to terminate the lists.
>>
>> Tested with X server, no problems encountered.
>>
>> This patch includes the interface and implementation of the mapping
>> set function. 
>>
> 
> Hrm, I thought we agreed that remapping access vectors at runtime was a
> bad idea?
> 

I did think that initially, but I didn't realize that the mapping could 
be done underneath the AVC instead of on every single call to 
avc_has_perm or whatnot.

The overhead of the remapping should be negligible compared to the cost 
of an selinuxfs operation, right?  And it frees the userspace object 
manager from having to manage the translation tables itself.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
