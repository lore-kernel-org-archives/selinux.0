Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pB8CPaav026017
	for <selinux@tycho.nsa.gov>; Thu, 8 Dec 2011 07:25:37 -0500
Received: from nm4.bt.bullet.mail.ukl.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id pB8CPZ4M011389
	for <selinux@tycho.nsa.gov>; Thu, 8 Dec 2011 12:25:35 GMT
Message-ID: <1323347134.34388.YahooMailClassic@web87002.mail.ird.yahoo.com>
Date: Thu, 8 Dec 2011 12:25:34 +0000 (GMT)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: CIL/SELinux Userspace Integration
To: Steve Lawrence <slawrence@tresys.com>, Eric Paris <eparis@parisplace.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <CACLa4pumnzC-HXMhm2YKEEx3WJBtSYQpejkEJ-tM8Czm1inqaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I added (genfscon selinuxfs / ...) as Eric suggested and booleans now work okay in policy.

I found getsebool and sestatus -b worked okay. 

setsebool worked setting a different value in running policy, however 'setsebool -P ..' core dumped. 

Richard

--- On Wed, 7/12/11, Eric Paris <eparis@parisplace.org> wrote:

> From: Eric Paris <eparis@parisplace.org>
> Subject: Re: CIL/SELinux Userspace Integration
> To: "Steve Lawrence" <slawrence@tresys.com>
> Cc: "Richard Haines" <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
> Date: Wednesday, 7 December, 2011, 20:15
> So the problem comes from the code
> which creates the files in
> /selinux/booleans.  It does an explicit check for a
> genfs rule for
> selinuxfs to label the new inode.  I'm not certain why
> we need this
> bit of code.  Maybe it is there to support labeling of
> individual
> booleans somehow, but I don't see how of why this
> particular piece of
> code is needed.  In any case I believe (Steve tested
> but I'm not
> exactly sure what he did) that you can add a genfs
> statement for
> selinuxfs and it will start working...
> 
> On Wed, Dec 7, 2011 at 1:45 PM, Eric Paris <eparis@parisplace.org>
> wrote:
> > I've found and fixed one kernel bug using this policy,
> but not THE
> > kernel bug.  Weeeee
> >
> > On Wed, Dec 7, 2011 at 9:04 AM, Steve Lawrence <slawrence@tresys.com>
> wrote:
> >> On 12/07/2011 08:54 AM, Eric Paris wrote:
> >>>
> >>> On Wed, Dec 7, 2011 at 8:32 AM, Steve
> Lawrence<slawrence@tresys.com>
> >>>  wrote:
> >>>>
> >>>> On 12/03/2011 11:30 AM, Richard Haines
> wrote:
> >>>
> >>>
> >>>>> 5) I could not load a new policy that
> had a boolean and supporting
> >>>>>    statements in it. The actual
> binary policy was fine (using apol), but
> >>>>>    load_policy had problems. I
> started with a Fedora 16 base and added
> >>>>>    the new Integration code with no
> problems. Is it a known problem as
> >>>>>    if not I'll check further.
> >>>>>    The errors I had when running
> semodule with a boolean were (Note: I
> >>>>>    had already built a new base
> policy (SELINUXTYPE=rch-test1) with no
> >>>>>    problems):
> >>>>
> >>>>
> >>>>
> >>>> Hmmm, this is interesting. Both seinfo and
> apol are fine with my
> >>>> CIL-generated binary, but fails to load
> when I add booleans. I also
> >>>> generated a similar mdp policy.conf, ran
> checkpolicy, and that failed to
> >>>> load as well. sediff also shows the two
> binaries to be the same.
> >>>>
> >>>> I'll look into this more, but because of
> that, I'm thinking this is a
> >>>> kernel
> >>>> bug. If anyone else wants to look at it,
> I've attached a simple file that
> >>>> is
> >>>> the standard mdp.conf with a single
> boolean defined, and single
> >>>> conditional
> >>>> statement using that boolean. This builds
> a binary fine, and apol/seinfo
> >>>> have no problem with it, but fails to load
> with load_policy.
> >>>>
> >>>>>
> >>>>>                      
> ------ Start --------------
> >>>>> # semodule -i base.cil ext_gateway.cil
> int_gateway.cil move_file.cil
> >>>>>
> >>>>> SELinux:  Could not load policy file
> >>>>>
> /etc/selinux/rch-test1/policy/policy.26:  No such file or
> directory
> >>>>> /sbin/load_policy:  Can't load
> policy:  No such file or directory
> >>>>>
> >>>>> libsemanage.semanage_reload_policy:
> load_policy returned error code 2.
> >>>>> (No
> >>>>> such file or directory).
> >>>>> SELinux:  Could not load policy file
> >>>>>
> /etc/selinux/rch-test1/policy/policy.26:  No such file or
> directory
> >>>>> /sbin/load_policy:  Can't load
> policy:  No such file or directory
> >>>>>
> >>>>> libsemanage.semanage_reload_policy:
> load_policy returned error code 2.
> >>>>> (No
> >>>>> such file or directory).
> >>>>> semodule:  Failed!
> >>>>>
> >>>>>                     -----
> End -----------------
> >>>
> >>>
> >>> If you send me the policy.X in question I'll
> spend a couple minutes
> >>> figuring out what the kernel is upset
> about...
> >>
> >>
> >> policy.24 attached. Thanks.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
