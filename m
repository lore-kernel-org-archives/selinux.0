Subject: RE: Restorecon script
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>,
   Ivan Gyurdiev <gyurdiev@redhat.com>, "'Daniel J Walsh'" <dwalsh@redhat.com>,
   "'SELinux'" <selinux@tycho.nsa.gov>, selinux-dev@tresys.com
In-Reply-To: <200506101806.j5AI635F009168@gotham.columbia.tresys.com>
References: <200506101806.j5AI635F009168@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 14:04:43 -0400
Message-Id: <1118426683.3774.159.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-10 at 14:06 -0400, Karl MacMillan wrote:
> Or only giving the read access I assume. So we are not trying to protect from
> malicious code running in the user's domain disclosing data by relabeling to
> httpd_user_content_t, for example?

Not presently, no. 

>  If that is the case the user domain is
> trusted to manage these files at their discretion. One point I was trying to
> make is that this probably has to be the case as removing relabel permission
> from the user domain has no impact.

Right, malicious code could just create/write to httpd_user_content_t;
it doesn't need relabel permission. Only way to avoid that is to
restrict all creation of web content through a controlled app that
confirms user intent, but at that point, you are unlikely to be using
~/public_html at all in your web setup.

> Relabeling on every login still seems excessive and based on what this policy is
> trying to accomplish perhaps not a good idea. If the files are under the user's
> control then they should be fully under their control. What if I am waiting to
> relabel my ~/public_html until I am done with the content and this administrator
> controlled script does it for me?

IMHO, you shouldn't be putting it into ~/public_html until you are ready
for it to be exported; that doesn't seem to be different from current
usage.

A larger concern might be that you don't want the restorecon to clobber
local customization, e.g. to distinguish read-only content under
~/public_html from content that can be modified by a user CGI.  I think
that the customizable types support would actually prevent that, as
restorecon won't touch those types by default.

One advantage of relabeling on login (similar to relabeling from
rc.sysinit that is presently done for certain files) is that it helps
counter type lossage that may occur over time due to direct user
manipulation (e.g. moving aside your public_html and dropping in a new
tree, but failing to restorecon it manually) or under targeted policy.
Obviously it is better to proactively preserve the types in the first
place, but we aren't there yet.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
