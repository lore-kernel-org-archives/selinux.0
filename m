From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>, lky <lky77@sjtu.edu.cn>
Subject: Re: question about su and passwd
Date: Tue, 28 Oct 2003 02:01:03 +1100
Cc: SELINUX <SELinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
References: <001401c39a74$ac06b370$5d38a8c0@lky> <1067266352.18818.51.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1067266352.18818.51.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310280201.03376.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 28 Oct 2003 01:52, Stephen Smalley wrote:
> On Fri, 2003-10-24 at 17:20, lky wrote:
> > Hi, When I change the account with su I found the security context
> > didn't change( the 2 account have different contexts ). Should I use
> > aother command?
>
> Since 'su' is most frequently used simply to obtain privileges (aka
> capabilities) for administrative tasks by becoming the Linux superuser,
> it seems undesirable to also change the SELinux user identity, as

My interpretation of lky's message was that they wanted to change role/domain 
not SE Linux identity.  Although now you mention this, the original message 
was unclear.  Lky, please clarify what you desire.

I agree with Steve that changing the SE Linux identity is not desirable, IMHO 
the only supported way of changing identity should be to logout and login 
again.

> SELinux can represent such changes via role/domain changes while
> preserving user accountability.  newrole supports changing roles within
> a session, and domain transitions within a role can occur upon executing

If lky desires to change role as well as UID that still provides some issues.  
Changing UID via "su" and changing role via newrole require different 
passwords as they are checking different things.  Doing both in the same 
operation does not seem to be possible.

However doing this through sudo is possible as sudo already has configuration 
options for specifying which UID transitions are permitted and which 
passwords should be used.  I recall that someone (Dan?) posted a sudo patch 
to do this sort of thing.

There is only one case that I can think of where such things are really 
needed, that is for logging in to an account with a non-root UID and staff_r, 
and then wanting to change to UID==0 and sysadm_r.  Maybe a special-case 
program for this operation would be a better solution?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
