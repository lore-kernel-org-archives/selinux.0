From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Chris Grier <grier@uiuc.edu>
Subject: Re: policy questions and bugs
Date: Thu, 20 May 2004 07:04:57 +1000
Cc: Colin Walters <walters@verbum.org>, SELinux <SELinux@tycho.nsa.gov>
References: <20040515033020.GA5060@balder> <1084640772.10945.9.camel@nexus.verbum.private> <20040519200759.GA13982@balder>
In-Reply-To: <20040519200759.GA13982@balder>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405200704.57316.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 20 May 2004 06:07, Chris Grier <grier@uiuc.edu> wrote:
> > > Why do normal users have the option of changing to sysadm?
> >
> > That's a Red Hat addition to the policy.
>
> How do I make it go away? I thought it was a matter of removing the

Comment out the definition of user_canbe_sysadm in tunable.te (put "dnl" at 
the start of the line), then load the policy.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
