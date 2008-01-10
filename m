From: Steve Grubb <sgrubb@redhat.com>
To: Alexander Viro <aviro@redhat.com>
Subject: Re: [RFC] Obtaining PATH entry without audit userland
Date: Thu, 10 Jan 2008 10:40:18 -0500
Cc: linux-audit@redhat.com, Yuichi Nakamura <ynakam@hitachisoft.jp>,
        SELinux@tycho.nsa.gov
References: <20080110172605.89A2.YNAKAM@hitachisoft.jp> <200801101019.50692.sgrubb@redhat.com> <20080110153237.GH16537@devserv.devel.redhat.com>
In-Reply-To: <20080110153237.GH16537@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801101040.19032.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 10 January 2008 10:32:37 Alexander Viro wrote:
> On Thu, Jan 10, 2008 at 10:19:50AM -0500, Steve Grubb wrote:
> > I was under the impression that Al Viro has already sent a patch allowing
> > for PATH in all AVC messages. Al?
>
> In the mainline for quite a while...

That's what I thought.

Yuichi, what kernel are you testing against that is having the problem? Is 
there a simple test case that shows the problem so we can check the kernel to 
make sure its working properly?

Thanks,
-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
