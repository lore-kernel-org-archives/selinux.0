Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t44IoNtR032125
 for <selinux@tycho.nsa.gov>; Mon, 4 May 2015 14:50:24 -0400
Received: by qgej70 with SMTP id j70so70198088qge.2
 for <selinux@tycho.nsa.gov>; Mon, 04 May 2015 11:50:22 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Marek Milkovic <mmilkovi@redhat.com>
Subject: Re: [PATCH] selinux: Print 'sclass' as string when unrecognized
 netlink message occurs
Date: Mon, 04 May 2015 14:50:20 -0400
Message-ID: <9875143.p7TCZKgdYi@sifl>
In-Reply-To: <CAHC9VhRxf2Ck8pgR3Z2y-8T39RJAGhKuWE0PtM-FP5aH5vNbVQ@mail.gmail.com>
References: <1427990294-19573-1-git-send-email-mmilkovi@redhat.com>
 <CAHC9VhRxf2Ck8pgR3Z2y-8T39RJAGhKuWE0PtM-FP5aH5vNbVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tuesday, April 07, 2015 07:28:07 AM Paul Moore wrote:
> On Thu, Apr 2, 2015 at 11:58 AM, Marek Milkovic <mmilkovi@redhat.com> wrote:
> > This prints the 'sclass' field as string instead of index in unrecognized
> > netlink message. The textual representation makes it easier to
> > distinguish the right class.
> > 
> > Signed-off-by: Marek Milkovic <mmilkovi@redhat.com>
> > ---
> > 
> >  security/selinux/hooks.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Thanks Marek, this looks good.  I'm adding this to the next queue for
> after the merge window.

Merged into next with a minor reformat to fit the code into an 80-char wide 
terminal.

> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 87a9156..d75f525 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -4712,8 +4712,8 @@ static int selinux_nlmsg_perm(struct sock *sk,
> > struct sk_buff *skb)> 
> >                 if (err == -EINVAL) {
> >                 
> >                         printk(KERN_WARNING
> >                         
> >                                "SELinux: unrecognized netlink message:"
> > 
> > -                              " protocol=%hu nlmsg_type=%hu
> > sclass=%hu\n",
> > -                              sk->sk_protocol, nlh->nlmsg_type,
> > sksec->sclass); +                              " protocol=%hu
> > nlmsg_type=%hu sclass=%s\n", +                             
> > sk->sk_protocol, nlh->nlmsg_type, secclass_map[sksec->sclass - 1].name);> 
> >                         if (!selinux_enforcing ||
> >                         security_get_allow_unknown())
> >                         
> >                                 err = 0;
> >                 
> >                 }
> > 
> > --
> > 2.1.0
> > 
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to
> > Selinux-request@tycho.nsa.gov.

-- 
paul moore
www.paul-moore.com
