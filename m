Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h83CPSLa024628
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 08:25:28 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h83CNtpQ014936
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 12:23:55 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h83CNtQX014933
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 12:23:55 GMT
Subject: Re: Data type changed?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Wu Yanjun <yanjunwu@sonata.iscas.ac.cn>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200309031100.47270.yanjunwu@sonata.iscas.ac.cn>
References: <200309031100.47270.yanjunwu@sonata.iscas.ac.cn>
Content-Type: text/plain
Message-Id: <1062591879.18568.315.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 03 Sep 2003 08:24:39 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-09-02 at 23:00, Wu Yanjun wrote:
> In Linux-2.6.0-test4, I see selinux changed the type of basic data structures 
> significantly.  eg. turn security_id_t, access_vector_t, security_class_t, 
> etc. back to their protoypes.Could any one tell me what's the reason? and 
> will these changes be permanent?

typedefs are considered harmful by the kernel developers, and the change
is permanent.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
