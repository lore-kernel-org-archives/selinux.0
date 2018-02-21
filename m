Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1LKk35C028368
 for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2018 15:46:08 -0500
Received: by mail-qt0-f196.google.com with SMTP id f4so3661450qtj.6
 for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2018 12:45:54 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Richard Haines <richard_c_haines@btinternet.com>
CC: <selinux@tycho.nsa.gov>, <netdev@vger.kernel.org>,
 <linux-sctp@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <vyasevich@gmail.com>, <nhorman@tuxdriver.com>, <sds@tycho.nsa.gov>,
 <eparis@parisplace.org>, <casey@schaufler-ca.com>, <jmorris@namei.org>
Date: Wed, 21 Feb 2018 15:45:43 -0500
Message-ID: <161ba1d60d8.2781.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <20180221143345.GA3888@localhost.localdomain>
References: <20180220191527.14307-1-richard_c_haines@btinternet.com>
 <20180221143345.GA3888@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [PATCH V7 2/4] sctp: Add ip option support
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On February 21, 2018 9:33:51 AM Marcelo Ricardo Leitner <marcelo.leitner@gmail.com> wrote:
> On Tue, Feb 20, 2018 at 07:15:27PM +0000, Richard Haines wrote:
>> Add ip option support to allow LSM security modules to utilise CIPSO/IPv4
>> and CALIPSO/IPv6 services.
>> 
>> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>
> LGTM too, thanks!
>
> Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

I agree, thanks everyone for all the work, review, and patience behind this patchset!  I'll work on merging this into selinux/next and I'll send a note when it's done.

--
paul moore
www.paul-moore.com
