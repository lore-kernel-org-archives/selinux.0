Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6GIwvWI023360
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 14:58:57 -0400
Received: by obnw1 with SMTP id w1so52725345obn.3
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 11:58:53 -0700 (PDT)
Date: Thu, 16 Jul 2015 13:57:50 -0500
From: Seth Forshee <seth.forshee@canonical.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH 0/7] Initial support for user namespace owned mounts
Message-ID: <20150716185750.GB51751@ubuntu-hedt>
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 <87615k7pyu.fsf@x220.int.ebiederm.org>
 <20150716135947.GC77715@ubuntu-hedt>
 <55A7C920.7090206@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55A7C920.7090206@schaufler-ca.com>
Cc: Serge Hallyn <serge.hallyn@canonical.com>, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov, linux-fsdevel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jul 16, 2015 at 08:09:20AM -0700, Casey Schaufler wrote:
> On 7/16/2015 6:59 AM, Seth Forshee wrote:
> > On Wed, Jul 15, 2015 at 10:15:21PM -0500, Eric W. Biederman wrote:
> >> Seth I think for the LSMs we should start with:
> >>
> >> diff --git a/security/security.c b/security/security.c
> >> index 062f3c997fdc..5b6ece92a8e5 100644
> >> --- a/security/security.c
> >> +++ b/security/security.c
> >> @@ -310,6 +310,8 @@ int security_sb_statfs(struct dentry *dentry)
> >>  int security_sb_mount(const char *dev_name, struct path *path,
> >>                         const char *type, unsigned long flags, void *data)
> >>  {
> >> +       if (current_user_ns() != &init_user_ns)
> >> +               return -EPERM;
> >>         return call_int_hook(sb_mount, 0, dev_name, path, type, flags, data);
> >>  }
> > This just makes it impossible to mount from a user namespace. Every
> > mount from current_user_ns() != &init_user_ns will fail.
> >
> >> Then we should push this down into all of the lsms.
> >> Then when we should remove or relax or change the check as appropriate
> >> in each lsm.
> >>
> >> The point is this is good enough to see that it is trivially safe,
> >> and this allows us to focus on the core issues, and stop worrying about
> >> the lsms for a bit.
> 
> Given the extent to which LSMs are deployed I find it a bit
> worrisome that they might not be considered a "core issue".
> 
> >> Then we can focus on each lsm one at at time and take the time to really
> >> understand them and talk with their maintainers etc to make certain
> >> we get things correct.
> 
> The "Do the easy stuff, fix the hard stuff after we've sold the product"
> approach works really well until you get to the point of fixing the hard
> stuff. This is the origin of the 90/90 rule of software development.
> 
> >>
> >> This should remove the need for your patches 5, 6 and 7. For the
> >> immediate future.
> > I'm still not entirely sure what you were trying to do, maybe refuse to
> > mount whenever a security module is loaded? I think this could be a good
> > option to start, but couldn't we restrict it to only the LSMs which use
> > xattrs for security labels? In situations where the filesystem cannot
> > supply security policy metadata I can't think of any reason to disallow
> > the mounts.
> 
> This whole notion of mounting a generic filesystem (e.g. ext4) that
> is "owned" by a user (as opposed to the system) has lots of implications,
> and I seriously doubt that many of them have been accounted for.
> 
> Think back to the "negative group access" issue. You can't just
> ignore issues that are inconvenient, or claim that you have a reasonable
> system just because *you* can't think of a problem.

I've spent a lot of time considering the implications and previous
vulnerabilities, and I've addressed everything I turned up. Now I'm
asking for review from those with more experience with and expertise of
the code in question. I'm not sure what more I should be doing.

I welcome feedback about anything I've missed, but stating generally
that you think I probably missed something isn't very helpful.

The LSM issue is thornier than the rest of it though, which is why I
specifically asked for review there in the cover letter. There's a lot
of complexity and nuance, and I still don't have a grasp on all the
subtleties. One such subtlety is the full impact of simply ignoring the
security labels on disk (but I am still confused as to why this is
different from filesystems which don't support xattrs at all).

I was unaware of Lukasz's patches until yesterday, and I will have a
look at them. But since we don't have the LSM support for user
namespaces yet, I don't see the problem with doing something safe for
LSMs initially and evolving the LSM integration for user ns mounts along
with the rest of the user ns integration.

Your point is taken about my less-than-expert opinion about the other
security modules. We should at minimum get acks from the maintainers of
those modules that unprivileged mounts will not compromise MAC.

For Smack specifically, I believe my only concern was the SMACK64EXEC
attribute, as all the other attributes only affected subjects' access to
the files. So maybe it would be possible to simply ignore this attribute
in unprivileged mounts and respect the others, even lacking more
complete LSM support for user namespaces.

Seth
