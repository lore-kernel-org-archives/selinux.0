From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: Summary of Informal SELinux Meeting on May 6, 2004
Date: Fri, 4 Jun 2004 18:03:23 +1000
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   "'SELinux'" <SELinux@tycho.nsa.gov>,
   "'Fedora SELinux support list for users & developers.'" <fedora-selinux-list@redhat.com>
References: <200406022032.i52KWuSf003348@gotham.columbia.tresys.com> <20040603195738.GE3856@lkcl.net>
In-Reply-To: <20040603195738.GE3856@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406041803.23026.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 4 Jun 2004 05:57, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
>  all in the same single monolithic daemon that bound itself
>  to several different ports and several different unix domain
>  sockets, you wouldn't seriously consider saying that "this
>  hybrid is a trusted application" would you?

"trusted" in this context does not mean "the code is great and we can totally 
trust it", but rather "due to the design of the system we have no choice but 
to trust it as it can totally break the security if it has a problem".

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
