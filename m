Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAA1MAEo012570
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2007 20:22:10 -0500
Received: from mailhub.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAA1MAdf011359
	for <selinux@tycho.nsa.gov>; Sat, 10 Nov 2007 01:22:10 GMT
From: Paul Moore <paul.moore@hp.com>
To: casey@schaufler-ca.com
Subject: Re: [RFC PATCH v6 05/13] SELinux: add secctx_to_secid() LSM hook
Date: Fri, 9 Nov 2007 20:21:03 -0500
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
References: <199039.66000.qm@web36614.mail.mud.yahoo.com>
In-Reply-To: <199039.66000.qm@web36614.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200711092021.03362.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 09 November 2007 5:19:02 pm Casey Schaufler wrote:
> --- Paul Moore <paul.moore@hp.com> wrote:
> > Add a secctx_to_secid() LSM hook to go along with the existing
> > secid_to_secctx() LSM hook.
>
> I'll bite. Where does this get used?

Patch 12/13, functions netlbl_unlabel_staticadd() and 
netlbl_unlabel_staticadddef().  It is used to convert a user supplied label 
into a token which is later passed to the LSM; in the SELinux case it is used 
directly in an avc_has_perm() call.

Go ahead and check, I'll wait ... just please don't bring up the whole 
getpeercon() issue (essentially the example you chose, although you picked 
the connectionless version) again.  Worrying about something that typically 
happens only once (if at all) per-connection is not something I want to worry 
about optimizing if it causes the per-packet case to become more tedious.

> There. I got the righteous indignation off my chest. I say to
> go ahead with adding this to the LSM ... {snip}

Sigh.  I agree, the whole tokenized label concept is conceptually very 
annoying and I'll also agree that it can be frustrating for certain 
implementations.  However, the world we live in (the Linux kernel) makes use 
of these tokenized labels (secid, SID, etc) because it's all the original LSM 
folks could get in some places.  The fact that this works fine with SELinux 
(actually works better than fine in some cases) is a happy coincidence and 
probably the reason things haven't changed much.

I _really_ don't want to get into the "one true security model" debate, but 
the fact remains that as long as SELinux is the only LSM implementation in 
the mainline kernel there is no reason to change this.  If/when SMACK (this 
is really the immediate source of the "righteous indignation" after all, 
right?) is merged then it will probably make sense to go revisit some of 
those earlier decisions regarding these tokenized labels.  For me personally, 
right now I'm just concerned about making sure the labeled networking bits 
work as well as we can make them work; with SELinux that means using a 
secid/SID to speed up the per-packet access checks.  For SMACK, this will 
probably mean passing the actual string label.  You and I have already talked 
about this so _you_know_ there is a SMACK friendly solution to the 
fallback/static label functionality; I just can't justify adding code that 
serves no purpose in the context (haha!) of the current kernel sources.

You know all this Casey, so I have no idea where all of these comments are 
coming from - bad day at work?  Somebody run over your dog?  Well, go home, 
have a beer and forget about it for right now.  Get SMACK merged, or any 
other LSM which highlights the same problem, and we can put that "righteous 
indignation" to good use; right now, it's just plan tiresome.

> In Linux 2.7 I propose that we fix these problems. Not today.

Un huh ... in the meantime I'm gonna work with what I have :)

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
