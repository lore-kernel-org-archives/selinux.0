Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9RGWdWt026074
	for <selinux@tycho.nsa.gov>; Mon, 27 Oct 2003 11:32:39 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9RGWOIS024880
	for <selinux@tycho.nsa.gov>; Mon, 27 Oct 2003 16:32:24 GMT
Received: from sjtu.edu.cn (mailhost.shnet.edu.cn [202.112.26.54])
	by jazzswing.ncsc.mil  with ESMTP id h9RGWKDc024868
	for <selinux@tycho.nsa.gov>; Mon, 27 Oct 2003 16:32:21 GMT
Message-ID: <009901c39ca9$4e2e9e70$5d38a8c0@lky>
From: "lky" <lky77@sjtu.edu.cn>
To: <russell@coker.com.au>, "Stephen Smalley" <sds@epoch.ncsc.mil>
Cc: "SELINUX" <SELinux@tycho.nsa.gov>
References: <001401c39a74$ac06b370$5d38a8c0@lky> <1067266352.18818.51.camel@moss-spartans.epoch.ncsc.mil> <200310280201.03376.russell@coker.com.au>
Subject: Re: question about su and passwd
Date: Tue, 28 Oct 2003 00:42:24 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Monday, October 27, 2003 11:01 PM, Russell Coker wrote:
> My interpretation of lky's message was that they wanted to change role/domain 
> not SE Linux identity.  Although now you mention this, the original message 
> was unclear.  Lky, please clarify what you desire.

Yes, that's my meaning. But thanks Steve too for clarifying about newrole.

> There is only one case that I can think of where such things are really 
> needed, that is for logging in to an account with a non-root UID and staff_r, 
> and then wanting to change to UID==0 and sysadm_r.  Maybe a special-case 
> program for this operation would be a better solution?

That's just what I want. I am too lazy to logout and login again:)
Thanks!


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
