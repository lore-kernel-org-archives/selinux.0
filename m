Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9ECMtWt017942
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 08:22:55 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9ECMm0p005170
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 12:22:48 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h9ECMmr7005165
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 12:22:48 GMT
Subject: Re: specifying groups of types
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200310111435.46684.russell@coker.com.au>
References: <200310111435.46684.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1066134168.5054.11.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 14 Oct 2003 08:22:48 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2003-10-11 at 00:35, Russell Coker wrote:
> Following a discussion on IRC, it occurs to me that it would be handy to have 
> the following in the policy language:
> allow some_domain { file_type !shadow_t }:...
> 
> So we can specify everything in file_type except for shadow_t.

Yes, although I'm not sure about the notation; might be better to
provide a set difference operator, e.g.
	file_type - shadow_t

Are you offering to implement this enhancement to checkpolicy?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
