Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9F7TpWt023788
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 03:29:51 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9F7Ti0p019980
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 07:29:44 GMT
Received: from Cantor.suse.de (ns.suse.de [195.135.220.2])
	by jazzswing.ncsc.mil  with ESMTP id h9F7Thr7019977
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 07:29:43 GMT
Received: from Hermes.suse.de (Hermes.suse.de [195.135.221.8])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by Cantor.suse.de (Postfix) with ESMTP id AD92616FB28D
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 09:29:49 +0200 (CEST)
Date: Wed, 15 Oct 2003 09:29:49 +0200
From: Thorsten Kukuk <kukuk@suse.de>
To: selinux@tycho.nsa.gov
Subject: Re: Filesystem problems
Message-ID: <20031015072949.GA12602@suse.de>
References: <1066191058.3f8cc8d257e4c@eaglemail.unt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1066191058.3f8cc8d257e4c@eaglemail.unt.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 14, Ignacio Tripodi wrote:

> I had a 2.4 kernel with SELinux enabled, could load a policy, relabeled the 
> filesystem (ext3) and was able to see the extended attributes of all files. 
> However, after I upgraded to the 2.6 SELinux kernel, I wasn't able to load 
> the policy again. It still lets me in since I enabled the development mode 
> but the tools don't recognize the running kernel as an SELinux-enabled 
> kernel. Besides, this is what I get in the dmesg after it mounts the root 
> filesystem:
> 
> security_context_to_sid: called before initial load_policy on unknown 
> context system_u:object_
> r:file_t
> security_context_to_sid: called before initial load_policy on unknown 
> context system_u:object_
> r:root_t

With kernel 2.6.0-test7, I have a lot of ext3 problems with SELinux
enabled, which always ends in a filesystem crash and a necessary
fsck.ext3 run at the next boot. Don't know if this comes from the
usage of extended attributes or if ext3 itself is broken in 2.6.

  Thorsten

-- 
Thorsten Kukuk       http://www.suse.de/~kukuk/        kukuk@suse.de
SuSE Linux AG        Deutschherrnstr. 15-19        D-90429 Nuernberg
--------------------------------------------------------------------    
Key fingerprint = A368 676B 5E1B 3E46 CFCE  2D97 F8FD 4E23 56C6 FB4B

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
