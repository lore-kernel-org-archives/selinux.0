Message-ID: <4533D53E.1020800@hp.com>
Date: Mon, 16 Oct 2006 14:53:50 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: vyekkirala@TrustedCS.com
Cc: "'Christopher J. PeBenito'" <cpebenito@tresys.com>,
        "'Karl MacMillan'" <kmacmillan@mentalrootkit.com>,
        "'Joshua Brindle'" <jbrindle@tresys.com>, selinux@tycho.nsa.gov,
        sds@tycho.nsa.gov
Subject: Re: Denials from newest kernel
References: <000501c6f151$147d5180$cc0a010a@tcssec.com>
In-Reply-To: <000501c6f151$147d5180$cc0a010a@tcssec.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
>>>>>allow apache_t  httpd_ipsec_t:association { polmatch };
>>>>>
> 
> <snip>
> 
>>The above rule clearly shows a relationship between a domain(socket?)
>>and a SPD entry.  It does not show a relationship between a packet and
>>an association.
> 
> 
> This relationship is implicit in that a packet from apache_t can only
> use an association labeled apache_t. This would be currently shown in the
> SELinux policy itself as:
> 
> allow apache_t apache_t:association { sendto };
> 
> We did talk about moving this "implicit" relationship into the kernel itself
> essentially eliminating the association indirection for SAs.

That might be a good thing to do regardless of the secid work.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
