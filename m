Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4RIoJgA014413
	for <selinux@tycho.nsa.gov>; Fri, 27 May 2005 14:50:19 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4RIj3rx029511
	for <selinux@tycho.nsa.gov>; Fri, 27 May 2005 18:45:03 GMT
Date: Fri, 27 May 2005 19:53:32 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux <selinux@tycho.nsa.gov>, selinux-dev@tresys.com
Subject: Re: [RFC] Module language syntax
Message-ID: <20050527185331.GA1544@lkcl.net>
References: <1117217853.9785.22.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1117217853.9785.22.camel@localhost>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, May 27, 2005 at 02:17:33PM -0400, Joshua Brindle wrote:

> installation. The production environment then does not need a build
> environment such as make, m4 and so on. The module tools will allow
> these modules to be "linked in" to the current policy. It's at this link
> time that both the modules dependencies and the optional dependencies
> are determined and optionals with fulfilled dependencies are enabled.
 
 i take it that booleans are ... just... added / supported, too?

 such that they are declared in the binary module, used in the binary
 module, added to the config files and can be set at runtime, yes/

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
