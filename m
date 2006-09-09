From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] newrole: use pam session management services - v4
Date: Sat, 9 Sep 2006 11:01:06 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>, janak@us.ibm.com,
        sgrubb@redhat.com, tmraz@redhat.com, ltcgcw@us.ibm.com,
        klaus@atsec.com, selinux@tycho.nsa.gov
References: <1157403682.7223.16.camel@localhost.localdomain> <4501A841.4060006@redhat.com> <1157740847.31695.207.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1157740847.31695.207.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200609091101.13457.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 09 September 2006 04:40, Stephen Smalley <sds@tycho.nsa.gov> 
wrote:
> Part of the confusion here is what you plan to put in vanilla
> Fedora/RHEL versus the LSPP certified configuration.  I assume you want
> a single newrole binary that can handle either case (which means it has
> to be setuid root, and include the capability manipulation code and
> pam_open_session call).  Do you plan to include pam_namespace in the pam
> config always, or only in the LSPP certified configuration?

pam_namespace will provide great benefits for many people who can't use the 
MLS policy, even on targetted systems it can do a lot of good (in some ways 
it can do more good on targetted systems than on strict or MLS).

Why not have a separate package for the newrole program which has 
selinux-policy-strict and selinux-policy-mls depend on it?  Then people who 
only use the targetted policy (most users) will not have newrole installed.

Another thing to consider is to have a type nonexec_t in the targeted policy 
assigned to the newrole program with an assertion that the type in question 
can never be executed.  Then the only case you have to worry about is running 
newrole on a system with SE Linux disabled.

-- 
http://etbe.blogspot.com/          My Blog
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
