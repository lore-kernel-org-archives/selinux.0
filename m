Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i872PRrT023651
	for <selinux@tycho.nsa.gov>; Mon, 6 Sep 2004 22:25:28 -0400 (EDT)
Received: from wisconsin.yamato.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i872OZvL006521
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2004 02:24:36 GMT
Received: from e19f2n15.jp.ibm.com (d19relay01.sagamino.japan.ibm.com [9.189.5.43])
	by wisconsin.yamato.ibm.com (8.11.6p2-20030922/8.11.1) with ESMTP id i872PFx588318
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2004 11:25:15 +0900
Received: from D19ML102.sagamino.japan.ibm.com (d19av02.sagamino.japan.ibm.com [9.189.5.91])
	by e19f2n15.jp.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id i872PEo5160538
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2004 11:25:14 +0900
In-Reply-To: <200409061526.i86FQA6I003847@mms-r00.iijmio.jp>
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Subject: Re: PAM in suse9.1 (Re: SuSE 9.1 SELinux)
From: Takuya Mishina <TMISHINA@jp.ibm.com>
Message-ID: <OF296DC5F7.062BA6BF-ON49256F08.000B7FC4-49256F08.000D462A@jp.ibm.com>
Date: Tue, 7 Sep 2004 11:25:10 +0900
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all,

Nakamura-san's patch for pam_unix module is useful to make newrole running 
without setuid bit.

I've changed my SuSE 9.1 to use Nakamura-san's patched pam_unix.so.
(modify /etc/pam.d/newrole and install patched pam_unix.so to 
/lib/security)
After that newrole runs correctly without setuid bit.


Yuichi Nakamura <himainu-ynakam@miomio.jp> wrote on 2004/09/07 00:25:59:
> *In modules/pam_unix/support.c of FedoraCore3-test1
> <snip>
>                 if (geteuid() || SELINUX_ENABLED) {
>                         /* we are not root perhaps this is the reason? 
Run helpe
> r */
>                         D(("running helper binary"));
>                         retval = _unix_run_helper_binary(pamh, p, ctrl, 
name);
> <snip>
> 
> *in modules/pam_unix/support.c of SUSE9.1
> <snip>
>                 if (geteuid()) {
>                         /* we are not root perhaps this is the reason? 
Run helpe
> r */
>                         D(("running helper binary"));
>                         retval = _unix_run_helper_binary(pamh, p, ctrl, 
name);
> <snip>


---
Takuya MISHINA
IBM Research, Tokyo Research Laboratory




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
