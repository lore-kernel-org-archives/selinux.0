Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jA4F6VMA026895
	for <selinux@tycho.nsa.gov>; Fri, 4 Nov 2005 10:06:31 -0500 (EST)
Subject: Re: [ SELINUX ] [ POLICYCOREUTILS ] Convert setsebool -P to use
	libsemanage
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>,
   Karl MacMillan <kmacmillan@tresys.com>, Frank Mayer <mayerf@tresys.com>,
   chris pebenito <cpebenito@tresys.com>, Daniel J Walsh <dwalsh@redhat.com>,
   James Morris <jmorris@redhat.com>, Chad Sellers <csellers@tresys.com>
In-Reply-To: <436AF7BC.5000705@cornell.edu>
References: <436915FB.3040500@tresys.com>
	 <1131027033.23420.30.camel@moss-spartans.epoch.ncsc.mil>
	 <436A86E6.4040205@cornell.edu>  <436AF7BC.5000705@cornell.edu>
Content-Type: text/plain
Date: Fri, 04 Nov 2005 09:57:12 -0500
Message-Id: <1131116232.23420.245.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-11-04 at 00:55 -0500, Ivan Gyurdiev wrote:
> - separate code paths for error and success (don't like fallthrough - 
> error-prone)

On this point, please see "Chapter 6:  Centralized exiting of functions"
in Documentation/CodingStyle in the kernel tree.  Note that in splitting
the code paths, it looks like you have introduced a memory leak, as you
no longer free the vallist on the success path?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
