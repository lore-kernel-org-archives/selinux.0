Subject: Re: concept of a permissive domain
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Eric Paris <eparis@parisplace.org>
Cc: Joshua Brindle <jbrindle@tresys.com>, Daniel J Walsh <dwalsh@redhat.com>,
        Chad Sellers <csellers@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <7e0fb38c0710121107h5cf3ed66l7725c794150bb821@mail.gmail.com>
References: <C315C13B.2C502%csellers@tresys.com>
	 <46F11C6C.4070306@redhat.com> <470F7BC0.4030003@redhat.com>
	 <470FB394.8000106@tresys.com>
	 <7e0fb38c0710121107h5cf3ed66l7725c794150bb821@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 12 Oct 2007 15:03:08 -0400
Message-Id: <1192215788.3294.38.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-10-12 at 14:07 -0400, Eric Paris wrote:
> On 10/12/07, Joshua Brindle <jbrindle@tresys.com> wrote:
> 
> > I don't like this one either. I'd rather do what we were thinking about
> > with selinuxfs where we have /selinux/types/foo_domain_t have a bitmap
> > of properties, one of them being permissive.
> 
> I still don't agree.  From the point of view of analysis a permissive
> domain and an unconfined domain are the same thing.  Thus this should
> be a part of the policy the same way unconfined domains are.
> 
> I also still disagree that the policy administrator and the
> application administrator are the same person or will have the ability
> to reasonably work together in such a close manner as to make the
> selinuxfs permissive domain implementation acceptable.  The guy who
> adds a new policy module might not be able to control enough of the
> system/application to echo 1 > /selinux/blah/blah/blah/enforcing every
> time the application is started.  Nor do we necessarily want to put
> the permissions to make an application permissive in the domains
> associated with the application itself.  aka I sure as heck don't want
> httpd_t to be allowed to make itself permissive and at the same time I
> personally don't think that the httpd init script is the right place
> either since I'd rather not give initrc_t permission to make anything
> permissive.  (ok I think initrc_t is still and unconfined domain, but
> I don't like it)

So I agree - I _really_ don't understand why we say some selinux
configuration is part of the policy and some is not. It is just
confusing and requires that we built more infrastructure.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
