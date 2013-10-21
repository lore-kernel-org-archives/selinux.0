Message-ID: <52653E45.5020908@tresys.com>
Date: Mon, 21 Oct 2013 10:46:29 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Richard Haines <richard_c_haines@btinternet.com>
CC: James Carter <jwcart2@tycho.nsa.gov>,
        Dominick Grift
	<dominick.grift@gmail.com>,
        SELinux List <selinux@tycho.nsa.gov>
Subject: Re: Update to CIL
References: <52617C02.4060500@tycho.nsa.gov> <1382199839.82880.YahooMailNeo@web87903.mail.ir2.yahoo.com> <52652DE1.4020504@tresys.com> <1382365347.75138.YahooMailNeo@web87902.mail.ir2.yahoo.com>
In-Reply-To: <1382365347.75138.YahooMailNeo@web87902.mail.ir2.yahoo.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/21/2013 10:22 AM, Richard Haines wrote:
>
>
>>>   4) Not sure if this is a bug or 'as designed', I tried using
>> "in" in a
>>>       booleanif statement but failed. The "in-boolean.cil" module
>> demos
>>>       this error.
>>>
>>
>> This should not be allowed. The only thing that should be allowed in a
>> booleanif statement are typetransitions, typerules, and avrules.
>>
>>
> Regarding the allowed items - the 'call' statement is also allowed as I'm using it
> already on both versions of the compiler so it seemed strange to exclude the 'in'
> statement.
>

Yes, you're correct, I forgot about the call statement. That is allowed 
in booleanif's, but that is because what basically happens with calls is 
that the contents of the macro are copied into the booleanif. This means 
that any macros called inside of a booleanif must only contain those 
statements I listed above.

However, the 'in' statment works kindof like a preprocessor macro in C, 
only it knows about CIL namespaces. And so the 'in' statement never 
makes it into the binary policy. This means that if we allowed 'in' 
statements in booleanifs and you disabled a boolean at runtime, we 
couldn't undo whatever changes the 'in' statement made, which is not 
likely what the user intended. For this reason, we do not allow the 'in' 
statement in booleanifs.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
