Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4RIwngA014477
	for <selinux@tycho.nsa.gov>; Fri, 27 May 2005 14:58:49 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4RIrFPP019068
	for <selinux@tycho.nsa.gov>; Fri, 27 May 2005 18:53:15 GMT
Subject: Re: [RFC] Module language syntax
From: Joshua Brindle <jbrindle@tresys.com>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: selinux <selinux@tycho.nsa.gov>, selinux-dev@tresys.com
In-Reply-To: <20050527185331.GA1544@lkcl.net>
References: <1117217853.9785.22.camel@localhost>
	 <20050527185331.GA1544@lkcl.net>
Content-Type: text/plain
Date: Fri, 27 May 2005 14:54:26 -0400
Message-Id: <1117220066.9783.27.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-05-27 at 19:53 +0100, Luke Kenneth Casson Leighton wrote:
> On Fri, May 27, 2005 at 02:17:33PM -0400, Joshua Brindle wrote:
> 
> > installation. The production environment then does not need a build
> > environment such as make, m4 and so on. The module tools will allow
> > these modules to be "linked in" to the current policy. It's at this link
> > time that both the modules dependencies and the optional dependencies
> > are determined and optionals with fulfilled dependencies are enabled.
>  
>  i take it that booleans are ... just... added / supported, too?
> 
>  such that they are declared in the binary module, used in the binary
>  module, added to the config files and can be set at runtime, yes/
> 
>  l.
> 

booleans and conditionals are runtime and are not at all affected by the
loadable modules. The optional dependencies added for modules are
totally separate from conditionals and are much closer to m4 ifdefs in
practice and could hopefully be used to replace many of them.

Joshua Brindle


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
