Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA01574
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 13:45:12 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA15406
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 17:43:22 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
	by jazzswing.ncsc.mil  with SMTP id RAA15401
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 17:43:22 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A101524374@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Stephen Smalley'" <sds@tislabs.com>,
        Russell Coker
	 <russell@coker.com.au>
Cc: "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        SE Linux
	 <selinux@tycho.nsa.gov>
Subject: RE: insmod
Date: Mon, 29 Apr 2002 12:45:29 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


on Monday, April 29, 2002 11:52 AM, Stephen Smalley wrote:\

> > A snippet from my assert.te file:
> > neverallow ~{ initrc_t admin insmod_t } sysctl_t:file {  write append };
> > neverallow ~{ initrc_t admin } sysctl_fs_t:file { write append };
> > neverallow ~{ initrc_t admin kmod_t insmod_t }  sysctl_kernel_t:file {
write
> > append };
> 
> The above line for sysctl_kernel_t is the same as the  corresponding line
> in the 2002031409 NSA SELinux release.  That change was merged in
> accordance with the earlier discussion on the list.  However,  the
sysctl_t
> line in the example policy does not include insmod_t, since I  wasn't
aware
> that it was necessary (and I'm not sure why it is necessary  for tainted).
> With regard to ipsec, we should probably define a new type for the
> IPSEC-related entries and assign it to those entries.
> 
> If we want to reduce the need to edit assert.te, we could define type
> attributes for domains that should be authorized to write to  the sysctl
> types and merely use the type attribute in the assertion, as 
> is currently done for privmem/memory_device_t.

I was wondering if we could define different type for diffent type of 
sysctl.

example:
	net.ipv4.ip_forward
	net.ipv4.conf.default.rp_filter

I know there are many differnt type os sysctl. I would like to
be only grant ipsec the above permission, but nothing else.


Mark

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
