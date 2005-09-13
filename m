Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8DJDXNs027086
	for <selinux@tycho.nsa.gov>; Tue, 13 Sep 2005 15:13:33 -0400 (EDT)
Received: from free.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8DJAdMg023659
	for <selinux@tycho.nsa.gov>; Tue, 13 Sep 2005 19:10:39 GMT
Date: Tue, 13 Sep 2005 20:10:27 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: New ideas on implementation on libsetrans.
Message-ID: <20050913191027.GD6744@lkcl.net>
References: <43271BDA.3060403@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43271BDA.3060403@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

*grin* - is that the "are you completely mad??" daemon?  the one based
on the principles, considered insane, akin to winbindd?

:)

l.

p.s. need help doing the marshalling / unmarshalling, or
recommendation of techniques or tools to use (dceidl can
generate code to do pickling / unpickling of highly complex
data structures it takes _seconds_ to do - not hours of
hand-marshalling) let me know.

p.p.s. for god's sake don't go anywhere near dbus.  or xmlrpc
for that matter.

On Tue, Sep 13, 2005 at 02:35:06PM -0400, Daniel J Walsh wrote:
> After some discussion, we want to change the translation library into a 
> long running daemon with a unix domain socket that libselinux can talk 
> to for translation.  This eliminates the need to use dlopen, and link 
> with -dl. 
> 
> Dan
> 
> -- 
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov 
> with
> the words "unsubscribe selinux" without quotes as the message.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
