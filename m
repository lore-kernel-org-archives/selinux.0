Message-ID: <45228BE8.5020300@hp.com>
Date: Tue, 03 Oct 2006 12:12:24 -0400
From: Linda Knippers <linda.knippers@hp.com>
MIME-Version: 1.0
To: Eric Paris <eparis@parisplace.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        lspp-list <redhat-lspp@redhat.com>, vyekkirala@TrustedCS.com,
        jmorris@namei.org
Subject: Re: RHEL5 Kernel with labeled networking
References: <1159834998.28144.115.camel@localhost.localdomain>	 <452282F2.1000107@hp.com> <1159890073.19176.51.camel@moss-spartans.epoch.ncsc.mil> <452286ED.7070307@hp.com>
In-Reply-To: <452286ED.7070307@hp.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Linda Knippers wrote:
> Stephen Smalley wrote:
> 
>>On Tue, 2006-10-03 at 11:34 -0400, Linda Knippers wrote:
>>
>>
>>>Eric,
>>>
>>>I've booted your kernel on the following systems:
>>>
>>>ia64 box running rhel5 beta 1 targeted policy
>>>x86 box running fc6t2 mls policy
>>>
>>>I don't have any labeled networking specifically configured.
>>>
>>>Networking only works in permissive mode.  If I put either system
>>>in enforcing mode, I can't ping, bring up X, or do anything.
>>>
>>>Are there some policy changes that are needed?   Seems like by default
>>>everything should work like it did before?
>>
>>
>>Only if you set /selinux/compat_net to 1.
>>Otherwise, you need modified policy to define and allow flow_in/flow_out
>>permissions as required, and I suspect you need more in order to deal
>>with the fact that we now get labeled traffic on loopback by default
>>(thus affecting packet send/recv as well).  Venkat, do you have a policy
>>patch?
>>
> 
> 
> Ok, with /selinux/compat_net set to 1, I can go into enforcing mode
> on my rhel5 beta 1 targeted system.  Its got selinux-policy-2.3.3-22.
> 
> The first time I tried the same thing on my fc6/mls system it killed
> all my network sessions.  The second time I tried it my established
> sessions stayed up but the mouse quit working.  This system has
> selinux-policy-mls-2.3.16-6.

The mouse problem has nothing to do with this kernel.  It stops
working in mls enforcing mode with older kernels as well.  I haven't
been running X on my mls system so I never noticed before.

-- ljk


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
