Message-ID: <4C239056.7020006@bian-fu.net>
Date: Thu, 24 Jun 2010 19:05:26 +0200
From: Alice Mynona <alice_mynona@bian-fu.net>
MIME-Version: 1.0
To: Dominick Grift <domg472@gmail.com>
CC: SELinux@tycho.nsa.gov
Subject: Re: Developing a SELinux policy for antivirus - Activating a boolean
 variable when another has been actived
References: <4C237345.2010200@bian-fu.net> <4C238465.60104@gmail.com>
In-Reply-To: <4C238465.60104@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks for your answer.

Dominick Grift schrieb am 24.06.2010 18:14 Uhr:
> On 06/24/2010 05:01 PM, Alice Mynona wrote:
>> I have also taken a look at "file_contexts" (cd
> /etc/selinux/targeted/modules/active && grep antivirus_t
> file_contexts*), but there's no "antivirus_t" anymore.
> 
> antivirus_t is defined a domain type so you wont find it in the list of
> file contexts because those are file types.
>

stupid ;-) It's late. Of course, you are right.
 
> does sesearch --allow -s antivirus_t return anything

ERROR: could not find datum for type antivirus_t

> or sesearch --allow -t antivirus_t?

ERROR: could not find datum for type antivirus_t

> 
> and:
> 
> semanage fcontext -l | grep antivirus

No matches.

> 
> and
> 
> semodule -l | grep antivirus
> 

No matches.

It's funny, isn't it?

Best regards,

Alice

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
