Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9TDfwXZ007826
	for <selinux@tycho.nsa.gov>; Fri, 29 Oct 2004 09:41:58 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9TDeWMb027587
	for <selinux@tycho.nsa.gov>; Fri, 29 Oct 2004 13:40:38 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Alex Ackerman" <alex@darkhonor.com>
Subject: Re: make policy complains on file_contexts
Date: Fri, 29 Oct 2004 23:41:39 +1000
Cc: selinux@tycho.nsa.gov
References: <A52BEA1D8EE8634B9196A136333637B1DAF0@maat.darkhonor.net>
In-Reply-To: <A52BEA1D8EE8634B9196A136333637B1DAF0@maat.darkhonor.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410292341.39618.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 29 Oct 2004 06:24, "Alex Ackerman" <alex@darkhonor.com> wrote:
> The line in question in file_contexts/program/eclipse.fc is:
> HOME_DIR/\.eclipse(/.*)?        system_u:object_r:ROLE_eclipse_rw_t
>
> Eclipse stores user configuration and workspace information in the user's
> home directory (.eclipse and workspace). So I followed the Mozilla model
> exactly (actually, just cut and pasted into the new file and renamed
> mozilla -> eclipse).  Any ideas how to decipher solve this one?

Please show us all the policy for eclipse, including 
macros/program/eclipse_macros.te, domains/program/eclipse.te, and the change 
you made to macros/base_user_macros.te.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
