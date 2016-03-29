Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u2T8YHVV012649
 for <selinux@tycho.nsa.gov>; Tue, 29 Mar 2016 04:35:57 -0400
Subject: Re: Fedora 23 error when using policy generator
To: Amir Eaman <amir.imen@gmail.com>, selinux@tycho.nsa.gov
References: <CA+D4ZVpm660vuxgQSYQH_QU5re=mvczEK=8L3L+DAbtcNAHh9g@mail.gmail.com>
 <CA+D4ZVpHWM_hS_Ld8n00yJ_A_aO517WJp1mDrW+kXJvdeJo=mw@mail.gmail.com>
From: Miroslav Grepl <mgrepl@redhat.com>
Message-ID: <56FA3DEE.40801@redhat.com>
Date: Tue, 29 Mar 2016 10:33:50 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CA+D4ZVpHWM_hS_Ld8n00yJ_A_aO517WJp1mDrW+kXJvdeJo=mw@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/27/2016 05:29 AM, Amir Eaman wrote:
> The exact error is: in Fedora 23
> 
> root@localhost selinux-master]# *selinux-polgengui***
> 
>     Failed to retrieve rpm info for selinux-policy 
>     Traceback (most recent call last): 
>       File "/bin/selinux-polgengui", line 360, in forward 
>         self.generate_policy() 
>       File "/bin/selinux-polgengui", line 506, in generate_policy 
>         self.info <http://self.info>(my_policy.generate(outputdir)) 
>       File "/usr/lib64/python2.7/site-packages/sepolicy/generate.py",
>     line 1382, in generate 
>         out += "%s # %s\n" % (self.write_spec(out_dir), _("Spec file")) 
>       File "/usr/lib64/python2.7/site-packages/sepolicy/generate.py",
>     line 1228, in write_spec 
>         fd.write(self.generate_spec()) 
>       File "/usr/lib64/python2.7/site-packages/sepolicy/generate.py",
>     line 1190, in generate_spec 
>         selinux_policyver = get_rpm_nvr_list("selinux-policy")[1] 
>     TypeError: 'NoneType' object has no attribute '__getitem__'
> 
> 
> On Sat, Mar 26, 2016 at 8:39 PM, Amir Eaman <amir.imen@gmail.com
> <mailto:amir.imen@gmail.com>> wrote:
> 
>     Hi,
>     When I press apply button in the last step for policy generator on
>     Fedora 23 the following error is issued. What should I do?
>     ​
> 
>     > Failed to retrieve rpm info for selinux-policy
>     > Traceback (most recent call last):
>     >   File "/usr/lib/python-exec/python2.7/sepolicy", line 643, in <module>
>     >     args.func(args)
>     >   File "/usr/lib/python-exec/python2.7/sepolicy", line 517, in generate
>     >     print mypolicy.generate(args.path)
>     >   File "/usr/lib64/python2.7/site-packages/sepolicy/generate.py", line 1370, in generate
>     >     out += "%s # %s\n" % (self.write_spec(out_dir), _("Spec file"))
>     >   File "/usr/lib64/python2.7/site-packages/sepolicy/generate.py", line 1219, in write_spec
>     >     fd.write(self.generate_spec())
>     >   File "/usr/lib64/python2.7/site-packages/sepolicy/generate.py", line 1181, in generate_spec
>     >     selinux_policyver = get_rpm_nvr_list("selinux-policy")[1]
>     > TypeError: 'NoneType' object has no attribute '__getitem__'

Could you please open a new Fedora bug - https://bugzilla.redhat.com/.

Thank you.

> 
>     ​
> 
>     -- 
> 
> 
> 
> 
> -- 
> 
> 
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 


-- 
Miroslav Grepl
Senior Software Engineer, SELinux Solutions
Red Hat, Inc.
