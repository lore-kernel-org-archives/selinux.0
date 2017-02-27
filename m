Message-ID: <1488219577.19819.19.camel@tycho.nsa.gov>
Subject: Re: [PATCH] libsemanage: Perform access check using euid instead of
 uid
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Petr Lautrbach <plautrba@redhat.com>, Vit Mojzis <vmojzis@redhat.com>,
 selinux@tycho.nsa.gov
Date: Mon, 27 Feb 2017 13:19:37 -0500
In-Reply-To: <79b80f16-2d28-ab87-31e7-eaf052ed9d7a@redhat.com>
References: <20170214131448.22837-1-vmojzis@redhat.com>
 <1487085107.29417.4.camel@tycho.nsa.gov>
 <79b80f16-2d28-ab87-31e7-eaf052ed9d7a@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-02-22 at 16:47 +0100, Petr Lautrbach wrote:
> On 02/14/2017 04:11 PM, Stephen Smalley wrote:
> > 
> > On Tue, 2017-02-14 at 14:14 +0100, Vit Mojzis wrote:
> > > 
> > > Use faccessat() with AT_EACCESS instead of accesss() in order to
> > > check
> > > permissions of effective user. access() calls checking existence
> > > of
> > > a file (F_OK) were left untouched since they work correctly.
> > > 
> > > This enables setuid programs to use libsemanage.
> > 
> > Not sure we want setuid programs using libsemanage.  Is there a use
> > case for that?  I wouldn't warrant it to be safe.
> 
> The motivation is described in the response from the original
> reporter
> in the bug:
> 
> ---
> I think the reason why I filed the bug back then was
> https://fedorahosted.org/sssd/ticket/2564
> 
> In general I don't think the bug is a big deal to us and if upstream
> is
> reluctant to this change, just close the bug. I just found it odd to
> check if a file exists before acting on it instead of just trying to
> work with the file and failing on errors..the current approach seems
> a
> bit racy to me.
> 
> About the question in the thread that asks why do we use the selinux
> libraries in a setuid library..the reason is that in order to pass
> certain certifications, no code in SSSD that deals with network
> connections should run as root. Therefore, the SSSD itself runs as a
> nonprivileged user and for actions that require root privileges (like
> setting a selinux context for a user) we fork our a setgid helper
> that
> actually does the work.
> ---
> 
> I think it's about situations when a process can create e.g.
> /var/lib/selinux/targeted/semanage.read.LOCK001 using fopen(), but
> libsemanage denies to work as it thinks it can't access the store.

So then I would suggest looking at removing the use of access() checks
altogether, aside from trivial F_OK and X_OK tests that should be
harmless.
