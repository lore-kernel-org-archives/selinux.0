Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h839JkLa023583
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 05:19:46 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h839IDpQ001574
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 09:18:13 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by jazzswing.ncsc.mil  with ESMTP id h839IDQX001571
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 09:18:13 GMT
Date: Wed, 3 Sep 2003 05:18:59 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Wu Yanjun <yanjunwu@sonata.iscas.ac.cn>
cc: selinux@tycho.nsa.gov
Subject: Re: Data type changed?
In-Reply-To: <200309031100.47270.yanjunwu@sonata.iscas.ac.cn>
Message-ID: <Pine.LNX.4.44.0309030514500.13795-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 3 Sep 2003, Wu Yanjun wrote:

> 
> In Linux-2.6.0-test4, I see selinux changed the type of basic data structures 
> significantly.  eg. turn security_id_t, access_vector_t, security_class_t, 
> etc. back to their protoypes.Could any one tell me what's the reason? and 
> will these changes be permanent?

The reason these typedefs were removed was to help get SELinux accepted
into the mainline kernel, where typedefs are generally frowned upon.

The changes are expected to be permanent.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
