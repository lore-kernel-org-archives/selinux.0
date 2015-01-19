Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t0JE8ED2005139
 for <selinux@tycho.nsa.gov>; Mon, 19 Jan 2015 09:08:14 -0500
Received: by mail-wg0-f53.google.com with SMTP id x13so31802414wgg.12
 for <selinux@tycho.nsa.gov>; Mon, 19 Jan 2015 06:08:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54BCF7BD.7010702@itechfrontiers.com>
References: <54BCF7BD.7010702@itechfrontiers.com>
Date: Mon, 19 Jan 2015 08:08:05 -0600
Message-ID: <CAFPpqQEN2ZY9kaDms6VMjYtRKGoKrdGSdj-k4XccNhNqMSQC5w@mail.gmail.com>
Subject: Re: Selinux for Go
From: Ted Toth <txtoth@gmail.com>
To: "Patrick K., ITF" <cto@itechfrontiers.com>
Content-Type: text/plain; charset=UTF-8
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

rpm -q libselinux-devel -l | grep go
/usr/lib64/golang/src/pkg/github.com/selinux
/usr/lib64/golang/src/pkg/github.com/selinux/selinux.go


On Mon, Jan 19, 2015 at 6:25 AM, Patrick K.,   ITF
<cto@itechfrontiers.com> wrote:
> Hello,
>
> I'm looking for lib SELinux binding for Go (Lang)
>
>  http://people.fedoraproject.org/~dwalsh/SELinux/
>
> Any idea?
>
> Best regards,
>
>
>  Patrick K. Kashi
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
