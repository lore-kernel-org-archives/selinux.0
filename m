Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s49IJ7Vu018713
 for <selinux@tycho.nsa.gov>; Fri, 9 May 2014 14:19:08 -0400
Received: from web23g.yandex.ru (web23g.yandex.ru [95.108.253.232])
 by forward19.mail.yandex.net (Yandex) with ESMTP id 2AF301120BE4
 for <selinux@tycho.nsa.gov>; Fri,  9 May 2014 22:19:05 +0400 (MSK)
From: Victor Porton <porton@narod.ru>
To: SELinux <selinux@tycho.nsa.gov>
Subject: Refactor installation of policies and modules
MIME-Version: 1.0
Message-Id: <3092401399659544@web23g.yandex.ru>
Date: Fri, 09 May 2014 21:19:04 +0300
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Consider the following use case (we may specify that it runs on a Debian system).

First we need to create a base (entirely permissive) policy for Debian, because the default Debian policy is buggy or may be unwanted in any other reason (as for performance).

Suppose then I install and configure this permissive policy.

The next thing I want, is to create a "sandbox" Debian package which installs its own SELinux module. Sandbox should allow running programs with limited filesystem and network access as for usage of untrusted programs downloaded from the Web. It is required for a real project: http://freesoft.portonvictor.org/namespaces.xml (which I may implement as a proxy server which uses the "sandbox" binary from "sandbox" package, probably and/or as a command line program).

Next, suppose I decide that the default policy is no more buggy and switch the policy.

What does happen in this case? A disaster! The "sandbox" module installed for the permissive policy is not installed for the default policy. So "sandbox" may not work and allow access of untrusted programs to my files.

^^ This is the first trouble.

The second trouble is known to all of you: When we edit /etc/selinux/config the attributes of the filesystem are not updated automatically.

My proposed solution follows. The solution requires refactoring of SELinux policies and modules installation, but it is certainly a job worth to do.

Manual editing of /etc/selinux/config should be deprecated.

Instead there should be a command which:

- allows to choose a policy from several installed policies (and also to enable/disable SELinux).

- when it is requested to change a policy, it should be recompiled with all installed SELinux modules. If compilation fails, the policy should not be changed (a security requirement!) (this may require compilation into a temporary directory before actual installation of the modules)

When installed, non-base modules should be kept say in /etc/selinux/modules/ so that they could be reinstalled when switching policy.

An other benefit of editing the configuration such as /etc/selinux/config only with a special command, is that the FS can be automatically relabeled when policy is switched or enabled after being disabled.

Please take my proposal seriously:

- It is a real-life trouble which needs to be solved (in Debian and other systems).

- It is a security threat. Think seriously about sandbox suddenly allowing any actions to a program downloaded from the Web!

I may or may not work on this refactoring myself: I am not a system programmer, but I am willing to work for this project.

P.S. I may probably develop the above mentioned permissive policy for Debian, as I can't work with buggy default policy. Then I want to invest my goodness into creating a robust sandbox.

--
Victor Porton - http://portonvictor.org
