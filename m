Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9UL5BBB002861
 for <selinux@tycho.nsa.gov>; Sun, 30 Oct 2016 17:05:11 -0400
Received: by mail-wm0-f41.google.com with SMTP id n67so197480789wme.1
 for <selinux@tycho.nsa.gov>; Sun, 30 Oct 2016 14:05:09 -0700 (PDT)
Received: from [192.168.0.14] (81-66-120-207.rev.numericable.fr.
 [81.66.120.207])
 by smtp.googlemail.com with ESMTPSA id 130sm21153054wmf.0.2016.10.30.14.05.06
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 30 Oct 2016 14:05:07 -0700 (PDT)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: State of rpm_execcon SWIG wrapper
To: selinux@tycho.nsa.gov
Message-ID: <22209650-ddac-d265-6928-43896a0a26cb@m4x.org>
Date: Sun, 30 Oct 2016 22:05:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

While testing a few things on the SWIG wrappers (like compiling them
with clang and a bunch of warnings), I got the following warning:

    selinuxswig_wrap.c:12253:11: error: variable 'arg4' is uninitialized
    when used here [-Werror,-Wuninitialized]
            while(arg4[i]) {
                  ^~~~

After digging a little bit, I find out that the following command (which
does an invalid call to rpm_execon wrapper) triggers a segmentation
fault on my system:

    python -c 'import selinux;selinux.rpm_execcon()'

This bug can be fixed by adding some magic to selinuxswig_python.i (for
example "%typemap(arginit) char * const [] { $1 = NULL; }" and a few
more things). After this I found two other issues in this wrapper:

  * The size of the buffer which is allocated to copy argv and envp is
too small: the code uses "malloc(size + 1)" instead of "calloc(size + 1,
sizeof(char *))" [1]. This makes some valid call to
selinux.rpm_execcon() overflow a memory block allocated on the heap.
  * The memory allocated with this malloc is leaked if one argument of
rpm_execon is not a sequence of bytes [2]. Replacing the "return NULL;"
with "SWIG_fail;" can fix this issue.

Instead of writing patches to fix all these bugs, I am wondering whether
anyone is still using this interface, which has been deprecated since
2012 [3] and which can be removed at compile-time by using
"DISABLE_RPM=y". Is this interface going to be removed soon? Or is it
worth spending time to fix it?

Cheers,
Nicolas

[1]
https://github.com/SELinuxProject/selinux/blob/libselinux-2.6/libselinux/src/selinuxswig_python.i#L171
[2]
https://github.com/SELinuxProject/selinux/blob/libselinux-2.6/libselinux/src/selinuxswig_python.i#L177
[3]
https://github.com/SELinuxProject/selinux/commit/a2737333c795cae2aa4e31deed95a8e155d64d4a
