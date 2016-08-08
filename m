Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u78MuYJG014252
 for <selinux@tycho.nsa.gov>; Mon, 8 Aug 2016 18:56:35 -0400
Received: by mail-oi0-f47.google.com with SMTP id 4so257103699oih.2
 for <selinux@tycho.nsa.gov>; Mon, 08 Aug 2016 15:56:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6db760db-7b20-9fb9-29df-07b4a46b0ace@tycho.nsa.gov>
References: <8f97fb23-65b5-bef5-bbae-f6139a2766f4@redhat.com>
 <6db760db-7b20-9fb9-29df-07b4a46b0ace@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 8 Aug 2016 18:56:30 -0400
Message-ID: <CAHC9VhTp_7P0YFgxGHyHWHME6ni-QBDF8taN+=utCz8dUEnnDg@mail.gmail.com>
Subject: Re: Any way to label /proc/self/mem with a different type then the
 process type.
To: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Aug 8, 2016 at 2:32 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 08/08/2016 01:41 PM, Daniel J Walsh wrote:
>> I have been requested by some container people to make this only
>> readable not writable to prevent certain types of attacks on the
>>
>> kernel.  No idea if this is a good idea or not.
>
> Would require a kernel change.  Support for per-file labeling of
> /proc/pid came up previously in SE for Android, so the SE for Android
> todo list has an item here:
>
> Extend SELinux /proc/pid labeling support to support derived types on
> specific /proc/pid files based on both the associated task context and
> the file name, e.g. name-based type transitions. This would allow
> applying different restrictions to different /proc/pid files of the same
> process via SELinux.
>
> Probably should go on the SELinux kernel todo list.

Added.

FWIW, at some point this year when I've got a few hours to burn I'm
probably going to setup a mirror of the SELinux kernel repo in the
GitHub and start tracking these things as GitHub issues instead of the
wiki.  I've been doing this for audit and it has been working
reasonably well and provides for more history/discussion than the wiki
approach we are currently using.  Unfortunately it doesn't solve the
problem of being short a few kernel devs :)

-- 
paul moore
www.paul-moore.com
