Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-id: <1438601680.2111.3.camel@samsung.com>
Subject: Re: [PATCH v3 01/11] user_ns: 3 new LSM hooks for user namespace
 operations
From: Lukasz Pawelczyk <l.pawelczyk@samsung.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
Date: Mon, 03 Aug 2015 13:34:40 +0200
In-reply-to: <20150801034816.GA5541@mail.hallyn.com>
References: <1437732285-11524-1-git-send-email-l.pawelczyk@samsung.com>
 <1437732285-11524-2-git-send-email-l.pawelczyk@samsung.com>
 <20150730213059.GA13589@mail.hallyn.com> <1438334936.2081.6.camel@samsung.com>
 <20150801034816.GA5541@mail.hallyn.com>
Cc: linux-doc@vger.kernel.org, NeilBrown <neilb@suse.de>,
 linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
 Eric Dumazet <edumazet@google.com>, selinux@tycho.nsa.gov,
 Jonathan Corbet <corbet@lwn.net>, havner@gmail.com,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Jiri Slaby <jslaby@suse.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Alexey Dobriyan <adobriyan@gmail.com>, Kees Cook <keescook@chromium.org>,
 Arnd Bergmann <arnd@arndb.de>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
 Fabian Frederick <fabf@skynet.be>, Al Viro <viro@zeniv.linux.org.uk>,
 James Morris <james.l.morris@oracle.com>,
 John Johansen <john.johansen@canonical.com>,
 Greg KH <gregkh@linuxfoundation.org>, Oleg Nesterov <oleg@redhat.com>,
 Andy Lutomirski <luto@amacapital.net>, linux-security-module@vger.kernel.org,
 Zefan Li <lizefan@huawei.com>, Joe Perches <joe@perches.com>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On pią, 2015-07-31 at 22:48 -0500, Serge E. Hallyn wrote:
> On Fri, Jul 31, 2015 at 11:28:56AM +0200, Lukasz Pawelczyk wrote:
> > On czw, 2015-07-30 at 16:30 -0500, Serge E. Hallyn wrote:
> > > On Fri, Jul 24, 2015 at 12:04:35PM +0200, Lukasz Pawelczyk wrote:
> > > > @@ -969,6 +982,7 @@ static int userns_install(struct nsproxy 
> > > > *nsproxy, struct ns_common *ns)
> > > >  {
> > > >  	struct user_namespace *user_ns = to_user_ns(ns);
> > > >  	struct cred *cred;
> > > > +	int err;
> > > >  
> > > >  	/* Don't allow gaining capabilities by reentering
> > > >  	 * the same user namespace.
> > > > @@ -986,6 +1000,10 @@ static int userns_install(struct nsproxy 
> > > > *nsproxy, struct ns_common *ns)
> > > >  	if (!ns_capable(user_ns, CAP_SYS_ADMIN))
> > > >  		return -EPERM;
> > > >  
> > > > +	err = security_userns_setns(nsproxy, user_ns);
> > > > +	if (err)
> > > > +		return err;
> > > 
> > > So at this point the LSM thinks current is in the new ns.  If
> > > prepare_creds() fails below, should it be informed of that?
> > > (Or am I over-thinking this?)
> > > 
> > > > +
> > > >  	cred = prepare_creds();
> > > >  	if (!cred)
> > > >  		return -ENOMEM;
> > 
> > Hmm, the use case for this hook I had in mind was just to allow or
> > disallow the operation based on the information passed in 
> > arguments.
> > Not to register the current in any way so LSM can think it is or 
> > isn't
> > in the new namespace.
> > 
> > I think that any other LSM check that would like to know in what
> > namespace the current is, would just check that from current's 
> > creds.
> > Not use some stale and duplicated information the above hook could 
> > have
> > registered.
> > 
> > I see no reason for this hook to change the LSM state, only to 
> > answer
> > the question: allowed/disallowed (eventually return an error cause 
> > it
> > is unable to give an answer which falls into the disallow 
> > category).
> 
> How about renaming it "security_userns_may_setns()" for clarity?

I personally have nothing against it. However looking at already
existing hooks only one of them has "may" in the name (unix_may_send)
while a lot clearly have exactly this purpose (e.g. most of inode_*
family, some from file_* and task_*). So it seems the trend is against
it.

What do you think? Anyone else has an opinion?



-- 
Lukasz Pawelczyk
Samsung R&D Institute Poland
Samsung Electronics
