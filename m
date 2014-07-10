Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6AFlITQ020973
 for <selinux@tycho.nsa.gov>; Thu, 10 Jul 2014 11:47:18 -0400
Received: by mail-pd0-f178.google.com with SMTP id r10so11037687pdi.37
 for <selinux@tycho.nsa.gov>; Thu, 10 Jul 2014 08:47:21 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.177.238])
 by mx.google.com with ESMTPSA id ez1sm46571945pbd.91.2014.07.10.08.47.19
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Thu, 10 Jul 2014 08:47:20 -0700 (PDT)
Message-ID: <53BEB586.6030408@gmail.com>
Date: Thu, 10 Jul 2014 21:17:18 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: directory fcontext
References: <3dae1574bd56d6674be7d7cc875abceb.squirrel@host290.hostmonster.com>
In-Reply-To: <3dae1574bd56d6674be7d7cc875abceb.squirrel@host290.hostmonster.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/10/14 20:55, m.roth@5-cent.us wrote:
> What should be the fcontext for a directory that contains cgi (or, in this
> case, ruby gems)?
>
>       mark
>
> --
> selinux mailing list
> selinux@lists.fedoraproject.org
> https://admin.fedoraproject.org/mailman/listinfo/selinux

You can see that by running restorecon command on the dir which's 
supposed to hold the scripts.

To add new directories with that default security context, use semanage 
fcontext and run restorecon on the new directory.
