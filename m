Message-ID: <452A7884.4010707@hp.com>
Date: Mon, 09 Oct 2006 12:27:48 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: selinux@tycho.nsa.gov, redhat-lspp@redhat.com, jmorris@namei.org,
        sds@tycho.nsa.gov, eparis@redhat.com, jbrindle@tresys.com
Subject: Re: [PATCH 0/1] selinux: secid reconciliation fixes V01: Intro
References: <452A3ECF.5030105@trustedcs.com> <452A5CAB.6010003@hp.com>
In-Reply-To: <452A5CAB.6010003@hp.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> Venkat Yekkirala wrote:
>>Paul, if you could respin your patchset relative to this one I would
>>appreciate it. While doing so, can you look for NetLabel only when
>>there's no xfrm label on a packet, since we now know that using both
>>is redundant? This way we don't have to worry about NetLabel code
>>bugs/side effects when someone is using just xfrm. Thanks.
> 
> As far as I can tell there are no problems with the latest NetLabel/secid patch
> when layered on top of the secid patches.  There was a lot of testing and debate
> on this last Friday but it turned out to be a problem with the secid patch not
> clearing the secmark on exit as well as some confusion around policy and
> multicast traffic.  All of the NetLabel bugs from the past month or two have
> only occurred on communication channels when NetLabel was in use - there was
> some thought that the recent Bluetooth bug was NetLabel related but it wasn't,
> it was a fault with the MLSXFRM patchset.
> 
> If there is some issue I'm not aware of send me some mail or give me a call
> (XXX-XXX-XXXX) and we can work it out.

Please disregard the phone number I send out earlier, it was the wrong number -
if you need to get ahold of me please call me at 603-884-5056.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
