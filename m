Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t0JELZc2006220
 for <selinux@tycho.nsa.gov>; Mon, 19 Jan 2015 09:21:35 -0500
Message-ID: <54BD12EE.3060106@itechfrontiers.com>
Date: Mon, 19 Jan 2015 09:21:34 -0500
From: "Patrick K.,   ITF" <cto@itechfrontiers.com>
MIME-Version: 1.0
To: Ted Toth <txtoth@gmail.com>
Subject: Re: Selinux for Go
References: <54BCF7BD.7010702@itechfrontiers.com>
 <CAFPpqQEN2ZY9kaDms6VMjYtRKGoKrdGSdj-k4XccNhNqMSQC5w@mail.gmail.com>
In-Reply-To: <CAFPpqQEN2ZY9kaDms6VMjYtRKGoKrdGSdj-k4XccNhNqMSQC5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Ted,

That's not available in RHEL 6.6 & 7

I suppose your OS is Fedora Right?

Plus github.com/selinux/selinux.go  NOT FOUND

I'm Looking For Mr. Daniel Walsh's implementation which was here before:

http://people.fedoraproject.org/~dwalsh/SELinux/


Best regards,


-- 
  Patrick K. Kashi

On 1/19/2015 9:08 AM, Ted Toth wrote:
> rpm -q libselinux-devel -l | grep go
> /usr/lib64/golang/src/pkg/github.com/selinux
> /usr/lib64/golang/src/pkg/github.com/selinux/selinux.go
>
>
> On Mon, Jan 19, 2015 at 6:25 AM, Patrick K.,   ITF
> <cto@itechfrontiers.com> wrote:
>> Hello,
>>
>> I'm looking for lib SELinux binding for Go (Lang)
>>
>>   http://people.fedoraproject.org/~dwalsh/SELinux/
>>
>> Any idea?
>>
>> Best regards,
>>
>>
>>   Patrick K. Kashi
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to
>> Selinux-request@tycho.nsa.gov.
