Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p26I5Lle021400
	for <selinux@tycho.nsa.gov>; Sun, 6 Mar 2011 13:05:22 -0500
Received: from fep05-svc.tim.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p26I5JkM003553
	for <selinux@tycho.nsa.gov>; Sun, 6 Mar 2011 18:05:20 GMT
Subject: Re: [SELinux] Wildcard for object classes?
From: Guido Trentalancia <guido@trentalancia.com>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>, Simon Brandmair <sbrandmair@gmx.net>
In-Reply-To: <201103061032.21143.russell@coker.com.au>
References: <ii11vf$vns$02$1@news.t-online.com>
	 <201103061032.21143.russell@coker.com.au>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 06 Mar 2011 19:05:12 +0100
Message-ID: <1299434713.2971.6.camel@tesla.lan>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Simon and Russel !

On Sun, 06/03/2011 at 10.32 +1100, Russell Coker wrote:
> On Sat, 29 Jan 2011, Simon Brandmair <sbrandmair@gmx.net> wrote:
> > I just started looking into SELinux. I am wondering if there is a way to
> > have wildcards in avc rules like:
> > auditallow source_t target_t : * * ;
> > which audits all access from source_t to target_t.
> > 
> > Or do I have to add all classes objects to the rule like:
> > auditallow source_t target_t : {appletalk_socket, association,
> > blk_file ... } * ;
> 
> No, there isn't such a wildcard at this time (AFAIK).  It might be worth 
> adding one so I've moved this discussion to the SE Linux upstream mailing list 
> (please don't CC debian-security on future replies).

But perhaps you can define a set:

define(`all_the_stuff_i_need', `{ appletalk_socket association
blk_file ... }')

and then make use of it:

auditallow source_t target_t:all_the_stuff_i_need *;

Please double-check (what I told you but also the use of commas in the
list). The reference policy mailing list might also be a useful source
of information in this specific case.

Hope it helps.

Regards,

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
