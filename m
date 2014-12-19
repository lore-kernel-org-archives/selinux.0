Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sBJJijfr032264
 for <selinux@tycho.nsa.gov>; Fri, 19 Dec 2014 14:44:45 -0500
Received: by mail-la0-f54.google.com with SMTP id pv20so1435092lab.13
 for <selinux@tycho.nsa.gov>; Fri, 19 Dec 2014 11:44:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54945543.7090706@redhat.com>
References: <54945543.7090706@redhat.com>
Date: Fri, 19 Dec 2014 13:44:42 -0600
Message-ID: <CAHZ_Ajv=-P5baKoGNXgd-v9SAZhXkVmc2DpaBrVh2_ErSoQF_Q@mail.gmail.com>
Subject: Re: Some of our customers are looking to turn on SELinux but they
 also want to use CSP from Symantec
From: eric gisse <jowr.pi@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Content-Type: text/plain; charset=UTF-8
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

> Why disabling SELinux is important? Because both SELinux and CSP are doing the same thing, except CSP does it better!

I wonder how Symantec backs that claim up.

On Fri, Dec 19, 2014 at 10:41 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Currently Symantec requires SELinux be disabled, claiming there is
> conflicts in the kernel modules.
>
> http://www.symantec.com/connect/forums/does-scsp-agent-support-selinux
>
> As the customer wants to take advantage of certain  SELinux features
> like sVirt for VMs and Docker Containers, this conflict is coming to a head.
>
> Is anyone familiar with whether or not this is a real conflict or just
> something assumed by Symantec?
>
> The customer like Symantec's ability to do intrusion detection and
> remote logging and configuration of CSB.
>
> Bottom line the customer wants both.
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
