Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7UCOC8q018699
 for <selinux@tycho.nsa.gov>; Tue, 30 Aug 2016 08:24:12 -0400
Date: Tue, 30 Aug 2016 08:24:06 -0400 (EDT)
From: Simon Sekidde <ssekidde@redhat.com>
To: Kashif ali <kashif.ali.9498@gmail.com>
Cc: ileyd <ileyd@icloud.com>, SELinux <selinux@tycho.nsa.gov>
Message-ID: <6558120.7835182.1472559846164.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAFC8oacf3GMrD=H=157g211h4Z=D6sXOSHiThO8YqXchtYRtAA@mail.gmail.com>
References: <CAFC8oaeE46DS5MqpbH5NNL7WWorTQZifkfN1QjpdD7Zu_Ken2A@mail.gmail.com>
 <C3AAB836-C2CB-4EA0-8EEF-ACB000B82C24@icloud.com>
 <CAFC8oacf3GMrD=H=157g211h4Z=D6sXOSHiThO8YqXchtYRtAA@mail.gmail.com>
Subject: Re: MLS Enforcing Problem
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



----- Original Message -----
> From: "Kashif ali" <kashif.ali.9498@gmail.com>
> To: "ileyd" <ileyd@icloud.com>
> Cc: "SELinux" <selinux@tycho.nsa.gov>
> Sent: Friday, August 26, 2016 12:55:56 PM
> Subject: Re: MLS Enforcing Problem
> 
> i'm using centos 6.5 and there is no error after putting selinux in enforced
> machine won't allow me to login
> 

How are you trying to login? Is this through ssh? 
If so please make sure you have the 'ssh_sysadm_login' boolean enabled. 

> On Fri, Aug 26, 2016 at 9:48 PM, ileyd < ileyd@icloud.com > wrote:
> 
> 
> Hi,
> 
> Could you give more detail? What operating system are you running, what error
> message exactly are you getting, etc.
> 
> This sounds vaguely like an issue that seems to be present on EL7 and later,
> and all remotely recent fedora versions.
> 
> The issue seems to be caused by /etc being labelled as SystemHigh instead of
> SystemLow, despite the policy. If you start the system in permissive mode,
> relabel it manually, and then put in in enforcing mode, you're able to
> login, etc. I'm not sure what causes it or how to fix it.
> 
> Kind Regards,
> ileyd
> 
> > On 26 Aug 2016, at 7:44 PM, Kashif ali < kashif.ali.9498@gmail.com > wrote:
> > 
> > Hi
> > * I'm facing an issue which is as follow
> > When Selinux is in enforcing mode and Policy type is Mls after relabeling
> > of whole system it doesn't Allow me to login it gives me error login
> > incorrect did i missing something? or it is something else.
> > Thanks
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov .
> > To get help, send an email containing "help" to
> > Selinux-request@tycho.nsa.gov .
> 
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.

-- 
Simon Sekidde * Red Hat, Inc. * Westford, MA
gpg: 5848 958E 73BA 04D3 7C06 F096 1BA1 2DBF 94BC 377E 
