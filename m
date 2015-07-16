Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6G1NL3m017775
 for <selinux@tycho.nsa.gov>; Wed, 15 Jul 2015 21:23:24 -0400
Received: by lbbzr7 with SMTP id zr7so34995006lbb.1
 for <selinux@tycho.nsa.gov>; Wed, 15 Jul 2015 18:23:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150716011410.GA74046@ubuntu-hedt>
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 <1436989569-69582-4-git-send-email-seth.forshee@canonical.com>
 <20150715214848.GA24204@mail.hallyn.com>
 <CALCETrVTGC8NJdpOhkqDaE8HdD95y-K2-VnsL+Oo4NjVUyovsA@mail.gmail.com>
 <87wpy1camr.fsf@x220.int.ebiederm.org> <20150716011410.GA74046@ubuntu-hedt>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 15 Jul 2015 18:23:01 -0700
Message-ID: <CALCETrUN-sK1gHPr5RxpGx5ZqXuYjJ6GiAxVW5kGM+fXTZKhgg@mail.gmail.com>
Subject: Re: [PATCH 3/7] fs: Ignore file caps in mounts from other user
 namespaces
To: Seth Forshee <seth.forshee@canonical.com>
Content-Type: text/plain; charset=UTF-8
Cc: Serge Hallyn <serge.hallyn@canonical.com>,
 SELinux-NSA <selinux@tycho.nsa.gov>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 LSM List <linux-security-module@vger.kernel.org>,
 James Morris <james.l.morris@oracle.com>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jul 15, 2015 at 6:14 PM, Seth Forshee
<seth.forshee@canonical.com> wrote:
> mnt_may_suid would also restrict the namespaces where the capabilities
> would be honored, but not to only namespaces where the mounter is
> already privileged. Of course it does require a user privileged in
> another namespace to perform a mount, but that still leaves me feeling a
> bit uncomfortable.

Right.  I think mnt_may_suid should check s_user_ns in addition.

>
> suid doesn't require quite so strict a check because (jumping ahead to
> the patches I haven't sent yet) ids in a user namespace mount of a
> normal filesystem are constrained to ids in that namespace. So users
> could only exploit this to suid to ids they already control, or if they
> managed to somehow bypass other kernel protections they could possibly
> gain access to user ns mounts belonging to another user.

True.  But LSMs labels probably want the same protection as file caps,
and the mnt_no_suid approach handles that, too.  (Your patches also do
this, but maybe we'd want to relax that some day for LSMs that are
scoped sensibly.)

>
> So if we have the s_user_ns check in get_file_caps the mnt_may_suid pass
> isn't strictly necessary, but I still think it is useful as a mitigation
> to the "leaks" Eric mentions. It _should_ be impossible for a user to
> gain access to another user's mount namespace,

No, it's very easy with SCM_RIGHTS.  We should make sure it's safe.

> Andy alludes to the possibility of checking s_user_ns or both s_user_ns
> and the mount namespace in mnt_may_suid, and those are certainly
> possibilities that would work equally well (though checking both is
> probably unnecessary). One thing I came away with from conversing with
> Eric though is that he wants to see a clear and explicit check in
> get_file_caps, not something implicit from may_mnt_suid. And I can see
> his point - there is a concern with file capabilities independent of the
> question of whether suid is allowed, and having a separate check does
> make that clearer.

But we absolutely need MS_NOSUID to block file caps, and it does.  Why
not just use the existing mechanism with an expanded sense of
"nosuid"?

--Andy
