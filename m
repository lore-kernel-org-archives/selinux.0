Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tBEHokgv014182
 for <selinux@tycho.nsa.gov>; Mon, 14 Dec 2015 12:50:48 -0500
Subject: Re: Exposing secid to secctx mapping to user-space
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>
References: <566B17FB.6010405@android.com>
 <CAHC9VhRuVg_gwJbz_NA5ftUHT9gzFR8sx3AXmQkZViXwnq3Sow@mail.gmail.com>
 <566B4ACE.3040301@tycho.nsa.gov> <1834864.RYHtAVZZNX@sifl>
Cc: Daniel Cashman <dcashman@android.com>, selinux@tycho.nsa.gov,
 Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>, serge@hallyn.com,
 linux-security-module@vger.kernel.org, jeffv@google.com,
 nnk@google.com, arve@google.com, Casey Schaufler <casey@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <566F016B.90002@schaufler-ca.com>
Date: Mon, 14 Dec 2015 09:50:35 -0800
MIME-Version: 1.0
In-Reply-To: <1834864.RYHtAVZZNX@sifl>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/13/2015 2:06 PM, Paul Moore wrote:
> On Friday, December 11, 2015 05:14:38 PM Stephen Smalley wrote:
>> Perhaps we could provide a new fixed-size tokenized version of the
>> security context string for export to userspace that could be embedded
>> in the binder transaction structure?  This could avoid both the
>> limitations of the current secid (e.g. limited to 32 bits, no
>> stackability) and the overhead of copying context strings on every IPC.
> On Friday, December 11, 2015 04:24:48 PM Casey Schaufler wrote:
>> How about this: Provide an alias mechanism for secctx. There would then
>> be a secid (32bits) a secctx (arbitrary text string) and a secalias which
>> could be a limited string of some length. You could use the alias in place
>> of the secctx anywhere you liked.
> My initial reaction to the secalias idea isn't overly positive.  It seems like 
> a kludge with a lot of duplication, both in terms of code and concept, and a 
> lot of risk for confusion both by users and policy writers.  I think if we 
> really wanted to limit the security label string format to a small size we 
> should have done that from the start, it's too late now.

The alias would be a user space controlled mapping. The kernel
code would only be involved at the border. I would never expect
policy to be written using aliases. As for being a kludge, yeah,
there's some of that, but I think that's true with the secid, too.

> Assuming we see some binder performance numbers, and the numbers are bad, I'm 
> a little more open to doing something with the secid token.  Up to this point 
> we haven't made any guarantees about the token and we haven't exported it 
> outside the kernel so there is some ability to change it to fit our needs.  
> Granted, this isn't perfect solution either, and perhaps ultimately we would 
> need something else, but I think it is worth looking into this first before we 
> introduce another string label.

I agree with getting numbers before someone dashes off to
make a premature optimization that exposes secids. If the
numbers are bad I would hope that the developers would look
at fixing binder rather than exposing (and forever requiring)
secids.
