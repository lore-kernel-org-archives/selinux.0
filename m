Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n874EA30008479
	for <selinux@tycho.nsa.gov>; Mon, 7 Sep 2009 00:14:10 -0400
Received: from mail-yw0-f204.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n874FSuA007243
	for <selinux@tycho.nsa.gov>; Mon, 7 Sep 2009 04:15:28 GMT
Received: by ywh42 with SMTP id 42so3444711ywh.30
        for <selinux@tycho.nsa.gov>; Sun, 06 Sep 2009 21:14:09 -0700 (PDT)
Message-ID: <4AA48895.8030400@gmail.com>
Date: Sun, 06 Sep 2009 21:14:13 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: zheyeung <zheyeung@gmail.com>
CC: waqar afridi <afridi.waqar@gmail.com>, selinux <selinux@tycho.nsa.gov>
Subject: Re: Problem install Reference Policy
References: <200909071010066097796@gmail.com>
In-Reply-To: <200909071010066097796@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

zheyeung wrote:
> hello waqar, I used to get this problem.after then, i edit file 
> build.conf in some way  ,then make . make successfully!
> but I've got another problem . after i install the policy (by editting 
> /etc/ selinux/config ,reboot)  ,my graphic user interface failed to 
> start up.and i don't kown why.
> I run "semanage login -l" ,found "login" of root is root: sysadm_r.but 
> default targeted in Fedora-11. root 's "login" is "unconfined_u: 
> unconfined_r".

you might try  make clean, make enableaudit, make policy
this will generate some more avc's that you might need
to allow to startx.
> 2009-09-07
> ------------------------------------------------------------------------
> zheyeung
> ------------------------------------------------------------------------
> *发件人：* waqar afridi
> *发送时间：* 2009-09-05  15:44:44
> *收件人：* selinux
> *抄送：*
> *主题：* Problem install Reference Policy
> Hello Every One,
>
> I am new to selinux, I am using Ubuntu and i am trying to install 
> reference Policy on it, after running command make load, I get this error,
> I dont know whats wrong
>
> /usr/bin/checkpolicy policy.conf -o 
> /etc/selinux/refpolicy/policy/policy.23
> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> policy/modules/services/ifplugd.te":67:ERROR 'type netutils_exec_t is 
> not within scope' at token ';' on line 362418:
>     allow ifplugd_t netutils_exec_t:file { getattr open read execute };
> #line 67
> checkpolicy:  error(s) encountered while parsing configuration
> make: *** [/etc/selinux/refpolicy/policy/policy.23] Error 1
>
>
> -- 
> Waqar Afridi

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
