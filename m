From: lonnie@outstep.com
To: SELinux Mailing <SELinux@tycho.nsa.gov>
Subject: Re: setting up new test user domain?
Message-ID: <1008786485.3c20dc3520535@mail.outstep.com>
Date: Wed, 19 Dec 2001 13:28:05 -0500 (EST)
References: <Pine.GSO.4.33.0112190955150.5056-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0112190955150.5056-100000@raven>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Actually I found out that I had to use the original unchanged every.te as well 
as changing the be_domain back to domain in the be_user.te file.

My next questions will then be on how to use this new domain and create a new 
user with it's attributes. After that is done then I will try to edit the 
be_user.te file and try to start turning off things until I can effectively 
keep the user in their directory.

Would this be a proper methodology for this task?

cheers,
Lonnie

Quoting Stephen Smalley <sds@tislabs.com>:

> 
> On Wed, 19 Dec 2001 lonnie@outstep.com wrote:
> 
> > I have made a copy of the user.te to be_user.te and have changes all
> instances
> > of "user" ti "be_user" and changed the "domain" to "be_domain"
> inside
> > be_user.te.
> 
> You should leave the "domain" type attribute unchanged.  Since you are
> changing every.te, you can leave this attribute unmodified.  You only
> need
> to modify the domain attribute if you aren't changing every.te.  As I
> mentioned earlier, if you change the attribute, you have to remove an
> assertion to avoid the error you are encountering.
> 
> > the problem that I am getting now is an assertion error:
> >
> > assertion fail: allow be_user_su_t be_user_t:process { transition }
> was granted
> >
> > could you please tell me what these assertion errors mean and, in
> general, how
> > to fix them?
> 
> In this case, you just need to restore the "domain" type attribute for
> your new domain.  This assertion is the first one in the assert.te
> file,
> and it verifies that every type that can be associated with a process
> is
> also tagged as a domain.
> 
> If you haven't already done so, you might want to read the Policy
> Configuration Language description from the first technical report
> skim the second technical report, and read the "Meeting Critical
> Security
> Objectives..." published paper available from
> http://www.nsa.gov/selinux/docs.html.  These reports and papers
> provide
> quite a bit of information, but it is admittedly difficult to get
> started.
> We plan on writing a new policy document that is better suited for
> people
> who want to customize their policy, define new roles, domains and/or
> types, or even create a new policy from scratch, but this will take
> some
> time.
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
