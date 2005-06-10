Subject: RE: Restorecon script
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'Joshua Brindle'" <jbrindle@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, "'SELinux'" <selinux@tycho.nsa.gov>,
   selinux-dev@tresys.com
In-Reply-To: <200506101958.j5AJwc5F002311@gotham.columbia.tresys.com>
References: <200506101958.j5AJwc5F002311@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 16:45:36 -0400
Message-Id: <1118436336.4812.9.camel@dhcp83-8.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> All applications are vulnerable and malicious code will run in this domain at
> some point. This is about what happens when that eventually happens. I'm just
> clarifying what the goals of these changes are.

The way to fix that is to put the applications in a restricted domain,
not to make user_t that restricted domain, by refusing to grant the
user relabel rights to files that he/she should have access to.

> > Please note that *recursive* relabeling is only performed if
> > relabeling of a top level directory (in that list) fails. Therefore
> > it's not all that slow. Do you have an alternative proposal?
> > 
> 
> I'm not concerned about the performance. Relabeling always has risks and
> complicates analysis of security policies - I think it is best avoided except
> under special circumstances. This is really the point that started this whole
> thread - relabeling should be treated as a special case if at all possible.

The script was mostly concerned with creating things in the right
context to begin with. It would be easy to modify it to not relabel 
anything if it locates a folder that's in the wrong context, but 
I'm not sure whether that should be done - seems to me like
the wrong context should be fixed.

> The alternative is to do this at package installation time. This would allow,
> for example, for an admin to verify that it is safe to relabel and potentially
> take the system off line.

How exactly would this be done at installation time, in such a manner
as to account for existing users?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
