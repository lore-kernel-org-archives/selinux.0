Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8NJ9YiH030868
	for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2011 15:09:34 -0400
Received: from cp-out7.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p8NJ9XxR005496
	for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2011 19:09:33 GMT
Message-ID: <1316804960.2487.62.camel@vortex>
Subject: Re: [refpolicy] pam_selinux(gdm-password:session): Security Context
 justin:staff_r:insmod_t:s0 Assigned
From: Guido Trentalancia <guido@trentalancia.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Date: Fri, 23 Sep 2011 21:09:20 +0200
In-Reply-To: <4E7CC41E.5040004@redhat.com>
References: <1316144432.85313.YahooMailNeo@web114304.mail.gq1.yahoo.com>
	  <4E736453.8000506@redhat.com> <4E7369AF.3000709@yahoo.com>
	  <4E737223.1060601@redhat.com> <1316795427.12007.110.camel@vortex>
	 <4E7CC41E.5040004@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2011-09-23 at 13:38 -0400, Daniel J Walsh wrote:
> On 09/23/2011 12:30 PM, Guido Trentalancia wrote:
> > On Fri, 2011-09-16 at 11:58 -0400, Daniel J Walsh wrote:
> >> On 09/16/2011 11:22 AM, Justin P. Mattock wrote:
> >>> On 09/16/2011 07:59 AM, Daniel J Walsh wrote:
> >>>> ps -eZ |grep sshd
> >>> I dont have sshd running, but here is ps auxZ to give you an
> >>> idea of what I am seeing: http://fpaste.org/u6IB/
> >>> 
> >>> if I adjust /etc/pam.d/login and add select_context to 
> >>> pam_selinux.so then do init 3 in lilo I am able to have the 
> >>> context justin:staff_r:staff_t:s0  the way it should. but as
> >>> soon as I init 5 gdm starts up, and everything goes back to 
> >>> name:staff_r:insmod_t:s0
> >>> 
> >>> I think I am either missing a boolean to have the transisiton 
> >>> runing properly, and/or pam.d or some config file somewhere
> >>> needs to be adjusted. keep in mind refpolicy has no patches
> >>> added to it(not sure if I need any for systemd), just plain git
> >>> pull etc...
> >>> 
> >>> Justin P. Mattock
> >> Well since you don't have a init_t running, I think your problem 
> >> starts there.  Looks like your system is badly mislabeled or
> >> something in init is broken.   I take it this is not a Red Hat
> >> Based OS?
> > 
> > I'd actually like to take this opportunity to stress once again
> > that in my opinion the system boot/init process should fail
> > irreversibly as soon as the init process has failed to transition
> > to its own designated context from the initial kernel context.
> > 
> > Regards,
> > 
> > Guido
> > 
> > 
> > -- This message was distributed to subscribers of the selinux
> > mailing list. If you no longer wish to subscribe, send mail to
> > majordomo@tycho.nsa.gov with the words "unsubscribe selinux"
> > without quotes as the message.
> > 
> > 
> Well it does crash if you are in enforcing mode on RHEL and Fedora boxes.

Yes, very good. At the end, a very polite message is not the first
priority in such as situation...

But unfortunately this is not the case for the upstream bits.

Ideally should be tackled in the SELinux kernel code. Did RHEL and
Fedora patch the kernel then to achieve that ?

Regards,

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
