Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s39HHgGN015804
 for <selinux@tycho.nsa.gov>; Wed, 9 Apr 2014 13:17:42 -0400
Received: by mail-qg0-f50.google.com with SMTP id q108so2622130qgd.37
 for <selinux@tycho.nsa.gov>; Wed, 09 Apr 2014 10:17:42 -0700 (PDT)
Message-ID: <534580B3.8040704@quarksecurity.com>
Date: Wed, 09 Apr 2014 13:17:39 -0400
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: [PATCH 0/4] APOL Enhancements to support additional policy
 features
References: <1396968778-19260-1-git-send-email-richard_c_haines@btinternet.com>
In-Reply-To: <1396968778-19260-1-git-send-email-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: setools-bugs@tresys.com, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Richard Haines wrote:
> These four patches will update setools-3.3.8.tar.bz2 available from
> http://oss.tresys.com/projects/setools/wiki/download
>
> I know this is not being fully supported but as I use APOL frequently
> I thought I would update it to support the latest policy version 29 (I
> could be the only user!!!). Tested on latest Fedora 20 x86_64
>

We use it quite a bit too so thank you very much.

Since we wanted to try out the patches, and because of my disdain for 
subversion I put up an (unofficial) git mirror that includes your 
patches on github at:

https://github.com/QuarkSecurity/setools

And to make it easier for others to try them out we posted some rpms:

https://quarksecurity.com/files/RPMS/

Oh, your ChangeLog change had to be rebased, as SVN trunk had an 
additional comment. I also fixed it to be tabs since that is the 
standard for that file.

Thanks!
