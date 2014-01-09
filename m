Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s09JcP0R015237
 for <selinux@tycho.nsa.gov>; Thu, 9 Jan 2014 14:38:25 -0500
Received: from web13m.yandex.ru (web13m.yandex.ru [37.140.138.104])
 by forward1m.mail.yandex.net (Yandex) with ESMTP id E9A071221364
 for <selinux@tycho.nsa.gov>; Thu,  9 Jan 2014 23:38:21 +0400 (MSK)
From: Victor Porton <porton@narod.ru>
To: selinux@tycho.nsa.gov
Subject: My proposal for a new feature in Linux kernel
MIME-Version: 1.0
Message-Id: <47061389296301@web13m.yandex.ru>
Date: Thu, 09 Jan 2014 21:38:21 +0200
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

So my final proposal:

struct full_sockaddr_t {
  struct sockaddr *ADDR;
  socklen_t LENGTH;
};

// Syscall
int selinux_restrict_domains(struct full_sockaddr_t *socks, unsigned int num_socks);

This call would restrict the sockets accessed by a process (and its childs) to the specified array of socket addresses.

For security reasons it should be impossible to add more hosts to this list. (We may allow to further restrict.)

Please implement it in Linux kernel.

-- 
Victor Porton - http://portonvictor.org
