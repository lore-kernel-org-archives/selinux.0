Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sBFBWblg011262
 for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2014 06:32:37 -0500
Received: by mail-la0-f49.google.com with SMTP id hs14so9283067lab.36
 for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2014 03:32:34 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 15 Dec 2014 05:32:34 -0600
Message-ID: <CAHZ_Ajs3ah9JcoxdmUr54-AzsN8ksP81HMpMfi-egTx4=Hzt-w@mail.gmail.com>
Subject: open_init_pty function?
From: eric gisse <jowr.pi@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In tracking down some related issues, the subject of the helper
program /usr/sbin/open_init_pty came up.

This gets called by run_init as the final step for running a program
in the initrc context, like this:

if (execvp("/usr/sbin/open_init_pty", argv)) {
  perror("execvp");
  exit(-1);
}

The context for this problem is the discovery that open_init_pty
doesn't play well with others by refusing to pass along return codes.
Eg, run_init from stock will always return 0.

Debian fixes this problem by fixing open_init_pty to return status
codes, redhat bypasses it in favor of execvp(), and gentoo uses stock
and is evaluating its' options.

What I'm trying to figure out is, is the function of open_init_pty in
the general sense.

Init scripts don't generally get a pty, so I don't understand the
necessity and hope someone here can shed a little light on this.
