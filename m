From: lonnie@outstep.com
To: SELinux Mailing <SELinux@tycho.nsa.gov>
Subject: Re: setting up new test user domain?
Message-ID: <1008771630.3c20a22e1de4b@mail.outstep.com>
Date: Wed, 19 Dec 2001 09:20:30 -0500 (EST)
References: <Pine.GSO.4.33.0112181324340.4844-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0112181324340.4844-100000@raven>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi there,

I have made a copy of the user.te to be_user.te and have changes all instances 
of "user" ti "be_user" and changed the "domain" to "be_domain" inside 
be_user.te.

I have also added the be_user_r definition to the rbac file.

The las t thing that I have done was to "sed "s/domain/~be_domain/g" every.te > 
newevery.te and then copy it over.

the problem that I am getting now is an assertion error:

assertion fail: allow be_user_su_t be_user_t:process { transition } was granted

could you please tell me what these assertion errors mean and, in general, how 
to fix them?

Cheers,
Lonnie

Quoting Stephen Smalley <sds@tislabs.com>:

> 
> On Tue, 18 Dec 2001 lonnie@outstep.com wrote:
> 
> > Now then, after making the new domain, should I presume that I can
> simply use
> > the standard "adduser" to put a user in that domain, and also use
> the
> > standard "chown" to change the ownership of files to belong to the new
> domain?
> 
> No.  adduser hasn't been modified to be aware of SELinux, and chown
> only
> deals with the Linux user and group attributes.  You need to define an
> entry for the new user and his authorized roles in policy/users and an
> entry for the new role and its authorized domain(s) in policy/rbac. 
> To
> set the security context on the user's home directory, you can use the
> new 'chcon' program.
> 
> --
> Stephen D. Smalley, NAI Labs
> ssmalley@nai.com
> 
> 
> 
> 
> --
> You have received this message because you are subscribed to the selinux
> list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
> 

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
