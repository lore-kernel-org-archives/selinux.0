Subject: RE: Restorecon script
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'Joshua Brindle'" <jbrindle@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, "'SELinux'" <selinux@tycho.nsa.gov>,
   selinux-dev@tresys.com
In-Reply-To: <200506101806.j5AI635F009168@gotham.columbia.tresys.com>
References: <200506101806.j5AI635F009168@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 14:21:01 -0400
Message-Id: <1118427661.3720.36.camel@dhcp83-8.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Or only giving the read access I assume. So we are not trying to protect from
> malicious code running in the user's domain disclosing data by relabeling to
> httpd_user_content_t, for example? 

Malicious code should not be running in the user_t domain.
the user_t domain is highly privileged, and we should try to keep
malicious code out of it. That's why most vulnerable applications
are being placed in restricted domains.

I don't think there's much we can do to protect from the user domain,
since it also represents the actual user, working from the terminal,
which must be allowed to do what he/she desires.

> If that is the case the user domain is
> trusted to manage these files at their discretion. One point I was trying to
> make is that this probably has to be the case as removing relabel permission
> from the user domain has no impact.

The user domain actually didn't have too many relabel privileges, until
I added them just now to our version of policy.

> Relabeling on every login still seems excessive and based on what this policy is
> trying to accomplish perhaps not a good idea.

Please note that *recursive* relabeling is only performed if
relabeling of a top level directory (in that list) fails. Therefore
it's not all that slow. Do you have an alternative proposal?

>  If the files are under the user's
> control then they should be fully under their control. 

The way to do that is by integrating ugly libselinux code into
a large number of applications. I think this will not be 
well received by the upstream developers at this time.

> What if I am waiting to
> relabel my ~/public_html until I am done with the content and this administrator
> controlled script does it for me?

The script is only invoked when you launch a login shell (this is
actually a problem). Also, it does not do anything with public_html.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
