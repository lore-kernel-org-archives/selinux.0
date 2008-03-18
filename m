Subject: Re: policycoreutils semanage --proto --protocol inconsistent flags
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Caleb Case <ccase@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <E1JbcqS-0003pv-CG@shiva.hsd1.md.comcast.net.>
References: <E1JbcqS-0003pv-CG@shiva.hsd1.md.comcast.net.>
Content-Type: text/plain
Date: Tue, 18 Mar 2008 16:37:18 -0400
Message-Id: <1205872638.6466.140.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-03-18 at 10:31 -0400, Caleb Case wrote:
> semanage --help indicates two conflicting ways of using the port protocol flag:
> 
> # semanage --help | grep proto
> semanage port -{a|d|m} [-tr] [ -p protocol ] port | port_range
> 	-p, --proto      Port protocol (tcp or udp)
> 
> That is --protocol and --proto.
> 
> The code paths are similarly conflicted with --protocol as the 'valid_option', but --proto as the flag actually used in getopt. This results in --protocol not being recognized:
> 
> # semanage port -t ftp_port_t -a --protocol tcp 12345
> /usr/sbin/semanage: Options Error option --protocol not recognized 
> 
> The port is not added in this case.
> 
> Using --proto instead results in a 'not valid for port objects' error, but the error is ignored and the port added:
> 
> # semanage port -t ftp_port_t -a --proto tcp 12345
> --proto not valid for port objects
> 
> # semanage port -l | grep 12345
> ftp_port_t                     tcp      12345, 21
> 
> The man pages for semanage are also inconsistent.
> 
> This patch resolves the inconsistency to use --proto.

Thanks, merged.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
