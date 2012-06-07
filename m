From: Paul Moore <paul@paul-moore.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>, SELinux@tycho.nsa.gov
Subject: Re: [PATCH 2/2] Update SELinux policy capability to always check peer class.
Date: Thu, 07 Jun 2012 12:52:53 -0400
Message-ID: <2008897.ahYGsh5Elr@sifl>
In-Reply-To: <4FD0D1FF.5070702@tresys.com>
References: <1339003731-6743-1-git-send-email-cpebenito@tresys.com> <2470358.yNoEqIjIIh@sifl> <4FD0D1FF.5070702@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday, June 07, 2012 12:08:31 PM Christopher J. PeBenito wrote:
> On 06/07/12 11:33, Paul Moore wrote:
> > On Thursday, June 07, 2012 11:27:00 AM Christopher J. PeBenito wrote:
> >> On 06/07/12 10:28, Paul Moore wrote:
> >>> On Wednesday, June 06, 2012 01:28:51 PM Chris PeBenito wrote:
> >>>> Update the always_check_network policy capability which, when enabled,
> >>>> treats peer labeling as enabled, even if there is no Netlabel or
> >>>> labeled IPSEC configuration.
> >>>> 
> >>>> Signed-off-by: Chris PeBenito <cpebenito@tresys.com>
> >>> 
> >>> I still object to this patchset for all the same old reasons, but I feel
> >>> obligated to point out that this patchset is still incomplete/incorrect
> >>> in
> >>> that it only deals with the socket_sock_rcv_skb hook.
> >> 
> >> I found the missing hooks, but does this need to affect
> >> selinux_ip_output()?> 
> > Nope.
> 
> Is there anything I'm missing other than selinux_ip_forward() and
> selinux_ip_postroute()?

It is probably best just to post the patches so that they can be (re)reviewed. 

I'm also curious if you are going to do anything about incorporating the 
secmark configuration into the greater SELinux policy.  As far as I'm 
concerned, that is the only way I would consider ack'ing these patches (I did 
mention this in the original thread).

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
