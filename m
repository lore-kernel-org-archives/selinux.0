Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2V8buDo022912
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 03:37:56 -0500 (EST)
Received: from mail.lemuria.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2V8adiv022203
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 08:36:39 GMT
Date: Thu, 31 Mar 2005 10:37:36 +0200
From: Tom <tom@lemuria.org>
To: Ivan Gyurdiev <ivg2@cornell.edu>, Casey Schaufler <casey@schaufler-ca.com>,
   selinux@tycho.nsa.gov
Subject: Re: Desktop apps interoperability
Message-ID: <20050331103736.K1195@lemuria.org>
References: <20050330155207.58846.qmail@web31601.mail.mud.yahoo.com> <1112199204.8592.13.camel@cobra.ivg2.net> <20050330235010.B622@lemuria.org> <20050330221246.GC9752@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050330221246.GC9752@lkcl.net>; from lkcl@lkcl.net on Wed, Mar 30, 2005 at 11:12:46PM +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Mar 30, 2005 at 11:12:46PM +0100, Luke Kenneth Casson Leighton wrote:
>  kdbfs "flattens" the directory structures and forces applications,
>  via patches to the file save and file open dialogs, to ONLY be able
>  to save documents in certain subdirectories, ~/Documents, ~/Music ...
>  etc.

There will be many people who reject that concept and our solution here
should cater to them as well. SELinux "but desktop apps are only
secured if you use KDE with a specific patch" is not something I would
find acceptable.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
