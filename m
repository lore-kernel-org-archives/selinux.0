MIME-Version: 1.0
In-Reply-To: <4CFB4191.3090106@schaufler-ca.com>
References: <20101203214518.30001.89859.stgit@paris.rdu.redhat.com>
 <4CF9C1A1.7050603@schaufler-ca.com> <1291498481.4929.77.camel@localhost.localdomain>
 <4CFB4191.3090106@schaufler-ca.com>
From: Kyle Moffett <kyle@moffetthome.net>
Date: Mon, 6 Dec 2010 18:32:51 -0500
Message-ID: <AANLkTimGY178MkEa5aF9q_oC-h5jqrB=8WUwBtmM_Kmh@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] fs/vfs/security: pass last path component to LSM
 on inode creation
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Eric Paris <eparis@redhat.com>, penguin-kernel@i-love.sakura.ne.jp,
        selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org,
        linux-security-module@vger.kernel.org, viro@zeniv.linux.org.uk,
        hch@lst.de
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Dec 5, 2010 at 02:38, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 12/4/2010 1:34 PM, Eric Paris wrote:
>> SELinux very
>> much so is and will continue to be based solely on label based controls.
>
> I'm not sure that I buy that. The very presence of restorecond, which
> sets labels based strictly on pathnames, begs the observer to question
> whether an SELinux system (e.g. a RedHat distribution) can be truly
> said to be strictly label based. Yes, individual access control decisions
> are made based on the combination of the policy and the labels, but
> with the suggested changes it becomes very difficult to distinguish the
> enforcement of the kernel (e.g. creating "passwd" in a etc_t directory)
> where restorecond is assumed to have set "/etc" to etc_t from checking
> the same access rights on a file that happens to be named "/etc/passwd".
> Yes, the kernel component of SELinux relies strictly on the labels,
> but the reality is that SELinux is heavily dependent on the user space
> component to maintain the proper labels on files so that the specified
> policy is rational.

I believe this is a limitation of the current policy structure that
could completely go away with support for last-component matching.

Now, there is *always* a relatively complex set of assumptions that
the policy itself makes about the userspace environment.  For example,
the policy must assume that the "passwd" tool does not allow
unprivileged users to change *other* users passwords.  It must assume
that the "login" tool actually performs proper authentication, etc.
The policy can only assume that programs called "login" or "password"
in the various system binary directories conform to these
requirements.

Userspace itself is very *thoroughly* dependent on specific file
names, "sh", "sed", "awk", "passwd", "mkfs"... the list goes on for
many pages.  In most cases, though it does NOT care *where* in $PATH
the tool is located, and that frequently varies across Linux
distributions.  Any comprehensive least-privilege security policy
truly needs to take this into account.


> I don't see a significant difference from a security standpoint
> between creating "shadow" in a etc_t directory and creating
> "/etc/shadow", because "everyone knows" that "/etc" gets etc_t,
> and the userspace tools enforce it.

The difference is in the complexity of other tasks, such as
".htaccess" files, where they are created not just in a single
directory, but in a whole directory hierarchy.  From a performance
standpoint I would much rather have a rule that says: [create
".htaccess" in an www_t directory as "www_htaccess_t"] plus a few to
prohibit hardlinks to and from ".htaccess" files, as opposed to a
bunch of rules using paths like: "/var/www/**/.htaccess"

The latter case also results in absolutely *ridiculous* duplication of
rules when I suddenly decide to put other web-site files in other
places: "/srv/mirror/ftp.example.com/pub".

>> You actually point out exactly the flaw of pathname based security, not
>> a problem with my new object labeling extension.  If the program
>> responsible for creating /etc/shadow is able to be tricked into
>> creating /etc/foo/shadow instead, that file is still going to contain
>> passwords and information that should be protected just like /etc/shadow
>> needs to be protected.
>
>> It's irrelevant if the pathname is wrong.
>
> Well, no, that's not true. The data will not be available to its
> legitimate consumers if it is created in /etc/foo/shadow, even if
> /etc/foo is (somehow) labeled etc_t.
>
>> It's
>> about the data and the integrity/confidentiality of the data.
>
> This is also true, but it is not the only concern. If a /etc/foo
> is on removable media the integrity and confidentiality, as defined
> by the label of /etc/foo, is not going to mean all that much.

If you're concerned about shadow confidentiality in that way then you
should not have a rule that says "allow shadow_t filesystem:associate
removable_filesystem_t" or similar.  That would prevent you from
creating a shadow_t file on a removable_filesystem_t even if the root
directory of the FS was labelled etc_t.


>> /var/run:  Lots of programs used to (and many still do) create files
>> directly in /var/run/.  We in the fedora land have urged packages to
>> use /var/run/[package name] because it made labeling easier to get
>> right.  This is SELinux forcing it's way of life onto userspace.
>> Something we would rather avoid if it's possible to automate.
>>
>> ~/.ssh:  When a user or even sshd creates the ~/.ssh directory the
>> kernel doesn't realize that this is different than creating the
>> directory "Downloads."  How do we solve that today?  We have a program
>> that puts an inotify watch on ~/.ssh when you log in and which will, as
>> fast as it can, relabel that directory to the correct label.  How much
>> crap is that?
>
> You could fix these applications. That's the right thing to do.
> I didn't say it's easy, just that its right.

No... in general... you *can't* just "fix" those applications.  Did
you even spend a minute to think about the ".ssh" example?  To add a
bit more detail... when I log into a freshly installed system over a
serial console one of the first things I do as root is:
  mkdir .ssh && cat >.ssh/authorized_keys

Then I copy and paste my public key into the terminal, then hit
Ctrl-D.  Any conceivable way of "fixing" that would introduce horrors
into "bash" and "coreutils" that would get you on their developer's
killfiles for life!  The whole point of having plain-text config files
is that they can be easily mucked about with by an administrator using
"cat", "sed", and "vi".


> BTW: I'm not saying your goals are bad, but I do question the
> implementation. It really looks like the pathname hooks are your
> easiest and most correct approach.

If I recall that doesn't work because several of the path-based hooks
are in different places from the inode-based hooks.  Specifically,
current SELinux hooks are always called *after* all of the DAC-based
checks, versus the path-based hooks which need a vfsmount parameter
only available *before* the DAC-based checks; if you changed this you
would cause a whole bunch of new audit false positives.

Cheers,
Kyle Moffett


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
