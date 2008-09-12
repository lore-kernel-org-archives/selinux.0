Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8CCiWO1001058
	for <selinux@tycho.nsa.gov>; Fri, 12 Sep 2008 08:44:33 -0400
Received: from mail-gx0-f12.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8CCiW77000861
	for <selinux@tycho.nsa.gov>; Fri, 12 Sep 2008 12:44:33 GMT
Received: by gxk5 with SMTP id 5so18719190gxk.18
        for <selinux@tycho.nsa.gov>; Fri, 12 Sep 2008 05:44:32 -0700 (PDT)
Message-ID: <dd18b0c30809120544t4908fbd7tfb473ad62fcf512b@mail.gmail.com>
Date: Fri, 12 Sep 2008 05:44:32 -0700
From: "Justin Mattock" <justinmattock@gmail.com>
To: "Tomas Mraz" <tmraz@redhat.com>
Subject: Re: setkey ipsec no avc's message
Cc: "SE Linux" <selinux@tycho.nsa.gov>
In-Reply-To: <1221202592.3332.87.camel@vespa.frost.loc>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <dd18b0c30809111447yb1e1d59n30570e0773ae2cb7@mail.gmail.com>
	 <1221202592.3332.87.camel@vespa.frost.loc>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 11, 2008 at 11:56 PM, Tomas Mraz <tmraz@redhat.com> wrote:
> On Thu, 2008-09-11 at 14:47 -0700, Justin Mattock wrote:
>> when starting ipsec, there is a daemon
>> or I can run /usr/sbin/setkey. at the moment I've disabled
>> setkey daemon at boot up, and am using the manual
>> approach. when issuing setkey -f /etc/ipsec-tools.conf
>> the file does go into the SDP entry without any issues,
>>  but also leaves avc's in dmesg. (below);
>>
>> [  157.919674] type=1415 audit(1221168887.813:5): op=SAD-add
>> auid=4294967295 ses=4294967295 subj=a-12:sysadm_r:sysadm_t
>> src=10.0.0.8 dst=10.0.0.5 spi=512(0x200) res=1
>> [  157.919714] type=1300 audit(1221168887.813:5): arch=40000003
>> syscall=102 success=yes exit=120 a0=9 a1=bfee55b0 a2=805a6d0 a3=20
>> items=0 ppid=3830 pid=3916 auid=4294967295 uid=0 gid=0 euid=0 suid=0
>> fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts1 ses=4294967295 comm="setkey"
>> exe="/usr/sbin/setkey" subj=a-12:sysadm_r:sysadm_t key=(null)
> ...
>> When using audit2allow -d
>> there is a message of: No AVC's found.
>> Anyways not sure if this is good or bad...
>> thaught it would be better to post than to not at all.
>> Besides that ipsec seems to be running nicely, with the policy
>> in enforcing mode.
>> regards;
> The messages are not AVCs so audit2allow does not have any work to do.
> The messages are in the audit.log/dmesg just for auditing purposes and
> are not related to SELinux.
>
> --
> Tomas Mraz
> No matter how far down the wrong road you've gone, turn back.
>                                              Turkish proverb
>
>

At the moment I don't have auditd
running, but if these are normal, then
O.K.
just thought it would be better to post, than not.
At first I thought I was running setkeys in the wrong
role.
regards;

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
