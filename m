From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: <mayerf@tresys.com>,
   "'Joshua D. Guttman disp: current'" <guttman@mitre.org>,
   "'Karl MacMillan'" <kmacmillan@tresys.com>
Subject: Re: Announce: SELinux conditional policy extensions
Date: Sat, 14 Feb 2004 14:51:07 +1100
Cc: "'SELinux List'" <SELinux@tycho.nsa.gov>,
   "'Stephen D. Smalley'" <sds@epoch.ncsc.mil>,
   "'Amy L. Herzog'" <aherzog@mitre.org>,
   "'John D. Ramsdell'" <ramsdell@mitre.org>,
   "'Galen B. Williamson'" <gwilliam@mitre.org>,
   "'Grant M. Wagner'" <gmw@tycho.ncsc.mil>, "'David Caplan'" <dac@tresys.com>
References: <000c01c3f265$9139f860$020d010a@columbia.tresys.com>
In-Reply-To: <000c01c3f265$9139f860$020d010a@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402141451.08044.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 14 Feb 2004 06:14, "Frank Mayer" <mayerf@tresys.com> wrote:
> 2) Because SE Linux introduced "pragmatic" mandatory security to the world,
> and it seems to be having success after our decades of failure of finding a
> means to introduce strong mandatory security to the "mainstream."  My
> observations to date are very few are concerned (rightly or wrongly) with
> rigorous policy analysis, and are more concerned with a practical mechanism
> to provide greater least privilege and system hardening.

Yes, this is an issue that can not be under-estimated.

Currently my work is tending towards providing less protection so that it is 
more acceptable to the majority of users.  My personal preference of the 
trade-off between security and usability is to have more security than most 
people will be prepared to accept.  But we have to do what's necessary to get 
the user-base.

When we get SE Linux in wide-spread use with a less restrictive policy it will 
be much easier for everyone who is interested in security.  Taking a system 
that's running SE Linux in a less restrictive manner and reconfiguring it to 
be more restrictive is easy, installing SE Linux on a server that has not run 
it before is much more difficult.

I would like to see at least 30% of university students who are enthusiastic 
about Linux using SE Linux!  Then in a few years time there will be a good 
user-base of people who know how SE Linux works and have a good general 
knowledge of security.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
