Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mAMHIqZW029703
	for <selinux@tycho.nsa.gov>; Sat, 22 Nov 2008 12:18:52 -0500
Received: from wa-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mAMHIqcq007747
	for <selinux@tycho.nsa.gov>; Sat, 22 Nov 2008 17:18:52 GMT
Received: by wa-out-1112.google.com with SMTP id j5so1622774wah.18
        for <selinux@tycho.nsa.gov>; Sat, 22 Nov 2008 09:18:51 -0800 (PST)
Subject: Re: Problem Setting Policy To Enforcing Mode
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: erahul29@yahoo.com
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <674101.15460.qm@web50212.mail.re2.yahoo.com>
References: <674101.15460.qm@web50212.mail.re2.yahoo.com>
Content-Type: text/plain
Date: Sat, 22 Nov 2008 09:18:47 -0800
Message-Id: <1227374327.3205.14.camel@LiNuX>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2008-11-22 at 03:09 -0800, Rahul Jain wrote:
> Thankyou all for your kind help.
>  
> Finally I was able to boot my policy. As suggested, I removed
> dontaudit rules from my policy by doing "make enableaudit". Then I did
> some quick fixes and was finally able to boot the policy. However I am
> still facing some issues:
> Firstly - My syslog daemon takes too long to start almost 10 min.
> Please note my test systems are high end multiprocessor express
> servers with 8 GB of RAM.
> Secondly: I am not able to come back to permissive mode, not even
> by login as sysadm_r role. My file system is read only and so I am not
> able to edit the /etc/selinux/config file. "setenforce" command
> temperoraly puts the policy in permissive mode but still config file
> could not be edited. I even tried it in linux single user mode,
> but the problem persists. Is it the property of the tresys reference
> policy or my policy is still not behaving properly?
> I reallly appreciate your kind help
>  
> Thanks 
> Rahul    
> 

Cool, glad to hear you're up and running.
Like what Stephen had mentioned, you should check and
make sure the files are labeled correctly. before doing a 
make enable audit.(this way you don't strip down you're policy);
With the syslog either you have it installed incorrectly, or 
there still is denials showing up causing syslog to partially
work. i.g. I usually do a "rm /var/log/syslog, touch /var/log/syslog,
reboot, audit2allow -i /var/log/syslog", to see any dbus avc's
(that is if dbus is running correctly); most likely if 
you are booting into permissive and syslog start's right up, as opposed
to enforcing, then there's a denial floating around that needs to be
allowed. As for setting permissive mode,
what is you're initial context?
(i.g. id -Z once you've started up.);

regards;

-- 
Justin P. Mattock <justinmattock@gmail.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
