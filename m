From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Latest Diffs.
Date: Sat, 28 Aug 2004 22:46:20 +1000
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <412CAE6B.30006@redhat.com>
In-Reply-To: <412CAE6B.30006@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408282246.20447.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 26 Aug 2004 01:21, Daniel J Walsh <dwalsh@redhat.com> wrote:
> We now have named booleans working with named master updates.
>
> Added can_ypbind to lots of te files to support NIS environments.

If we are going to add can_ypbind() to every daemon domain then why not put it 
in daemon_core_rules()?

We don't want to have duplicate policy in all .te files, that makes it harder 
to read and analyse, increases errors (both omitting needed access and 
permitting unwanted access).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
