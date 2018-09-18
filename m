Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8IFe0jA002439
 for <selinux@tycho.nsa.gov>; Tue, 18 Sep 2018 11:40:00 -0400
To: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
 James Morris <jmorris@namei.org>,
 Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc: LSM <linux-security-module@vger.kernel.org>,
 LKLM <linux-kernel@vger.kernel.org>, SE Linux <selinux@tycho.nsa.gov>,
 John Johansen <john.johansen@canonical.com>,
 Kees Cook <keescook@chromium.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 "Schaufler, Casey" <casey.schaufler@intel.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <alpine.LRH.2.21.1809130727310.19741@namei.org>
 <d2ad1caf-4e81-f33d-f764-6f90f9d101c4@digikod.net>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <6c678308-fae3-22b0-8750-20d1b70e1bc5@schaufler-ca.com>
Date: Tue, 18 Sep 2018 08:23:11 -0700
MIME-Version: 1.0
In-Reply-To: <d2ad1caf-4e81-f33d-f764-6f90f9d101c4@digikod.net>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v2 00/10] LSM: Module stacking in support of
 S.A.R.A and Landlock
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 9/18/2018 12:44 AM, Mickaël Salaün wrote:
> On 9/12/18 23:29, James Morris wrote:
>> Adding the SARA and LandLock authors for review & comment.
>>
>> Salvatore & Mickaël: does this patchset meet your needs for merging to 
>> mainline?
> It almost does! For now, I need the task_struct, cred, inode and file
> security blobs. Only the task_struct one is missing.

I will add the task blob as well as the ipc blob needed by
SARA for v3.
 

>
> FYI, the capitalization of Landlock is not consistent in all commit
> messages. :)

Sorry. I have been trying to get people to use Smack instead
of SMACK for years. I will strive to use Landlock consistently.
