From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Karl MacMillan" <kmacmillan@tresys.com>
Subject: Re: Now that SELinux supports booleans should we replace tunables with booleans?
Date: Wed, 14 Apr 2004 23:38:51 +1000
Cc: "'Daniel J Walsh'" <dwalsh@redhat.com>,
   "'SELinux'" <SELinux@tycho.nsa.gov>,
   "'Selinux Dev'" <selinux-dev@tresys.com>
References: <200404141310.i3EDAlJx015401@gotham.columbia.tresys.com>
In-Reply-To: <200404141310.i3EDAlJx015401@gotham.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200404142338.51788.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 14 Apr 2004 23:11, "Karl MacMillan" <kmacmillan@tresys.com> wrote:
> > For most items in tunable.te they won't be changed often or for small
> > reasons.
> > In some cases changing tunable.te will require application restart (or
> > system
> > reboot) to fully take affect.
>
> Why is a reboot required?

If we have a tunable option to determine which domain processes run in (such 
as single_userdomain) or a tunable that determines the identity that daemons 
get (such as direct_sysadm_daemon) then restarting processes is necessary.  
Some people find it difficult to do this successfully and find it easier to 
do a reboot.

> > The aim of booleans is for things that are designed to be transient (EG
> > secure
> > levels).
>
> I don't agree completely with this. Booleans allow well defined policy
> changes to be made by domains without policy compilation and reloading
> privileges. In order to use the tunables, a user/domain must have full
> access to change anything about the policy. With the booleans a user can be
> authorized to change a portion of the policy in a specific way without any
> other policy privileges. This seems like an important advantage to me.

The advantages of booleans are clear IMHO.  But they don't seem applicable to 
something that will be set at install time on a system that is capable of 
building a policy.  Maybe for an iPaQ booleans for tunable options would be 
good.  For a desktop or server they seem to offer less benefits.

Finally, for booleans both options have to be in the policydb and in the 
kernel at run-time.  For tunable.te they aren't, and can significantly reduce 
the policy size.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
