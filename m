Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2QICDcV017979
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 14:12:13 -0400
Received: by qaeb19 with SMTP id b19so2532811qae.12
        for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 11:12:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120326174549.07f27c96@eldamar.bigon.be>
References: <20120326174549.07f27c96@eldamar.bigon.be>
Date: Mon, 26 Mar 2012 14:12:12 -0400
Message-ID: <CACLa4pt=Y5N+7GmJRsmGV0DavJP8ykhO0ST5RtVd7zss9PNT+w@mail.gmail.com>
Subject: Re: [PATCH 4/4] policycoreutils -- Make restorecon return 0 when a
 file has changed context with no error
From: Eric Paris <eparis@parisplace.org>
To: Laurent Bigonville <bigon@debian.org>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Mar 26, 2012 at 11:45 AM, Laurent Bigonville <bigon@debian.org> wrote:
> Hi,
>
> restorecon should return 0 when a file has changed context with no
> error. With the last version it's returning 1.
>
> I'm not sure if a patch has already been proposed for this issue.
>
> Laurent
>
> Description: Make restorecon return 0 when a file has changed context with no error
> Author: Russell Coker <russell@coker.com.au>
> Last-Update: 2012-03-07
> Bug-Debian: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=662990
>
> ---
>  setfiles/restore.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/policycoreutils/setfiles/restore.c b/policycoreutils/setfiles/restore.c
> index 9a7d315..a378af0 100644
> --- a/policycoreutils/setfiles/restore.c
> +++ b/policycoreutils/setfiles/restore.c
> @@ -218,10 +218,9 @@ static int restore(FTSENT *ftsent)
>                        r_opts->progname, my_file, newcon, strerror(errno));
>                goto skip;
>        }
> -       ret = 1;
>  out:
>        freecon(newcon);
> -       return ret;
> +       return 0;
>  skip:
>        freecon(newcon);
>        return SKIP;

Is this right?  Don't we get to "out" from a number of error cases?
Do we always want 0?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
