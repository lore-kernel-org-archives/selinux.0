Date: Mon, 3 Apr 2017 11:10:42 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul@paul-moore.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Markus Elfring <elfring@users.sourceforge.net>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 William Roberts <william.c.roberts@intel.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] selinux: Fix an uninitialized variable bug
In-Reply-To: <CAHC9VhT7njoVyHgyiTQhCcvZEYrTE_XZRLxT4+JJPiH3W88AUw@mail.gmail.com>
Message-ID: <alpine.LRH.2.20.1704031054080.27757@namei.org>
References: <20170331152118.GA8141@mwanda>
 <1490975541.31110.12.camel@tycho.nsa.gov>
 <CAHC9VhT7njoVyHgyiTQhCcvZEYrTE_XZRLxT4+JJPiH3W88AUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 31 Mar 2017, Paul Moore wrote:

> On Fri, Mar 31, 2017 at 11:52 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On Fri, 2017-03-31 at 18:21 +0300, Dan Carpenter wrote:
> >> We removed this initialization as a cleanup but it is probably
> >> required.
> >>
> >> The concern is that "nel" can be zero.  I'm not an expert on SELinux
> >> code but I think it looks possible to write an SELinux policy which
> >> triggers this bug.  GCC doesn't catch this, but my static checker
> >> does.
> >>
> >> Fixes: 9c312e79d6af ("selinux: Delete an unnecessary variable
> >> initialisation in range_read()")
> >> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> >
> > Nice catch, thanks!
> >
> > Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> 
> Yes, indeed.  Thanks Dan, I should have caught this when merging Markus' patch.
> 

I'd like to reiterate that I generally don't want to accept cleanup 
patches into the security tree from Markus (or indeed from others who 
only do cleanup/whitespace work).

See https://lkml.org/lkml/2017/1/29/172, and please click through and read 
Dan's comments.

All patches carry risks of introducing new bugs, and kernel "cleanup: 
patches generally offer a pretty high cost/benefit ratio.  If such patches 
come from core developers of that code, or from kernel developers with 
experience in *analyzing and fixing* bugs, that's very different.

Paul, please review all of these patches very carefully before sending 
your pull request.


-- 
James Morris
<jmorris@namei.org>
