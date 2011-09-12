Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8CM3mam022108
	for <selinux@tycho.nsa.gov>; Mon, 12 Sep 2011 18:03:48 -0400
Received: from mail-gx0-f169.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8CM3lsA012048
	for <selinux@tycho.nsa.gov>; Mon, 12 Sep 2011 22:03:47 GMT
Received: by gxk3 with SMTP id 3so550356gxk.0
        for <selinux@tycho.nsa.gov>; Mon, 12 Sep 2011 15:03:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1315862884.2223.33.camel@vortex>
References: <201109011509.05872.russell@coker.com.au>
	<4E5F8BAA.6060208@redhat.com>
	<1314912106.2334.2.camel@vortex>
	<CACLa4ptfSU3obZ8OyMVFfKDsqwLQn58-O9YRUbCyU8=mLzn=tA@mail.gmail.com>
	<1315862884.2223.33.camel@vortex>
Date: Mon, 12 Sep 2011 18:03:47 -0400
Message-ID: <CACLa4psEgGzMazNY6f8bvm7bh1Wo7sg97wpAb5LzBRS8qK4nxA@mail.gmail.com>
Subject: Re: policycoreutils manpages needed
From: Eric Paris <eparis@parisplace.org>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, russell@coker.com.au,
        SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

That sounds great!  Thanks!

-Eric

On Mon, Sep 12, 2011 at 5:28 PM, Guido Trentalancia
<guido@trentalancia.com> wrote:

> I would like to take this opportunity to suggest that we create manual
> pages for configuration files where possible (none available at the
> moment ?!?).
>
> For example, the very first one I would like to have is
> semanage.conf.5.
>
> Then we could also create restorecond.conf.5 and restorecond_user.conf.5
> (both of them should be trivial).
>
> There might be very slight improvements possible for the seunshare
> manual page. The manual pages for sepolgen* are missing and therefore
> will need to be created from scratch. The manual page for sandbox.8
> could be improved by mentioning that a configuration file exists in
> $(DESTDIR)/etc/sysconfig/sandbox (along with a manual page
> sandbox.conf.5).
>
> That said, I am now going to start creating semanage.conf.5...
>
> Regards,
>
> Guido
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
