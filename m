Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7QGmnj1010983
 for <selinux@tycho.nsa.gov>; Fri, 26 Aug 2016 12:48:49 -0400
Received: from process-dkim-sign-daemon.mr25p46im-ztdg02101301.me.com by
 mr25p46im-ztdg02101301.me.com
 (Oracle Communications Messaging Server 7.0.5.38.0 64bit (built Feb 26 2016))
 id <0OCI00H00ZVI6500@mr25p46im-ztdg02101301.me.com> for selinux@tycho.nsa.gov;
 Fri, 26 Aug 2016 16:48:45 +0000 (GMT)
From: ileyd <ileyd@icloud.com>
Content-type: text/plain; charset=us-ascii
MIME-version: 1.0 (1.0)
Subject: Re: MLS Enforcing Problem
Message-id: <C3AAB836-C2CB-4EA0-8EEF-ACB000B82C24@icloud.com>
Date: Sat, 27 Aug 2016 02:48:40 +1000
References: <CAFC8oaeE46DS5MqpbH5NNL7WWorTQZifkfN1QjpdD7Zu_Ken2A@mail.gmail.com>
In-reply-to: <CAFC8oaeE46DS5MqpbH5NNL7WWorTQZifkfN1QjpdD7Zu_Ken2A@mail.gmail.com>
To: Kashif ali <kashif.ali.9498@gmail.com>, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

Could you give more detail?  What operating system are you running, what error message exactly are you getting, etc.

This sounds vaguely like an issue that seems to be present on EL7 and later, and all remotely recent fedora versions.  

The issue seems to be caused by /etc being labelled as SystemHigh instead of SystemLow, despite the policy.  If you start the system in permissive mode, relabel it manually, and then put in in enforcing mode, you're able to login, etc.  I'm not sure what causes it or how to fix it.

Kind Regards,
ileyd

> On 26 Aug 2016, at 7:44 PM, Kashif ali <kashif.ali.9498@gmail.com> wrote:
> 
> Hi
> * I'm facing an issue which is as follow 
>   When Selinux is in enforcing mode and Policy type is Mls after relabeling of whole system it doesn't Allow me to login it gives me error login incorrect did i missing something? or it is something else.
> Thanks
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
