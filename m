Message-ID: <452A5CAB.6010003@hp.com>
Date: Mon, 09 Oct 2006 10:28:59 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: selinux@tycho.nsa.gov, redhat-lspp@redhat.com, jmorris@namei.org,
        sds@tycho.nsa.gov, eparis@redhat.com, jbrindle@tresys.com
Subject: Re: [PATCH 0/1] selinux: secid reconciliation fixes V01: Intro
References: <452A3ECF.5030105@trustedcs.com>
In-Reply-To: <452A3ECF.5030105@trustedcs.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
> This patchset is relative to davem's net-2.6 git tree as of a few weeks back,
> and is an incremental fix to the secid-reconciliation patch series plus
> the ipsec leak patches.
> 
> This patchset includes the fix sent out this past Friday night.
> 
> This patchset is more immediately intended for the kernels undergoing
> LSPP certification, but needs to be reviewed for very-near-future
> upstreaming into 2.6.19.

>From what I understand the merge window for 2.6.19 is closed, it closed last
week with the release of 2.6.19-rc1.  While 2.6.19 is still open for bugfixes,
its not entirely clear to me this would qualify.  Perhaps James could give us
his opinion.

Regardless, there is always 2.6.20 and of course RHEL5 although I wonder at this
point if that ship has passed too.

> Paul, if you could respin your patchset relative to this one I would
> appreciate it. While doing so, can you look for NetLabel only when
> there's no xfrm label on a packet, since we now know that using both
> is redundant? This way we don't have to worry about NetLabel code
> bugs/side effects when someone is using just xfrm. Thanks.

As far as I can tell there are no problems with the latest NetLabel/secid patch
when layered on top of the secid patches.  There was a lot of testing and debate
on this last Friday but it turned out to be a problem with the secid patch not
clearing the secmark on exit as well as some confusion around policy and
multicast traffic.  All of the NetLabel bugs from the past month or two have
only occurred on communication channels when NetLabel was in use - there was
some thought that the recent Bluetooth bug was NetLabel related but it wasn't,
it was a fault with the MLSXFRM patchset.

If there is some issue I'm not aware of send me some mail or give me a call
(603-641-0536) and we can work it out.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
