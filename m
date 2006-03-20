Subject: Re: Changes to policycoreutils.
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: russell@coker.com.au
Cc: Daniel J Walsh <dwalsh@redhat.com>, James Morris <jmorris@namei.org>,
        Valdis.Kletnieks@vt.edu, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200603210727.47903.russell@coker.com.au>
References: <441B2C7B.7050307@redhat.com> <441EC183.6000404@redhat.com>
	 <1142869863.16487.57.camel@moss-spartans.epoch.ncsc.mil>
	 <200603210727.47903.russell@coker.com.au>
Content-Type: text/plain
Date: Mon, 20 Mar 2006 15:47:15 -0500
Message-Id: <1142887635.16487.205.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-03-21 at 07:27 +1100, Russell Coker wrote:
> On Tuesday 21 March 2006 02:51, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > There are
> > also recently added new syscalls to help reduce races in walking the
> > file tree (i.e. openat and friends) - possibly there should be some for
> > lsetxattr as well so that lsetfileconat() could be implemented?
> 
> Yes, I think a lsetxattrat() syscall is necessary, and I agree that we need 
> better code to deal with race conditions in the library.
> 
> Incidentally it's the first time I've heard of coreutils being cited as a good 
> example in this regard.

Not saying that they necessarily have it right, but they have dealt with
a number of security bug reports over time in this space (particularly
for rm -rf behavior), so it wouldn't hurt to look at their approach.
Likewise for findutils.  Unfortunately, they each seem to have their own
specialized logic.  Converting setfiles and restorecon over to using
fts(3) ala the parallel setfmac utility in FreeBSD might help.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
