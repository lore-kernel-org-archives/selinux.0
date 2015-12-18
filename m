Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tBINsiNI007227
 for <selinux@tycho.nsa.gov>; Fri, 18 Dec 2015 18:54:44 -0500
Received: by mail-ob0-f176.google.com with SMTP id 18so90142247obc.2
 for <selinux@tycho.nsa.gov>; Fri, 18 Dec 2015 15:54:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56707EF9.4070709@android.com>
References: <566B17FB.6010405@android.com>
 <CAHC9VhRuVg_gwJbz_NA5ftUHT9gzFR8sx3AXmQkZViXwnq3Sow@mail.gmail.com>
 <566B4ACE.3040301@tycho.nsa.gov> <1834864.RYHtAVZZNX@sifl>
 <566F016B.90002@schaufler-ca.com>
 <476DC76E7D1DF2438D32BFADF679FC56011AD188@ORSMSX103.amr.corp.intel.com>
 <566F3E8D.3060604@tycho.nsa.gov>
 <476DC76E7D1DF2438D32BFADF679FC56011AD1EC@ORSMSX103.amr.corp.intel.com>
 <56702B25.9010205@tycho.nsa.gov> <56707EF9.4070709@android.com>
Message-ID: <CAHC9VhSx2xDQ=XjA9rGKeCy2vcgAM2=Am6=j-6XTNqjru2A1oA@mail.gmail.com>
Subject: Re: Exposing secid to secctx mapping to user-space
From: Paul Moore <paul@paul-moore.com>
To: Daniel Cashman <dcashman@android.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
 "Roberts, William C" <william.c.roberts@intel.com>,
 Casey Schaufler <casey@schaufler-ca.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "serge@hallyn.com" <serge@hallyn.com>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "jeffv@google.com" <jeffv@google.com>,
 "nnk@google.com" <nnk@google.com>, "arve@google.com" <arve@google.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
Date: Fri, 18 Dec 2015 23:54:49 -0000

On Tue, Dec 15, 2015 at 3:58 PM, Daniel Cashman <dcashman@android.com> wrote:
> On 12/15/2015 07:00 AM, Stephen Smalley wrote:
>> 1. I don't think it is the size of the context that is the concern but
>> rather the fact that it is a variable-length string, whereas current
>> binder commands use fixed-size arguments and encode the size in the
>> command value (common for ioctls).  Supporting passing a variable-length
>> string would be a change to the protocol and would complicate the code.
>>  On the performance side, it means generating a context string from the
>> secid and then copying it to userspace on each IPC (versus just getting
>> the secid and putting that in the existing binder_transaction_data that
>> is already copied to userspace).
>
> This is precisely the motivation for the original enquiry. Issue has
> been brought up about changing the protocol, and concern has also been
> strongly expressed about the overhead introduced by the string
> operations, although this has not been measured.  User-space would still
> need to do something intelligent with the secid, which would involve its
> own lookup and caching, but the idea is that this wouldn't be done with
> the binder lock held.
>
>> 2. Don't know; deferring to Daniel to run whatever binder IPC benchmarks
>> might exist with and without the current patch that copies the context
>> string.
>
> Yes, this needs to be done.  This issue was brought up as part of
> discussion regarding a proposed change to the binder driver to add the
> context string to each transaction.  An outcome of that discussion was,
> "before we go too far into this, let's see the reaction upstream to
> exposing the secid."  Based on the reaction here (upstream), I think
> it's my responsibility to push forward the string-based change and get
> the appropriate perf numbers so that a meaningful comparison can be made.

The existing, variable length string based approach is going to be
your easiest path forward with respect to the kernel, although it may
turn out to be a non-starter from a binder point of view.  I just want
to reiterate that I'm not against the idea of exposing the secid
tokens, but not necessarily in their current form; we will probably
want to revisit the idea of a persistent secid and consider the impact
to any future stacking work.

-- 
paul moore
www.paul-moore.com
