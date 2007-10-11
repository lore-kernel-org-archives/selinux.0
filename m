MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Are the reference policy abstractions the right ones?
Date: Thu, 11 Oct 2007 03:18:53 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588F3C5@exchange.columbia.tresys.com>
References: <1191942521.2794.89.camel@moss-lions.epoch.ncsc.mil>
From: "Frank L. Mayer" <mayerf@tresys.com>
To: <jwcart2@tycho.nsa.gov>, "SELinux" <selinux@tycho.nsa.gov>
Cc: "Steve Smalley" <sds@epoch.ncsc.mil>,
        "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> One of the goals of reference policy is to provide a more modern feel to
> the policy by eliminating the use of types in a global manner across the
> whole policy.  It does this by allowing interfaces to be defined through
> which permissions can be granted to the types of a module.  There seems
> to be several problems with this.
 
Probably the primary motivation for this and other refpol goals was to allow tool manipulation of source policies and the creation of development tools and higher-level/domain-specific languages. Chris can talk better about the challenges with the implementation  (such as the weakness of m4 as an implementation language), but perhaps our real failure is not creating better higher level abstractions/languages/tools upoon the re-structured "assembly" policy language. 
 
> 1) The user is constantly presented with types. 
 
Which is perhaps the problem for simplication of development/admin. All I know is that it was impossible to create any type of policy source tools/domain-specific languages when types were gloablly used throughout the sources. Not that I have any concrete suggestions how to improve the situation off hand ;)
 
Frank

 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
