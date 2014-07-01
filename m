Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s61Aj4Ds019557
 for <selinux@tycho.nsa.gov>; Tue, 1 Jul 2014 06:45:04 -0400
Received: by mail-we0-f173.google.com with SMTP id t60so9542800wes.4
 for <selinux@tycho.nsa.gov>; Tue, 01 Jul 2014 03:45:05 -0700 (PDT)
Message-ID: <1404211504.9852.38.camel@x220.localdomain>
Subject: Re: Where's the class defined in file_contexts*
From: Dominick Grift <dominick.grift@gmail.com>
To: dE <de.techno@gmail.com>
Date: Tue, 01 Jul 2014 12:45:04 +0200
In-Reply-To: <53B2759A.2030209@gmail.com>
References: <53B2759A.2030209@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2014-07-01 at 14:17 +0530, dE wrote:
> The default security context of a object also depends on it's class.
> 
> I was looking at 
> etc/selinux/<SELINUXTYPE>/contexts/files/file_contexts*, but I couldn't 
> see any definition of a class.
> 
> Also semanage fcontext doesn't have an option define a class. Entries 
> are based only on files and directories.

semanage support -f

only file object classes apply to file object context specifications
obviously.

file: --
dir: -d
symbolic link: -l
named pipe: -p
sock file: -s

semanage fcontext -a ... -f -d "/test/mydir"
semanage fcontext -a ...-f -s "/test/mysocket"
semanage fcontext -a ... -f -- "/test/myfile"
... etc ...

if the file object context spec applies to any file object then you need
not specify the class:

semanage fcontext -a ... "/test/anyfileobjects(/.*)?"

So in file_contexts look for -- -d -s -l -p, if none of those are
specified then the spec applies to any file object class

> 
> If you get red text in this email please notify.
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
