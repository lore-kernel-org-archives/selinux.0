From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [patch] Tuning avtab to reduce memory usage
Date: Tue, 18 Sep 2007 18:11:28 -0400
Cc: KaiGai Kohei <kaigai@ak.jp.nec.com>, selinux@tycho.nsa.gov,
        Yuichi Nakamura <ynakam@hitachisoft.jp>,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
References: <20070821130540.7AD3.YNAKAM@hitachisoft.jp> <46E7583C.9030103@ak.jp.nec.com> <1190136066.14037.53.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1190136066.14037.53.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709181811.29332.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, September 18 2007 1:21:06 pm Stephen Smalley wrote:
> The patch looks good overall - a couple minor comments below.
> Paul, can you test the netlabel import/export functionality?

Yep, I just ran it through some simple tests using a patched kernel and the 
categories looked okay (i.e. the same at both ends).  I also inspected a few 
packets by hand and the categories on the wire looked correct as well.

[NOTE: wireshark 0.99.6 appears to have my CIPSO patch in it now so you can 
use that to decode CIPSO options]

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
