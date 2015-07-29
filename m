Date: Wed, 29 Jul 2015 10:25:50 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Lukasz Pawelczyk <l.pawelczyk@samsung.com>
Subject: Re: [PATCH v3 11/11] smack: documentation for the Smack namespace
Message-ID: <20150729152550.GC19285@mail.hallyn.com>
References: <1437732285-11524-1-git-send-email-l.pawelczyk@samsung.com>
 <1437732285-11524-12-git-send-email-l.pawelczyk@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437732285-11524-12-git-send-email-l.pawelczyk@samsung.com>
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

On Fri, Jul 24, 2015 at 12:04:45PM +0200, Lukasz Pawelczyk wrote:
> +--- Design ideas ---
> +
> +"Smack namespace" is rather "Smack labels namespace" as not the whole
> +MAC is namespaced, only the labels. There is a great analogy between
> +Smack labels namespace and the user namespace part that remaps UIDs.
> +
> +The idea is to create a map of labels for a namespace so the namespace
> +is only allowed to use those labels. Smack rules are always the same
> +as in the init namespace (limited only by what labels are mapped) and
> +cannot be manipulated from the child namespace. The map is actually
> +only for labels' names. The underlying structures for labels remain
> +the same. The filesystem also stores the "unmapped" labels from the
> +init namespace.
> +
> +Let's say we have those labels in the init namespace:
> +label1
> +label2
> +label3
> +
> +and those rules:
> +label1 label2 rwx
> +label1 label3 rwx
> +label2 label3 rwx
> +
> +We create a map for a namespace:
> +label1 -> mapped1
> +label2 -> mapped2
> +
> +This means that 'label3' is completely invisible in the namespace. As if
> +it didn't exist. All the rules that include it are ignored.
> +
> +Effectively in the namespace we have only one rule:
> +mapped1 mapped2 rwx
> +
> +Which in reality is:
> +label1 label2 rwx
> +
> +All requests to access an object with a 'label3' will be denied. If it
> +ever comes to a situation where 'label3' would have to be printed
> +(e.g. reading an exec or mmap label from a file to which we have
> +access) then huh sign '?' will be printed instead.
> +
> +All the operations in the namespace on the remaining labels will have
> +to be performed using their mapped names. Things like changing own
> +process's label, changing filesystem label. Labels will also be
> +printed with their mapped names.
> +
> +You cannot import new labels in a namespace. Every operation that
> +would do so in an init namespace will return an error in the child
> +namespace. You cannot assign an unmapped or not existing label to an
> +object. You can only operate on labels that have been explicitly
> +mapped.
> +
> +
> +--- Capabilities ---
> +
> +Enabling Smack related capabilities (CAP_MAC_ADMIN and
> +CAP_MAC_OVERRIDE) is main goal of Smack namespace, so it can work
> +properly in the container. And those capabilities do work to some
> +extent. In several places where capabilities are checked compatibility
> +with Smack namespace has been introduced. Capabilities are of course
> +limited to operate only on mapped labels.
> +
> +CAP_MAC_OVERRIDE works fully, will allow you to ignore Smack access
> +rules, but only between objects that have labels mapped. So in the
> +example above having this CAP will allow e.g. label2 to write to
> +label1, but will not allow any access to label3.

(Sorry it took me this long to get to reading, and thanks for working
on this)

Oh my.  All this is not at all what I'd expected :)

Is there rationale for these decisions?  Hm, I guess it really is
following the user_ns design, but the huge difference is that the
user_ns is partitioning an already-enumerated set of kuids.  The
smack labels are inherently different.

In containers, something we'd really like to be able to do is:

Create a new container.  Just run it as label 'c1'.  Inside the
container, let the admin install mysql from a package which assigns
type 'mysqld', protecting the rest of the container from mysql.
Without the host admin doing anything.

Normally the way I think of implementing something like this would be
to allow the host to say "c1 is to be namespaceable."  Then on a userns
unshare, if the task is in c1, it gets transitioned into the ns.  Then the
container sees c1 as _ (or whatever).  It can create 'mysql' which is
actually 'c1.mysql' on the host, and it can create and override rules
to c1.*.

Also, allowing CAP_MAC_OVERRIDE in this way seems overly dangerous.
If there were rules defined by the container, then I'd expect those to
be overrideable - but not all rules pertaining to all labels mapped
into the container.  But I guess based on  your envisioned usage (where
I assume 'label1' is meant to *only* be used for that container) it
might be ok.

thanks,
-serge
