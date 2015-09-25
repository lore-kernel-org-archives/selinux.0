Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8PCnbBb021325
 for <selinux@tycho.nsa.gov>; Fri, 25 Sep 2015 08:49:38 -0400
Received: by ioiz6 with SMTP id z6so108821454ioi.2
 for <selinux@tycho.nsa.gov>; Fri, 25 Sep 2015 05:49:36 -0700 (PDT)
Date: Fri, 25 Sep 2015 07:49:24 -0500
From: Seth Forshee <seth.forshee@canonical.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Serge Hallyn <serge.hallyn@canonical.com>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Andy Lutomirski <luto@amacapital.net>, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v4 4/7] fs: Limit file caps to the user namespace of the
 super block
Message-ID: <20150925124924.GB104990@ubuntu-hedt>
References: <1443039368-55445-1-git-send-email-seth.forshee@canonical.com>
 <1443039368-55445-5-git-send-email-seth.forshee@canonical.com>
 <87fv23o4vs.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87fv23o4vs.fsf@x220.int.ebiederm.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Sep 24, 2015 at 04:59:35PM -0500, Eric W. Biederman wrote:
> Seth Forshee <seth.forshee@canonical.com> writes:
> 
> > Capability sets attached to files must be ignored except in the
> > user namespaces where the mounter is privileged, i.e. s_user_ns
> > and its descendants. Otherwise a vector exists for gaining
> > privileges in namespaces where a user is not already privileged.
> >
> > Add a new helper function, in_user_ns(), to test whether a user
> > namespace is the same as or a descendant of another namespace.
> > Use this helper to determine whether a file's capability set
> > should be applied to the caps constructed during exec.
> 
> No issues with this but given that we always pass current_user_ns()
> we may want to simplify the users of in_user_ns by renaming it
> current_in_user_ns() and hard codeing current_user_ns().

Sure, if that's what you prefer then I'll change it.

Seth
