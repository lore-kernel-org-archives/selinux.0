Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t09LqQUM008649
 for <selinux@tycho.nsa.gov>; Fri, 9 Jan 2015 16:52:26 -0500
Received: by mail-we0-f175.google.com with SMTP id k11so10192299wes.6
 for <selinux@tycho.nsa.gov>; Fri, 09 Jan 2015 13:52:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1420837553.31986.2.camel@gmail.com>
References: <1420837553.31986.2.camel@gmail.com>
Date: Fri, 9 Jan 2015 16:52:18 -0500
Message-ID: <CAB9W1A3Y_+gZv=ZWGTGvuk_z8P_Ys7SVNAUz8wRCS1EDW_dcJg@mail.gmail.com>
Subject: Re: RFC: https://bugzilla.redhat.com/show_bug.cgi?id=1174405
From: Stephen Smalley <stephen.smalley@gmail.com>
To: Dominick Grift <dac.override@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Ports in the local port range can be auto-assigned by the kernel to
unbound sockets on first use.  So it makes no sense to control them,
and there isn't even an LSM hook in the place where such auto-port
selection occurs.  Controlling binding to ports is only useful when
the port number is a "name" (i.e. a well-defined value that is
expected to correspond to a specific service), to prevent spoofing of
security-relevant services like sshd.

On Fri, Jan 9, 2015 at 4:05 PM, Dominick Grift <dac.override@gmail.com> wrote:
> https://bugzilla.redhat.com/show_bug.cgi?id=1174405
>
> This is a inconsistency in SELinux
>
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
