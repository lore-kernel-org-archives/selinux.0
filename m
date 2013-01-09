Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r09EUtOp006088
	for <selinux@tycho.nsa.gov>; Wed, 9 Jan 2013 09:30:55 -0500
Received: by mail-la0-f44.google.com with SMTP id fr10so1938413lab.17
        for <selinux@tycho.nsa.gov>; Wed, 09 Jan 2013 06:30:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <50ED5C8E.4040202@redhat.com>
References: <50EC1D32.3090607@redhat.com>
	<50EC31AE.5040807@tycho.nsa.gov>
	<50ED5C8E.4040202@redhat.com>
Date: Wed, 9 Jan 2013 09:30:22 -0500
Message-ID: <CACLa4pvjb4Y_AMcuTv_6Aoa=2QUhsWiZT6iknOHG3B6EQe2yTw@mail.gmail.com>
Subject: Re: setfscreatecon optimizations
From: Eric Paris <eparis@parisplace.org>
To: Ondrej Oprala <ooprala@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jan 9, 2013 at 7:03 AM, Ondrej Oprala <ooprala@redhat.com> wrote:
> Thank you for the pointers, it helped me out a lot. I tested the patched
> libselinux with
> $cp -a dir1 dir2
> and got an approx. 20% save in instruction count. The patch is attached.
> Thanks,

Thanks!  I'm working on it right now.  You did the:
        __selinux_once(once, init_procattr);
        init_thread_destructor();
Before variable declaration and you do not handle context==NULL, which
is how you clear the value.  I'll fix both of those up and apply to
the devel tree.  Thanks so much!

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
