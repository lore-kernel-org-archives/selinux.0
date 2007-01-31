Message-ID: <45C02948.9090607@tresys.com>
Date: Wed, 31 Jan 2007 00:29:44 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: James Antill <jantill@redhat.com>, Steve Grubb <sgrubb@redhat.com>,
        linux-audit@redhat.com, ewalsh@tycho.nsa.gov, selinux@tycho.nsa.gov
Subject: Re: missing avc message field names
References: <20070129185542.32977.qmail@web51502.mail.yahoo.com>	 <200701291556.37235.sgrubb@redhat.com> <45BE6410.9050604@redhat.com>	 <200701291749.21897.sgrubb@redhat.com> <45BF5AE3.6030602@mentalrootkit.com> <1170197588.3373.28.camel@laptop.and.org> <45BFE7EC.8050609@mentalrootkit.com>
In-Reply-To: <45BFE7EC.8050609@mentalrootkit.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> James Antill wrote:
>> On Tue, 2007-01-30 at 09:49 -0500, Karl MacMillan wrote:
>>> Steve Grubb wrote:
>>>> ausearch -m all --raw | grep anything you want
>>> tail -f happens to be my favorite counter example, but I am certain 
>>> there are other useful tricks for monitoring logs that will break. 
>>> Not to mention the number of log monitoring and aggregation tools 
>>> that assume text logs.
>>
>>  To be fair the new audit dispatcher already has a plugin that does the
>> same thing as "tail -f" without needing to call stat(), and that'll be
>> released before auditd has binary logs ... although one could certainly
>> argue that it's not as obvious, it seems like a small price.
>>
>
> So you will have that wheel reinvented soon - that still leaves many, 
> many more that you have no control over.

Even with a tail replacement there has to be thousands of internally 
written and maintained log monitoring and reporting apps that will 
break, this is a fundamental change in how logging works on linux, not 
something that can or should be changed on a whim (or otherwise).


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
