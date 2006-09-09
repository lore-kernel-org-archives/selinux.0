From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH] newrole: use pam session management services - v4
Date: Sat, 9 Sep 2006 10:56:56 +1000
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>, janak@us.ibm.com,
        sgrubb@redhat.com, tmraz@redhat.com, ltcgcw@us.ibm.com,
        klaus@atsec.com, selinux@tycho.nsa.gov
References: <1157403682.7223.16.camel@localhost.localdomain> <1157740847.31695.207.camel@moss-spartans.epoch.ncsc.mil> <4501BB5A.1060301@redhat.com>
In-Reply-To: <4501BB5A.1060301@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200609091057.03846.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 09 September 2006 04:50, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Why not have newrole not be setuid at all, but when you install the LSPP
> package is sets it setuid.  Then we can only call pam_session if we are
> setuid.  (I think you can check that.)
> If you want to use pam_namespace you need to setuid the app, for strict
> policy.

Yes, namespaces with strict policy is a desirable configuration, so having it 
depend on the LSPP package isn't going to solve all problems.

I guess you could have the strict policy package make it setuid.

-- 
http://etbe.blogspot.com/          My Blog
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
