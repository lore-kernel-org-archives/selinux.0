Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k01HmvXf000934
	for <selinux@tycho.nsa.gov>; Sun, 1 Jan 2006 12:48:57 -0500 (EST)
Received: from e34.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k01Hms1Z025351
	for <selinux@tycho.nsa.gov>; Sun, 1 Jan 2006 17:48:54 GMT
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e34.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k01HmtS0005627
	for <selinux@tycho.nsa.gov>; Sun, 1 Jan 2006 12:48:55 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k01HlfSr184158
	for <selinux@tycho.nsa.gov>; Sun, 1 Jan 2006 10:47:41 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k01Hmtuv006015
	for <selinux@tycho.nsa.gov>; Sun, 1 Jan 2006 10:48:55 -0700
Date: Sun, 1 Jan 2006 11:48:54 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: linux-security-module@wirex.com, "SELinux(NSA)" <selinux@tycho.nsa.gov>
Subject: Re: SELinux metadata protection
Message-ID: <20060101174854.GB16971@sergelap.austin.ibm.com>
References: <43B6C9E3.8020406@kaigai.gr.jp> <20060101153856.GA15767@sergelap.austin.ibm.com> <43B811E9.9000907@kaigai.gr.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43B811E9.9000907@kaigai.gr.jp>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting KaiGai Kohei (kaigai@kaigai.gr.jp):
> Hmm... I'm not so familiar with ISO-15408.
> Do you know previous discussions about such behavior on filename resolving 
> or readdir ?

I can look around later in the week for past discussions (not sure
whether there have been any), but at least here is the protection
profile I'm talking about:
http://niap.nist.gov/cc-scheme/pp/PP_MLOSPP-MR_V1.22.html

> Pay attention to what 'filler' was overwritten in this patch.
> When LSM is enable, FS's readdir method (dir->f_op->readdir) always calls 
> 'security_file_filldir'
> for each directory entry instead of original 'filler' given by arguments.

Yes, I see, and I was being dense and misread it.  So forget what I said
before.  But please add a good comment above the security_file_filldir
definition.  Also, the kernel community doesn't like typedefs, so please
change

+typedef struct {
+       struct file *dir;
+       void *buffer;
+       filldir_t filler;
+} security_filldir_t;

to something like

+struct security_filldir_info {
+       struct file *dir;
+       void *buffer;
+       filldir_t filler;
+};


Do you have any performance measurements, say with selinux and with only
capabilities compiled in, with and without this patch?  I suspect that will
be one of the most important points of contention if this goes to the
linux-kernel list.

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
