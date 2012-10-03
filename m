Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q93JX61J014269
	for <selinux@tycho.nsa.gov>; Wed, 3 Oct 2012 15:33:06 -0400
Received: by vbbfc21 with SMTP id fc21so9664976vbb.12
        for <selinux@tycho.nsa.gov>; Wed, 03 Oct 2012 12:32:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPzO=NydFKroZ5_+_3NK1QYcn37QqAaDeSMW+7NGjc==iFKZQQ@mail.gmail.com>
References: <CAPzO=NydFKroZ5_+_3NK1QYcn37QqAaDeSMW+7NGjc==iFKZQQ@mail.gmail.com>
Date: Wed, 3 Oct 2012 21:32:54 +0200
Message-ID: <CAPzO=NyRtCSZ6LnbW2fMmt0ZwAft=v5kwar5gejFmwbJzvXq6w@mail.gmail.com>
Subject: Re: run_init change in latest policycoreutils
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Sep 30, 2012 at 7:48 PM, Sven Vermeulen
<sven.vermeulen@siphos.be> wrote:
> --- policycoreutils-2.1.10/run_init/run_init.c  2011-12-21
> 18:46:04.000000000 +0100
> +++ policycoreutils-2.1.13.pristine/run_init/run_init.c 2012-09-29
> 11:08:41.267304041 +0200
> @@ -406,6 +406,13 @@
>                         new_context);
>                 exit(-1);
>         }
> +       if (! access("/usr/sbin/open_init_pty", X_OK)) {
> +               if (execvp(argv[1], argv + 1)) {
> +                       perror("execvp");
> +                       exit(-1);
> +               }
> +               return 0;
> +       }

Shouldn't this be "if(access(...))" instead of "if(! access(...))"?

After all, if the access is ok (returns 0), then with the current
patch the embraced code is executed, which doesn't use open_init_pty.
And if access isn't ok, then it uses open_init_pty (which will fail,
since the access is not ok)...

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
