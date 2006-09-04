Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k84N03Hr016248
	for <selinux@tycho.nsa.gov>; Mon, 4 Sep 2006 19:00:03 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k84MxdEV012131
	for <selinux@tycho.nsa.gov>; Mon, 4 Sep 2006 22:59:40 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: Latest updates
Date: Tue, 5 Sep 2006 08:59:53 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
References: <44F7358E.4010101@redhat.com> <44F88DD4.6020804@redhat.com> <1157382946.3199.211.camel@sgc>
In-Reply-To: <1157382946.3199.211.camel@sgc>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200609050859.56692.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 05 September 2006 01:15, "Christopher J. PeBenito" 
<cpebenito@tresys.com> wrote:
> on further review, why does /boot/grub/* need to be boot_runtime_t?
> GRUB shouldn't be writing these files.

boot_runtime_t is not needed any more, and has not been needed since Red Hat 
stopped creating sym-links such as /boot/kernel.h and /boot/System.map.  It's 
been quite a while since that has been needed, I don't think that there has 
never been a Fedora release which supported SE Linux that had such symlinks.

On a couple of occasions I have submitted patches to remove that.  But it 
seems almost impossible to remove things from the policy.  Any time I submit 
a patch to remove something someone else immediately submits a patch to put 
it back in.

-- 
http://etbe.blogspot.com/          My Blog
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
