Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8C6vswk031557
	for <selinux@tycho.nsa.gov>; Fri, 12 Sep 2008 02:57:54 -0400
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8C6v9cm007177
	for <selinux@tycho.nsa.gov>; Fri, 12 Sep 2008 06:57:09 GMT
Subject: Re: setkey ipsec no avc's message
From: Tomas Mraz <tmraz@redhat.com>
To: Justin Mattock <justinmattock@gmail.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <dd18b0c30809111447yb1e1d59n30570e0773ae2cb7@mail.gmail.com>
References: <dd18b0c30809111447yb1e1d59n30570e0773ae2cb7@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 12 Sep 2008 08:56:32 +0200
Message-Id: <1221202592.3332.87.camel@vespa.frost.loc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2008-09-11 at 14:47 -0700, Justin Mattock wrote:
> when starting ipsec, there is a daemon
> or I can run /usr/sbin/setkey. at the moment I've disabled
> setkey daemon at boot up, and am using the manual
> approach. when issuing setkey -f /etc/ipsec-tools.conf
> the file does go into the SDP entry without any issues,
>  but also leaves avc's in dmesg. (below);
> 
> [  157.919674] type=1415 audit(1221168887.813:5): op=SAD-add
> auid=4294967295 ses=4294967295 subj=a-12:sysadm_r:sysadm_t
> src=10.0.0.8 dst=10.0.0.5 spi=512(0x200) res=1
> [  157.919714] type=1300 audit(1221168887.813:5): arch=40000003
> syscall=102 success=yes exit=120 a0=9 a1=bfee55b0 a2=805a6d0 a3=20
> items=0 ppid=3830 pid=3916 auid=4294967295 uid=0 gid=0 euid=0 suid=0
> fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts1 ses=4294967295 comm="setkey"
> exe="/usr/sbin/setkey" subj=a-12:sysadm_r:sysadm_t key=(null)
...
> When using audit2allow -d
> there is a message of: No AVC's found.
> Anyways not sure if this is good or bad...
> thaught it would be better to post than to not at all.
> Besides that ipsec seems to be running nicely, with the policy
> in enforcing mode.
> regards;
The messages are not AVCs so audit2allow does not have any work to do.
The messages are in the audit.log/dmesg just for auditing purposes and
are not related to SELinux.

-- 
Tomas Mraz
No matter how far down the wrong road you've gone, turn back.
                                              Turkish proverb


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
