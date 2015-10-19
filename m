Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9JEdV4w003284
 for <selinux@tycho.nsa.gov>; Mon, 19 Oct 2015 10:39:31 -0400
Subject: Re: how to troubleshoot SELinux when auditd won't start?
To: Bond Masuda <bond.masuda@jlbond.com>, selinux@tycho.nsa.gov
References: <562355F4.2040303@jlbond.com>
From: Daniel J Walsh <dwalsh@redhat.com>
Message-ID: <5625009E.9070502@redhat.com>
Date: Mon, 19 Oct 2015 10:39:26 -0400
MIME-Version: 1.0
In-Reply-To: <562355F4.2040303@jlbond.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Avcs should show up in the /var/log/messages or the journal even if
audit is not running.

On 10/18/2015 04:19 AM, Bond Masuda wrote:
> I'm running into an issue where SELinux is preventing auditd from
> starting. But I can't figure out exactly what SELinux is not happy
> about since without auditd, I can't look for AVC messages. I think
> SELinux is blocking auditd from starting up because auditd starts up
> once I do 'setenforce 0'.
>
> Any advice?
> Bond
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>
>
