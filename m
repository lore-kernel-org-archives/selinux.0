Date: Wed, 19 Dec 2001 16:54:10 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: <lonnie@outstep.com>
cc: SELinux Mailing <SELinux@tycho.nsa.gov>
Subject: Re: setting up new test user domain?
In-Reply-To: <1008795695.3c21002f44f24@mail.outstep.com>
Message-ID: <Pine.GSO.4.33.0112191641430.5056-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 19 Dec 2001 lonnie@outstep.com wrote:

> If I do this on the original every.te
>
> sed "s/domain/~be_domain/g" every.te > newevery.te
> mv newevery.te every.te
>
> Then in my new file "be_user.te"
>
> I have replaced
> "user_t" with "be_user_t"
> "define('user_domain'," with "define('be_domain',"
> "user_domain(user)" with "be_domain(be_user)"
> "type user_t domain userdomain" with "type be_user_t domain be_userdomain"
>
> then when I go to the policy directory and do "make" I get the error unknown
> type 'be_domain'

In your every.te file, you are using the name of your macro
(be_domain) rather than the name of your domain (be_user_t).
Unfortunately, fixing that error won't actually help you, due
to a limitation in the current policy language/compiler.  I erred in
suggesting this approach; you should go back to not using the "domain"
type attribute with your new domain and leave every.te unmodified (but
remove the assertion from assert.te).  Sorry.

I doubt that many of the other subscribers to this list are interested in
this discussion any further, so you may want to take it off-list as a
courtesy.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
