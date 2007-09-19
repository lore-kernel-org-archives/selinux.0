From: Paul Moore <paul.moore@hp.com>
To: vyekkirala@TrustedCS.com
Subject: Re: [RFC] [PATCH 4/4] SELinux changes
Date: Wed, 19 Sep 2007 17:40:04 -0400
Cc: "'James Morris'" <jmorris@namei.org>,
        "Stephen Smalley" <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        "Karl MacMillan" <kmacmillan@mentalrootkit.com>,
        "Joshua Brindle" <method@manicmethod.com>
References: <009801c7fb03$2c298260$cc0a010a@tcssec.com>
In-Reply-To: <009801c7fb03$2c298260$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709191740.04406.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, September 19 2007 5:22:24 pm Venkatesh Yekkirala wrote:
> > -----Original Message-----
> > From: James Morris [mailto:jmorris@namei.org]
> > On Wed, 19 Sep 2007, Stephen Smalley wrote:
> > > We thought we were eliminating the need for these per-packet
> > > per-node/netif checks by way of secmark, but I guess not if we are
> > > keeping secmark separate from labeled networking.
> >
> > The checks should only be made if labeled networking is active.
>
> Actually even when we aren't using labeled networking, we would
> want to prevent packets arriving on a top-secret interface from
> being forwarded onto a secret interface. So, the checks would be
> in order here as well.

[Sorry to be quiet on the patches but I'm still looking/thinking]

Just for clarification James, what is the motivation for making the permission 
checks conditional?  Performance?  Compatibility?

Compatibility is an issue that we are going to have to deal with for both flow 
control and peer label reconciliation.  My current thinking is that we 
introduce a new functionality version flag which is set by the policy at load 
time and is used to determine code paths.  It's similar to the compat_net 
flag but more general purpose.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
