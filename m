From: lonnie@outstep.com
To: SELinux Mailing <SELinux@tycho.nsa.gov>
Subject: Re: setting up new test user domain?
Message-ID: <1008795695.3c21002f44f24@mail.outstep.com>
Date: Wed, 19 Dec 2001 16:01:35 -0500 (EST)
References: <Pine.GSO.4.33.0112191351410.5056-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0112191351410.5056-100000@raven>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi again,

I am trying to get through the documentation to get a better idea as to how and 
go about these things, but just a small question, ok.

If I do this on the original every.te

sed "s/domain/~be_domain/g" every.te > newevery.te
mv newevery.te every.te

Then in my new file "be_user.te"

I have replaced
"user_t" with "be_user_t" 
"define('user_domain'," with "define('be_domain',"
"user_domain(user)" with "be_domain(be_user)"
"type user_t domain userdomain" with "type be_user_t domain be_userdomain"

then when I go to the policy directory and do "make" I get the error unknown 
type 'be_domain'

could there be a problem in that it is looking for ~be_domain although I 
thought that"~" was for "not"

I'll work on getting more of the reading done as well.
cheers'
Lonnie

Quoting Stephen Smalley <sds@tislabs.com>:

> 
> On Wed, 19 Dec 2001 lonnie@outstep.com wrote:
> 
> > Actually I found out that I had to use the original unchanged every.te
> as well
> > as changing the be_domain back to domain in the be_user.te file.
> 
> No, that isn't right.  If you use the original every.te file and you
> keep
> the "domain" attribute on your new domain, then the rules in every.te
> will
> be applied to your new domain, which is more permissive than you want. 
> As
> I said originally, you must either change every.te to exclude your new
> domain or you must not use the "domain" attribute on your new domain. 
> The
> first option seems preferable (changing every.te).
> 
> Please make sure that you've read the available documentation
> regarding
> the policy before proceeding any further.  Randomly making changes
> without
> any understanding of what you are doing is unlikely to produce the
> desired
> result.
> 
> --
> Stephen D. Smalley, NAI Labs
> ssmalley@nai.com
> 
> 
> 
> 
> 

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
