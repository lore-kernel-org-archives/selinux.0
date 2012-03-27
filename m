Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2RFhr7m028746
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:43:53 -0400
Received: by yenq2 with SMTP id q2so38698yen.12
        for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 08:43:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120326204746.260ec002@fornost.bigon.be>
References: <20120326204746.260ec002@fornost.bigon.be>
Date: Tue, 27 Mar 2012 16:43:52 +0100
Message-ID: <CAPweEDw5SVESGq933CEp8SbqAbUUjHcax0esB7sPqMsS+Aq6Wg@mail.gmail.com>
Subject: Re: [PATCH 2/2] libselinux -- Do not link against python library,
 this is considered bad practice in debian
From: lkcl luke <luke.leighton@gmail.com>
To: Laurent Bigonville <bigon@debian.org>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Mar 26, 2012 at 7:47 PM, Laurent Bigonville <bigon@debian.org> wrote:
> Hi,
>
> Do not link python module with libpython, the interpreter is already linked against it.

 ah, that reminds me: does the python debian build infrastructure cope
with 2.6, 2.7 etc. etc. producing multiple versions of this c-based
module?  if not i know of a way to do that, but it uses an earlier
version of the debian helper tools, and also needs automake not just
autoconf.

 for another project i had to write an m4 automake macro which used
python2.{insertversion}-config to record the various includes and
library versions etc.

 let me know if this is of any use?

 l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
