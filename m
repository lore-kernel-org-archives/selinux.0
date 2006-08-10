From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Jim Meyering <meyering@redhat.com>
Subject: Re: does mv need a --context=CTX (-Z) option, too?
Date: Fri, 11 Aug 2006 08:56:24 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@redhat.com>,
        selinux@tycho.nsa.gov
References: <87hd0kc308.fsf@rho.meyering.net> <44DB4585.3070500@redhat.com> <87y7twijdm.fsf@rho.meyering.net>
In-Reply-To: <87y7twijdm.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608110856.28919.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 11 August 2006 03:35, Jim Meyering <meyering@redhat.com> wrote:
> Thanks, for your replies Dan and Karl.
> I'm glad I asked.  Barring objections (Russell?), cp's -Z/--context=CTX
> option will not make it to "upstream".

I think it's OK to have cp and friends just preserve the current context.  
Using matchpathcon is an optional extra, and --context=CTX isn't really 
required.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
