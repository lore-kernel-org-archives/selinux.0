Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkatesh Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Paul Moore'" <paul.moore@hp.com>
Cc: "'James Morris'" <jmorris@namei.org>,
        "Stephen Smalley" <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>,
        "Karl MacMillan" <kmacmillan@mentalrootkit.com>,
        "Joshua Brindle" <method@manicmethod.com>
Subject: RE: [RFC] [PATCH 4/4] SELinux changes
Date: Thu, 20 Sep 2007 09:42:29 -0500
Message-ID: <009901c7fb94$7930ee90$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <200709191740.04406.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> [Sorry to be quiet on the patches but I'm still looking/thinking]

No problem. I also wanted to ping on any further thinking on using
the IP option space (versus split secmark) for carrying the loopback
label as well as the label when a forwarded packet has used NetLabel/cipso
when coming in, but is going out using a non-labeled (plain) IPsec tunnel.
In the latter case, we would have the label unavailable for use in
the outgoing filter checks unless the ip option in the inner "tunneled"
packet is copied into the outer "tunnel" packet as well. I suggested
using the special localhost IP option to carry this label, but stripping
it out right after the flow_out checks. But on further discussions here
on our end, it seems like this would be extremely fragile, even if made
somehow workable in all cases. For example, this could potentially fail
when using AH on the tunnel packet. Which all makes us believe going
the split secmark route might be the most reliable/robust route under
the circumstances.

I know we wanted to hash out the flow control stuff first which I believe
we have a good handle on at this point. So my above query.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
