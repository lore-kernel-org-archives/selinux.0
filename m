Message-ID: <45DDCAA4.1070103@trustedcs.com>
Date: Thu, 22 Feb 2007 10:53:56 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [RFC] Remove init_context_translations() from libselinux
References: <1172078429.14363.279.camel@moss-spartans.epoch.ncsc.mil> <45DDBFB0.9040401@redhat.com>
In-Reply-To: <45DDBFB0.9040401@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Stephen Smalley wrote:
>> I think we've talked about this before, but never followed through.
>> Is there any reason to retain the init_context_translations() function
>> in libselinux, which sends a SETRANS_INIT message to mcstransd, gets a
>> response, and discards it?  Can we drop it and the call to it from the
>> library constructor/initializer?
>>
>>   
> Ok with me.

Removal looks OK to me.  It used to be that a failure would cause
translations to be disabled, but it is now vestigial.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
