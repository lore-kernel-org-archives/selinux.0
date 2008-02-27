Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1RIQ9vC001951
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2008 13:26:09 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m1RIQ8KD022947
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2008 18:26:08 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: policycaps implementation in checkmodule
Date: Wed, 27 Feb 2008 13:25:45 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015880195CAE5@exchange.columbia.tresys.com>
In-Reply-To: <1204135942.3206.37.camel@localhost.localdomain>
References: <1204135942.3206.37.camel@localhost.localdomain>
From: "Todd Miller" <Tmiller@tresys.com>
To: "Eric Paris" <eparis@redhat.com>
Cc: "selinux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric Paris wrote:
> So I started playing with poliycaps today and it just isn't compiling.
> And lets start off by saying I haven't seen lex or yacc in years.  And
> could be so far off base here it is unbelievable.  Here is my module:
> 
> ****
> module capabilities 0.0.1;
> 
> policycap network_peer_controls;
> policycap open_perms;
> ****
> 
> First thing someone is going to say is that these only work in the
> base 
> module, which is all fine and good, I'm not talking about these
> actually 
> doing anything, I'm talking about these just getting through the
> compiler.  So don't bring that up yet out of the blue.  Here's what I
> get:

The compiler parses the base module differently from the other modules.

policy                  : base_policy
                        | module_policy
                        ;

Since the policycap directive is only valid in the base module you get
a syntax error when using them in a module.

There was a long discussion about policycaps in modules and why it
would be unsafe to allow them there.  The upshot of which was they
were restricted to base.  

 - todd


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
