Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q31G2FWp021309
	for <selinux@tycho.nsa.gov>; Sun, 1 Apr 2012 12:02:15 -0400
Message-ID: <20120401170208.12056z039tiwvd0k@webmail.tuffmail.net>
Date: Sun, 01 Apr 2012 17:02:08 +0100
From: Martin Orr <martin@martinorr.name>
To: Eric Paris <eparis@parisplace.org>
Cc: Laurent Bigonville <bigon@debian.org>, selinux@tycho.nsa.gov
Subject: Re: [PATCH 4/4] policycoreutils -- Make restorecon return 0 when a
	file has changed context with no error
References: <20120326174549.07f27c96@eldamar.bigon.be>
	<CACLa4pt=Y5N+7GmJRsmGV0DavJP8ykhO0ST5RtVd7zss9PNT+w@mail.gmail.com>
In-Reply-To: <CACLa4pt=Y5N+7GmJRsmGV0DavJP8ykhO0ST5RtVd7zss9PNT+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon Mar 26 19:12:12 2012, Eric Paris wrote:

> On Mon, Mar 26, 2012 at 11:45 AM, Laurent Bigonville  
> <bigon@debian.org> wrote:
>> Hi,
>>
>> restorecon should return 0 when a file has changed context with no
>> error. With the last version it's returning 1.
>>
>> I'm not sure if a patch has already been proposed for this issue.
>>
>> Laurent
>>
>> Description: Make restorecon return 0 when a file has changed  
>> context with no error
>> Author: Russell Coker <russell@coker.com.au>
>> Last-Update: 2012-03-07
>> Bug-Debian: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=662990
>>
>> ---
>>  setfiles/restore.c |    3 +--
>>  1 files changed, 1 insertions(+), 2 deletions(-)
>>
>> diff --git a/policycoreutils/setfiles/restore.c  
>> b/policycoreutils/setfiles/restore.c
>> index 9a7d315..a378af0 100644
>> --- a/policycoreutils/setfiles/restore.c
>> +++ b/policycoreutils/setfiles/restore.c
>> @@ -218,10 +218,9 @@ static int restore(FTSENT *ftsent)
>>                        r_opts->progname, my_file, newcon, strerror(errno));
>>                goto skip;
>>        }
>> -       ret = 1;
>>  out:
>>        freecon(newcon);
>> -       return ret;
>> +       return 0;
>>  skip:
>>        freecon(newcon);
>>        return SKIP;
>
> Is this right?  Don't we get to "out" from a number of error cases?
> Do we always want 0?

The return value of 1 when some file context is changed is needed by  
restorecond.

This patch fixes the same bug:
http://permalink.gmane.org/gmane.comp.security.selinux/16793

-- 
Martin Orr



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
