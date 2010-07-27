Subject: Re: help with a compiled policy and port 443
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: Ralph Blach <chipper19522@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4C4DF495.3000704@gmail.com>
References: <4C4DF495.3000704@gmail.com>
Content-Type: text/plain
Date: Tue, 27 Jul 2010 10:31:31 -0400
Message-Id: <1280241091.2673.51.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-07-26 at 16:48 -0400, Ralph Blach wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> good afternoon,
> I happen to be a novice at selinux and wish more familiar with it.
> 
> This worked before but it does not work now.
> 
> I wish to put ssh on port 443
> 
> Before I used the commands
> 
> 
> semanage port -d -t http_port_t -p tcp 443
> semanage port -a -t sshd_port_t -p tcp 443
> 
> and these worked perfectly.
> 
> Now I get the error
> 
> semanage port -d -t http_port_t -p tcp 443
> /usr/sbin/semanage: Port tcp/443 is defined in policy, cannot be deleted
> [root@chipblach ~]#
> 
> 
> How do I get around this and and get semanage to function?
> 
> 
> what is a defined policy and how I edit it?
> 
> Thanks
> 

what I did was semanage port -m -t ssh_port_t -p tcp 443 and it added
443 to the list of ports for ssh_port_t. The issue is that 443 is still
listed under the ports for http_port_t as well. If I remember correctly
it should take the last change made as the label for the port. So even
though it says 443 for http_port_t it will match the entry for
ssh_port_t.

Dave


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
