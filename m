Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i86FQGrT021725
	for <selinux@tycho.nsa.gov>; Mon, 6 Sep 2004 11:26:16 -0400 (EDT)
Received: from mbox-o00.iijmio.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i86FQEaj018718
	for <selinux@tycho.nsa.gov>; Mon, 6 Sep 2004 15:26:15 GMT
Message-Id: <200409061526.i86FQA6I003847@mms-r00.iijmio.jp>
Date: Mon, 06 Sep 2004 11:25:59 -0400
From: Yuichi Nakamura <himainu-ynakam@miomio.jp>
MIME-Version: 1.0
To: Takuya Mishina <TMISHINA@jp.ibm.com>
Cc: selinux@tycho.nsa.gov, himainu-ynakam@miomio.jp
Subject: PAM in suse9.1 (Re: SuSE 9.1 SELinux)
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <OF93C1DDD2.9FAF1403-ON49256F06.00517E1E-49256F07.0007F249@jp.ibm.com>
References: <OF93C1DDD2.9FAF1403-ON49256F06.00517E1E-49256F07.0007F249@jp.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Takuya Mishina <TMISHINA@jp.ibm.com> wrote:
> I've tried being enable SELinux on SuSE 9.1 personal edition, followings 
> are the installation and configuration memo.
According to Japanese SELinux Mailing list(as you know, Takuya),
we have to add "auth" attribute to local_login_t and 
add "allow local_login_t shadow_t:file r_file_perms;"
We have to do the same thing for "sshd_t".

It seems that PAM in SUSE does not use "unix_chkpwd" to read /etc/shadow.
I think it will be better to use "unix_chkpwd", because the priveledge to read password is restricted.
The following is PAM source related to this.

*In modules/pam_unix/support.c of FedoraCore3-test1
<snip>
                if (geteuid() || SELINUX_ENABLED) {
                        /* we are not root perhaps this is the reason? Run helpe
r */
                        D(("running helper binary"));
                        retval = _unix_run_helper_binary(pamh, p, ctrl, name);
<snip>

*in modules/pam_unix/support.c of SUSE9.1
<snip>
                if (geteuid()) {
                        /* we are not root perhaps this is the reason? Run helpe
r */
                        D(("running helper binary"));
                        retval = _unix_run_helper_binary(pamh, p, ctrl, name);
<snip>

"_unix_run_helper_binary" is always called in FC3+SELinux, but not in SUSE9.1.

> + setuid to /usr/bin/newrole
>   # chmod 4755 /usr/bin/newrole
>   SuSE Linux newrole seems not to use PAM for authentication, so newrole 
> must be able to read /etc/shadow. 
This may be the problem of "unix_chkpwd" in PAM, too.

---
Yuichi Nakamura
Japan SELinux Users Group(JSELUG)
http://www.selinux.gr.jp/
The George Washington University

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
