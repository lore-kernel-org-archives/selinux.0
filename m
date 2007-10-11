Subject: RE: Are the reference policy abstractions the right ones?
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: "Frank L. Mayer" <mayerf@tresys.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Steve Smalley <sds@epoch.ncsc.mil>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588F3C5@exchange.columbia.tresys.com>
References: <1191942521.2794.89.camel@moss-lions.epoch.ncsc.mil>
	 <6FE441CD9F0C0C479F2D88F959B01588F3C5@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 11 Oct 2007 16:26:24 -0400
Message-Id: <1192134384.21812.43.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-10-11 at 03:18 -0400, Frank L. Mayer wrote:
> > One of the goals of reference policy is to provide a more modern feel to
> > the policy by eliminating the use of types in a global manner across the
> > whole policy.  It does this by allowing interfaces to be defined through
> > which permissions can be granted to the types of a module.  There seems
> > to be several problems with this.
>  
> Probably the primary motivation for this and other refpol goals was to allow tool manipulation of source policies and the creation of development tools and higher-level/domain-specific languages. Chris can talk better about the challenges with the implementation  (such as the weakness of m4 as an implementation language), but perhaps our real failure is not creating better higher level abstractions/languages/tools upoon the re-structured "assembly" policy language. 
 
The difficulty with trying to build a higher-level language on top of
policy language is that, unlike a program that is being executed, there
is no locality in the policy.  When a problem occurs while a program is
executing, you can get a stack trace and see what functions were
executing.  When there is a denial in policy, all you know is that that
rule does not exist.  There is no way to say where that rule would have
been if it had existed.  This makes it very hard to abstract away that
lower level language.

> > 1) The user is constantly presented with types. 
>  
> Which is perhaps the problem for simplication of development/admin. All I know is that it was impossible to create any type of policy source tools/domain-specific languages when types were gloablly used throughout the sources. Not that I have any concrete suggestions how to improve the situation off hand ;)
>  
> Frank
> 
>  
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
