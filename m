Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u4VD9ot0007036
 for <selinux@tycho.nsa.gov>; Tue, 31 May 2016 09:09:50 -0400
Date: Tue, 31 May 2016 13:05:33 +0000 (UTC)
From: Richard Haines <richard_c_haines@btinternet.com>
Reply-To: Richard Haines <richard_c_haines@btinternet.com>
To: Stephen Smalley <sds@tycho.nsa.gov>,
 "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Message-ID: <532278537.3784656.1464699933281.JavaMail.yahoo@mail.yahoo.com>
In-Reply-To: <08abe881-e195-92d0-fa20-87eadaccf645@tycho.nsa.gov>
References: <1462893734-9509-1-git-send-email-richard_c_haines@btinternet.com>
 <08abe881-e195-92d0-fa20-87eadaccf645@tycho.nsa.gov>
Subject: Re: [PATCH 1/3] libselinux: Evaluate inodes in selinux_restorecon(3)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>






> On Friday, 20 May 2016, 17:24, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On 05/10/2016 11:22 AM, Richard Haines wrote:
>>  This patch transfers matchpathcon.c inode evaluation services to
>>  selinux_restorecon.c and modifies them to also support setfiles(8)
>>  inode services.
>> 
>>  The overall objective is to modify restorecon(8) and setfiles(8)
>>  to use selinux_restorecon(3) services and then, when ready
>>  remove the deprecated matchpathcon services from libselinux.
>> 
>>  Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>>  ---
>>   libselinux/include/selinux/restorecon.h  |   4 +
>>   libselinux/man/man3/selinux_restorecon.3 |   5 +-
>>   libselinux/src/matchpathcon.c            | 139 +------------
>>   libselinux/src/selinux_restorecon.c      | 333 
> ++++++++++++++++++++++++++++---
>>   libselinux/utils/selinux_restorecon.c    |  14 +-
>>   5 files changed, 330 insertions(+), 165 deletions(-)

>> 

----- snip ------
> 
> Maybe we ought to just leave the matchpathcon ones alone (aside from
> deprecating and ultimately removing them), and bring over the versions
> added to setfiles when it was converted to using selabel_open().

> 

I'll leave matchpathcon alone and port over the setfiles code.
