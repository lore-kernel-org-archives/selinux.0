Date: Wed, 06 Apr 2016 15:39:55 -0400 (EDT)
Message-Id: <20160406.153955.2244652846180310527.davem@davemloft.net>
To: paul@paul-moore.com
Cc: pabeni@redhat.com, linux-security-module@vger.kernel.org,
 james.l.morris@oracle.com, agruenba@redhat.com, sds@tycho.nsa.gov,
 fw@strlen.de, netdev@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [RFC PATCH 0/2] selinux: avoid nf hooks overhead when not needed
From: David Miller <davem@davemloft.net>
In-Reply-To: <CAHC9VhT0444cEDKsfww7Yj22svSFOfY4ersVhh8up9ZrZ_8rng@mail.gmail.com>
References: <CAHC9VhQS+LfPbj0UuKFiVCW7LKthJmgOt08MvCiwKjTZZYstxA@mail.gmail.com>
 <20160406.142316.1728426867290841888.davem@davemloft.net>
 <CAHC9VhT0444cEDKsfww7Yj22svSFOfY4ersVhh8up9ZrZ_8rng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <paul@paul-moore.com>
Date: Wed, 6 Apr 2016 14:36:43 -0400

> On Wed, Apr 6, 2016 at 2:23 PM, David Miller <davem@davemloft.net> wrote:
>> From: Paul Moore <paul@paul-moore.com>
>> Date: Wed, 6 Apr 2016 10:07:27 -0400
>>
>>> "While marking the LSM hook structure doesn't directly affect the
>>> SELinux netfilter hooks, once we remove the ability to deregister the
>>> LSM hooks we will have no need to support deregistering netfilter
>>> hooks and I expect we will drop that functionality as well to help
>>> decrease the risk of tampering."
>>
>> This is not a reasonable postiion.
>>
>> The performance implications are non-trivial for using netfilter hooks
>> when they aren't actually needed.
> 
> With all due respect, I think you've taken what I consider to be some
> unreasonable positions when it comes to the network stack and LSMs in
> the past.  We have different perspectives and different priorities as
> a result, from my perspective the security advantage gained by
> eliminating the ability to disable SELinux at runtime is more
> important.

SELinux folks seem to get rather upset to people outright disabling
the facility, but many users still do exactly that.

In my opinion, it's uncompromising positions like the one you are
having here is part of the reason that issue will continue.

It is not AND, it's an OR, people want choice, and if you don't give
it to them they will find a way to achieve what they want with or
without your help.  And you might not like what they come up with.

If distributions are turning SELinux on by default, then we have to
care about whather netfilter performance should suffer for facilities
which are unused.
