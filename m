Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sBQIxBYO017740
 for <selinux@tycho.nsa.gov>; Fri, 26 Dec 2014 13:59:11 -0500
Received: by mail-wi0-f176.google.com with SMTP id ex7so17534260wid.15
 for <selinux@tycho.nsa.gov>; Fri, 26 Dec 2014 10:59:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <2d35ff94.2ee0.14a7f51cad5.Coremail.jdh1988@yeah.net>
References: <2d35ff94.2ee0.14a7f51cad5.Coremail.jdh1988@yeah.net>
Date: Fri, 26 Dec 2014 13:59:08 -0500
Message-ID: <CAB9W1A3GLdjep=+OE--LS8kNNjiG9JejrV3uQv4DVQojgCs4cw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_could_selinux_satisfy_my_need=EF=BC=9F?=
From: Stephen Smalley <stephen.smalley@gmail.com>
To: jiangdahui <jdh1988@yeah.net>
Content-Type: text/plain; charset=UTF-8
Cc: selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

That's a job for the Linux Integrity Measurement Architecture (IMA),
not for SELinux.  See http://linux-ima.sourceforge.net/ and
http://sourceforge.net/p/linux-ima/wiki/Home/ for more information.

On Wed, Dec 24, 2014 at 9:41 PM, jiangdahui <jdh1988@yeah.net> wrote:
> hi all:
>       I have a task to have some components in kernel and user spaces to get
> the follow goal：
>       1. get a user space program's information;
>       2. calculate a value with a algorithm like HASH with the information
> as input;
>       3. look up a white list to get a expected value and compare it with
> the calculated one to verify the integrity of the program.
>       4.there should be components in user space program to set the white
> list and inform the user whether a  program is permitted or not.
>       I have learned that seLinux has achieved most hooks of LSM, and I
> think my need is a basic one, I don't want to reinvent the wheel, so could
> any experienced user or developer give me some advice? thanks!
>
> best regards!
>
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
