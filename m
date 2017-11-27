Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vARHnfFt006733
 for <selinux@tycho.nsa.gov>; Mon, 27 Nov 2017 12:49:41 -0500
Received: by mail-it0-f52.google.com with SMTP id x13so21823342iti.4
 for <selinux@tycho.nsa.gov>; Mon, 27 Nov 2017 07:50:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171127100102.4409-1-jzarsky@redhat.com>
References: <CAFftDdosb4sqRyexNmT11mjgATWLNW4jrabJ-u0zKuuCOWx4-g@mail.gmail.com>
 <20171127100102.4409-1-jzarsky@redhat.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Mon, 27 Nov 2017 07:50:27 -0800
Message-ID: <CAFftDdpvouX1L9d_iwKWxYmFw9=W7ORQ+AvZzhniR1kGbf3sHA@mail.gmail.com>
To: Jan Zarsky <jzarsky@redhat.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] libsemanage: properly check return value of
 iterate function
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Nov 27, 2017 at 2:01 AM, Jan Zarsky <jzarsky@redhat.com> wrote:
> Function dbase_llist_iterate() iterates over records and checks return
> value of iterate function. According to a manpage semanage_iterate(3),
> handler can return value 1 for early exit. dbase_llist_iterate()
> currently checks for return value > 1, which does not include
> expected value 1.
>
> Affected functions:
> semanage_bool_iterate_local
> semanage_fcontext_iterate
> semanage_fcontext_iterate_local
> semanage_ibendport_iterate_local
> semanage_ibpkey_iterate_local
> semanage_iface_iterate_local
> semanage_node_iterate_local
> semanage_port_iterate_local
> semanage_seuser_iterate
> semanage_seuser_iterate_local
> semanage_user_iterate
> semanage_user_iterate_local

Not really what I had in mind. I meant what was the affect. This is simple
enough to gather, so ack on v1,

My understanding is that the affect is that it that it doesn't short
circuit the iterate
routine so lockups take longer than they need be, is that correct?

>
> Signed-off-by: Jan Zarsky <jzarsky@redhat.com>
> ---
>  libsemanage/src/database_llist.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsemanage/src/database_llist.c b/libsemanage/src/database_llist.c
> index 8ce2e2c1..c8f4ff0b 100644
> --- a/libsemanage/src/database_llist.c
> +++ b/libsemanage/src/database_llist.c
> @@ -263,7 +263,7 @@ int dbase_llist_iterate(semanage_handle_t * handle,
>                 if (rc < 0)
>                         goto err;
>
> -               else if (rc > 1)
> +               else if (rc > 0)
>                         break;
>         }
>
> --
> 2.14.3
>
>



-- 
Respectfully,

William C Roberts
