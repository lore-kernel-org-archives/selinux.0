Message-ID: <454A3007.6050300@hp.com>
Date: Thu, 02 Nov 2006 12:51:03 -0500
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: vyekkirala@TrustedCS.com
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>, James Morris <jmorris@namei.org>,
        selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        gcwilson@us.ibm.com
Subject: Re: SELinux Networking Enhancements
References: <001801c6fea5$baee0da0$cc0a010a@tcssec.com>
In-Reply-To: <001801c6fea5$baee0da0$cc0a010a@tcssec.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
>>Ok, I think I'm beginning to get it (I'm a bit slow lately 
>>:\).. You are
>>defining a condition where iptables will call into the security server
> 
> Correct.
> 
>>using the packet label (either secmark or external, how do 
>>you decide?)
> 
> Both.

If we use secfilter to do access controls for both internal and external
labeling using the same class/permission I think we might have a problem similar
to what we ran into with the secid reconciliation approach: internal labeling
mechanisms (SECMARK) assign labels based on packet properties while the external
mechanisms (XFRM, NetLabel) assign labels based on the sending socket's context.

>>With these 
>>filter rules if
>>they aren't in place the policy becomes less restrictive (right?)..
> 
> We could also be restrictive or leave it up to the policy entirely.

More explanation please.

I don't understand how secfilter could be made restrictive in the same manner as
SECMARK.  How can you know if the netfilter rules are missing?  What would you
compare the loaded netfilter rules against?  I guess you could compare them
against something maintained inside the SELinux security server, but I think you
would need to put some rather invasive hooks into the netfilter management code
to ensure that the required secfilter netfilter rules are not subverted.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
