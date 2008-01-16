From: David Howells <dhowells@redhat.com>
In-Reply-To: <Xine.LNX.4.64.0801161156410.24959@us.intercode.com.au>
References: <Xine.LNX.4.64.0801161156410.24959@us.intercode.com.au> <20080115234652.22183.24850.stgit@warthog.procyon.org.uk>
To: James Morris <jmorris@namei.org>
Cc: dhowells@redhat.com, Stephen Smalley <sds@tycho.nsa.gov>,
        casey@schaufler-ca.com, Trond.Myklebust@netapp.com, npiggin@suse.de,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH 00/26] Permit filesystem local caching
Date: Wed, 16 Jan 2008 16:48:46 +0000
Message-ID: <30642.1200502126@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris <jmorris@namei.org> wrote:

> > The SELinux base code will also need updating to have the security class, lest
> > the following error appear in dmesg:
> > 
> > 	context_struct_compute_av:  unrecognized class 69
> 
> Alternately, what's needed is a newer policy which supports unknown 
> permission classes.  Any recent distro policy should have this.

I'm seeing this with an up to date Fedora 7 installation.  Do I need F8
instead?

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
