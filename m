Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o28GBu7B022280
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2010 11:11:56 -0500
Received: from mail-bw0-f228.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o28GCL1B002775
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2010 16:12:22 GMT
Received: by bwz28 with SMTP id 28so450265bwz.34
        for <selinux@tycho.nsa.gov>; Mon, 08 Mar 2010 08:11:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <10143821003041346o6903d2bbw49863b44d05a2a8c@mail.gmail.com>
References: <4B858A2A.8080302@redhat.com>
	 <10143821003011129w6257e547ua14c2c98ec6ace77@mail.gmail.com>
	 <4B8C277E.6020608@redhat.com> <4B8C35E7.2020300@redhat.com>
	 <4B8FE8FB.6050607@manicmethod.com>
	 <10143821003041346o6903d2bbw49863b44d05a2a8c@mail.gmail.com>
Date: Mon, 8 Mar 2010 11:11:51 -0500
Message-ID: <10143821003080811l32b1243frcb71d7289b74cd37@mail.gmail.com>
Subject: Re: Audit2allow generating dontaudit rules.
From: Karl MacMillan <karlwmacmillan@gmail.com>
To: Joshua Brindle <method@manicmethod.com>, SE Linux <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Accidentally sent this straight to Josh.

Karl

On Thu, Mar 4, 2010 at 4:46 PM, Karl MacMillan <karlwmacmillan@gmail.com> wrote:
> I meant this - I don't want to pass around a boolean flag when we have
> a flag for rule type. This allows cleanly adding support for, say,
> generating both allow rules and auditallow rules at the same time.
>
> Karl
>
> On Thu, Mar 4, 2010 at 12:08 PM, Joshua Brindle <method@manicmethod.com> wrote:
>> Daniel J Walsh wrote:
>>>
>>> On 03/01/2010 03:45 PM, Daniel J Walsh wrote:
>>>>
>>>> On 03/01/2010 02:29 PM, Karl MacMillan wrote:
>>>>>
>>>>> I'd rather pass in the rule type to the AVRule init rather than a
>>>>> boolean about this being a dontaudit rule.
>>>>>
>>>>> Karl
>>>>>
>>>>> On Wed, Feb 24, 2010 at 3:20 PM, Daniel J Walsh<dwalsh@redhat.com>
>>>>> wrote:
>>>>>>
>>>> How about this patch. Moves the dontaudit up the chain a little bit.
>>>> Is this what you want.
>>>
>>> One minor problem. Updated patch.
>>>
>>
>> Karl?
>>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
