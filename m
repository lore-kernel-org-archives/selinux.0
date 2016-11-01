Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uA1DBIox025733
 for <selinux@tycho.nsa.gov>; Tue, 1 Nov 2016 09:11:21 -0400
Received: by mail-pf0-f174.google.com with SMTP id n85so95199576pfi.1
 for <selinux@tycho.nsa.gov>; Tue, 01 Nov 2016 06:11:14 -0700 (PDT)
Date: Tue, 1 Nov 2016 21:11:10 +0800
From: Jason Zaman <jason@perfinion.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Discussion on setting the /proc/self/oom_score_adj file label.
Message-ID: <20161101131110.GA2886@meriadoc.perfinion.com>
References: <649de230-05ee-5b12-70dd-ac4f64cf9020@redhat.com>
 <4c7501e1-8645-0559-ad1e-358452086c43@tycho.nsa.gov>
 <7ac0844f-6b1f-18f5-7b14-3b806b9aa205@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7ac0844f-6b1f-18f5-7b14-3b806b9aa205@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Nov 01, 2016 at 08:33:09AM -0400, Daniel J Walsh wrote:
> 
> 
> On 11/01/2016 08:31 AM, Stephen Smalley wrote:
> > On 11/01/2016 07:50 AM, Daniel J Walsh wrote:
> >> I wrote a blog http://danwalsh.livejournal.com/75282.html which talks
> >> about chrome sandbox and its attempt to change its parents oom_score_adj
> >> value.  Which is labeled unconfined_t, the question has come up on
> >> Twitter to be able to change the label on just this object.
> >>
> >> I think we discussed this before, but how difficult would it be to
> >> change individual file labels under /proc/self/?
> > Technically feasible, already on the kernel todo list,
> > https://github.com/SELinuxProject/selinux/wiki/Kernel-Todo
> >
> > However, I agree with Dominick here - the parent shouldn't run in
> > unconfined_t in the first place.
> >
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> >
> >
> Sure, We could label chrome to run as some other label,but then you end
> up in multiple unconfined domains
> running, or end up attempting to confine chrome, which is a loosing
> battle, in the general use case.

We have chrome and firefox confined in gentoo and have no problems. There are a
set of booleans to allow it to read/write the entire homedir vs just
~/Downloads/ if you want that on. if you skipped the booleans and just give
chromium_t userdom_manage_* then its pretty unconfined and would work out of
the box.

Even if we had a way to set the label on just that one file, it'd still
be unconfined_oom_score_t and then the sandbox would still be able to
set it on every single process running in unconfined so theres no
benefit anyway.

https://gitweb.gentoo.org/proj/hardened-refpolicy.git/tree/policy/modules/contrib/chromium.te#n331

meriadoc ~ # semanage boolean -l | grep chrom
chromium_bind_tcp_unreserved_ports (on   ,   on)  Allow chromium to bind to tcp ports
chromium_manage_all_user_content (off  ,  off)  Allow chromium to manage all user content (including content that is specific to an application, such as the configuration files of other applications in the users home directory).
chromium_manage_generic_user_content (off  ,  off)  Allow chromium to manage generic user content (i.e. content that is not specific to an application).
chromium_read_all_user_content (off  ,  off)  Allow chromium to read all user content (including content that is specific to an application, such as the configuration files of other applications in the users home directory).
chromium_read_generic_user_content (on   ,   on)  Allow chromium to read generic user content (i.e. content that is not specific to an application).
chromium_read_system_info      (on   ,   on)  Allow chromium to read system information
chromium_rw_usb_dev            (on   ,   on)  Allow chromium to read/write USB devices
chromium_use_java              (off  ,  off)  Allow the use of java plugins

-- Jason
