Date: Tue, 31 Mar 2009 13:34:46 -0500
From: Nicolas Williams <Nicolas.Williams@sun.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Jarrett Lu <Jarrett.Lu@sun.com>, nfs-discuss@opensolaris.org,
        labeled-nfs@linux-nfs.org, nfsv4@ietf.org, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [nfsv4] [Labeled-nfs] New MAC label support Internet Draft posted to IETF	website
Message-ID: <20090331183445.GH9992@Sun.COM>
References: <49CBFB94.6030408@sun.com> <20090327001102.GU9992@Sun.COM> <1238158539.15207.6.camel@localhost.localdomain> <1238160162.15207.19.camel@localhost.localdomain> <49CD06E7.6030802@sun.com> <20090327172632.GA9992@Sun.COM> <49CD2169.3080209@sun.com> <1238434634.2484.90.camel@localhost.localdomain> <49D10FC1.3000103@sun.com> <49D188D6.6020107@schaufler-ca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49D188D6.6020107@schaufler-ca.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Mar 30, 2009 at 08:07:02PM -0700, Casey Schaufler wrote:
> Not to throw a puppy in the gears, but sophisticated handshaking and
> negotiation protocols are not the answer. We had TSIG session management
> for doing that and it is just not enough. How would you negotiate the
> differences between two SELinux policies?

You don't.  You either establish that they are the same (or that one or
both peers are translating to a common policy) or that they are not.  In
the latter case you fail to communicate further.  It seems quite
reasonable to me to have a single policy for a site -- that seems doable
for MLS, but for DTE it's more likely that there will be OS-specific
parts of a site policy, and the potential need to map between existing
OS-specific policies and something else seems daunting, at least at
first glance, but I'm an optimist, so I think it must be doable :)

Nico
-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
