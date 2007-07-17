Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6HI6qqa013707
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 14:06:52 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l6HI6nTM022796
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 18:06:49 GMT
Message-ID: <469D0522.2010106@tresys.com>
Date: Tue, 17 Jul 2007 14:06:26 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov, kmacmillan@mentalrootkit.com
Subject: Re: [POLICYREP] [PATCH 1/1] policyrep role implementation
References: <20070717172210.256077142@manicmethod.com> <20070717172318.422721428@manicmethod.com>
In-Reply-To: <20070717172318.422721428@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:

> --- policyrep-roles.orig/libpolicyrep/tests/libpolicyrep-test.cpp
> +++ policyrep-roles/libpolicyrep/tests/libpolicyrep-test.cpp
> @@ -39,7 +39,11 @@ void test()
>          t->attributes().insert("userdomain");
>          
>          mod->append_child(t);
> -        
> +
> +	RolePtr r(new Role("foo"));
> +	r->types().insert("foo");
> +	mod->append_child(r);       
> + 
>  	std::cout << "============ basic test ============" << std::endl;
>          output_tree(std::cout, pol);
>          

One thing I'd like to note, while this simple testing mechanism is 
working for now as we add more policy components and do more complex 
things we are going to need something more sophisticated. Should we move 
to cppunit or boost testing? We are already using boost so it might be 
worthwhile to use their test suite (though I've never used it so I can't 
vouch for it.) <http://www.boost.org/libs/test/doc/index.html>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
