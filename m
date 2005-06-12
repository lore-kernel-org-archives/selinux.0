Date: Sun, 12 Jun 2005 16:25:05 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Valdis.Kletnieks@vt.edu
Cc: Park Lee <parklee_sel@yahoo.com>, Casey Schaufler <casey@schaufler-ca.com>,
   SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Question about integration of IPsec with SELinux?
Message-ID: <20050612152505.GD31033@lkcl.net>
References: <20050612021611.94597.qmail@web51501.mail.yahoo.com> <200506121234.j5CCYt4G009234@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200506121234.j5CCYt4G009234@turing-police.cc.vt.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Jun 12, 2005 at 08:34:54AM -0400, Valdis.Kletnieks@vt.edu wrote:

> OpenSSH and OpenSSL *both* suffer from the very real *practical* problem
> that their connections terminate in userspace, while IPsec terminates
> connections in the kernel.  


 ah - there _is_ a way round that: to use something like tun/tap.

 there's a VPN project i forget the name of... tinc, yes, it's called
 tinc.

 it's an entirely userspace VPN.

 it would, imo, be perfectly reasonable to add into tun/tap a means to
 pass selinux avc queries etc. over that.

 ... heck - why not? :)

 l.

 p.s. i _hate_ the concept of doing this kind of high-level
 work in userspace.  i _wish_ linus wasn't so damn stupidly pig-headed
 about monolithic kernels.  all this stuff would be _so_ much less
 hassle and so much a non-issue on top of an L4 microkernel or in the
 GNU/Hurd.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
