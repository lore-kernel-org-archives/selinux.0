Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5IHWbTU016463
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2010 13:32:38 -0400
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o5IHVnGC003384
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2010 17:31:49 GMT
Received: from moss-lions.epoch.ncsc.mil (moss-lions.epoch.ncsc.mil [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.4/8.14.4) with ESMTP id o5IHXBEo009806
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2010 13:33:11 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.4/8.14.4/Submit) id o5IHXBtK009805
	for selinux@tycho.nsa.gov; Fri, 18 Jun 2010 13:33:11 -0400
Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5DDSP4i026945
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2010 09:28:27 -0400
Received: from mail-ww0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o5DDTp7C024993
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2010 13:29:59 GMT
Received: by mail-ww0-f53.google.com with SMTP id 39so2972271wwb.12
        for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2010 06:28:26 -0700 (PDT)
Date: Sat, 12 Jun 2010 20:49:10 +0200
From: Dan Carpenter <error27@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        selinux@tycho.nsa.gov
Subject: [patch 0/7 v2] selinux: return proper error codes instead of -1
Message-ID: <20100612184910.GO5483@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've respun these patches based on Eric's feedback.  It was mostly to
use "rc" consistently instead of "ret" and also to use "if (rc)" instead
of "if (rc < 0)".

One thing which I didn't really change was in [patch 3/7].
On Tue, Jun 08, 2010 at 04:12:18PM -0400, Eric Paris wrote:
> I'm not in love with this one.  The change in cond_read_av_list() is
> fine, but the style and completeness in cond_insertf I think is even
> worse.  My biggest problem is the fact that you sent an error code at
> the top and just sorta leave it.  There are still lots of
>
> if (function())
>         goto err;
>
> which really should be
>
> rc = function()
> if (rc)
>         goto err;
>

The problem is those functions in cond_insertf() don't return error 
codes, they return pointers and NULL.  I could put an:

	rc = -EINVAL;

in front of each goto but that seems awkward.  I did change one of the
cond_insertf() returns to -ENOMEM where my first patch left it as
-EINVAL, but otherwise I basically left that function the same.

Everything else should be OK though.

regards,
dan carpenter


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
