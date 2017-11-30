To: Eric Dumazet <eric.dumazet@gmail.com>,
 Casey Schaufler <casey@schaufler-ca.com>,
 James Morris <james.l.morris@oracle.com>
Cc: Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org,
 Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
 LSM <linux-security-module@vger.kernel.org>
References: <alpine.LFD.2.20.1711292113350.7808@localhost>
 <4d73f839-7a86-6edc-b44b-e296bd5947c2@schaufler-ca.com>
 <alpine.LFD.2.20.1711301130330.17322@localhost>
 <ae2e71e4-c366-5a1e-9fd6-4de944f4a158@schaufler-ca.com>
 <1512039044.19682.12.camel@gmail.com>
 <b92c6b3d-5c7e-9859-4bb2-b1a0aa64d86b@gmail.com>
 <d29937fd-dd04-8568-f89c-505ff725761a@gmail.com>
 <1512064629.19682.21.camel@gmail.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <070df585-6615-554c-e0a0-4415930a1688@gmail.com>
Date: Thu, 30 Nov 2017 11:03:27 -0700
MIME-Version: 1.0
In-Reply-To: <1512064629.19682.21.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [BUG] kernel stack corruption during/after Netlabel
 error
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/30/17 10:57 AM, Eric Dumazet wrote:
> I wonder if this should not be in a separate patch ?
> 
> Bug was added in 971f10eca186cab238c49daa91f703c5a001b0b1 ("tcp: better
> TCP_SKB_CB layout to reduce cache line misses")  in linux 3.18
> 
> While VRF was added later.
> 
> If you agree, I will prepare a patch series, with different Fixes tag
> so that David can decide which path needs to be backported into each
> stable version.
> 

That's sound fine to me.
