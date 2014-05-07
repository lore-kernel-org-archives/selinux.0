Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s47CmwFD023032
 for <selinux@tycho.nsa.gov>; Wed, 7 May 2014 08:48:58 -0400
Received: by mail-ig0-f171.google.com with SMTP id c1so7614751igq.10
 for <selinux@tycho.nsa.gov>; Wed, 07 May 2014 05:48:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5367C08F.1010804@redhat.com>
References: <CANnpg5Q8Uf23hKB1s3OtOQiXJSuUh5hyB08wkecWQ6U7oMusBA@mail.gmail.com>
 <5367C08F.1010804@redhat.com>
Date: Wed, 7 May 2014 08:48:58 -0400
Message-ID: <CANnpg5TkzegeatevCXdEfck1pC6oOJYrUXrtauWp6qCw5nsM_g@mail.gmail.com>
Subject: Re: staff_u permission
From: Steve Huston <huston@astro.princeton.edu>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, May 5, 2014 at 12:47 PM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> First off, I hope you realize that you still need to allow DAC
> permissions, meaning if users on the system were not allowed to edit
> these files with SELinux in permissive mode or disabled, they still
> would not be allowed to edit the files with SELinux in enforcing, no
> matter the label.  You could add a group permissions to the /etc/puppet
> directory and allow users in that group to write.  Another option would
> be to allow the users to use sudo to get access to this directory.

I probably wasn't clear in my initial description; using standard Unix
groups is what I'd already done, so the next step was how to get
SELinux to know what I was doing is OK :>

> If we want to leave the files labeled as puppet_etc_t, then simply
> adding a custom policy like
>
> # cat mystaff.te
> policy_module(mystaff,1.0)
> gen_require(`
> type staff_t, puppet_etc_t;
> ')
> manage_dirs_pattern(staff_t, puppet_etc_t, puppet_etc_t)
> manage_files_pattern(staff_t, puppet_etc_t, puppet_etc_t)
> manage_lnk_files_pattern(staff_t, puppet_etc_t, puppet_etc_t)
>
> # make -f /usr/share/selinux/devel/Makefile
> # semodule -i mystaff.pp

Worked perfectly, thanks!

-- 
Steve Huston - W2SRH - Unix Sysadmin, PICSciE/CSES & Astrophysical Sci
  Princeton University  |    ICBM Address: 40.346344   -74.652242
    345 Lewis Library   |"On my ship, the Rocinante, wheeling through
  Princeton, NJ   08544 | the galaxies; headed for the heart of Cygnus,
    (267) 793-0852      | headlong into mystery."  -Rush, 'Cygnus X-1'
