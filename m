Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0II7PIi021822
	for <selinux@tycho.nsa.gov>; Tue, 18 Jan 2005 13:07:25 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0II5K9K016038
	for <selinux@tycho.nsa.gov>; Tue, 18 Jan 2005 18:05:22 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Lee <FriedBob@sbcglobal.net>
Subject: Re: audit ... denied messages
Date: Wed, 19 Jan 2005 05:07:01 +1100
Cc: selinux@tycho.nsa.gov
References: <41E293C2.9040608@sbcglobal.net> <41E2CA19.4060602@diyab.net> <41E330AA.80609@sbcglobal.net>
In-Reply-To: <41E330AA.80609@sbcglobal.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200501190507.04605.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 11 January 2005 12:49, Lee <FriedBob@sbcglobal.net> wrote:
> Timothy Wood wrote:
> | Are you passing enforcing=1 to the kernel at boot time?
>
> Yes, these errors/messages only occur when I pass "selinux=1" to the
> kernel at boot, which I assume does the same thing as "enforcing=1" ?

selinux=1 enables SE Linux (it may be disabled by default depending on kernel 
configuration).  enforcing=1 causes SE Linux to be in "enforcing mode" (where 
it prevents access that the policy doesn't permit) instead of "permissive 
mode" (where it just logs messages and doesn't prevent any access).

> | Can you include some of these messages?
>
> I've got 5 pages of errors that I copied from dmesg.  One of them
> changes the aspect of my problems, as I saw a line telling me my
> reiserfs partition doesn't support labeling.  Here's a few select lines
> from them.   Seems I need a kernel patch for the reiser issue, so I'll
> look for that.
>
>
> ~ audit(1105370321.810:0): avc:  denied  { read } for  pid=446
> exe=/sbin/ldconfig name=libartsc.so.0.0.0 dev=hdc1 ino=749412
> scontext=system_u:system_r:ldconfig_t tcontext=system_u:object_r:usr_t
> tclass=file

The file is mis-labelled.  Run "find $X -inum 749412" where $X is the root 
directory of the file system hdc1 to find the file in question.

The following messages are in the same category.

-- 
IT executives rate Red Hat #1 for value
http://www.redhat.com/promo/vendor/index.html

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
