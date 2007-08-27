From: Paul Moore <paul.moore@hp.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Mon, 27 Aug 2007 09:48:39 -0400
Cc: casey@schaufler-ca.com, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        joe@nall.com, Eric Paris <eparis@parisplace.org>
References: <D709A20F2164C84E8B7014B0301F5EF8521178@HAVOC.tcs-sec.com>
In-Reply-To: <D709A20F2164C84E8B7014B0301F5EF8521178@HAVOC.tcs-sec.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708270948.39375.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday, August 27 2007 9:02:32 am Venkat Yekkirala wrote:
> > Actually, after reading Josh's mail I'm now thinking
> > "netfilter label" is
> > probably a better choice.  After all, the bikeshed will need
> > to be repainted
> > in a few years ... ;)
>
> I like "netfilter label" as well (I take it most admins know what
> netfilter is; otherwise firewall label?)

I like both "firewall" and "netfilter" label.  I'm tempted to stick 
with "netfilter label" for right now simply because it better matches it up 
with the kernel mechanism that assigns the label.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
