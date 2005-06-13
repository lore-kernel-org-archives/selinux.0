Date: Mon, 13 Jun 2005 11:01:58 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Question about integration of IPsec with SELinux?
Message-ID: <20050613100158.GA6610@lkcl.net>
References: <200506121918.j5CJIhlt021805@turing-police.cc.vt.edu> <20050612233233.18232.qmail@web31610.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050612233233.18232.qmail@web31610.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Jun 12, 2005 at 04:32:33PM -0700, Casey Schaufler wrote:
> 
> --- Valdis.Kletnieks@vt.edu wrote:
> 
> 
> > You'll want *some* way of managing the allocation of
> > contexts cluster-wide,
> > just so you don't have two usages of jdoe_u that
> > refer to two different users..
> 
> You will do well to consider the implications
> of allowing anything other than identical policies
> within a cluster or even a grid. 

 okay.

 simplistic view: in nt-land, you have local workstations
 'policy' and you have a global 'policy'.



 the local workstations' policies are typically set up to
 allow a local admin to log in to the machine, etc. using the
 local SAM database (and you select the workstation domain /
 local SAM by selecting the workstation's name on the login
 dialog box to do that).

 what you DO NOT DO is add any permissions into the local SAM database
 for any local users to be able to access any of the domain resources.

 in this way you have a scheme whereby the workstation is still
 to some extent useable / recoverable even when disconnected
 (isolated) from the domain.

 do you _really_ want a domain-wide policy that specifies
 "only the domain admin has the manage the network interfaces"?

 because what happens if there _is_ no network by which you can access
 or validate the domain policy such that you can trouble-shoot the
 network interface?

 !!!

 
 even though it's access-control based, there is much to be
 learned from the application of microsoft's nt domain protocol.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
