Date: Mon, 5 Mar 2007 09:24:21 +0900
From: Yuichi Nakamura <ynakam@hitachisoft.jp>
To: "Ryan Bradetich" <rbradetich@gmail.com>
Cc: ynakam@hitachisoft.jp, "Stephen Smalley" <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov,
        "Christopher J. PeBenito" <cpebenito@tresys.com>, busybox@kaigai.gr.jp
Subject: Assgin domain to busybox applet(Re: Failed write to
 /selinux/context in selinux_trans_to_raw_contex()
Message-Id: <20070305092421.c5121997.ynakam@hitachisoft.jp>
In-Reply-To: <e739902b0703020821y5d880932re07b74cca44e0b9c@mail.gmail.com>
References: <e739902b0702282357i2f5645bbmab4c04a0bdb1d3f3@mail.gmail.com>
	<1172751150.19041.536.camel@moss-spartans.epoch.ncsc.mil>
	<e739902b0703010810g64146e59h184dfe13365e16ce@mail.gmail.com>
	<1172765760.19041.578.camel@moss-spartans.epoch.ncsc.mil>
	<e739902b0703011324y561503a0v49ded6db4b700b8c@mail.gmail.com>
	<e739902b0703012254j5b078fckd364da8b8ccfb4ab@mail.gmail.com>
	<1172836471.19041.611.camel@moss-spartans.epoch.ncsc.mil>
	<e739902b0703020821y5d880932re07b74cca44e0b9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2 Mar 2007 08:21:03 -0800
"Ryan Bradetich" wrote:
> [NOTE: I will be asking the communities advice on shortly is how to
> handle busybox.  The problem is that busybox is a single binary that
> provides the functionality of many binaries (init, login, coreutils,
> etc).  I am not quite far enough to fully understand the problem, but
> I am pretty sure it will be a problem.  I will start a different
> thread on this problem soon.]
We(people in JSELUG(Japan SELinux Users Group) 
are extending busybox to assign domain to busybox applets.
It might be useful for you.
You can obtain it from
http://code.google.com/p/sebusybox/source

By preparing wrapper program or separting executable,
you can assign domain to applet,
but it is not useful.
We decided to extend busybox to support dynamic domain transition.

In this, "CONFIG_SELINUX_DYNTRANSITION" is prepared.
It is under "Support NSA Security Enhanced Linux" in menu.
By enabling this, you can assign domain to applet by dynamic domain transition.

It can assign entrypoint label to applet, by following syntax.
In file_contexts file:
<path to busybox>/<name of applet>  system_u:object_r:<entry point label>
For example, assume following situation
* busybox executable is: /usr/bin/busybox
* applet name is httpd
* entrypoint label you want to assign is httpd_exec_t
Then you have to write following in file_contexts
/usr/bin/busybox/httpd  system_u:object_r:httpd_exec_t

You also need to write domain_auto_trans rule
and allow some permissions(setcontext, dyntransition) for dynamic domain transition.
Sample policy is under construction, sorry..

Extended Busybox obtain
applet's entrypoint label by matchpathcon,  
decides domain transition by compute_av, and set new domain by setcon.

We are using file_contexts file to label entrypoint.
However, it has to use /proc/self/exe,
so before mounting /proc ,it does not work.

We are preparing another patch that does not use file_contexts 
and uses "busybox_contexts file" to assign entrypoint label.
I hope we can announce it in near future..

Documentation is under construction, 
so please ask us if you have questions.

Regards,
-- 
Yuichi Nakamura
Hitachi Software Engineering Co., Ltd.
SELinux Policy Editor: http://seedit.sourceforge.net/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
