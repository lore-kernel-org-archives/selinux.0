Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7KIipLj024988
 for <selinux@tycho.nsa.gov>; Sat, 20 Aug 2016 14:44:51 -0400
Received: by mail-oi0-f54.google.com with SMTP id 4so104224395oih.2
 for <selinux@tycho.nsa.gov>; Sat, 20 Aug 2016 11:44:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <89E5C3EA-9794-4496-A195-1C997A5BBF44@trentalancia.net>
References: <1471709886.22998.1.camel@trentalancia.net>
 <CAHC9VhRouoqqrq_Vn1A3wh7kwvodUK-j7xR3=uwep7t0Ktdh3w@mail.gmail.com>
 <89E5C3EA-9794-4496-A195-1C997A5BBF44@trentalancia.net>
From: Paul Moore <pmoore@redhat.com>
Date: Sat, 20 Aug 2016 14:44:45 -0400
Message-ID: <CAGH-KguvJZVLAUYQP_iFk2KG7DDFe9kGADWK_dkbGPHuStjpcQ@mail.gmail.com>
Subject: Re: [PATCH] Differentiate between Unix Stream Socket and Sequential
 Packet Socket
To: Guido Trentalancia <guido@trentalancia.net>
Cc: Paul Moore <paul@paul-moore.com>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, Aug 20, 2016 at 1:39 PM, Guido Trentalancia
<guido@trentalancia.net> wrote:
> Hello Paul,
>
> thanks for getting back on this.
>
> The patch follows a recent discussion with Christopher PeBenito on the Reference Policy mailing list.

Which patch/thread (what was the subject line)?  I have seen a lot of
patches and discussion between you and Chris lately (thanks for your
contributions!) but I haven't followed them very closely.

> Christopher suggested to modify the actual code.
>
> I suppose it provides a better insight during code analysis on the type of socket connections being made and a more fine-grained control of permissions being granted or denied to the policy designer.

The only value I can see to this change would be if we needed to
differentiate between AF_UNIX stream and seqpacket connections, and to
be honest I don't see the difference being that important.  As I said
before, we need to understand what you are trying to solve and how it
is only possible with this change.  The unspecified problem you are
seeing below wont be resolved by this patch (as you already
mentioned).

> For some reason however, I have seen code using the SOCK_SEQPACKET type and executed immediately after policy load (possibly from initramfs, before switchroot) showing up in the log files as using an unspecified socket type. I have explained already to Christopher that this patch won't change such behavior...

Yes, that should be unrelated to this change.  Are you able to
reproduce the above problem reliably?

-- 
paul moore
security @ redhat
