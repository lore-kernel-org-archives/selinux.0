Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA03661
	for <selinux@tycho.nsa.gov>; Thu, 19 Dec 2002 19:12:59 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id AAA00925
	for <selinux@tycho.nsa.gov>; Fri, 20 Dec 2002 00:10:32 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id AAA00921
	for <selinux@tycho.nsa.gov>; Fri, 20 Dec 2002 00:10:28 GMT
Date: Fri, 20 Dec 2002 11:16:46 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: [ISN] Music file flaws could threaten traders
Message-ID: <20021220001646.GD15409@snoopy.apana.org.au>
References: <Pine.LNX.4.44.0212190257480.19905-100000@idle.curiosity.org> <200212192307.20386.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200212192307.20386.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Dec 19, 2002 at 11:07:20PM +0100, Russell Coker wrote:
> On Thu, 19 Dec 2002 09:58, InfoSec News wrote:
> > http://news.com.com/2100-1001-978403.html?tag=fd_top
> >
> > By Robert Lemos
> > Staff Writer, CNET News.com
> > December 18, 2002, 5:12 PM PT
> >
> > A security firm on Wednesday warned that people using Windows XP or
> > popular music player WinAmp could fall prey to a vulnerability,
> > enabling a modified music file to take control of a person's PC.

I think it should be possible to write a program that checks to source
file, makes sure it is valid and doesn't contain any errors or other
potentially dangerous stuff (eg. a multimedia tag with too much data, as
per article), and then relabels it with a file label that allows the
user to freely use that file.

Even better, this program could be generalized to automatically
detect the format, and take appropriate action (eg. virus scanner
for executables, MP3 valididator for MP3 files, etc).

(then again, I am not entirely familiar with MP3 or PNG formats, they
weren't around when I did my University course).
--
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
