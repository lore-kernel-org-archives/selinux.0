Date: Wed, 19 Sep 2007 14:12:53 -0700 (PDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        paul.moore@hp.com, Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>
Subject: Re: [RFC] [PATCH 4/4] SELinux changes
In-Reply-To: <1190211506.25863.56.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.64.0709191412170.31778@us.intercode.com.au>
References: <46F00BAC.8040103@trustedcs.com> <1190211506.25863.56.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 19 Sep 2007, Stephen Smalley wrote:

> We thought we were eliminating the need for these per-packet
> per-node/netif checks by way of secmark, but I guess not if we are
> keeping secmark separate from labeled networking.

The checks should only be made if labeled networking is active.

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
