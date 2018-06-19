Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5JFkebE031381
 for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2018 11:46:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID06.oob.disa.mil (Postfix) with SMTP id 419C4Z3jHnz2Dbms
 for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2018 15:46:38 +0000 (UTC)
Received: from USFB3CPA01_EEMSG_MP23.eemsg.mil (unknown [192.168.16.18])
 by USFBF3ID06.oob.disa.mil (Postfix) with ESMTP id 419C4Y1ZxLz2Dbm0
 for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2018 15:46:37 +0000 (UTC)
Received: by mail-lf0-f66.google.com with SMTP id i15-v6so240578lfc.2
 for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2018 08:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180612080912.7827-1-peter.enderborg@sony.com>
 <20180612080912.7827-2-peter.enderborg@sony.com>
 <a85d28e8cbd32acda21424ab6a46089f26969671.camel@perches.com>
 <ef97b4b2-35da-7642-aa9d-de3e968cfb81@sony.com>
In-Reply-To: <ef97b4b2-35da-7642-aa9d-de3e968cfb81@sony.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 19 Jun 2018 11:46:23 -0400
Message-ID: <CAHC9VhR=1Z6sPJ=oetCg0fGFGb7yKq3OxRATeo15jhqMY5JoQQ@mail.gmail.com>
To: peter.enderborg@sony.com
Cc: joe@perches.com, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>,
 danielj@mellanox.com, dledford@redhat.com, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 01/13] selinux: Cleanup printk logging in
 conditional
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jun 13, 2018 at 2:23 AM peter enderborg
<peter.enderborg@sony.com> wrote:
> On 06/12/2018 04:38 PM, Joe Perches wrote:
> > On Tue, 2018-06-12 at 10:09 +0200, Peter Enderborg wrote:
> >> Replace printk with pr_* to avoid checkpatch warnings.
> > I believe it would be nicer to remove the
> > "SELinux: " prefix embbeded in each format
> > and use a specific
> >
> > #define pr_fmt(fmt) "SELinux: " fmt
> >
> > to automatically prefix these formats.
>
> I cant argument about that, however some of the warnings and debug prints in this set does not have this
> so it will then change the actual output. (And I also think that they should have a the prefix, but I don't
> know why they don't) So I am not sure if it appropriate for a cleanup patch, it supposed to have no functional change.

As others have mentioned, I think this patch is still a step forward
so I'm going to go ahead and merge it; thanks Peter.

As far as the prefix, or lack of, is concerned, that's probably an
oversight that we should fix at some point, but we would need to look
at each instance to verify.

-- 
paul moore
www.paul-moore.com
