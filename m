Message-ID: <4B268648.7040702@gmail.com>
Date: Mon, 14 Dec 2009 10:39:04 -0800
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: tresys <refpolicy@oss1.tresys.com>, xorg@freedesktop.org,
        SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: avc's generated causes the system to freeze up
References: <dd18b0c30912111344j65436d86h85f8d74e752e19af@mail.gmail.com> <4B2677DF.6060801@tycho.nsa.gov>
In-Reply-To: <4B2677DF.6060801@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/14/09 09:37, Eamon Walsh wrote:
> On 12/11/2009 04:44 PM, Justin Mattock wrote:
>> I'm running X.Org X Server 1.7.99.2
>> not sure if this is fixed with the latest
>> but after building the latest refpolicy
>> and defining my allow rules, both
>> regularly, and with make enableaudit
>> I still get avc's being generated here and there,
>> but for some they seem to just spamm Xorg.0.log
>> causing my system to freeze up.
>> heres an example:
>>
>
>
> If the denials are not causing a problem other than log spam, just use a
> dontaudit rule to silence them.
>
>

  ahh.. didn't even think of that.

as for xace and everything, pretty good.
I'll just donaudit(like you had mentioned)
those few avc denials that find themselves
showing up long after making the policy
and putting her into enforcing mode.

Justin P. Mattock




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
