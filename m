Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8GG2vJC027573
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2011 12:02:57 -0400
Received: from cp-out9.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8GG2uej013050
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2011 16:02:56 GMT
Subject: Re: [refpolicy] pam_selinux(gdm-password:session): Security Context
 justin:staff_r:insmod_t:s0 Assigned
From: Guido Trentalancia <guido@trentalancia.com>
To: "Justin P. Mattock" <justinmattock@yahoo.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, tresys <refpolicy@oss1.tresys.com>,
        SE-Linux <selinux@tycho.nsa.gov>
Date: Fri, 16 Sep 2011 18:02:45 +0200
In-Reply-To: <4E7369AF.3000709@yahoo.com>
References: <1316144432.85313.YahooMailNeo@web114304.mail.gq1.yahoo.com>
	 <4E736453.8000506@redhat.com> <4E7369AF.3000709@yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316188965.2225.48.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2011-09-16 at 08:22 -0700, Justin P. Mattock wrote:
> On 09/16/2011 07:59 AM, Daniel J Walsh wrote:
> > ps -eZ |grep sshd
> I dont have sshd running, but here is ps auxZ to give you an idea of 
> what I am seeing:
> http://fpaste.org/u6IB/

Graphical environment is not running in the proper context.

Not even init has transitioned properly to its own context.

> if I adjust /etc/pam.d/login and add select_context to pam_selinux.so 
> then do init 3 in lilo I am able to have the context
> justin:staff_r:staff_t:s0  the way it should. but as soon as I init 5 
> gdm starts up, and everything goes back to name:staff_r:insmod_t:s0
> 
> I think I am either missing a boolean to have the transisiton runing 

Why don't you post the booleans that you're using then:

getsebool -a

For example, what are you using for init ? If you're using upstart, have
you set init_upstart=on ?

> properly, and/or pam.d or some config file somewhere needs to be adjusted.
> keep in mind refpolicy has no patches added to it(not sure if I need any 
> for systemd), just plain git pull  etc...

So are you using systemd for init ? There is a boolean called
init_systemd which possibly is similar to the above mentioned one for
upstart.

Start from tackling init running in the kernel context and not
transitioning to init_t. The rest might be mostly due to that: personal
experience.

> Justin P. Mattock

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
