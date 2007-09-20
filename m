From: Paul Moore <paul.moore@hp.com>
To: vyekkirala@TrustedCS.com
Subject: Re: [RFC] [PATCH 4/4] SELinux changes
Date: Thu, 20 Sep 2007 14:30:37 -0400
Cc: "'James Morris'" <jmorris@namei.org>,
        "Stephen Smalley" <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        "Karl MacMillan" <kmacmillan@mentalrootkit.com>,
        "Joshua Brindle" <method@manicmethod.com>
References: <009901c7fb94$7930ee90$cc0a010a@tcssec.com> <200709201131.50680.paul.moore@hp.com>
In-Reply-To: <200709201131.50680.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709201430.37998.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday, September 20 2007 11:31:50 am Paul Moore wrote:
> On Thursday, September 20 2007 10:42:29 am Venkatesh Yekkirala wrote:
> > No problem. I also wanted to ping on any further thinking on using
> > the IP option space (versus split secmark) for carrying the loopback
> > label as well as the label when a forwarded packet has used
> > NetLabel/cipso when coming in, but is going out using a non-labeled
> > (plain) IPsec tunnel. In the latter case, we would have the label
> > unavailable for use in the outgoing filter checks unless the ip option in
> > the inner "tunneled" packet is copied into the outer "tunnel" packet as
> > well. I suggested using the special localhost IP option to carry this
> > label, but stripping it out right after the flow_out checks. But on
> > further discussions here on our end, it seems like this would be
> > extremely fragile, even if made somehow workable in all cases. For
> > example, this could potentially fail when using AH on the tunnel packet.
> > Which all makes us believe going the split secmark route might be the
> > most reliable/robust route under the circumstances.
>
> Okay, let's see.  Like I said, I'm a little preoccupied with items #1 and
> #2 right now, but you make a valid point.  Just to be clear, I consider
> splitting the secmark field to be a last resort option and while I'm not
> giving a NO vote on it, I want to make sure we have examined all of the
> other possibilities before going down that road.

If it's only an issue for forwarding, it might be possible to add another 
entry to the inet[6]_skb_param struct to store the peer label.  According to 
my quick calculations both structs are under the 48 byte limit.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
