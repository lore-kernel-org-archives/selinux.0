Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4JFmo2c018328
 for <selinux@tycho.nsa.gov>; Tue, 19 May 2015 11:48:50 -0400
Received: by wicmx19 with SMTP id mx19so121943785wic.0
 for <selinux@tycho.nsa.gov>; Tue, 19 May 2015 08:48:48 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 19 May 2015 10:48:48 -0500
Message-ID: <CAFPpqQF4RPxtJZcdDB_2yke_L+hX4vSk98vOzeFt-EVfznu3+g@mail.gmail.com>
Subject: exec'ing new process with different type and MLS level
From: Ted Toth <txtoth@gmail.com>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I've got a process that runs at SystemHigh who's type has lots of mac
privileges call it x_t  that execs (calling fork, setexeccon and then
execv) other processes in a less privileged type call it y_t and at
'lower' levels. Between the fork and exec I also close all of the file
descriptor 0 to maxfd. The issue is that there are MLS constraint AVCs
generated for the y_t 'use' access of the fd for ld.so because it is
labeled x_t:SystemHigh. Since I did the setexeccon to y_t I'd have
thought that ld.so would have been opened as y_t. What am I missing
here?

Ted
