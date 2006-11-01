Subject: RE: Question on checks against unlabeled
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: vyekkirala@TrustedCS.com
Cc: sds@tycho.nsa.gov, selinux@tycho.nsa.gov, latten@austin.ibm.com,
        hallyn@elg11.watson.ibm.com, "'Trent Jaeger'" <tjaeger@cse.psu.edu>
In-Reply-To: <000101c6fcff$498e9960$cc0a010a@tcssec.com>
References: <000101c6fcff$498e9960$cc0a010a@tcssec.com>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 09:48:58 -0500
Message-Id: <1162392538.31675.162.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-10-31 at 09:14 -0600, Venkat Yekkirala wrote:
> Hi Chris,
> 
> I am looking for some input :) from your (policywriter's) end on the
> following:
> 
> I have code that now "selects" a labeled association that has the same label
> as the socket, when the socket "polmatches" a "labeled" SPD rule.
> 
> There's also the following check in the kernel currently:
> allow socket_t unlabeled_t:association { sendto }
> 
> The intent as explained below by Trent is to make sure a socket can
> "use" an "non-labeled" association in the following cases:
> 
> a. socket matches a "non-labeled" SPD rule and hence is using a non-labeled
> IPSec SA.
> 
> b. no IPSec SA being used by the socket.
> 
> 
> We have the following choices:
> 
> 1. We retain the sendto check against unlabeled_t in the above scenarios (a
> and b).
> 
> 2. We restrict the sendto check only to scenario "a" where we in fact have
> an
>    association (albeit a "non-labeled" SA).
> 
> 3. We eliminate the sendto check for both the scenarios.
> 
> 4. We retain the check for both, but for consistency we also do the
> following
>    check after we "select" a labeled SA.
> 
>    allow socket_t self:association { sendto };
> 
>    IOW, your policy will always need to have one of the following:
>    allow socket_t self:association { sendto } where a "labeled" SA can be
> used.
>    allow socket_t unlabeled_t:association { sendto } where an "non-labeled"
> SA or no SA at all is permitted for the socket.
> 
> What's your preference?

I would say 4.  In my response to James (SELinux Networking Enhancements
thread) that I sent a little earlier, I had what I would consider to be
an ideal policy.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
