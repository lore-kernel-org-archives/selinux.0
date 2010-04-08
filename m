MIME-Version: 1.0
In-Reply-To: <201004081145.04646.paul.moore@hp.com>
References: <20100405190124.6015.72502.stgit@flek.lan>
	 <201004081145.04646.paul.moore@hp.com>
Date: Thu, 8 Apr 2010 12:01:54 -0400
Message-ID: <i2s7e0fb38c1004080901tb3a3fc78u707fd1ed1b492f29@mail.gmail.com>
Subject: Re: [PATCH] selinux: UNIX domain socket fixes
From: Eric Paris <eparis@parisplace.org>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Apr 8, 2010 at 11:45 AM, Paul Moore <paul.moore@hp.com> wrote:
> On Monday 05 April 2010 03:01:24 pm Paul Moore wrote:
>> Correct a problem where we weren't setting the peer label correctly on
>> connected UNIX domain sockets and do some other general fixup while we
>> are messing with the code.
>>
>> Signed-off-by: Paul Moore <paul.moore@hp.com>
>
> Does anyone object to this patch going in?
>
> I know Stephen had a comment about some of the changes regarding the inode and
> sock security structs, but I haven't heard anything since my response to him
> so I'm going to assume he's okay with the changes (speak up if your not).

It's going to conflict with the patch James committed last night from
me to rename all of the "ssec" in the code to sksec.  I'm pretty sure
James can handle that conflict, but just so we know it is there.....

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
