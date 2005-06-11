Subject: RE: Restorecon script
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'Joshua Brindle'" <jbrindle@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, "'SELinux'" <selinux@tycho.nsa.gov>
In-Reply-To: <200506111745.j5BHjX5F009794@gotham.columbia.tresys.com>
References: <200506111745.j5BHjX5F009794@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Sat, 11 Jun 2005 14:35:28 -0400
Message-Id: <1118514928.5704.36.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> 
> I'm confused . . . you seem to be disagreeing by agreeing. 

That's exactly what I'm doing. 
You're arguing against giving ROLE_t the right to relabel certain
files. I say the battle is futile, and applications need to be moved
out of ROLE_t to achieve any kind of security. ROLE_t is just too 
broad an umbrella for grouping applications - I prefer to think of it
as a domain for apps without a policy yet.

Anyway, I agree that rpm would be better suited for creating
directories - mostly because of resource tracking per application,
and the login shell requirement....so I surrender the argument.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
