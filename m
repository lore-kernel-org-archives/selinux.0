From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: James Antill <james.antill@redhat.com>
Subject: Re: [PATCH -v2] SELinux: create new open permission
Date: Fri, 29 Feb 2008 23:37:24 +1100
Cc: Eric Paris <eparis@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux <selinux@tycho.nsa.gov>, sds@tycho.nsa.gov, jmorris@namei.org,
        Paul Moore <paul.moore@hp.com>
References: <1204221520.3206.86.camel@localhost.localdomain> <1204225233.3206.120.camel@localhost.localdomain> <1204230728.11268.261.camel@code.and.org>
In-Reply-To: <1204230728.11268.261.camel@code.and.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200802292337.29243.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 29 February 2008 07:32, James Antill <james.antill@redhat.com> 
wrote:
> > > What does open on a dir mean?  Isn't that the same as the read perm?
> >
> > Admittedly there is very little distinction and I don't know the
> > usefulness, but it is possible for a process to pass an open fd to a
> > directory so I saw little reason to exclude it.
>
>  Also we have the *at() and fchdir() calls, so this distinction (between
> open and read on dirs) is useful.

This new open permission is being created specifically to allow file handles 
to be inherited across exec.

Inheriting a directory file handle for the purpose of fchdir() seems quite 
unlikely.  In fact when fchdir() is mentioned in mailing list discussions it 
always seems to be in the context of allowing a process to break out of a 
chroot() jail.

Does anyone have a hypothetical example of how fchdir() could be used in a way 
which doesn't break the security of a system but yet need to have open and 
read access be differentiated?

As an aside, I'm concerned about the implications of this new file open 
permission for overall quality of SE Linux policy (both reference policy and 
custom policy).  I anticipate many people writing policy that allows read and 
write access wildly with the idea that controls on open will prevent them 
being exploited.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
