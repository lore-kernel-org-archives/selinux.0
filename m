From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Patch for strict policy
Date: Sun, 26 Sep 2004 02:57:42 +1000
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <41542FF5.2090502@redhat.com>
In-Reply-To: <41542FF5.2090502@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409260257.42394.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 25 Sep 2004 00:32, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Added policy templates for swat, ktalkd, in.comcast, and rsyn daemons to
> be run by xinetd.
> Separated out inetd_child_t context into a macro.
> Mailman fixes

-allow udev_t self:capability { chown dac_override dac_read_search fowner 
fsetid sys_admin mknod };
+allow udev_t self:capability { chown dac_override dac_read_search fowner 
fsetid sys_admin mknod net_raw net_admin };

What is udev doing that requires net_raw and net_admin?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
