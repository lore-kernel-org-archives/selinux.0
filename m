Subject: RE: dynamic context transitions
From: Karl MacMillan <kmacmillan@tresys.com>
To: Chad Hanson <chanson@TrustedCS.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Frank Mayer <mayerf@tresys.com>,
   Darrel Goeddel <DGoeddel@TrustedCS.com>,
   SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <36282A1733C57546BE392885C06185924D93DC@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C06185924D93DC@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Date: Wed, 03 Nov 2004 10:46:46 -0500
Message-Id: <1099496806.20150.9.camel@pham.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-11-03 at 10:36 -0500, Chad Hanson wrote:
> Stephen Smalley wrote:
> > 
> > >From the kernel POV, any code in the application has the potential to
> > execute with the maximum set of permissions granted to any domain in the
> > "domain transition group", or in reality, their union.  You may
> > carefully write your application to shed and gain permissions as needed,
> > but an exploit of a flaw in that application may indeed succeed in
> > getting code to execute in that process with that maximum set of
> > permissions.  Hence, the application still has to be "trusted" to
> > exercise that maximal set of permissions, and has a corresponding
> > assurance burden.  In contrast, if you decompose the application, the
> > kernel can ensure that only the specific code that should execute with
> > privilege does so, and the trust burden on the rest of the application
> > is greatly reduced.  See the difference?
> > 
> 
> I agree with this from an overall vulnerability POV. My point is that a
> dynamic  non-reversible transition can increase the security of an
> application by limiting it's permissions, including helpers that can be
> execed. Also, even though the vulnerability threat is always the maximum set
> of the current permissions, I don't agree that you necessary always want
> those permissions to be active, if you have a choice IMHO. This is just a
> difference of opinion between privilege bracketed code and exec level
> permissions. At the end of the day, I don't see how a privilege bracket
> mechanism can weaken the assurance of an application if we follow the
> approach that all domains in the "domain transition group" for an
> application are a subset of a high level domain which describes the maximal
> set of application permissions.


I think there are very important differences between the dynamic
transitions and the exec model and I read part of your message above as
arguing they are basically equivalent. Correct me if I am wrong. Despite
that, I basically agree with what you are saying. Additionally, I have
_not_ been trying to argue that dynamic context transitions weakens
assurance, just that it doesn't increase assurance (this is all in the
context of a single application - it may be that dynamic context
transitions have an effect of the overall assurance of the SELinux
mechanism). Again, there may be other reasons to do this, I just want to
make certain that this is considered in the correct context (no pun
intended about the correct context).

Karl

> -Chad
-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
