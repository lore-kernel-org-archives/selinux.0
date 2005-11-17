Subject: Re: Debian SELinux backports project
From: Erich Schubert <erich@debian.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20051117141118.GR3082@lkcl.net>
References: <1132232710.16126.6.camel@wintermute.xmldesign.de>
	 <20051117141118.GR3082@lkcl.net>
Content-Type: text/plain; charset=ISO-8859-15
Date: Thu, 17 Nov 2005 15:27:24 +0100
Message-Id: <1132237644.16126.11.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Luke,
I'll not support older kernels. I'll recommend to either build your own
kernel, or get the linux-image 2.6.14+ from unstable.
Fortunately, the linux kernel doesn't depend on much userspace programs.
Obviously, the kernel cannot depend on a library, which is very
nice. ;-)
But the debian "vanilla" kernels do depend on a tool to generate
appropriate init ramdisks, so I'll probably include an unmodified
"backport" of yaird or one of the other initrd tool, once I've decided
which I prefer. Yaird worked okay on a test machine of mine, but not on
a second one, unfortunately; but I don't know why yet... Looked like
some module was missing for mounting the root which is on software raid;
the "old" kernel had these drivers built in, making it of course harder
for yaird to detect the appropriate modules...

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
  A polar bear is a rectangular bear after a coordinate transform.   //\
       Signatur befindet sich auf der Rückseite dieser E-Mail.       V_/_



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
