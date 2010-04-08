From: Paul Moore <paul.moore@hp.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: UNIX domain socket fixes
Date: Thu, 8 Apr 2010 11:45:04 -0400
Cc: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@redhat.com>
References: <20100405190124.6015.72502.stgit@flek.lan>
In-Reply-To: <20100405190124.6015.72502.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201004081145.04646.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 05 April 2010 03:01:24 pm Paul Moore wrote:
> Correct a problem where we weren't setting the peer label correctly on
> connected UNIX domain sockets and do some other general fixup while we
> are messing with the code.
> 
> Signed-off-by: Paul Moore <paul.moore@hp.com>

Does anyone object to this patch going in?

I know Stephen had a comment about some of the changes regarding the inode and 
sock security structs, but I haven't heard anything since my response to him 
so I'm going to assume he's okay with the changes (speak up if your not).

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
