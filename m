From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Now that SELinux supports booleans should we replace tunables with booleans?
Date: Thu, 15 Apr 2004 15:28:46 +1000
Cc: Valdis.Kletnieks@vt.edu, SELinux <SELinux@tycho.nsa.gov>
References: <200404141315.i3EDFkJx015414@gotham.columbia.tresys.com> <200404141950.i3EJoFSM021953@turing-police.cc.vt.edu> <407DF398.4010405@redhat.com>
In-Reply-To: <407DF398.4010405@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200404151528.46754.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 15 Apr 2004 12:29, Daniel J Walsh <dwalsh@redhat.com> wrote:
> I would prefer not to use unused at all, but some macro version to
> indicate whether to include a te
> file or not.  Moving files around on the fly is not a great solution.

The problem is that in some cases there will be several rpms which may require 
a particular .te file.  One solution is to have a directory of .te files 
which can be copied in if any of the candidate rpms is installed.  Another is 
to have a small rpm contain the .te file in question and then have all the 
rpms that need that policy depend on the .te file.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
