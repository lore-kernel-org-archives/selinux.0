From: Paul Moore <paul.moore@hp.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Subject: Re: [patch] Tuning avtab to reduce memory usage
Date: Wed, 12 Sep 2007 15:54:41 -0400
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        Yuichi Nakamura <ynakam@hitachisoft.jp>,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
References: <20070821130540.7AD3.YNAKAM@hitachisoft.jp> <46CC00F4.2090501@ak.jp.nec.com> <46E7583C.9030103@ak.jp.nec.com>
In-Reply-To: <46E7583C.9030103@ak.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709121554.41662.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, September 11 2007 11:08:44 pm KaiGai Kohei wrote:
> The attached patch applies the standard bitmap operations
> for the iteration macro of ebitmap, and enables to improve
> the performance in AVC-misses case.

In addition to the code changes to ebitmap_netlbl_{import,export}() you should 
probably either remove, or preferably update, the comment block in the body 
of the functions.

Thank you for also fixing my cut and paste error in the comment block at the 
top of the ebitmap_netlbl_import() function :)

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
