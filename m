Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8BITmrT025454
	for <selinux@tycho.nsa.gov>; Sat, 11 Sep 2004 14:29:48 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8BISq9R025885
	for <selinux@tycho.nsa.gov>; Sat, 11 Sep 2004 18:28:53 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Yuichi Nakamura <himainu-ynakam@miomio.jp>
Subject: Re: PAM in suse9.1 (Re: SuSE 9.1 SELinux)
Date: Sun, 12 Sep 2004 04:29:36 +1000
Cc: selinux@tycho.nsa.gov
References: <OF296DC5F7.062BA6BF-ON49256F08.000B7FC4-49256F08.000D462A@jp.ibm.com> <200409071747.i87HkxJ6012464@mms-r00.iijmio.jp>
In-Reply-To: <200409071747.i87HkxJ6012464@mms-r00.iijmio.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-2022-jp"
Message-Id: <200409120429.36022.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 8 Sep 2004 03:46, Yuichi Nakamura <himainu-ynakam@miomio.jp> wrote:
>   }
>
>   retval = PAM_SUCCESS;
> - if (pwd == NULL || salt == NULL || strlen(salt) == 1) {
> -  if (geteuid()) {
> + if (pwd == NULL || salt == NULL || strlen(salt) == 1) {
> +
> +  if (geteuid() || SELINUX_ENABLED) {

Why not just skip the geteuid() test entirely and run the helper whenever it's 
not possible to directly read /etc/shadow?  The worst-case scenario for such 
a code change is to needlessly run the helper in situations where a disk 
error or other serious failure makes the file unavailable, but optimising 
performance for grossly broken systems which are essentially unusable is not 
worth doing IMHO.

Also skipping the geteuid() test entirely will also potentially allow other 
MAC systems to be dropped in place with little effort.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
