From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Chad Sellers <csellers@tresys.com>
Subject: Re: MCS read only cats
Date: Thu, 12 Nov 2009 14:13:23 +1100
Cc: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>, SELinux@tycho.nsa.gov
References: <C72056E1.AFD7E%csellers@tresys.com>
In-Reply-To: <C72056E1.AFD7E%csellers@tresys.com>
MIME-Version: 1.0
Message-Id: <200911121413.31687.russell@coker.com.au>
Content-Type: text/plain;
  charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 12 Nov 2009, Chad Sellers <csellers@tresys.com> wrote:
> On 11/3/09 6:45 AM, "Michal Svoboda" <michal.svoboda@agents.felk.cvut.cz>
> > I have been thinking of how to best implement a feature called read only
> > categories. That is, if we have a file with say c2, then c2 folks would
> > have full access (given by TE rules), but also there would be a category
> > called r2 (or c512+2 = c514 or whatever), that would be given read only
> > access to the file.
>
> You probably didn't get any responses because no one has a good idea of how
> you could do this. The MLS engine (which is what powers MCS) was not
> designed to do what you have in mind.

Currently we don't support ranges on files, but we can change policy to allow 
it.  You could have something like the following:

mlsconstrain file { read }
        (( h1 dom l2 ) or ( t2 == domain ) or ( t1 == mlsfileread ));

mlsconstrain file { create relabelto }
        (( h1 dom h2 ) and ( l1 dom 12 ));

So (h1 dom h2) grants write access and (l1 dom l2) grants read access.


Now you could also implement that as (l1 dom l2) grants write access and (h1 
dom h2) grants read access if you wanted to control the release of 
information as opposed to controlling modification of system state.


But generally read-only files are implemented with new types.  I do that on 
the custom policy for my SE Linux Play Machine.

-- 
Russell Coker <russell@coker.com.au>
http://etbe.coker.com.au/          My Blog
http://etbe.coker.com.au/category/security/  My Security blog posts
http://www.coker.com.au/selinux/play.html  My Play Machine, root PW "SELINUX"


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
