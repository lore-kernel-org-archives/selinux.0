Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s2VM8UOg011904
 for <selinux@tycho.nsa.gov>; Mon, 31 Mar 2014 18:08:30 -0400
References: 
Message-ID: <1396303709.28726.YahooMailNeo@web124903.mail.ne1.yahoo.com>
Date: Mon, 31 Mar 2014 15:08:29 -0700 (PDT)
From: Andy Ruch <adruch2002@yahoo.com>
Subject: SSSD on a read-only filesystem
To: SELinux ML <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Reply-To: Andy Ruch <adruch2002@yahoo.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

I'm implementing SSSD on my RHEL 6.5 system with a read-only root filesystem. SSSD attempts to write a file to /etc/selinux/<policy>/logins that maps the linux user to an selinux user. However, this causes problems since /etc is read-only. I've played with mounting /etc/selinux/<policy>/logins in tmpfs and everything seems to work. My questions really comes down to:


1) Are there any security concerns with having the 'logins' directory in tmpfs? 


2) Are there any functional considerations if the 'logins' directory gets erased every time the system reboots?



Thanks,
Andy Ruch
