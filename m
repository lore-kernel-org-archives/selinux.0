Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w44EYCN1001183
 for <selinux@tycho.nsa.gov>; Fri, 4 May 2018 10:34:12 -0400
Received: by mail-pg0-f51.google.com with SMTP id e1-v6so4229913pga.6
 for <selinux@tycho.nsa.gov>; Fri, 04 May 2018 07:33:10 -0700 (PDT)
Date: Fri, 4 May 2018 22:26:42 +0800
From: Jason Zaman <jason@perfinion.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Message-ID: <20180504142642.GA63280@baraddur.perfinion.com>
References: <27be33f6-67d1-38bf-0351-4ea5af2fb1e1@tycho.nsa.gov>
 <83e8bd2a-a2c9-5d2e-4667-e98ab2821cd9@tycho.nsa.gov>
 <709e6b08-2a3a-84ec-da43-f514469d45f7@tycho.nsa.gov>
 <20180504075510.GB5101@baraddur.perfinion.com>
 <3c51abc9-2d3a-3cef-2ba1-d976dee651c5@tycho.nsa.gov>
 <20180504132629.GC3263@julius.enp8s0.d30>
 <acd4d278-d819-4491-7cae-9644a2b9adfb@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <acd4d278-d819-4491-7cae-9644a2b9adfb@tycho.nsa.gov>
Subject: Re: Last call for selinux userspace 2.8 release
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, May 04, 2018 at 09:36:12AM -0400, Stephen Smalley wrote:
> On 05/04/2018 09:26 AM, Dominick Grift wrote:
> > On Fri, May 04, 2018 at 09:08:36AM -0400, Stephen Smalley wrote:
> >> On 05/04/2018 03:55 AM, Jason Zaman wrote:
> >>> On Thu, May 03, 2018 at 10:52:24AM -0400, Stephen Smalley wrote:
> >>>> Hi,
> >>>>
> >>>> If you have encountered any unreported problems with the 2.8-rcX releases or have any
> >>>> pending patches you believe should be included in the 2.8 release, please post them soon.
> >>>
> >>> the rc2 release has been fine for me for several days now. And I havent
> >>> heard any issues from any gentoo users either so we're probably good to
> >>> go. -rc1 failed to boot properly for me because some important things in
> >>> /run or /dev didnt get labeled but that was fixed in rc2.
> >>
> >> Hmm...I'd like to understand that better. The change was verifying file_contexts when using restorecon,
> >> which was reverted in -rc2.  But the fact that it prevented labeling files in -rc1 means that either
> >> you have a bug in your file_contexts configuration or there is some other bug there.
> > 
> > If it cannot validate_context then it will be unhappy:
> > 
> > [root@julius ~]# dnf history info last
> > Transaction ID : 364
> > Begin time     : Fri 04 May 2018 01:12:36 PM CEST
> > Begin rpmdb    : 1404:e739a03c49fec80ed41a1ea4c599d8f877b01d76
> > End time       : Fri 04 May 2018 01:14:01 PM CEST (85 seconds)
> > End rpmdb      : 1404:27bd40dce7edbf226ffad80f482cd75231f1b6ab **
> > User           : kcinimod <kcinimod>
> > Return-Code    : Success
> > Command Line   : update --exclude efi-filesystem
> > Transaction performed with:
> >     Installed     dnf-2.7.5-12.fc29.noarch @rawhide
> >         Installed     rpm-4.14.1-8.fc28.x86_64 @tmp-rawhide
> > 	Packages Altered:
> > 	    Upgraded cockpit-166-1.fc29.x86_64                      @rawhide
> > ... snip ...
> > Scriptlet output:
> >    1 restorecon: /etc/selinux/dssp2-standard/contexts/files/file_contexts: has invalid context sys.id:sys.role:files.generic_boot.boot_file:s0
> >       2 restorecon: /etc/selinux/dssp2-standard/contexts/files/file_contexts: has invalid context sys.id:sys.role:files.generic_boot.boot_file:s0
> >          3 restorecon: /etc/selinux/dssp2-standard/contexts/files/file_contexts: has invalid context sys.id:sys.role:files.generic_boot.boot_file:s0
> > 	    4 restorecon: /etc/selinux/dssp2-standard/contexts/files/file_contexts: has invalid context sys.id:sys.role:files.generic_boot.boot_file:s0
> > 	       5 restorecon: /etc/selinux/dssp2-standard/contexts/files/file_contexts: has invalid context sys.id:sys.role:files.generic_boot.boot_file:s0
> 
> So, just to be clear: these contexts are in fact valid but the lack of permission to use the /sys/fs/selinux/context interface (for security_check_context) causes it to think the context is invalid and therefore fails?  If so, then 
> that makes sense and would be another reason for reverting that change.  In any case, -rc2 should have the fix.

Yeah im pretty sure this is what happened. The issues off the top of my
head were some relabelling very early on in boot of /dev/ and /run so
those ended up with completely wrong contexts so nothing afterwards
worked either. There wasnt much output cuz /dev/console was mislabelled.
Dbus and Udev stuff in /run was wrong too so X kind of started but I had
no keyboard or mouse and everything using dbus died too.

It apeared to mostly work if i booted in permissive and then force
relabelled a bunch of stuff then switched to enforcing. I only bumped to
-rc1 a day before -rc2 came out so I pretty much just updated again
immediately as soon as I saw the validation issues and everything was
fine again.

I could try out -rc1 in a VM again if you want to be certain but pretty
sure this is it.

-- Jason
