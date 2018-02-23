Date: Thu, 22 Feb 2018 23:40:10 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov,
 netdev@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 Vlad Yasevich <vyasevich@gmail.com>, nhorman@tuxdriver.com,
 Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, casey@schaufler-ca.com,
 James Morris <jmorris@namei.org>
Message-ID: <20180223024010.GE4375@localhost.localdomain>
References: <20180220191527.14307-1-richard_c_haines@btinternet.com>
 <20180221143345.GA3888@localhost.localdomain>
 <161ba1d60d8.2781.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <CAHC9VhSnPku5SYnNkyUqvi46OpzPZKbJf+fxeCR0y3ym0zcMYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHC9VhSnPku5SYnNkyUqvi46OpzPZKbJf+fxeCR0y3ym0zcMYA@mail.gmail.com>
Subject: Re: [PATCH V7 2/4] sctp: Add ip option support
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Feb 22, 2018 at 06:08:05PM -0500, Paul Moore wrote:
> On Wed, Feb 21, 2018 at 3:45 PM, Paul Moore <paul@paul-moore.com> wrote:
> > On February 21, 2018 9:33:51 AM Marcelo Ricardo Leitner <marcelo.leitner@gmail.com> wrote:
> >> On Tue, Feb 20, 2018 at 07:15:27PM +0000, Richard Haines wrote:
> >>> Add ip option support to allow LSM security modules to utilise CIPSO/IPv4
> >>> and CALIPSO/IPv6 services.
> >>>
> >>> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> >>
> >> LGTM too, thanks!
> >>
> >> Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> >
> > I agree, thanks everyone for all the work, review, and patience behind this patchset!  I'll work on merging this into selinux/next and I'll send a note when it's done.
> 
> I just merged the four patches (1,3,4 from the v6 patchset, 2 from the
> v7 patchset) in selinux/next and did a quick sanity test on the kernel
> (booted, no basic SELinux regressions).  Additional testing help is
> always appreciated ...

I'll try it early next week.

Any ideas on when this is going to appear on Dave's net-next tree?
We have a lot of SCTP changes to be posted on this cycle and would be
nice if we could avoid merge conflicts.

> 
> * git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
> * https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
> 
> -- 
> paul moore
> www.paul-moore.com
