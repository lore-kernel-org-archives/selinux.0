From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: A filename to label translation daemon
Date: Wed, 15 Aug 2012 08:34:51 +1000
Cc: Eric Paris <eparis@parisplace.org>, Colin Walters <walters@verbum.org>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov
References: <1344454290.25533.12.camel@localhost> <CACLa4ptRM3FcqanoagF=xUsvFZ1Ct9kEZW2uyiB7ECGK+zL0fg@mail.gmail.com> <1344962917.5588.61.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1344962917.5588.61.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201208150834.52281.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 15 Aug 2012, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> You should check that setfiles using glibc regex followed by setfiles
> using PCRE does not change anything on the filesystem, i.e. run the
> existing setfiles on all filesystems, then run the setfiles using PCRE
> with -nv to report any changes that would be made without applying them.

Of course that test would only really work for files that exist on the current 
filesystem.  But that should be a good enough approximation to be useful.

In terms of breakage in Debian, I'm not too bothered about that.  Before every 
release we need to do a lot of testing anyway.  The changes in this regard 
will be a lot less likely to break things than the regular churn of policy and 
daemon changes.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
