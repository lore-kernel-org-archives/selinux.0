From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Not sure the best way to handle this one.
Date: Sat, 16 Oct 2004 23:44:56 +1000
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
References: <416FCFEB.90504@redhat.com>
In-Reply-To: <416FCFEB.90504@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410162344.56706.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 15 Oct 2004 23:26, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Oct 15 08:37:55 dhcppc1 kernel: audit(1097843874.920:692545): avc:
> denied  { sys_module } for  pid=4338 exe=/usr/bin/nifd capability=16
> scontext=system_u:system_r:howl_t tcontext=system_u:system_r:howl_t
> tclass=capability

What is it trying to do?  Does an strace shed any light on the matter?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
