From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: named policy patch
Date: Tue, 12 Apr 2005 23:56:43 +1000
Cc: SELinux@tycho.nsa.gov
References: <200504122326.33930.russell@coker.com.au> <425BCF41.80403@redhat.com>
In-Reply-To: <425BCF41.80403@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200504122356.46860.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 12 April 2005 23:38, Daniel J Walsh <dwalsh@redhat.com> wrote:
> >+/usr/sbin/named-checkconf --	system_u:object_r:named_checkconf_exec_t
>
> Why not just label chckconf as named_exec_t?

We don't want a transition from sysadm_t when the administrator runs it.  
named_t does not have access to sysadm_tty_device_t or sysadm_devpts_t, I 
believe that if the startup fails then the administrator will want to run 
named-checkconf as part of a debugging process and will therefore need to 
have it running in sysadm_t to display the results.

It's exactly the same as the situation with ntpdate.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
