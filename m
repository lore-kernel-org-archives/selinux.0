From: lonnie@outstep.com
To: SELinux Mailing <SELinux@tycho.nsa.gov>
Subject: Re: setting up new test user domain?
Message-ID: <1008698374.3c1f8406aded5@mail.outstep.com>
Date: Tue, 18 Dec 2001 12:59:34 -0500 (EST)
References: <Pine.GSO.4.33.0112181247180.4844-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0112181247180.4844-100000@raven>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Since I would like to modify the original files as little a possible then it 
sounds to me like Option 1 would be be the best direction and I can usr the 
user_t (user.te) as a template for this new user domain.

Now then, after making the new domain, should I presume that I can simply use 
the standard "adduser" to put a user in that domain, and also use the 
standard "chown" to change the ownership of files to belong to the new domain?

Cheers,
Lonnie

Quoting Stephen Smalley <sds@tislabs.com>:

> 
> On Tue, 18 Dec 2001 lonnie@outstep.com wrote:
> 
> > Instead of modifying the user.te and every.te for our project, I think
> that it
> > might be better if I simple create a new test domain and place a
> "test" user in
> > that domain.
> 
> The rules in every.te are applied to every domain (or, to be more
> specific, to every type with the "domain" type attribute).  So if you
> create a test domain, these rules will also be applied to it unless
> you
> either 1) omit the "domain" type attribute from its declaration or 2)
> change every.te to exclude your test domain.
> 
> Option #1 will violate one of the assertions in the example policy, so
> you
> will have to remove that assertion from assert.te if you follow that
> route.  It will also require some additional rules for your test
> domain
> that are normally automatically picked up using the "domain"
> attribute,
> e.g. allowing init and the system administrator to kill the domain.
> 
> Option #2 requires you to edit every.te, but allows you to leave the
> assertions alone and lets you pick up the other rules automatically.
> If you name your new domain "testdomain", then you can do something
> like:
> 	sed "s/domain/~testdomain/g" every.te > newevery.te
> 	mv newevery.te every.te
> to create an every.te file that excludes your test domain.
> 
> > Would this be correct? If so then couls someone please help me to
> figure out
> > how to set up a simple domain from which to begin this process?
> 
> There are plenty of examples of domains in the current policy; use one
> of
> them as a starting point.  The most obvious one is the user_t domain
> that
> is currently used for ordinary users.  This is defined in
> domains/user/user.te.
> 
> --
> Stephen D. Smalley, NAI Labs
> ssmalley@nai.com
> 
> 
> 

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
