Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7VBoVoC007934
 for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2016 07:50:31 -0400
Received: by mail-pf0-f173.google.com with SMTP id y134so18923632pfg.0
 for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2016 04:50:24 -0700 (PDT)
Date: Wed, 31 Aug 2016 19:50:20 +0800
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov, refpolicy@oss.tresys.com
Subject: Re: Creating a new port type
Message-ID: <20160831115020.GA23970@meriadoc.perfinion.com>
References: <578825cb-5d96-1d51-c89e-40d7ee5cad03@gmail.com>
 <efaaf380-5195-8d8f-9555-21bc6bf87663@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <efaaf380-5195-8d8f-9555-21bc6bf87663@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Aug 31, 2016 at 12:51:27PM +0200, Lukas Vrabec wrote:
> 
> 
> Blog by Dan Walsh will helps you.
> 
> http://danwalsh.livejournal.com/10607.html
> 
> Lukas.

Im sending this to the reference policy ML since thats a better place
for it.

The way in the blog post is if you have your own policy that is not part
of upstream. If you want the port to work properly by default it needs
to be in base.pp.
Look in policy/modules/kernel/corenetwork.te.in. You just need to
add one more line and it creates all the interfaces and types for you.

-- Jason

> 
> 
> On 08/30/2016 11:46 PM, Ian Pilcher wrote:
> > I am attempting to write my first SELinux policy module (for the
> > Logitech Media Server/squeezeboxserver).  I would like to add a new
> > port type (slim_devices_port_t) for TCP and UDP 3483.
> >
> > I haven't been able to find an example of how to do this, except for
> > stunnel.te, and the comments in that file don't lead me to believe that
> > it is the right way to do things.
> >
> > Any pointers to examples or documentation would be appreciated.
> >
> > Thanks!
> >
> 
> 
> -- 
> Lukas Vrabec
> SELinux Solutions
> Red Hat, Inc.
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
