Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3LF3MI4020581
	for <selinux@tycho.nsa.gov>; Mon, 21 Apr 2003 11:03:22 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3LF31Vf022293
	for <selinux@tycho.nsa.gov>; Mon, 21 Apr 2003 15:03:01 GMT
Received: from kang.snu.edu (kang.snu.edu [204.126.2.3])
	by jazzswing.ncsc.mil  with ESMTP id h3LF2v4D022275
	for <selinux@tycho.nsa.gov>; Mon, 21 Apr 2003 15:02:59 GMT
Received: from gw.snu.edu ([172.16.200.11] helo=atlas.snu.edu)
	by kang.snu.edu with esmtp (Exim 4.12)
	id 197coh-00052B-00
	for selinux@tycho.nsa.gov; Mon, 21 Apr 2003 10:02:47 -0500
Message-Id: <sea3c1c6.014@atlas.snu.edu>
Date: Mon, 21 Apr 2003 10:02:30 -0500
From: "Joshua Brindle" <JBrindle@snu.edu>
To: <russell@coker.com.au>, <lms@ispgaya.pt>, <selinux@tycho.nsa.gov>
Subject: Re: SELinux ISO...
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>On Mon, 21 Apr 2003 14:29, Joshua Brindle wrote:
>>
http://sourceforge.net/project/showfiles.php?group_id=21266&release_id=1221

>>17 there are iso's available there, i think they are based off redhat
and
>> they are sorta old
>
>Have you tried them out?

taken a look at them, i know it labels the filesystem and loads policy,
etc during install
thats about as far as i got before getting bored with it.


>AFAIK no-one has yet solved all the issues involved in having a full
SE Linux 
>installation process with all files being labeled all the time.  This
would 
>require that the root media for the installation (floppy disk image or

>CD-ROM) have all it's files labeled with PSID's so that all programs
get the 
>right type.
>
>A CD-ROM that just does a regular Linux install with a SE kernel isn't

>particularly exciting.
>
>I did some work that leads toward this when the SE Linux kernel code 
>initialised itself on loading the initrd, and I had an initrd with a
mini 
>policy installed (about 30K compressed from memory) to ensure that
everything 
>it did was in the correct context.  Some policy changes related to
this were 
>incorporated in the main policy for init.te, kernel.te, and the
sysadm_t and 
>user_t policies.  I posted one patch about this on 2002/Sep/10, and
some 
>other small patches went in around that time.

won't the filesystem already be labeled? i don't understand the need
for an initrd.

>> --
>> I think there is a commercial effort to provide these called
Westcam(?)
>> I can't
>> find their url offhand but if you search the archives of this list
you
>> should find
>> them.
>
>Mark Westerman.

right, his site westcam.com doesn't appear to be responding..

>> SELinux on Gentoo isn't yet usable without the kernel in
development
>> mode, but
>> it's quickly getting there, I'll make some sort of announcement
when
>> it's really ready.
>
>What problems are you having?  Post here and I'm sure we can offer
some useful 
>advice.

We are looking at some logistical issues now. First we need a good way
of transporting policies. Portage does all the package downloads itself,
and limited files can be stored directly in portage, we are looking into
distributing application specific policies with the accompanying
application rather than having a giant policy package with everything
possible.

Second, we are looking into labeling files before they are installed to
the live filesystem and then moving them while preserving permissions.
One thing we have discussed (and will probably be working on soon) is
adding an argument to setfiles to tell it where to pretend the root is.

Portage compiles and installes apps in a separate part of the
filesystem (/var/tmp/portage/app-ver/) to be exact, and then installs
everything to /var/tmp/portage/app-ver/image and gets a manifest of the
package contents for use later when upgrading or removing. Our idea is
to label all the files in /var/tmp/portage/app-ver/image/ as if they
were on / using the base-policy and the application specific policy and
then move them to the live filesystem while preserving permissions. 

We have not started this yet, we've done some preliminary
experimentation but we still don't have a strong base-policy so we are
working to get that done first.

Any insight or previous experience in this would be greatly
appreciated. :)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
