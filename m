From: Paul Moore <paul.moore@hp.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Subject: Re: [patch] Tuning avtab to reduce memory usage
Date: Tue, 25 Sep 2007 08:04:28 -0400
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Yuichi Nakamura <ynakam@hitachisoft.jp>,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
References: <20070821130540.7AD3.YNAKAM@hitachisoft.jp> <1190402479.17518.130.camel@moss-spartans.epoch.ncsc.mil> <46F89767.2090203@ak.jp.nec.com>
In-Reply-To: <46F89767.2090203@ak.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-2022-jp"
Message-Id: <200709250804.28866.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 25 September 2007 1:06:47 am KaiGai Kohei wrote:
> > Ok, looks reasonable.  Please run it through ./scripts/checkpatch.pl and
> > fix up the minor issues it reports, then post a clean message with a
> > suitable description and the patch inline.
>
> What is your stance about warnings for "line over 80 characters" ?
> To resolve all of them makes harder to read source code, so I'm ignoring
> them in the attached version.

Others might have different or stronger opinions about this issue, but I would 
encourage you to keep the line length less than or equal to 80 characters.  I 
know it can make for some ugly looking code in some cases but being able to 
see the entire line in a 80 character wide terminal/editor is worth the cost.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
