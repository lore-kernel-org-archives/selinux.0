Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1NGDe8u008910
 for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2018 11:13:40 -0500
Received: by mail-lf0-f65.google.com with SMTP id f75so8059678lfg.6
 for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2018 08:11:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180223024010.GE4375@localhost.localdomain>
References: <20180220191527.14307-1-richard_c_haines@btinternet.com>
 <20180221143345.GA3888@localhost.localdomain>
 <161ba1d60d8.2781.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <CAHC9VhSnPku5SYnNkyUqvi46OpzPZKbJf+fxeCR0y3ym0zcMYA@mail.gmail.com>
 <20180223024010.GE4375@localhost.localdomain>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 23 Feb 2018 11:11:50 -0500
Message-ID: <CAHC9VhT_1GQJPoOBN0ambF=F1+ZXhoYB3mMc8kzgCFOep+hsCg@mail.gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov,
 netdev@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 Vlad Yasevich <vyasevich@gmail.com>, nhorman@tuxdriver.com,
 Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, casey@schaufler-ca.com,
 James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH V7 2/4] sctp: Add ip option support
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Feb 22, 2018 at 9:40 PM, Marcelo Ricardo Leitner
<marcelo.leitner@gmail.com> wrote:
> On Thu, Feb 22, 2018 at 06:08:05PM -0500, Paul Moore wrote:
>> On Wed, Feb 21, 2018 at 3:45 PM, Paul Moore <paul@paul-moore.com> wrote:
>> > On February 21, 2018 9:33:51 AM Marcelo Ricardo Leitner <marcelo.leitner@gmail.com> wrote:
>> >> On Tue, Feb 20, 2018 at 07:15:27PM +0000, Richard Haines wrote:
>> >>> Add ip option support to allow LSM security modules to utilise CIPSO/IPv4
>> >>> and CALIPSO/IPv6 services.
>> >>>
>> >>> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>> >>
>> >> LGTM too, thanks!
>> >>
>> >> Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
>> >
>> > I agree, thanks everyone for all the work, review, and patience behind this patchset!  I'll work on merging this into selinux/next and I'll send a note when it's done.
>>
>> I just merged the four patches (1,3,4 from the v6 patchset, 2 from the
>> v7 patchset) in selinux/next and did a quick sanity test on the kernel
>> (booted, no basic SELinux regressions).  Additional testing help is
>> always appreciated ...
>
> I'll try it early next week.
>
> Any ideas on when this is going to appear on Dave's net-next tree?
> We have a lot of SCTP changes to be posted on this cycle and would be
> nice if we could avoid merge conflicts.

It's merged into the SELinux tree, next branch; see the links below.
Last I checked DaveM doesn't pull the selinux/next into his net-next
tree (that would be a little funny for historical reasons).

Any idea on how bad the merge conflicts are?

>> * git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
>> * https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git

-- 
paul moore
www.paul-moore.com
