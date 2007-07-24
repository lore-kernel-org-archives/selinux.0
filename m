Date: Tue, 24 Jul 2007 17:05:39 +0900
From: Yuichi Nakamura <ynakam@hitachisoft.jp>
To: Joshua Brindle <method@manicmethod.com>
Subject: Re: [patch] customizable AVTAB_HASH_BITS for embedded devices
Cc: ynakam@hitachisoft.jp, KaiGai Kohei <kaigai@ak.jp.nec.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        busybox@kaigai.gr.jp, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <46A57282.1090902@manicmethod.com>
References: <46A56CBB.6020805@ak.jp.nec.com> <46A57282.1090902@manicmethod.com>
Message-Id: <20070724170220.41E1.YNAKAM@hitachisoft.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi.

Stephen, KaiGai, Josua, Thanks for comments.

On Mon, 23 Jul 2007 23:31:14 -0400
Joshua Brindle  wrote:
> KaiGai Kohei wrote:
> > Stephen Smalley wrote:
<snip>
> I think he was suggesting making it runtime configurable (or even
> automatic based on the size of the loaded policy)
> 
> One should be able to dynamically choose the number of hash buckets
> based off of how many rules are in the policy being loaded, keeping the
> buckets balanced though could be a harder problem to solve.
OK, I am testing to dynamically configuring number of hash slots based on number of rules.
I will send RFC later.
 
> > There is another background, although Nakamura-san didn't mentioned.
> > The AVC hit rate is extremely high, so getting longer the chain of
> > avtab hash list does not have maeningful difference in performance.
> >   
> We've had some issues lately with the speed of the avtab, specifically
> around finding reachable user domains. They've been addressed for now
> (my offloading some work to userspace) but there may be others lurking,
> people are finally starting to profile some of this code though.
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


Regards,
-- 
Yuichi Nakamura
Hitachi Software Engineering Co., Ltd.
Japan SELinux Users Group(JSELUG): http://www.selinux.gr.jp/
SELinux Policy Editor: http://seedit.sourceforge.net/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
