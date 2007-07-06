Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l66A4lFn007594
	for <selinux@tycho.nsa.gov>; Fri, 6 Jul 2007 06:04:47 -0400
Received: from nz-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l66A4kip005801
	for <selinux@tycho.nsa.gov>; Fri, 6 Jul 2007 10:04:46 GMT
Received: by nz-out-0506.google.com with SMTP id l1so147039nzf
        for <selinux@tycho.nsa.gov>; Fri, 06 Jul 2007 03:04:46 -0700 (PDT)
Message-ID: <468E12BB.7090108@gmail.com>
Date: Fri, 06 Jul 2007 18:00:27 +0800
From: Ken YANG <spng.yang@gmail.com>
MIME-Version: 1.0
To: Louis Lam <lshoujun@yahoo.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Newbie: Using SELINUX to contain vmware
References: <979466.12399.qm@web34812.mail.mud.yahoo.com>
In-Reply-To: <979466.12399.qm@web34812.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Louis Lam wrote:
> Hi All,
> 
> I'm trying to use SELINUX to contain vmware. I'm a newbie to the "newer" modules based SELINUX
> under RHEL5/CenTOS5. I can see that there is a vmware.if defined but don't know how to build the
> module vmware.pp. Not even sure if i'm on the correct track doing this. pl advice.

what is your system? in fedora, there is vmware module at default:

-(:17:48:$)-> sudo semodule -l|grep vmware
vmware  1.1.1

if your policy have not vmware module, you can build it from policy source:

# cd "dir containg your vmware source policy"
(vmware.fc, vmware.te, vmware.if)

# make -f /usr/share/selinux/devel/Makefile
(you must install selinux-policy-devel package first)

# semodule -i vmware.pp
# restorecon -R -v "vmware relative directories"


> 
> I'm trying to use SELINUX to contain the free vmplayer 2.0.0 downloadable from vmware site. Has
> anyone succeeded in doing so? Maybe can point me to the right resources. Thanks.

through upstream vmware policy, i can run vmware-workstation 6 smoothly,
so i think vmplayer 2.0.0 is also ok.


> 
> Thanks in Advance,
> Louis
> 
> Send instant messages to your online friends http://uk.messenger.yahoo.com 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
