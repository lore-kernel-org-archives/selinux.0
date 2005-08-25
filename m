Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7PKq3Ob019976
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2005 16:52:03 -0400 (EDT)
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7PKeN2f002675
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2005 20:40:23 GMT
Message-ID: <36282A1733C57546BE392885C06185920572FA@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: "'Stephen Smalley '" <sds@epoch.ncsc.mil>,
   Chad Hanson
	 <chanson@TrustedCS.com>
Cc: "'SELinux-dev@tresys.com '" <SELinux-dev@tresys.com>,
   Darrel Goeddel
	 <DGoeddel@TrustedCS.com>,
   "''Daniel J Walsh ' '" <dwalsh@redhat.com>,
   "''SE Linux ' '" <selinux@tycho.nsa.gov>
Subject: RE: libselinux category patch
Date: Thu, 25 Aug 2005 16:43:09 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

 
Upon further discussion, we could probably live without whitespace in the
MLS field. We can perform yet another stripping of the contexts in our own
applications that would desire to show whitespace instead of a
non-whitespace character such as '_'.

-Chad 

>On Wed, 2005-08-24 at 16:18 -0400, Chad Hanson wrote:
>> We definitely need to allow whitespace in the translated context.

>Hmm...translated context is beginning to sound like it has a different
>format than the raw context, which means that it needs to be handled via
>different manipulation functions than the raw context.  Differences that
>seem to be getting proposed include:
>- Dan wants to strip the sensitivity entirely from the translated
>context in the MCS libsetrans because MCS only uses categories,
>- Dan would ideally like to strip object_r from the translated context
>since it takes up display space and seemingly provides no useful
>information,
>- You would like the MLS field to include whitespace in the translated
>context.
>
>Do we need a separate set of context* functions for raw vs. translated?
>Do we need a separate data type?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
