Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8GGFiSY028646
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2011 12:15:44 -0400
Received: from nm4-vm0.bt.bullet.mail.ird.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id p8GGFhSZ016292
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2011 16:15:43 GMT
Message-ID: <1316189741.28111.YahooMailClassic@web87008.mail.ird.yahoo.com>
Date: Fri, 16 Sep 2011 17:15:41 +0100 (BST)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: policycoreutils manpages needed
To: Guido Trentalancia <guido@trentalancia.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, russell@coker.com.au,
        SE-Linux <selinux@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>
In-Reply-To: <1316157987.2364.65.camel@vortex>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I produced an selinux config file man page + others in the following document:
http://taiga.selinuxproject.org/~rhaines/notebooks/Updated_libselinux_Man_Pages.pdf

If you think any of them are useful I'm happy to convert them to the man page format (currently in OpenDocument format).

Richard

PS
I've been tracking other config file formats as they change but never get around to publishing them, so if there are specific ones let me know and I'll see what I've got.


--- On Fri, 16/9/11, Guido Trentalancia <guido@trentalancia.com> wrote:

> From: Guido Trentalancia <guido@trentalancia.com>
> Subject: Re: policycoreutils manpages needed
> To: "Eric Paris" <eparis@parisplace.org>
> Cc: "Daniel J Walsh" <dwalsh@redhat.com>, russell@coker.com.au, "SE-Linux" <selinux@tycho.nsa.gov>
> Date: Friday, 16 September, 2011, 8:26
> On Mon, 2011-09-12 at 23:28 +0200,
> Guido Trentalancia wrote:
> > I would like to take this opportunity to suggest that
> we create manual
> > pages for configuration files where possible (none
> available at the
> > moment ?!?).
> 
> I would like to stress the above once again.
> 
> Further manual pages that I found missing and that would be
> nice to have
> in the future:
> 
> - global /etc/selinux/config (difficult to name, would that
> be very
> generically config.5) ?
> - /etc/sestatus.conf: why not ?
> - setrans.conf
> 
> > For example, the very first one I would like to have
> is
> > semanage.conf.5. 
> 
> By the way, an initial version of the above has been
> prepared.
> 
> > Then we could also create restorecond.conf.5 and
> restorecond_user.conf.5
> > (both of them should be trivial).
> 
> I shall perhaps starting doing the above next...
> 
> Regards,
> 
> Guido
> 
> 
> --
> This message was distributed to subscribers of the selinux
> mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the
> message.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
