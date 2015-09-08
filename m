Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t883mFUu032453
 for <selinux@tycho.nsa.gov>; Mon, 7 Sep 2015 23:48:17 -0400
From: kuangjiou <kuangjiou@huawei.com>
To: Dominick Grift <dac.override@gmail.com>
CC: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: got some problems with the type_transition rules
Date: Tue, 8 Sep 2015 02:07:26 +0000
Message-ID: <60ABE64B4BE4AC45964F1A967BA76CB201F75392@SZXEMI502-MBS.china.huawei.com>
References: <60ABE64B4BE4AC45964F1A967BA76CB201F75356@SZXEMI502-MBS.china.huawei.com>
 <20150907161449.GA12835@x250>
In-Reply-To: <20150907161449.GA12835@x250>
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I got this message when I input "sesearch -ASCT -s unconfined_t | grep type_transition | grep tpm_dentry_t"
 type_transition unconfined_t tpm_dentry_t : file stmfile_lst_t;

does it mean the kernel 3.0.76 don't support for optional file name in type_transition rules?

-----邮件原件-----
发件人: Dominick Grift [mailto:dac.override@gmail.com] 
发送时间: 2015年9月8日 0:15
收件人: kuangjiou
抄送: 'selinux@tycho.nsa.gov'
主题: Re: got some problems with the type_transition rules

On Mon, Sep 07, 2015 at 11:22:26AM +0000, kuangjiou wrote:
> Hello,everyone!
> 
> I am trying to use the optional file name feature in type_transition 
> rules , And I test it in my OS (with kernel 3.0.76 and selinux 
> userspace 2.1.0 ),
> 
> 
> 1.       I add the type_tansition rule in my policy like this : filetrans_pattern(unconfined_t,tpm_dentry_t,stmfile_lst_t,file,"123"), It can be compiled and installed successfully
> 
> 
> 
> But , every files that I creat in the tpm_dentry_t dentry , I will get 
> the stmfile_lst_t type, not just the file named 123
> 
> 
> 
> 2.       I add two type_tansition rules in my policy like this :
> filetrans_pattern(unconfined_t,tpm_dentry_t,stmfile_lst_t,file,"123")
> 
> filetrans_pattern(unconfined_t,tpm_dentry_t,trust_log_t,file,"456")
> 
> 
> 
> It can be conpiled successfully, But got some error when install
> 

I would have a look at applicable type_transition rules with sesearch to see what is there.

sesearch -ASCT -s unconfined_t | grep type_transition | grep tpm_dentry_t

> 
> 
> 
> libsepol.expand_terule_helper: conflicting TE rule for (unconfined_t, 
> tpm_dentry_t:file):  old was stmfile_lst_t, new is trust_log_t
> libsepol.expand_module: Error during expand
> libsemanage.semanage_expand_sandbox: Expand module failed
> 
> semodule:  Failed!
> 
> 
> 
> 
> Can anyone help me with this problem, Thank you!
> 
> 
> pS: I got the selinux userspace 2.1.0 from here
> 
> https://github.com/SELinuxProject/selinux/wiki/Releases
> 
> 

> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.


--
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=vindex&search=0x314883A202DFF788
Dominick Grift
