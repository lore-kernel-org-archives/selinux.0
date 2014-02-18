Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s1ILjp9r031293
 for <selinux@tycho.nsa.gov>; Tue, 18 Feb 2014 16:45:51 -0500
Received: by mail-la0-f54.google.com with SMTP id y1so12991536lam.27
 for <selinux@tycho.nsa.gov>; Tue, 18 Feb 2014 13:45:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20140218212318.361DD680123@frontend2.nyi.mail.srv.osa>
References: <20140218212318.361DD680123@frontend2.nyi.mail.srv.osa>
Date: Tue, 18 Feb 2014 16:45:47 -0500
Message-ID: <CACLa4pu0iRVpJuWe+B01H-5CEghcWdoYsGdeSO5=V8CzrLQ01w@mail.gmail.com>
Subject: Re: cross-labeling vs precompiled PCRE
From: Eric Paris <eparis@parisplace.org>
To: Colin Walters <walters@verbum.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: SE-Linux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

agreed completely that a version check makes sense, but i'm pretty
sure I'll forget about it before I have time to look at it   :-(

On Tue, Feb 18, 2014 at 4:18 PM, Colin Walters <walters@verbum.org> wrote:
> Hi,
>
> So my rpm-ostree system is doing "cross labeling" - in my case, the build
> host is RHEL7, and the target system is Fedora rawhide.
>
> Concretely, I'm using selinux_set_policy_root() to load the policy from a
> chroot, then selabel_open (SELABEL_CTX_FILE).
>
> I know this might eventually break if Fedora's SELinux policy format breaks
> from what RHEL7 can understand...but I'm hoping to avoid that (or
> alternatively, update the RHEL7 SELinux libraries to understand newer
> formats).
>
> The advantage of doing it this way is I don't need to run through Anaconda
> (or more generally, execute any *code* from the OS I'm building).  Which in
> turn makes the system reliable and fast.
>
> There is one problem though - the PCRE precompiled regexps in e.g.
> "file_contexts.bin".  It turns out that the RHEL7 pcre silently fails to
> match the ones from rawhide =/
>
> I work around this by temporarily moving the .bin out of the way.
>
> But how about extending the file format to include e.g. the result of
> pcre_version(), and having the label code only use the mmap cache if the
> saved PCRE version exactly matches that on the system?
>
> This would cause labeling slowdowns when the pcre RPM is rebuilt until the
> selinux-policy RPM is later rebuilt, but that seems better than potentially
> silent failures.
>
> Thoughts?
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>
