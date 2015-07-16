Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6GD7IqY029002
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 09:07:18 -0400
Received: by obnw1 with SMTP id w1so46307996obn.3
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 06:07:11 -0700 (PDT)
Date: Thu, 16 Jul 2015 08:06:07 -0500
From: Seth Forshee <seth.forshee@canonical.com>
To: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 3/7] fs: Ignore file caps in mounts from other user
 namespaces
Message-ID: <20150716130607.GA77715@ubuntu-hedt>
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 <1436989569-69582-4-git-send-email-seth.forshee@canonical.com>
 <20150715214848.GA24204@mail.hallyn.com>
 <CALCETrVTGC8NJdpOhkqDaE8HdD95y-K2-VnsL+Oo4NjVUyovsA@mail.gmail.com>
 <87wpy1camr.fsf@x220.int.ebiederm.org>
 <20150716011410.GA74046@ubuntu-hedt>
 <CALCETrUN-sK1gHPr5RxpGx5ZqXuYjJ6GiAxVW5kGM+fXTZKhgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CALCETrUN-sK1gHPr5RxpGx5ZqXuYjJ6GiAxVW5kGM+fXTZKhgg@mail.gmail.com>
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

On Wed, Jul 15, 2015 at 06:23:01PM -0700, Andy Lutomirski wrote:
> > So if we have the s_user_ns check in get_file_caps the mnt_may_suid pass
> > isn't strictly necessary, but I still think it is useful as a mitigation
> > to the "leaks" Eric mentions. It _should_ be impossible for a user to
> > gain access to another user's mount namespace,
> 
> No, it's very easy with SCM_RIGHTS.  We should make sure it's safe.

Sure, what I really meant was that an attacker shouldn't be able to do
so without cooperation from the other user's processes. But I think
we're all in agreement that making it safe is a good idea.

Seth
