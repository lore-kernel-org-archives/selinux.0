Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9CEr6vm029620
	for <selinux@tycho.nsa.gov>; Thu, 12 Oct 2006 10:53:07 -0400
Received: from mail.atsec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9CEpmmj016826
	for <selinux@tycho.nsa.gov>; Thu, 12 Oct 2006 14:51:49 GMT
Date: Thu, 12 Oct 2006 09:48:19 -0500
From: Klaus Weidner <klaus@atsec.com>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov, redhat-lspp@redhat.com
Subject: Re: MLS enforcing PTYs, sshd, and newrole
Message-ID: <20061012144819.GF28520@w-m-p.com>
References: <20061012073338.GG28525@w-m-p.com> <200610122025.15043.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200610122025.15043.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Oct 12, 2006 at 08:25:12PM +1000, Russell Coker wrote:
> On Thursday 12 October 2006 17:33, Klaus Weidner <klaus@atsec.com> wrote:
> > If you need local console (or serial) login at different MLS levels for
> > the same user, you can create multiple Linux users for each human user
> > that share the same uid and home directory, and use "semanage login" to
> > map them to appropriate levels. So you'd have smith_secret_cat1,
> > smith_unclassified and so on.
> 
> That doesn't work well with password expiry policies.  Having 
> smith_secret_cat1 password expire at different times to smith_unclassified 
> would be a pain for users and sys-admins.
> 
> Then if you want to use RSA SecurID or similar tokens you have an extra level 
> of pain in mapping them to the right Unix account names.
> 
> I think that the right solution is to re-enable the code for selecting the 
> role etc at login time and adding some code for selecting the level.  It 
> should not be difficult to do this if there are no plans to ever support it 
> for ssh or X logins.

Good point, and I agree that the right long-term solution would be to
do context selection (via a PAM module?) at login time. 

I don't think that it's a significant issue though for current LSPP
configurations - any people who plan to use this please speak up if you
disagree.  The current LSPP configurations are for server systems, and
require that local consoles (including serial consoles listed in
/etc/securetty) are physically restricted to be accessible by admins
only, and admins can still use newrole. This leaves only non-admin serial
terminals, and I don't think those are that common these days.

Of course, people deploying a system that's based on the LSPP
configuration can choose to deviate from the evaluated configuration
based on their own risk assessment. This could include restoring general
access to "newrole" if they don't consider the PTY exploit to be a
concern.

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
