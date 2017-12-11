Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vBBDm1og018107
 for <selinux@tycho.nsa.gov>; Mon, 11 Dec 2017 08:48:01 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC04.oob.disa.mil (Postfix) with SMTP id 3ywPRL06Z0z14wTb
 for <selinux@tycho.nsa.gov>; Mon, 11 Dec 2017 13:47:58 +0000 (UTC)
Received: from UPBD19PA05.eemsg.mil (unknown [192.168.18.6])
 by UPDCF3IC04.oob.disa.mil (Postfix) with ESMTP id 3ywPRK6c1zz14wTX
 for <selinux@tycho.nsa.gov>; Mon, 11 Dec 2017 13:47:57 +0000 (UTC)
Date: Mon, 11 Dec 2017 08:47:53 -0500 (EST)
From: Jan Zarsky <jzarsky@redhat.com>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
Message-ID: <978800513.47600060.1513000073843.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAFftDdpvouX1L9d_iwKWxYmFw9=W7ORQ+AvZzhniR1kGbf3sHA@mail.gmail.com>
References: <CAFftDdosb4sqRyexNmT11mjgATWLNW4jrabJ-u0zKuuCOWx4-g@mail.gmail.com>
 <20171127100102.4409-1-jzarsky@redhat.com>
 <CAFftDdpvouX1L9d_iwKWxYmFw9=W7ORQ+AvZzhniR1kGbf3sHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH] libsemanage: properly check return value of
 iterate function
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

----- Original Message -----
> On Mon, Nov 27, 2017 at 2:01 AM, Jan Zarsky <jzarsky@redhat.com> wrote:
> > Function dbase_llist_iterate() iterates over records and checks return
> > value of iterate function. According to a manpage semanage_iterate(3),
> > handler can return value 1 for early exit. dbase_llist_iterate()
> > currently checks for return value > 1, which does not include
> > expected value 1.
> >
> > Affected functions:
> > semanage_bool_iterate_local
> > semanage_fcontext_iterate
> > semanage_fcontext_iterate_local
> > semanage_ibendport_iterate_local
> > semanage_ibpkey_iterate_local
> > semanage_iface_iterate_local
> > semanage_node_iterate_local
> > semanage_port_iterate_local
> > semanage_seuser_iterate
> > semanage_seuser_iterate_local
> > semanage_user_iterate
> > semanage_user_iterate_local
> 
> Not really what I had in mind. I meant what was the affect. This is simple
> enough to gather, so ack on v1,
> 
> My understanding is that the affect is that it that it doesn't short
> circuit the iterate
> routine so lockups take longer than they need be, is that correct?

Yes, that is the exactly the problem. I will try to be more clear next time.

> 
> >
> > Signed-off-by: Jan Zarsky <jzarsky@redhat.com>
> > ---
> >  libsemanage/src/database_llist.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsemanage/src/database_llist.c
> > b/libsemanage/src/database_llist.c
> > index 8ce2e2c1..c8f4ff0b 100644
> > --- a/libsemanage/src/database_llist.c
> > +++ b/libsemanage/src/database_llist.c
> > @@ -263,7 +263,7 @@ int dbase_llist_iterate(semanage_handle_t * handle,
> >                 if (rc < 0)
> >                         goto err;
> >
> > -               else if (rc > 1)
> > +               else if (rc > 0)
> >                         break;
> >         }
> >
> > --
> > 2.14.3
> >
> >
> 
> 
> 
> --
> Respectfully,
> 
> William C Roberts
> 
