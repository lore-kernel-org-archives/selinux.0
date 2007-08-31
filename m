Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7V9vpXw029271
	for <selinux@tycho.nsa.gov>; Fri, 31 Aug 2007 05:57:51 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7V9vnS9012398
	for <selinux@tycho.nsa.gov>; Fri, 31 Aug 2007 09:57:49 GMT
Message-ID: <46D7E619.40601@redhat.com>
Date: Fri, 31 Aug 2007 05:57:45 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Ian jonhson <jonhson.ian@gmail.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: About the polgengui in FC7
References: <8f34198c0708300703g7b75cdfbpe65a675e78a56dff@mail.gmail.com>	 <46D6FD7E.6060306@redhat.com> <8f34198c0708302015v1daba3e5n3111bf6da628b13d@mail.gmail.com>
In-Reply-To: <8f34198c0708302015v1daba3e5n3111bf6da628b13d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ian jonhson wrote:
> Dear Daniel,
> 
> Thank you very much for your answering.
> 
> 
> As you said in your article, I follows the steps to build my policy module:
> 
> Step 1:
> 
> 1.Name of application to be confined
>  - use the linux command, rwho, which I yum and installed my FC7
> livecd version.
>  - path: /usr/bin/rwho
> 2. Application type
>  - Web Application/Script (CGI). I choose the item. In fact, I don't
> know which one is correct.
> 3.Incoming network port connections
>  - UDP port 513
> 4.Outgoing network port connections
>  - UDP port 513
> 5.Common application traits
>  - application uses syslog to log messages. I choose this one beacuse
> I want to see something information feelback in syslog.
> 6.Files and directories (where the application will write)
>  - Add file: I added my application, my_test, from /root/selinux_test/.
>  - Add directories: my work directory, /root/selinux_test.
> 7.Generate policy in this directory
>  - Policy Directory: /root/selinux_test/policy
> 
> Step 2: Apply the new policy module
> 
> I enter into my work directory, /root/selinux_test/, and execute the
> shell script:
> 
> # cd /root/selinux_test
> # sh rwho.sh
> 
> It prompts a error message:
> 
> --------- dump of screen ----------
> make: /usr/share/selinux/devel/Makefile: No such file or directory
> make: *** No rule to make target '/usr/share/selinux/devel/Makefile', stop.
> /usr/sbin/semodule: Could not read file 'rwho.pp':
> /sbin/restorecon reset /usr/bin/rwho context
> system_u:object_r:bin_t:s0 -> system_u:object_r:bin_t:s0
> ...
yum install selinux-policy-devel
Then run the script again

> -----------------------------------
> 
> I called the ls to see what happed, however nothing created in current
> directory.
> 
> Step 3: Debug and complete the policy module
> 
> As you recommended in your article, I run in permissive mode.
> 
> # setenforce 0
> # service rwho restart
> rwho: unrecongnized service
> #
service rwhod restart
> 
> It looks like that something is wrong when I installed the rwho. I
> installed rwho by yum, and I don't know where is the problem.
> 
> I also look into the /etc/selinux, but I didn't find any new files or
> directories created here.
> 
> Another aspect I care about is "In the future we will be adding a
> mechanism for writing policy to actually confine a logged in user".
> You mean that current version does not support the case, in which I
> set customized policy for my executable program. For example, I build
> a executable program, named my_test_pg, in /root/selinux_test/. Then,
> I set a policy module for my_test_pg, which can access a file, named
> test_file_1, but cannot access another file, named test_file_2. If I
> have to implemented the example, what to do?
> 
yes you can do this,  The extension that I am adding, is to setup logged
in users who can not talk to the network, or only one port on the
network.  These users will not be able to run any setuid applications or
 even execute files in the home directories.
> 
> Thank you very much!
> 
> Your article and advices are very helpful to my jobs. :-)
> 
> 
> Ian

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFG1+YZrlYvE4MpobMRAlLtAJ9/Z7r0F6lNGNzSE4jD2sDRlJWwLQCfSg0C
MdEXXQJDChngRAbH8u23BN0=
=y2bC
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
