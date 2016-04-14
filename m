Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3EMrwF4032289
 for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2016 18:53:59 -0400
Received: by mail-oi0-f47.google.com with SMTP id w85so108422553oiw.0
 for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2016 15:53:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1460451162.5965.16.camel@redhat.com>
References: <cover.1459934322.git.pabeni@redhat.com>
 <CAHC9VhSZP1QxT-pQeHAW9m1xmyDsbFeA=9b8SdeWgS0RiDTOBA@mail.gmail.com>
 <20160406234532.GA731@breakpoint.cc> <2239567.jkCk1gtQAE@sifl>
 <1460451162.5965.16.camel@redhat.com>
Date: Thu, 14 Apr 2016 18:53:54 -0400
Message-ID: <CAHC9VhSgWAoWgywOZOvT76jCcHuEywjFu5CKJo9D0k+66RbFCA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] selinux: avoid nf hooks overhead when not needed
From: Paul Moore <paul@paul-moore.com>
To: Paolo Abeni <pabeni@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>
Cc: Florian Westphal <fw@strlen.de>, linux-security-module@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 James Morris <james.l.morris@oracle.com>,
 Andreas Gruenbacher <agruenba@redhat.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, netdev@vger.kernel.org,
 selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Apr 12, 2016 at 4:52 AM, Paolo Abeni <pabeni@redhat.com> wrote:
> Will be ok if we post a v2 version of this series, removing the hooks
> de-registration bits, but preserving the selinux nf-hooks and
> socket_sock_rcv_skb() on-demand/delayed registration ? Will that fit
> with the post-init read only memory usage that you are planning ?

The work Florian and and I were talking about would be limited just to
the netfilter hooks, the LSM hooks, e.g. socket_sock_rcv_skb() and
friends, would remain as they are today.  What what we discussing was
defaulting to not registering the netfilter hooks until it became
necessary due to a labeled networking configuration or the
always_check_network policy capability; the registration of the
netfilter hooks would be permanent, you could not unregister the hooks
at that point, you would need to reboot.  Does that make sense?

As far as Casey's concerns, I don't think the work we are talking
about for the v2 patchset would have any effect on the socket/sock
security blobs as you really can't manage those adequately from the
netfilter hooks; you most likely will reference them and perhaps even
update the data within, but not allocate or free the blobs.  Besides,
even in some weird case you were alloc/free'ing security blobs in the
netfilter hooks, we can deal with that on a per-LSM basis if/when the
full fledged stacking patches are merged; everything we are talking
about is a hidden implementation detail so changing it in the future
shouldn't be a problem.

-- 
paul moore
www.paul-moore.com
