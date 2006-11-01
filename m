Message-ID: <4548E08B.4020704@hp.com>
Date: Wed, 01 Nov 2006 12:59:39 -0500
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
Cc: vyekkirala@TrustedCS.com, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        James Morris <jmorris@namei.org>,
        Venkat Yekkirala <vyekkirala@tcsfw4.tcs-sec.com>,
        selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        gcwilson@us.ibm.com
Subject: Re: SELinux Networking Enhancements
References: <6FE441CD9F0C0C479F2D88F959B01588514973@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588514973@exchange.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
>>From: Venkat Yekkirala [mailto:vyekkirala@trustedcs.com] 
>>
> 
> <snip>
> 
>>As may have been noticed, I am currently thinking of a 
>>separate generic filtering module in the filter table that 
>>would filter packets based on the label (internal as well as 
>>external) on the packet and the label on the filtering point. 
> 
> This is not appropriate, the TE/MLS policy should be in the SELinux
> policy, not in the SELinux policy and the filter tables(or anywhere
> else). Policy should be centralized and analyzable to be part of the MAC
> policy at all.

Maybe I'm missing something, but I think you could make this part of the SELinux
policy much like SECMARK rules are part of the policy now, right?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
