From: "Roberts, William C" <william.c.roberts@intel.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, Casey Schaufler
 <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>
CC: Daniel Cashman <dcashman@android.com>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>, "serge@hallyn.com" <serge@hallyn.com>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "jeffv@google.com"
 <jeffv@google.com>, "nnk@google.com" <nnk@google.com>, "arve@google.com"
 <arve@google.com>
Subject: RE: Exposing secid to secctx mapping to user-space
Date: Mon, 14 Dec 2015 22:57:49 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC56011AD1EC@ORSMSX103.amr.corp.intel.com>
References: <566B17FB.6010405@android.com>
 <CAHC9VhRuVg_gwJbz_NA5ftUHT9gzFR8sx3AXmQkZViXwnq3Sow@mail.gmail.com>
 <566B4ACE.3040301@tycho.nsa.gov> <1834864.RYHtAVZZNX@sifl>
 <566F016B.90002@schaufler-ca.com>
 <476DC76E7D1DF2438D32BFADF679FC56011AD188@ORSMSX103.amr.corp.intel.com>
 <566F3E8D.3060604@tycho.nsa.gov>
In-Reply-To: <566F3E8D.3060604@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

<snip>
> >
> > If I understand correctly, the goal here is to avoid the lookup from
> > pid to context. If we somehow Had the context or a token to a context
> > during the ipc transaction to userspace, we could just use that In
> > computing the access decision. If that is correct, then since we have
> > PID, why not just extend the SE Linux compute av decision interface to support
> passing of PID and then it can do the lookup in the Kernel?
> 
> That's no less racy than getpidcon().
> 

I got a bounce from when I sent this from gmail, resending.

True, but in this case the binder transaction would be dead...

Why not just pass ctx? It's less than ideal, but it might be good enough for now until contexts get unwieldy big.

grep -rn '^type ' * | grep domain | cut -d' ' -f 2-2 | sed s/','//g | awk ' {  thislen=length($0); printf("%-5s %dn", NR, thislen); totlen+=thislen}                                     
END { printf("average: %dn", totlen/NR); } '

The avg type length for domain types in external/sepolicy is 7. Add the full ctx:

u:r:xxxxxxx:s0(cat)

1. We're looking at like 18 or so bytes, how do we know this won't be "fast enough"?
2. What's the current perf numbers, and what's agreed upon on what you need to hit to be fast enough?
3. I'm assuming the use case is in service manager, but would a userspace cache of AVD's help? Then you can (possibly) avoid both kernel trips, and you can invalidate the cache on policy reload and on PID deaths? In the case of service manager would it always be a miss based on usage pattern? I'm assuming things would say hey resolve this once, and be done. However, you could only do the ctx lookup and do the avd based on the policy in user space, thus avoiding 1 of two trips.
