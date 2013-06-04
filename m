Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r54FMgbG007644
	for <selinux@tycho.nsa.gov>; Tue, 4 Jun 2013 11:22:42 -0400
Received: by mail-ea0-f177.google.com with SMTP id j14so305671eak.36
        for <selinux@tycho.nsa.gov>; Tue, 04 Jun 2013 08:22:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGXs5wVBc3k_o9esDhB+fvfxLQ=U8JskzzhuYLxD6d_3Hf=gug@mail.gmail.com>
References: <CAGXs5wVBc3k_o9esDhB+fvfxLQ=U8JskzzhuYLxD6d_3Hf=gug@mail.gmail.com>
Date: Tue, 4 Jun 2013 11:22:40 -0400
Message-ID: <CADjGSjisU8ZPsjuS2YoMc72RvFyJd+ZK4GfyX8-z_SZfoOJ2pw@mail.gmail.com>
Subject: Re: xt_SECMARK and "unable to map security context 'httpcontext'" error
From: Joshua Brindle <brindle@quarksecurity.com>
To: Kevin Wilson <wkevils@gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jun 4, 2013 at 11:04 AM, Kevin Wilson <wkevils@gmail.com> wrote:
> Hi,
> I tried this:
>
> modprobe xt_SECMARK
> iptables -t mangle -A PREROUTING -p tcp --dport 80 -j SECMARK --selctx
> httpcontext

You would need a full SELinux context here, such as
system_u:object_r:http_packet_t:s0, and you'd need to ensure that the
label actually exists in your policy.

> and got:
> iptables: No chain/target/match by that name.
>
>
> Kernel log says:
> localhost kernel: [  491.321048] xt_SECMARK: unable to
> map security context 'httpcontext'
>
> Any ideas what should I do to enable this rule?
>
> regards,
> Kevin
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
