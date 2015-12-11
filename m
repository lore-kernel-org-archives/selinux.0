From: "Roberts, William C" <william.c.roberts@intel.com>
To: Paul Moore <paul@paul-moore.com>, Daniel Cashman <dcashman@android.com>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>, Stephen Smalley
 <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>, "serge@hallyn.com" <serge@hallyn.com>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "jeffv@google.com"
 <jeffv@google.com>, "nnk@google.com" <nnk@google.com>, "arve@google.com"
 <arve@google.com>
Subject: RE: Exposing secid to secctx mapping to user-space
Date: Fri, 11 Dec 2015 20:41:08 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC56011AC541@ORSMSX103.amr.corp.intel.com>
References: <566B17FB.6010405@android.com>
 <CAHC9VhRuVg_gwJbz_NA5ftUHT9gzFR8sx3AXmQkZViXwnq3Sow@mail.gmail.com>
In-Reply-To: <CAHC9VhRuVg_gwJbz_NA5ftUHT9gzFR8sx3AXmQkZViXwnq3Sow@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



> -----Original Message-----
> From: owner-linux-security-module@vger.kernel.org [mailto:owner-linux-
> security-module@vger.kernel.org] On Behalf Of Paul Moore
> Sent: Friday, December 11, 2015 11:55 AM
> To: Daniel Cashman <dcashman@android.com>
> Cc: selinux@tycho.nsa.gov; Stephen Smalley <sds@tycho.nsa.gov>; Eric Paris
> <eparis@parisplace.org>; James Morris <james.l.morris@oracle.com>;
> serge@hallyn.com; linux-security-module@vger.kernel.org; jeffv@google.com;
> nnk@google.com; arve@google.com
> Subject: Re: Exposing secid to secctx mapping to user-space
> 
> On Fri, Dec 11, 2015 at 1:37 PM, Daniel Cashman <dcashman@android.com>
> wrote:
> > Hello,
> >
> > I would like to write a patch that would expose, via selinuxfs, the
> > mapping between secids in the kernel and security contexts to
> > user-space, but before doing so wanted to get some feedback as to
> > whether or not such an endeavor could have any support upstream.  The
> > direct motivation for this is the desire to communicate calling
> > security ids/contexts over binder IPC on android for use in a
> > user-space object manager.  Passing the security ids themselves would
> > be simpler and more efficient in the critical kernel path, but they
> > currently have no user-space meaning.
> 
> In general we try to avoid exposing the secid tokens outside the kernel, I view
> them as an implementation hack designed to make it easier to manage and
> operate on the security labels in the kernel.  I suspect you will hear something
> very similar from Casey and the other Smack developers.  Another consideration
> is the long standing LSM stacking effort, they have several good reasons for
> wanting to abolish the secid token, propagating it to userspace would make that
> all but impossible.
> 
> While I'm sympathetic to your desire for less complexity and better performance
> in passing security labels, from a kernel perspective I think we lose too much in
> exporting the secid tokens outside the LSM.
> 

I looked at doing the same thing a while back, and pretty much came to the same conclusion
as Paul as mentioning here. I wanted to do this for sdcardd as part of the fuse struct. Since
the security pointer is opaque outside of the LSM, it makes it difficult to transfer this information.

However, could you just tag on something similar to how SO_PEERSEC works to the binder transaction?


> --
> paul moore
> www.paul-moore.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
