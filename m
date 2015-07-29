MIME-Version: 1.0
In-Reply-To: <20150729163742.GC21625@mail.hallyn.com>
References: <1437732285-11524-1-git-send-email-l.pawelczyk@samsung.com>
 <1437732285-11524-12-git-send-email-l.pawelczyk@samsung.com>
 <20150729152550.GC19285@mail.hallyn.com>
 <CACL4Mm-j2AJPc0347Ev0Rr2+FfBKEKgaZ+5boF35uAAwZFwrYg@mail.gmail.com>
 <20150729163742.GC21625@mail.hallyn.com>
Date: Wed, 29 Jul 2015 19:05:19 +0200
Message-ID: <CACL4Mm-UXodv+GcEbwVVoiDYUqa39YW3+RTnS7O61cUj8Pk6Og@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] smack: documentation for the Smack namespace
From: Lukasz Pawelczyk <havner@gmail.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset=UTF-8
Cc: linux-doc@vger.kernel.org, NeilBrown <neilb@suse.de>,
 linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
 Eric Dumazet <edumazet@google.com>, selinux@tycho.nsa.gov,
 Lukasz Pawelczyk <l.pawelczyk@samsung.com>, Jonathan Corbet <corbet@lwn.net>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
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

Just a clarification, from my previous email:

> 3. (expcetion #2) About the: "Without the host admin doing anything.".
> With this namespace you delegate part of CAP_MAC_ADMIN privilege to an
> unprivileged user (as with any other namespace). There is now way that
> this will not involve host admin.

What I meant is: "There is NO way that this will not involve host admin."
Typo, sorry.

On Wed, Jul 29, 2015 at 6:37 PM, Serge E. Hallyn <serge@hallyn.com> wrote:

> Ok, I'm hoping to discuss this with Casey at LSS.  I assume there will
> be reasons why what I want is simply not possible, but I'd like to give
> it a shot :)
>
> One way around this might be to let the host admin say:
>
> create smack labels c1_a1..c1_aN.  Map them into the container in a
> way such that they have no name in the container yet.
>
> Now when container admin says "create mysql_t", so long as there is
> a not-yet-named mapped label, c1-aM, it gets mapped to the new name.

This by itself like I said would theoretically be possible (without
the "no admin intervention" and "modifying rules" parts). You mark the
container prefixed with something, let's say with "C1". Now any new
label you create inside a namespace will get automatic (implicit)
mapping:

C1-label -> label

Casey disliked the idea for these reasons (there was actually more
then one as I remember now):
1. What I said previously about special meaning for labels. The real
host label C1-label has a meaning now.
2. Labels have a specific max length. By prefixing them we reduce that
length, and it is pressumed to be true in several parts of the code.
3. This mechanic allows users to import labels, and as Smack doesn't
free or reuse them this is potentially DOS surface. Granted this is
technical limitation only that could be remedied at some point, but
for now the assumption that labels are not destroyed is taken
advantage of in several parts of the code to simplify the
implementation of Smack itself. (Mappings and mapped label structures
are freed with the end of life of user namespace).

> One hurdle to overcome there, of course, is how to reproduce that
> mapping the next time we create this container.

The name of the real label would hold the info (C1-label).

> Anyway, if this patchset is simply about making smack work in user_ns
> at all, I'll reread with that in mind :)

Would appreciate.

Thanks,
Lukasz
