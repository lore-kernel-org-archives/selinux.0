Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6NGeUU3001638
 for <selinux@tycho.nsa.gov>; Sat, 23 Jul 2016 12:40:30 -0400
Received: by mail-oi0-f45.google.com with SMTP id l72so202273322oig.2
 for <selinux@tycho.nsa.gov>; Sat, 23 Jul 2016 09:40:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <43A9A938-AD9A-483C-8392-38AB64D87A2C@icloud.com>
References: <43A9A938-AD9A-483C-8392-38AB64D87A2C@icloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 23 Jul 2016 12:40:09 -0400
Message-ID: <CAHC9VhSU15SzCjWwFkfaU4tCHx9R4EtGM_atocbhCO4hkx663g@mail.gmail.com>
Subject: Re: Is there any SELinux support for labelled printing like with
 Trusted Extensions?
To: ileyd <ileyd@icloud.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, Jul 23, 2016 at 4:42 AM, ileyd <ileyd@icloud.com> wrote:
> Hi,
>
> Is there any support for labelled printing with SELinux like described here?
>
> https://docs.oracle.com/cd/E53394_01/html/E54841/manageprint-19.html#scrolltoc

Some time ago (RHEL5 timeframe) basic support for labeled printing was
added to CUPS.  However, I have no idea if that functionality is
currently maintained, or even still present in the CUPS code.

-- 
paul moore
www.paul-moore.com
