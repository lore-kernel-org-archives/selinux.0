Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n55HOpDo004685
	for <selinux@tycho.nsa.gov>; Fri, 5 Jun 2009 13:24:51 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n55HP9dA015319
	for <selinux@tycho.nsa.gov>; Fri, 5 Jun 2009 17:25:10 GMT
Subject: Re: SELinux context patch
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Caleb Case <ccase@tresys.com>
Cc: Chad Sellers <csellers@tresys.com>, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>,
        Joshua Brindle <method@manicmethod.com>
In-Reply-To: <1244221933.27717.1902.camel@gorn.columbia.tresys.com>
References: <4A11A5EC.9000904@redhat.com>
	 <C639A340.A73BA%csellers@tresys.com>
	 <150846cc0906041213n79e5e51ex3c72ab2cacb0ce64@mail.gmail.com>
	 <1244221933.27717.1902.camel@gorn.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 05 Jun 2009 13:24:18 -0400
Message-Id: <1244222658.27717.1908.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-06-05 at 13:12 -0400, Christopher J. PeBenito wrote:
> On Thu, 2009-06-04 at 15:13 -0400, Caleb Case wrote:
> > On Wed, May 20, 2009 at 12:08 PM, Chad Sellers <csellers@tresys.com> wrote:
> > > On 5/18/09 2:16 PM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:
> > >
> > >> This patch adds context files for virtual_domain and virtual_image,
> > >> these are both being used to locat the default context to be executed by
> > >> svirt.
> > >>
> > >> I also included the subs patch which I submitted before.  This patch
> > >> allows us to substitute prefixes to matchpathcon.
> > >>
> > >> So we can say /export/home == /home
> > >>
> > >> and
> > >>
> > >> /web == /var/www
> > >
> > > I'm surprised that the subs patch didn't get much discussion before. Any
> > > thoughts on this? Any worries that it might not meld well with the work
> > > currently being done to integrate FCGlob?
> > >
> > > Thanks,
> > > Chad
> > >
> > 
> > I don't think it will adversely affect FCGlob integration.
> > 
> > It is going to make it harder to understand what a file will get labeled though.
> > 
> > Might be useful for genhomedircon to generate a .subs file and for
> > refpolicy to provide labeling on a selinux user basis for home
> > directories:
> > 
> > /root
> > /home/unconfined_u
> > /home/sysadm_u
> > ...
> > 
> > with a .subs:
> > 
> > /home/bob /home/unconfined_u
> > /home/sally /home/sysadm_u
> > ...
> 
> Substituting the entire home dir root, like Dan's example /export/home
> == /home above, makes sense to me.  However, I do not like the idea of
> adding dummy file context entries to the policy like the above example
> (/home/unconfined_u and /home/sysadm_u) to make substitution usable for
> creating file contexts for individual home dirs.

The purpose of genhomedircon is to create these types of entries.  I
don't think we want file contexts in the policy that aren't actually
intended to be used.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
