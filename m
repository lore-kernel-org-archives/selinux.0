Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sBFDtobu016593
 for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2014 08:55:50 -0500
Message-ID: <548EE841.6090402@tresys.com>
Date: Mon, 15 Dec 2014 08:55:13 -0500
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
To: eric gisse <jowr.pi@gmail.com>, <selinux@tycho.nsa.gov>
Subject: Re: open_init_pty function?
References: <CAHZ_Ajs3ah9JcoxdmUr54-AzsN8ksP81HMpMfi-egTx4=Hzt-w@mail.gmail.com>
In-Reply-To: <CAHZ_Ajs3ah9JcoxdmUr54-AzsN8ksP81HMpMfi-egTx4=Hzt-w@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/15/2014 6:32 AM, eric gisse wrote:
> In tracking down some related issues, the subject of the helper
> program /usr/sbin/open_init_pty came up.
> 
> This gets called by run_init as the final step for running a program
> in the initrc context, like this:
> 
> if (execvp("/usr/sbin/open_init_pty", argv)) {
>   perror("execvp");
>   exit(-1);
> }
> 
> The context for this problem is the discovery that open_init_pty
> doesn't play well with others by refusing to pass along return codes.
> Eg, run_init from stock will always return 0.
> 
> Debian fixes this problem by fixing open_init_pty to return status
> codes, redhat bypasses it in favor of execvp(), and gentoo uses stock
> and is evaluating its' options.
> 
> What I'm trying to figure out is, is the function of open_init_pty in
> the general sense.
> 
> Init scripts don't generally get a pty, so I don't understand the
> necessity and hope someone here can shed a little light on this.

Most daemons will print early error messages before reopening their
stdin/out/err to /dev/null.  The purpose of open_init_pty is to provide
an isolated stdin/out/err for the init scripts and daemons.  Without it,
we'd have to allow all daemons to read/write sysadm/unconfined
terminals, which opens those highly-privileged users to attack.


-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
