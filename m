Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6HIanpX017266
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 14:36:49 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6HIalFN027793
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 18:36:47 GMT
Subject: Re: [POLICYREP] [PATCH 1/1] policyrep role implementation
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <469D0522.2010106@tresys.com>
References: <20070717172210.256077142@manicmethod.com>
	 <20070717172318.422721428@manicmethod.com>  <469D0522.2010106@tresys.com>
Content-Type: text/plain
Date: Tue, 17 Jul 2007 14:36:45 -0400
Message-Id: <1184697405.3833.30.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-07-17 at 14:06 -0400, Joshua Brindle wrote:
> Joshua Brindle wrote:
> 
> > --- policyrep-roles.orig/libpolicyrep/tests/libpolicyrep-test.cpp
> > +++ policyrep-roles/libpolicyrep/tests/libpolicyrep-test.cpp
> > @@ -39,7 +39,11 @@ void test()
> >          t->attributes().insert("userdomain");
> >          
> >          mod->append_child(t);
> > -        
> > +
> > +	RolePtr r(new Role("foo"));
> > +	r->types().insert("foo");
> > +	mod->append_child(r);       
> > + 
> >  	std::cout << "============ basic test ============" << std::endl;
> >          output_tree(std::cout, pol);
> >          
> 
> One thing I'd like to note, while this simple testing mechanism is 
> working for now as we add more policy components and do more complex 
> things we are going to need something more sophisticated. Should we move 
> to cppunit or boost testing? We are already using boost so it might be 
> worthwhile to use their test suite (though I've never used it so I can't 
> vouch for it.) <http://www.boost.org/libs/test/doc/index.html>
> 

Fine by me - we can at least try it and go for something else if needed.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
