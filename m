Message-ID: <457EE659.8050503@hp.com>
Date: Tue, 12 Dec 2006 12:26:49 -0500
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: vyekkirala@TrustedCS.com
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, sds@tycho.nsa.gov
Subject: Re: Labeling traffic over loopback
References: <000c01c71e0f$53c39da0$cc0a010a@tcssec.com>
In-Reply-To: <000c01c71e0f$53c39da0$cc0a010a@tcssec.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
>>>We could use an additional bit (local_label) to denote that
>>>"sp" holds the source label sid (no blob, so no lifecycle mgmt).
>>>
>>>What do people think?
>>
>>Can you give an example of what the *sp value would look 
>>like?  Are you thinking
>>of adding a new field to 'sec_path' or would you create a 
>>sort of dummy
>>'xfrm_state' entry?
> 
> Nope. Note "(no blob, so no lifecycle mgmt)".

True *sp is a blob, but it already has all the lifecycle mgmt code in place so I
don't think adding to it would be an 'evil' thing.  However, I could be wrong.

> More specifically, we could use a union in place of sp and
> when we are looking at a loopback packet and no xfrm in use
> we could use the union to hold the secid.

Do you have some pseudo code for setting this value, i.e. where are you thinking
of setting it on the outbound packet?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
