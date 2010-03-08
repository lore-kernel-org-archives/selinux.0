Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o28KiJFc012098
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2010 15:44:23 -0500
Received: from mail-bw0-f228.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o28Ki2Ke021482
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2010 20:44:03 GMT
Received: by bwz28 with SMTP id 28so731327bwz.34
        for <selinux@tycho.nsa.gov>; Mon, 08 Mar 2010 12:44:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B9550EF.5020208@redhat.com>
References: <4B858A2A.8080302@redhat.com>
	 <10143821003011129w6257e547ua14c2c98ec6ace77@mail.gmail.com>
	 <4B8C277E.6020608@redhat.com> <4B8C35E7.2020300@redhat.com>
	 <4B8FE8FB.6050607@manicmethod.com>
	 <10143821003041346o6903d2bbw49863b44d05a2a8c@mail.gmail.com>
	 <10143821003080811l32b1243frcb71d7289b74cd37@mail.gmail.com>
	 <4B9550EF.5020208@redhat.com>
Date: Mon, 8 Mar 2010 15:44:20 -0500
Message-ID: <10143821003081244o5813209do299567f5be89db7b@mail.gmail.com>
Subject: Re: Audit2allow generating dontaudit rules.
From: Karl MacMillan <karlwmacmillan@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Joshua Brindle <method@manicmethod.com>, SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Mar 8, 2010 at 2:33 PM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> On 03/08/2010 11:11 AM, Karl MacMillan wrote:
>>
>> Accidentally sent this straight to Josh.
>>
>> Karl
>>
>> On Thu, Mar 4, 2010 at 4:46 PM, Karl MacMillan<karlwmacmillan@gmail.com>
>>  wrote:
>>
>>>
>>> I meant this - I don't want to pass around a boolean flag when we have
>>> a flag for rule type. This allows cleanly adding support for, say,
>>> generating both allow rules and auditallow rules at the same time.
>>>
>>>
>
> <snip>
>
> Ok this one only adds a flag to the policygenerator to tell it to generate
> dontaudit rules.
>
> No passing of args.
>

Acked-by: Karl MacMillan <karlwmacmillan@gmail.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
