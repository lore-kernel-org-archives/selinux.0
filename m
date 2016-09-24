Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8O1AYwp031520
 for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2016 21:10:35 -0400
Received: by mail-qt0-f169.google.com with SMTP id 93so60178050qtg.2
 for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2016 18:10:33 -0700 (PDT)
Message-ID: <57E5D285.5080709@quarksecurity.com>
Date: Fri, 23 Sep 2016 21:10:29 -0400
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: william.c.roberts@intel.com
CC: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: Libsepol Mac Build Errors
References: <1474664152-18727-1-git-send-email-william.c.roberts@intel.com>
In-Reply-To: <1474664152-18727-1-git-send-email-william.c.roberts@intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

william.c.roberts@intel.com wrote:
> The patches below fix some warnings reported by Josh Brindle on
> the libsepol build.
>
> Josh can you test these and see if those three warning go away
> and give an ack if they are ok?
>
> [PATCH 1/3] libsepol: fix unused variable 'size' on mac build
> [PATCH 2/3] libsepol: fix unused variable 'len' on mac build
> [PATCH 3/3] libsepol: fix unitialized variable 'nread' on mac build

That fixed the build errors. The linker does not like the soname, 
version map, etc stuff though so I still don't get a sofile out.
