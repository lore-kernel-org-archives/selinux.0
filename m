Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0GGf4KK027100
 for <selinux@tycho.nsa.gov>; Mon, 16 Jan 2017 11:41:04 -0500
Received: by mail-vk0-f66.google.com with SMTP id t8so2924667vke.0
 for <selinux@tycho.nsa.gov>; Mon, 16 Jan 2017 08:41:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484580399.19104.6.camel@redhat.com>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <1484580399.19104.6.camel@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 16 Jan 2017 11:40:59 -0500
Message-ID: <CAHC9VhTxe0+TXagRfBqjWqvNuNrET+zg_72EbRzDDj4Q4oBBhQ@mail.gmail.com>
Subject: Re: [PATCH 00/46] SELinux: Fine-tuning for several function
 implementations
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Eric Paris <eparis@redhat.com>, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Jan 16, 2017 at 10:26 AM, Eric Paris <eparis@redhat.com> wrote:
> <opinion from irrelevant person>

Well, not totally irrelevant, I just reserve the right to ignore Eric
if I disagree with him ;)

> All of the patches look good to me except most of those which change
> the handling of `rc=`. I have a personal style preference for
>
> rc = -ENOMEM;
> val = kalloc();
> if (!val)
>   goto err;
>
> vs
>
> val = kalloc();
> if (!val) {
>   rc = -ENOMEM;
>   goto err;
> }
>
> because it saves 1 line and I think the compiler does the right/same
> thing. If there is preference among the people active in selinux
> developers (like I said, I'm now irrelevant) I guess they win.

My preference tends to be the other way around; I think putting the rc
assignment in the if block makes the code more readable and that is
how I tend to write things.  That said, I don't recall ever requiring
someone to redo a patch only because of this style nit ... if I did,
shame on me.

> But certainly a big +1 from me for the array allocation and sizeof()
> changes.

I do appreciate all the patches, thank you!  However, a bit of a
warning that it may take me a little bit of time to work my way
through reviewing and merging all of them.

-- 
paul moore
www.paul-moore.com
