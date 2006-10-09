Subject: Re: [PATCH 0/1] selinux: secid reconciliation fixes V01: Intro
From: Joshua Brindle <jbrindle@tresys.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: selinux@tycho.nsa.gov, redhat-lspp@redhat.com, jmorris@namei.org,
        sds@tycho.nsa.gov, paul.moore@hp.com, eparis@redhat.com
In-Reply-To: <452A3ECF.5030105@trustedcs.com>
References: <452A3ECF.5030105@trustedcs.com>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 08:40:18 -0400
Message-Id: <1160397618.16814.1.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-10-09 at 07:21 -0500, Venkat Yekkirala wrote:
> This patchset is relative to davem's net-2.6 git tree as of a few weeks back,
> and is an incremental fix to the secid-reconciliation patch series plus
> the ipsec leak patches.
> 

Do you have a git tree with everything you have so far? Some of your
patches won't apply to the net-2.6 I have. Perhaps James could put a
branch in his selinux-2.6?

> This patchset includes the fix sent out this past Friday night.
> 
> This patchset is more immediately intended for the kernels undergoing
> LSPP certification, but needs to be reviewed for very-near-future
> upstreaming into 2.6.19.
> 
> Paul, if you could respin your patchset relative to this one I would
> appreciate it. While doing so, can you look for NetLabel only when
> there's no xfrm label on a packet, since we now know that using both
> is redundant? This way we don't have to worry about NetLabel code
> bugs/side effects when someone is using just xfrm. Thanks.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
