Subject: RE: type_datum changed from define_type() and type_write() ?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: HarryCiao <harrytaurus2002@hotmail.com>
Cc: selinux-mailing-list <selinux@tycho.nsa.gov>
In-Reply-To: <SNT139-w375D6067F67D328277FD37ABDA0@phx.gbl>
References: <SNT139-w158CDE61B212AC89099502ABDB0@phx.gbl>
	 ,<1298470521.13789.9.camel@moss-pluto>
	 <SNT139-w375D6067F67D328277FD37ABDA0@phx.gbl>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 24 Feb 2011 13:14:43 -0500
Message-ID: <1298571283.31953.52.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-02-24 at 10:13 +0000, HarryCiao wrote:
> > But with regard to your problem, understand that types (and other
> > symbols) are first assigned temporary values during module
> compilation,
> > then they are mapped to their final values during module
> > linking/expansion into a final policy. So whenever ! you add new
> state,
> > you have to preserve it and map it properly during the link/expand
> > stages.
> 
> I see, I am a complete checkpoliy/libsepol rookie, don't know much
> about that. No wonder the type_datum.s.value is different from lexing
> to the end.
> 
> Any reference or starting point I could make use of to understand the
> compile/link/expansion process for the refpolicy? I believe this would
> be a pretty interesting topic.

Pathetic that I have to link to a blog entry, but it is all I could find
other than the code itself:
http://securityblog.org/brindle/2006/07/05/selinux-policy-module-primer/

Somebody should copy that content into selinuxproject.org.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
