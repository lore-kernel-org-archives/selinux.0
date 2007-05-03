Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l43CeauU018160
	for <selinux@tycho.nsa.gov>; Thu, 3 May 2007 08:40:36 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l43CeYQe024683
	for <selinux@tycho.nsa.gov>; Thu, 3 May 2007 12:40:34 GMT
Subject: Re: logwatch tries to look at avahi, avahi needs to use winbind
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4638F3CA.6020103@redhat.com>
References: <200704201854.l3KIs47L027135@redsox.boston.devel.redhat.com>
	 <1178128320.445.9.camel@sgc.columbia.tresys.com>
	 <4638F3CA.6020103@redhat.com>
Content-Type: text/plain
Date: Thu, 03 May 2007 12:40:10 +0000
Message-Id: <1178196010.445.49.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-02 at 16:25 -0400, Daniel J Walsh wrote:
> Christopher J. PeBenito wrote:
> > On Fri, 2007-04-20 at 14:54 -0400, dwalsh@redhat.com wrote:
> >> --- nsaserefpolicy/policy/modules/services/avahi.te	2007-03-20 23:38:05.000000000 -0400
> >> +++ serefpolicy-2.5.12/policy/modules/services/avahi.te	2007-04-18 16:04:51.000000000 -0400
> >> @@ -105,3 +105,7 @@
> >>  optional_policy(`
> >>  	udev_read_db(avahi_t)
> >>  ')
> >> +
> >> +optional_policy(`
> >> +	samba_stream_connect_winbind(avahi_t)
> >> +')
> >>     
> >
> > Merged except for this last part.  I can't find any reference in the
> > avahi code or wiki for it connecting to windbind.
> 
> Right, turns out avahi uses nsswitch, and this is causing the avc.  
> Attached patch to switch to using nsswitch.

Merged, except I made it unconditional, since I see usage of getpwnam()
and getgrnam() in main.c of avahi-daemon.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
