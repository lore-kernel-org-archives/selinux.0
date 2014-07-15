Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6F9P5Um003588
 for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2014 05:25:06 -0400
Date: Tue, 15 Jul 2014 13:25:07 +0400
From: Christian Evans <frodox@zoho.com>
To: <linux-security-module@vger.kernel.org>, <selinux@tycho.nsa.gov>
Message-ID: <147394c7bdf.1664242132703898203.-4933980174869987134@zoho.com>
Subject: NetLabel lead to kernel panic with some SELinux levels
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

While using network with configured NetLabel it lead to kernel panic on some SELinux levels.

I used netlabel_tools-0.19-7.el6.x86_64.rpm and kernel rhel7 3.10.0-123.el7.x86_64.
Also I reproduced it on RHEL 6.3/7.0, CentOs 6.5/7.0, Fedora 20. That is what I have been tested. I think it can be reproduced on older versions/kernels too.

# Steps to Reproduce:

1. Setup NetLabel. [Assume that 192.168.56.* --- local network (VBox HostOnly, for example) ]

# netlabelctl cipsov4 add pass doi:1 tags:5
# netlabelctl map del default
# netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
# netlabelctl map add default address:192.168.56.101/16 protocol:cipsov4,1

2. Give some user selinux range s0-s0:c0.c1023

... (this line depend on a distro, but idea the same)
# semanage login -mr s0-s0:c0.c1023 myuser1

# setenforce 1 (just in case)

3. Login with `myuser1`, change selinux level and ping someone in your local network 

login: myuser1
password: ...

$ newrole -l s0:c255,c800
Password ...

$ ping 192.168.56.1 (some another PC)


# Actual results:

It will lead to kernel panic.
If not, exit and try with another level (see Additional info).


# Expected results:

Receive ping reply (marked one, due to NetLabel configured).


# Additional info:

RHEL fails with all of this levels:
1. s0:c255,c800
2. s0:c350,c800
3. s0:c500,c800
4. s0:c255,c513
5. s0:c500,c513
6. s0:c511,c513
7. s0:c510,c512
8. ... (I think, there are more of them)

CentOs and Fedora sometimes fails not with first, but with second or third one.

---

I used kdump to debug this crash and it looks like there are problems in netlbl_secattr_catmap_setrng() and netlbl_secattr_catmap_setbit() function, because of
"BUG: unablle to handle kernel paging request at ... from netlbl_secattr_catmap_setbit" (from logs).

I think, there are problem while parsing received packet, because another interesting case:
* setup client and server PC with same config (netlabel and user levels)
* start, for example, nc -l 5555 on server
* start nc 192.168.56.1 (server ip) 5555 from client. It will lead to server panic :)

Looks like I found some issues in logic, but my patch didn't work yet, so ...

---
Regards,
Christian.
