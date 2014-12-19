Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sBJHx5px025592
 for <selinux@tycho.nsa.gov>; Fri, 19 Dec 2014 12:59:06 -0500
Message-ID: <54946769.4030107@schaufler-ca.com>
Date: Fri, 19 Dec 2014 09:59:05 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>,
 LSM <linux-security-module@vger.kernel.org>
Subject: Re: Some of our customers are looking to turn on SELinux but they
 also want to use CSP from Symantec
References: <54945543.7090706@redhat.com>
In-Reply-To: <54945543.7090706@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/19/2014 8:41 AM, Daniel J Walsh wrote:
> Currently Symantec requires SELinux be disabled, claiming there is
> conflicts in the kernel modules.
>
> http://www.symantec.com/connect/forums/does-scsp-agent-support-selinux

Based on the fact they are also disparaging AppArmor and a couple of
out-of-tree security modules, and that SELinux=permissive is not sufficient
I'm assuming it's an out-of-tree security module.


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

It would help if someone from the SELinux community would comment on
the v18 concurrent security modules patches. Moving that work forward
is your best step toward getting what you need. Of course, v18 doesn't
get you all the way, but it gets closer.

> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>
