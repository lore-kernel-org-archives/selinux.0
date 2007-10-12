Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9CIERtO023237
	for <selinux@tycho.nsa.gov>; Fri, 12 Oct 2007 14:14:27 -0400
Received: from an-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l9CIEQr5011014
	for <selinux@tycho.nsa.gov>; Fri, 12 Oct 2007 18:14:26 GMT
Received: by an-out-0708.google.com with SMTP id c38so70468ana
        for <selinux@tycho.nsa.gov>; Fri, 12 Oct 2007 11:14:14 -0700 (PDT)
Message-ID: <7e0fb38c0710121107h5cf3ed66l7725c794150bb821@mail.gmail.com>
Date: Fri, 12 Oct 2007 14:07:19 -0400
From: "Eric Paris" <eparis@parisplace.org>
To: "Joshua Brindle" <jbrindle@tresys.com>
Subject: Re: concept of a permissive domain
Cc: "Daniel J Walsh" <dwalsh@redhat.com>, "Chad Sellers" <csellers@tresys.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Eric Paris" <eparis@redhat.com>,
        "Karl MacMillan" <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
In-Reply-To: <470FB394.8000106@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <C315C13B.2C502%csellers@tresys.com> <46F11C6C.4070306@redhat.com>
	 <470F7BC0.4030003@redhat.com> <470FB394.8000106@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/12/07, Joshua Brindle <jbrindle@tresys.com> wrote:

> I don't like this one either. I'd rather do what we were thinking about
> with selinuxfs where we have /selinux/types/foo_domain_t have a bitmap
> of properties, one of them being permissive.

I still don't agree.  From the point of view of analysis a permissive
domain and an unconfined domain are the same thing.  Thus this should
be a part of the policy the same way unconfined domains are.

I also still disagree that the policy administrator and the
application administrator are the same person or will have the ability
to reasonably work together in such a close manner as to make the
selinuxfs permissive domain implementation acceptable.  The guy who
adds a new policy module might not be able to control enough of the
system/application to echo 1 > /selinux/blah/blah/blah/enforcing every
time the application is started.  Nor do we necessarily want to put
the permissions to make an application permissive in the domains
associated with the application itself.  aka I sure as heck don't want
httpd_t to be allowed to make itself permissive and at the same time I
personally don't think that the httpd init script is the right place
either since I'd rather not give initrc_t permission to make anything
permissive.  (ok I think initrc_t is still and unconfined domain, but
I don't like it)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
