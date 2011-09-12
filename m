Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8CLSS9G020486
	for <selinux@tycho.nsa.gov>; Mon, 12 Sep 2011 17:28:28 -0400
Received: from cp-out9.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8CLSQsA007260
	for <selinux@tycho.nsa.gov>; Mon, 12 Sep 2011 21:28:27 GMT
Subject: Re: policycoreutils manpages needed
From: Guido Trentalancia <guido@trentalancia.com>
To: Eric Paris <eparis@parisplace.org>
Cc: Daniel J Walsh <dwalsh@redhat.com>, russell@coker.com.au,
        SE-Linux
	 <selinux@tycho.nsa.gov>
Date: Mon, 12 Sep 2011 23:28:04 +0200
In-Reply-To: <CACLa4ptfSU3obZ8OyMVFfKDsqwLQn58-O9YRUbCyU8=mLzn=tA@mail.gmail.com>
References: <201109011509.05872.russell@coker.com.au>
	 <4E5F8BAA.6060208@redhat.com> <1314912106.2334.2.camel@vortex>
	 <CACLa4ptfSU3obZ8OyMVFfKDsqwLQn58-O9YRUbCyU8=mLzn=tA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1315862884.2223.33.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Eric !

On Thu, 2011-09-01 at 21:52 -0400, Eric Paris wrote:
> On Thu, Sep 1, 2011 at 5:21 PM, Guido Trentalancia
> <guido@trentalancia.com> wrote:
> > On Thu, 2011-09-01 at 09:42 -0400, Daniel J Walsh wrote:
> >> On 09/01/2011 01:09 AM, Russell Coker wrote:
> >> > Has anyone written manpages for genhomedircon, sepolgen-ifgen, and
> >> > seunshare? If not is there someone with some spare time and man
> >> > page writing skill?
> >> >
> >> We have man pages for genhomedircon and seunshare.  Although the
> >> genhomedircon man page is rather sparse.
> >
> > If help is needed for manual pages, I can have a look and spare some
> > time. I can start with genhomedircon as suggested by Dan unless other
> > ideas are brought forward...
> 
> Just make sure you look at the 'queue' branch of the upstream repo
> rather than the 'master' branch.  I'm pretty sure some of the man
> pages Dan mentioned only exist in the queue branch.

Apparently, there isn't a massive difference for the manual pages
between the master and the queue branches.

In particular there are no new manual pages being introduced in the
queue branch (although there are some modifications to existing pages
mainly due to modifications in the tools).

I would like to take this opportunity to suggest that we create manual
pages for configuration files where possible (none available at the
moment ?!?).

For example, the very first one I would like to have is
semanage.conf.5. 

Then we could also create restorecond.conf.5 and restorecond_user.conf.5
(both of them should be trivial).

There might be very slight improvements possible for the seunshare
manual page. The manual pages for sepolgen* are missing and therefore
will need to be created from scratch. The manual page for sandbox.8
could be improved by mentioning that a configuration file exists in
$(DESTDIR)/etc/sysconfig/sandbox (along with a manual page
sandbox.conf.5).

That said, I am now going to start creating semanage.conf.5...

Regards,

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
