Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7M0joxb023478
 for <selinux@tycho.nsa.gov>; Sun, 21 Aug 2016 20:45:50 -0400
Received: by mail-ua0-f172.google.com with SMTP id 97so163256496uav.3
 for <selinux@tycho.nsa.gov>; Sun, 21 Aug 2016 17:45:45 -0700 (PDT)
MIME-Version: 1.0
From: Jordan Zebor <jzebor@gmail.com>
Date: Sun, 21 Aug 2016 17:45:44 -0700
Message-ID: <CA+R10RLGqt1Q53x_w-UhT_FwhiqzM+a61vq-PchEuQ6VLkz+7w@mail.gmail.com>
Subject: Bug Report - "sepolicy manage"
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

To whom it may concern,

This is a bug report for file:
"selinux/policycoreutils/sepolicy/sepolicy/generate.py"
Lines: 218, 219, 232

The policy object "symbols" dictionary contains duplicate keys for
"openlog" and "pam_". The impact of this pattern can be observed later
when the gen_symbols method is called.

If openlog is a found symbol, I've observed that
"set_use_syslog(True)" is always used. The dictionary data structure
in python doesn't support duplicate keys and mutable, so the last
value parsed overwrites any previously set values.

As it is, "set_use_kerb_rcache", "set_use_kerberos" or "set_use_pam"
do not appear in the symbols dictionary, so they will never make it
into policy when gen_symbols checks the output of the binary symbol
table.

Python Dictionary References
https://docs.python.org/2/tutorial/datastructures.html#dictionaries
https://docs.python.org/3/tutorial/datastructures.html#dictionaries

Thanks,

Jordan
