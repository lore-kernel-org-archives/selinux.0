From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Colin Walters <walters@redhat.com>
Subject: Re: chfn/passwd
Date: Sun, 25 Apr 2004 22:24:16 +1000
Cc: SELinux@tycho.nsa.gov
References: <4088d1b8.2a5.1877.956371590@internode.on.net> <1082727010.6575.3.camel@nexus.verbum.private>
In-Reply-To: <1082727010.6575.3.camel@nexus.verbum.private>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200404252224.16624.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 23 Apr 2004 23:30, Colin Walters <walters@redhat.com> wrote:
> On Fri, 2004-04-23 at 04:20, keen@internode.on.net wrote:
> > Hi, I am running the December release on a 2.6.2 kernel on a
> > FC1. I have realised normal users could not change their
> > finger name as well as changing password under enforcement
> > mode.
>
> I remember fixing a bug like this in the FC2 policy a few weeks ago,
> maybe it was also in the upstream policy.  After mining my email a bit,
> here's the patch I came up with at the time.  Not sure if you're running
> into the same problem, you'd need to post the exact AVC messages.

The original chfn policy was written when we used the "spasswd" wrapper 
for /bin/passwd.  At that time there was no code called by chfn etc to set 
types, so the chfn policy just defined automatic type transitions (which 
resulted in the identity of the user in question being assigned 
to /etc/passwd - so anyone could see who last changed their finger name).  
Now that we have PAM code to relabel /etc/passwd (necessary to remove the 
spasswd wrapper) we need privowner so that it can change the identity 
of /etc/passwd.  Lack of this access should result in chfn failing when it 
calls setfscreatecon().

I guess that no-one had tested chfn since the time of spasswd.  ;)

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
