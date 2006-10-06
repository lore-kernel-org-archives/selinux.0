Message-ID: <4526CEB7.4090206@trustedcs.com>
Date: Fri, 06 Oct 2006 16:46:31 -0500
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
CC: selinux@tycho.nsa.gov, jmorris@namei.org, sds@tycho.nsa.gov,
        paul.moore@hp.com, eparis@redhat.com, sgrubb@redhat.com,
        jbrindle@tresys.com
Subject: Re: [PATCH 1/1] selinux: Null-out secmark after use
References: <4526CE64.9050704@trustedcs.com>
In-Reply-To: <4526CE64.9050704@trustedcs.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
> This nulls out the secmark field on the skb after
> we are done with ALL the access checks in the postroute_last
> hook to handle the case where multicast packets that we send
> might be arriving back to us on a non-loopback device. This
> would cause the flow_in hook to use the secmark on the skb
> (ostensibly from the originating socket) as a security point
> context, which it isn't.
> 
> Signed-off-by: James Morris <jmorris@namei.org>

Actually the sign-off should be (copied and pasted from the wrong email :):

Signed-off-by: Venkat Yekkirala <vyekkirala@TrustedCS.com>

Please disregard this patch.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
