Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9FDDKWt025109
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 09:13:20 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9FDDC0p009293
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 13:13:12 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by jazzswing.ncsc.mil  with ESMTP id h9FDDCr7009290
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 13:13:12 GMT
Date: Wed, 15 Oct 2003 09:13:45 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Ignacio Tripodi <ijt0003@unt.edu>
cc: selinux@tycho.nsa.gov
Subject: Re: Filesystem problems
In-Reply-To: <1066191058.3f8cc8d257e4c@eaglemail.unt.edu>
Message-ID: <Xine.LNX.4.44.0310150913020.5796-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 14 Oct 2003, Ignacio Tripodi wrote:

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

Are you trying to load an initial policy via initrd?

- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
