Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA13662
	for <selinux@tycho.nsa.gov>; Sun, 24 Mar 2002 20:15:19 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id BAA13677
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 01:13:55 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id BAA13672
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 01:13:53 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Dale Amon <amon@vnl.com>
Subject: Re: Mix and Match problems
Date: Mon, 25 Mar 2002 01:30:11 +0100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <20020322212840.CF3FE108F@lyta.coker.com.au> <20020324152223.GM20057@vnl.com>
In-Reply-To: <20020324152223.GM20057@vnl.com>
MIME-Version: 1.0
Message-Id: <20020325011447.6E9A02398C@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 24 Mar 2002 16:22, Dale Amon wrote:
> A question for Russ. In your debian package you still
> have the original policy/README file. If you are
> trying to build an selinux using your policy Makefile
> there is a catch-22. The README suggests building
> and installing policy first; but your Makefile uses
> chsid. chsid is not built until the next step when
> you make and make install libsecure; and even then

No.  If you use my packages then after installing the "selinux" package you 
have (for a new install) a copy of the sample policy files copied to 
/etc/selinux and chsid installed in /usr/bin/chsid.  It all works.

chsid should probably be in /usr/sbin though, but that's a minor issue.

> it would not ordinarily be built as the original
> libsecure/test/Makefile suggests it is needed only
> if chcon is not present.

That's fine, my debian/rules builds it anyway.  It has to be this way because 
the ability to change the SID of individual files is mandatory for the base 
SE Linux functionality.  Therefore my selinux package which is built from the 
selinux-small source archive MUST have the ability to do this.  As I'm forced 
to install chsid for this I haven't made chcon a priority, so there is still 
no Debian package of it.

> After going through that, I still got errors when
> trying to use your make install. I'm going to
> presume that is due to the fact that I'm doing
> a build under a non-selinux kernel and thus
> chsid is missing something it needs.
>
> This may all be moot, and I'm getting the problems
> only because I'm mixing your policy with Stephen's
> release, but thought I'd mention it in case it's
> of any use.

My makefiles etc are specifically designed for building packages of SE Linux. 
For Debian packages I have proven them to be workable, for RPM packages there 
should be no need for significant modification if you choose to have the same 
package contents as I have for Debian.  Otherwise it'll be problematic for 
you.

Supporting a Slackware style install is not something that concerns me.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
