Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA19233
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 17:25:05 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA21882
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 21:23:55 GMT
Received: from hotmail.com (f255.law14.hotmail.com [64.4.20.130])
	by jazzswing.ncsc.mil  with ESMTP id VAA21878
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 21:23:55 GMT
From: "M. H." <metalhead00@hotmail.com>
To: sds@tislabs.com
Cc: selinux@tycho.nsa.gov
Subject: Re: building libsecure.a advice
Date: Wed, 28 Aug 2002 14:24:03 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F255oHMwVN7miR9Odut0000011b@hotmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I may be missing something but running 'make install' from selinux/module 
fails (complains about missing asm/flask files.)
Are you saying that doing 'make install' from selinux/module followed by 
make in selinux/libsecure is sufficient to compile the library (and place 
the appropriate headers in /usr/local/selinux...)?



>From: Stephen Smalley <sds@tislabs.com>
>To: "M. H." <metalhead00@hotmail.com>
>CC: <selinux@tycho.nsa.gov>
>Subject: Re: building libsecure.a advice
>Date: Wed, 28 Aug 2002 16:11:40 -0400 (EDT)
>
>
>On Wed, 28 Aug 2002, M. H. wrote:
>
> > Has anyone tried to build JUST libsecure.a. Since SELinux applications 
>need
> > to be linked against it, I want to separate all necessary headers and
> > libraries (seems like libsecure.a is the only one) so I can integrate 
>them
> > in my build environment (rather than relying on the default include or 
>lib
> > directories of the system.)
> > A problem I've run into is finding a simple way of rebuilding the 
>library
> > without installing the whole kernel. I tried to run 'make' in the
> > selinux/libsecure directory but that fails since 
>selinux/libsecure/include
> > misses some necessary files (some of those are in
> > lsm-2.4/security/selinux/include.) Has anyone had any luck building ONLY
> > libsecure.a?
>
>As explained in selinux/README, you need to run 'make install' in
>selinux/module to install the support files from the SELinux module used
>to build the remaining components.  This doesn't require building the
>kernel itself.
>
>--
>Stephen D. Smalley, NAI Labs
>ssmalley@nai.com




_________________________________________________________________
MSN Photos is the easiest way to share and print your photos: 
http://photos.msn.com/support/worldwide.aspx


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
