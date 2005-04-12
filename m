Subject: Re: dhcpd policy settings
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Junji Kanemaru <linux@linuon.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <425B780B.20605@linuon.com>
References: <425B6127.3060808@linuon.com>  <425B780B.20605@linuon.com>
Content-Type: text/plain
Date: Tue, 12 Apr 2005 08:25:41 -0400
Message-Id: <1113308741.25217.36.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-04-12 at 16:26 +0900, Junji Kanemaru wrote:
> Well this is self reply though, I kinda found the reason that what caused
> the problem. I have created my daemon's home in /var/lib/my_daemon
> and it caused file_context to have setting home_root_t:dir for /var/lib.
> I'm going to create file context settings for my daemon.
> 
> Sorry for the bandwith,

If you try the latest genhomedircon script from the sourceforge CVS tree
(or rawhide if using Fedora Core), do you still have this problem?
genhomedircon was recently rewritten to try to avoid assigning the home
types to anything that has an entry in the base file contexts
configuration.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
