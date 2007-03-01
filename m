Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l217uUUw019108
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 02:56:30 -0500
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l217vqCO026137
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 07:57:53 GMT
Received: by wr-out-0506.google.com with SMTP id 37so131251wra
        for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2007 23:57:52 -0800 (PST)
Message-ID: <e739902b0702282357i2f5645bbmab4c04a0bdb1d3f3@mail.gmail.com>
Date: Wed, 28 Feb 2007 23:57:41 -0800
From: "Ryan Bradetich" <rbradetich@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Failed write to /selinux/context in selinux_trans_to_raw_contex()
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello all,

I have tracked down a problem that prevents me from logging into my
system when I build a policy that only has the base modules defined.
All the notes below are using revision 2202 of the reference policy
(sorry for the length of the email, these are my notes while  tracking
down the problem... hopefully something in them will offer some
insight to the problem).   This problem is very reproducible for me:

   base-only policy:
       1. make bare
       2. make conf
       3. vi policy/modules.conf (:1,$s/= module/= off/g)
       4. make policy
       5. make load
       6. sync
       7. reboot

   everything policy:
       1. make bare
       2. make conf
       3. make policy
       4. make load
       5. sync
       6. reboot

    kernel version: 2.6.20

I am really hoping for a description of what is supposed to happen, so
I better understand how the security server works.   My end goal is to
continue stripping down the reference policy to the bare minimum so I
can build a custom security policy for my embedded research project.

The problem I am seeing now is when I attempt to log into the system
with SELinux enabled, but in permissive mode the get_default_context()
in libselinux1 returns an error.  This error prevents me for logging
into the system, but when I boot the system with the selinux=0 kernel
parameter I am able to log into the system fine.

Here are my notes:

1. The login busybox applet makes a call to get_default_context() in
the libselinux1 library.  It passes the following arguments:
      user: "root"
      fromcon:  NULL,
      newcon: &user_sid;

2. get_default_context() calls the get_ordered_context_list(), also in
the libselinux1 library.  This function returns -1.

3. get_ordered_context_list()  calls the security_compute_user(), also
in the libselinux1
library.  This function returns 0.

4. In security_compute_user()
      The following check is passed: selinux_trans_to_raw_context()

5. check_compute_user() calls the security_compute_user_raw() function.
      The selinux_mnt is defined.
      Was able to open /selinux/user
      Was able to allocate memory.
      Was able to write to /selinux/user
      Was able to read from /selinux/user
      nel = 0

At this point the security_compute_user_raw() and check_compute_user()
both fall through and drop back to the get_ordered_context_list().
The nreach variable is calculated and ends up 0, where it goes jumps
to the failsafe label.

[NOTE: why are we in the failsafe?  Seems like I am missing something
that would avoid this step].

Tracing down into the failsafe label  I found the following:

6.  Makes a call to the get_failsafe_context.
     Open the selinux_failsafe_context_path()
     Perform a fgets_unlocked from the file descriptor
     Allocate a new conn using information from the
selinux_failsafe_context_path.
     Call the security_check_context()

7. The security_check_context() calls the selinux_trans_to_raw_context().

8.  The selinux_trans_to_raw_context does the following:
      opens /selinux/context
      writes to /selinux/context


This write system call is the difference between the everything policy
and the base-only policy files.   With the everything policy, this
write command successfully writes 23 bytes.   In the base-only policy,
the write command fails and sets errno to 22.


Thanks!

- Ryan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
