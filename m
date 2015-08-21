Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t7L54WB5003127
 for <selinux@tycho.nsa.gov>; Fri, 21 Aug 2015 01:04:32 -0400
Received: by obbwr7 with SMTP id wr7so50374560obb.2
 for <selinux@tycho.nsa.gov>; Thu, 20 Aug 2015 22:04:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGXu5jK+58CCUxPY1a8KkNMUHONKgO3Ce-vwLqTrzZ7NwDbqcg@mail.gmail.com>
References: <1437732285-11524-1-git-send-email-l.pawelczyk@samsung.com>
 <1437732285-11524-2-git-send-email-l.pawelczyk@samsung.com>
 <20150730213059.GA13589@mail.hallyn.com>
 <1438334936.2081.6.camel@samsung.com>
 <20150801034816.GA5541@mail.hallyn.com>
 <1438601680.2111.3.camel@samsung.com>
 <CAGXu5jK+58CCUxPY1a8KkNMUHONKgO3Ce-vwLqTrzZ7NwDbqcg@mail.gmail.com>
Date: Fri, 21 Aug 2015 01:04:27 -0400
Message-ID: <CAHC9VhRZn8WW9V8qECftR607979+AnSpXLwNrJXF6LFY7AusbQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] user_ns: 3 new LSM hooks for user namespace
 operations
From: Paul Moore <paul@paul-moore.com>
To: Kees Cook <keescook@chromium.org>
Cc: Lukasz Pawelczyk <l.pawelczyk@samsung.com>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Alexey Dobriyan <adobriyan@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@amacapital.net>, Arnd Bergmann <arnd@arndb.de>,
 Casey Schaufler <casey@schaufler-ca.com>,
 David Howells <dhowells@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Eric Paris <eparis@parisplace.org>,
 Fabian Frederick <fabf@skynet.be>, Greg KH <gregkh@linuxfoundation.org>,
 James Morris <james.l.morris@oracle.com>, Jiri Slaby <jslaby@suse.com>,
 Joe Perches <joe@perches.com>, John Johansen <john.johansen@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
 NeilBrown <neilb@suse.de>, Oleg Nesterov <oleg@redhat.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Zefan Li <lizefan@huawei.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-security-module <linux-security-module@vger.kernel.org>,
 SE Linux <selinux@tycho.nsa.gov>, havner@gmail.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Aug 3, 2015 at 9:38 PM, Kees Cook <keescook@chromium.org> wrote:
> On Mon, Aug 3, 2015 at 4:34 AM, Lukasz Pawelczyk
> <l.pawelczyk@samsung.com> wrote:
>> On pią, 2015-07-31 at 22:48 -0500, Serge E. Hallyn wrote:
>>> On Fri, Jul 31, 2015 at 11:28:56AM +0200, Lukasz Pawelczyk wrote:
>>> > On czw, 2015-07-30 at 16:30 -0500, Serge E. Hallyn wrote:
>>> > > On Fri, Jul 24, 2015 at 12:04:35PM +0200, Lukasz Pawelczyk wrote:
>>> > > > @@ -969,6 +982,7 @@ static int userns_install(struct nsproxy
>>> > > > *nsproxy, struct ns_common *ns)
>>> > > >  {
>>> > > >         struct user_namespace *user_ns = to_user_ns(ns);
>>> > > >         struct cred *cred;
>>> > > > +       int err;
>>> > > >
>>> > > >         /* Don't allow gaining capabilities by reentering
>>> > > >          * the same user namespace.
>>> > > > @@ -986,6 +1000,10 @@ static int userns_install(struct nsproxy
>>> > > > *nsproxy, struct ns_common *ns)
>>> > > >         if (!ns_capable(user_ns, CAP_SYS_ADMIN))
>>> > > >                 return -EPERM;
>>> > > >
>>> > > > +       err = security_userns_setns(nsproxy, user_ns);
>>> > > > +       if (err)
>>> > > > +               return err;
>>> > >
>>> > > So at this point the LSM thinks current is in the new ns.  If
>>> > > prepare_creds() fails below, should it be informed of that?
>>> > > (Or am I over-thinking this?)
>>> > >
>>> > > > +
>>> > > >         cred = prepare_creds();
>>> > > >         if (!cred)
>>> > > >                 return -ENOMEM;
>>> >
>>> > Hmm, the use case for this hook I had in mind was just to allow or
>>> > disallow the operation based on the information passed in
>>> > arguments.
>>> > Not to register the current in any way so LSM can think it is or
>>> > isn't
>>> > in the new namespace.
>>> >
>>> > I think that any other LSM check that would like to know in what
>>> > namespace the current is, would just check that from current's
>>> > creds.
>>> > Not use some stale and duplicated information the above hook could
>>> > have
>>> > registered.
>>> >
>>> > I see no reason for this hook to change the LSM state, only to
>>> > answer
>>> > the question: allowed/disallowed (eventually return an error cause
>>> > it
>>> > is unable to give an answer which falls into the disallow
>>> > category).
>>>
>>> How about renaming it "security_userns_may_setns()" for clarity?
>>
>> I personally have nothing against it. However looking at already
>> existing hooks only one of them has "may" in the name (unix_may_send)
>> while a lot clearly have exactly this purpose (e.g. most of inode_*
>> family, some from file_* and task_*). So it seems the trend is against
>> it.
>>
>> What do you think? Anyone else has an opinion?
>
> Personally, I prefer that hooks be named as closely to their caller,
> or calling context, as possible. In this case, it seems like "may" is
> implied. It's an LSM like all the others, so it can fail, which would
> cause the caller to fail too, so "may" tends to be implicit. I would
> leave it as-is, but I could be convinced otherwise.

I agree with Kees, sticking as close as possible to the general format
of "security_<caller>" for LSM hooks makes it easier when
reading/reviewing code.

-- 
paul moore
www.paul-moore.com
