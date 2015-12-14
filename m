Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tBEHC3E5011165
 for <selinux@tycho.nsa.gov>; Mon, 14 Dec 2015 12:12:03 -0500
Received: by mail-wm0-f43.google.com with SMTP id p66so72139144wmp.1
 for <selinux@tycho.nsa.gov>; Mon, 14 Dec 2015 09:11:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1834864.RYHtAVZZNX@sifl>
References: <566B17FB.6010405@android.com>
 <CAHC9VhRuVg_gwJbz_NA5ftUHT9gzFR8sx3AXmQkZViXwnq3Sow@mail.gmail.com>
 <566B4ACE.3040301@tycho.nsa.gov> <1834864.RYHtAVZZNX@sifl>
Date: Mon, 14 Dec 2015 12:03:39 -0500
Message-ID: <CAMN686H=1MKUWa5iW9cciiVwto03uEVGC7uj7kdt3S0-29BvhQ@mail.gmail.com>
Subject: Re: Exposing secid to secctx mapping to user-space
From: Mike Palmiotto <mike.palmiotto@crunchydata.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
 Casey Schaufler <casey@schaufler-ca.com>, selinux@tycho.nsa.gov,
 arve@google.com, linux-security-module@vger.kernel.org,
 James Morris <james.l.morris@oracle.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sun, Dec 13, 2015 at 5:06 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Friday, December 11, 2015 05:14:38 PM Stephen Smalley wrote:
>> Perhaps we could provide a new fixed-size tokenized version of the
>> security context string for export to userspace that could be embedded
>> in the binder transaction structure?  This could avoid both the
>> limitations of the current secid (e.g. limited to 32 bits, no
>> stackability) and the overhead of copying context strings on every IPC.
>
> On Friday, December 11, 2015 04:24:48 PM Casey Schaufler wrote:
>> How about this: Provide an alias mechanism for secctx. There would then
>> be a secid (32bits) a secctx (arbitrary text string) and a secalias which
>> could be a limited string of some length. You could use the alias in place
>> of the secctx anywhere you liked.
>
> My initial reaction to the secalias idea isn't overly positive.  It seems like
> a kludge with a lot of duplication, both in terms of code and concept, and a
> lot of risk for confusion both by users and policy writers.  I think if we
> really wanted to limit the security label string format to a small size we
> should have done that from the start, it's too late now.
>
> Assuming we see some binder performance numbers, and the numbers are bad, I'm
> a little more open to doing something with the secid token.  Up to this point
> we haven't made any guarantees about the token and we haven't exported it
> outside the kernel so there is some ability to change it to fit our needs.
> Granted, this isn't perfect solution either, and perhaps ultimately we would
> need something else, but I think it is worth looking into this first before we
> introduce another string label.

Agreed here. I can definitely see a use for security identifier tokens
in SE Postgres as well. Ideally these tokens would be 32 bit uints as
opposed to shorter string aliases.

--Mike

>
> --
> paul moore
> www.paul-moore.com
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
