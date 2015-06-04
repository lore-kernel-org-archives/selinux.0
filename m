Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t54KoAOt021030
 for <selinux@tycho.nsa.gov>; Thu, 4 Jun 2015 16:50:10 -0400
Received: by oihd6 with SMTP id d6so39832520oih.2
 for <selinux@tycho.nsa.gov>; Thu, 04 Jun 2015 13:50:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5570AC04.3050709@tycho.nsa.gov>
References: <20150604194045.31270.58300.stgit@localhost>
 <20150604194149.31270.13124.stgit@localhost>
 <5570AC04.3050709@tycho.nsa.gov>
Date: Thu, 4 Jun 2015 16:50:08 -0400
Message-ID: <CAHC9VhRoXDQTNvqj91-YWMuFfhUJq7wW90erJ3S78L6R_Wr=5Q@mail.gmail.com>
Subject: Re: [PATCH 1/6] selinux-testsuite: add _GNU_SOURCE to tests/Makefile
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jun 4, 2015 at 3:50 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 06/04/2015 03:41 PM, Paul Moore wrote:
>> diff --git a/tests/msg/msgrcv.c b/tests/msg/msgrcv.c
>> index b23c801..285dcad 100644
>> --- a/tests/msg/msgrcv.c
>> +++ b/tests/msg/msgrcv.c
>> @@ -6,11 +6,6 @@
>>
>>  #define MSGMAX 1024
>>
>> -struct msgbuf {
>> -  long mtype;     /* message type, must be > 0 */
>> -  char mtext[1024];  /* message data */
>> -};
>> -
>
> This doesn't seem right.  I see that the _GNU_SOURCE definition triggers
> inclusion of a struct msgbuf definition from sys/msg.h, but that
> definition doesn't allocate any space for the mtext buffer.  So then
> when we try to msgsnd() or msgrcv() with MSGMAX, we'll be
> reading/writing memory past the end of the structure?
>
> Maybe you were right the first time, sorry.

My mistake, I should have looked closer then I saw the conflict; I was
rushing to get some other things sorted and did something stupid,
thanks for the sanity check.

I like your idea of defining _GNU_SOURCE at a higher level, I think
the right solution here is to just rename our local definition of the
msgbuf struct.  A new patchset due shortly ...

-- 
paul moore
www.paul-moore.com
