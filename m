MIME-Version: 1.0
In-Reply-To: <20150729152550.GC19285@mail.hallyn.com>
References: <1437732285-11524-1-git-send-email-l.pawelczyk@samsung.com>
 <1437732285-11524-12-git-send-email-l.pawelczyk@samsung.com>
 <20150729152550.GC19285@mail.hallyn.com>
Date: Wed, 29 Jul 2015 18:13:59 +0200
Message-ID: <CACL4Mm-j2AJPc0347Ev0Rr2+FfBKEKgaZ+5boF35uAAwZFwrYg@mail.gmail.com>
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

Appologise for sending my previous email in HTML, this email address
was never meant to be used with lists. I resend in plain text.

On Wed, Jul 29, 2015 at 5:25 PM, Serge E. Hallyn <serge@hallyn.com> wrote:

>> +Enabling Smack related capabilities (CAP_MAC_ADMIN and
>> +CAP_MAC_OVERRIDE) is main goal of Smack namespace, so it can work
>> +properly in the container. And those capabilities do work to some
>> +extent. In several places where capabilities are checked compatibility
>> +with Smack namespace has been introduced. Capabilities are of course
>> +limited to operate only on mapped labels.
>> +
>> +CAP_MAC_OVERRIDE works fully, will allow you to ignore Smack access
>> +rules, but only between objects that have labels mapped. So in the
>> +example above having this CAP will allow e.g. label2 to write to
>> +label1, but will not allow any access to label3.
>
> (Sorry it took me this long to get to reading, and thanks for working
> on this)
>
> Oh my.  All this is not at all what I'd expected :)
>
> Is there rationale for these decisions?  Hm, I guess it really is
> following the user_ns design, but the huge difference is that the
> user_ns is partitioning an already-enumerated set of kuids.  The
> smack labels are inherently different.

There is a big rationale for this. This is not to make Smack limit how
namespace can be created (this can be done separately, no conflict
here). This is to make Smack work at all inside a namespace. Please
note that contrary to SELinux and AppArmor Smack needs CAP_MAC_ADMIN
for it to operate on a normal basis. There is no rule for changing
labels. CAP_MAC_ADMIN is always required for this. And you cannot
unlock and give this capability just like that to anyone. Like in
every namespace you need a level of abstraction to allow an
unprivileged namespace to administer something.

> In containers, something we'd really like to be able to do is:
>
> Create a new container.  Just run it as label 'c1'.  Inside the
> container, let the admin install mysql from a package which assigns
> type 'mysqld', protecting the rest of the container from mysql.
> Without the host admin doing anything.
>
> Normally the way I think of implementing something like this would be
> to allow the host to say "c1 is to be namespaceable."  Then on a userns
> unshare, if the task is in c1, it gets transitioned into the ns.  Then the
> container sees c1 as _ (or whatever).  It can create 'mysql' which is
> actually 'c1.mysql' on the host, and it can create and override rules
> to c1.*.

Few things here.
1. Such an extension with using prefixes (with two exceptions, see
below) could be added to my patches. I even planned to do so (make a
prefix for a container and assign it a group of labels, this doesn't
conflict with arbitrary mapping). But this was refused by Casey on a
basis that by Smack defintion labels have no meaning. So no prefixes.
2. (expcetion #1) Changing any rules in a container has been deemed
too insecure at this point.
3. (expcetion #2) About the: "Without the host admin doing anything.".
With this namespace you delegate part of CAP_MAC_ADMIN privilege to an
unprivileged user (as with any other namespace). There is now way that
this will not involve host admin. The way you described it you allow
an unprivileged process to change its own label and change labels on a
filesystem. This is simply against Smack rules and completely
insecure. Even with user_ns if you map several UID you need admin
intervention.
>
> Also, allowing CAP_MAC_OVERRIDE in this way seems overly dangerous.
> If there were rules defined by the container, then I'd expect those to
> be overrideable - but not all rules pertaining to all labels mapped
> into the container.  But I guess based on  your envisioned usage (where
> I assume 'label1' is meant to *only* be used for that container) it
> might be ok.

CAP_MAC_OVERRIDE is only possible for labels that the admin explicitly
mapped. So it's up to him to decide what is dangerous or not. It can
only map labels that are not used outside of the container if it
wishes to. But the user himself will not be able to explot that
without permission from the admin.

So sorry this is not what you expected, but it seems that what you
expected is simply not feasible.

> thanks,
> -serge

Thanks,
Lukasz
