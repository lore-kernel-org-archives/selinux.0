Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6GAijrT028295
	for <selinux@tycho.nsa.gov>; Fri, 16 Jul 2004 06:44:45 -0400 (EDT)
Received: from smtp800.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6GAiMbx000459
	for <selinux@tycho.nsa.gov>; Fri, 16 Jul 2004 10:44:23 GMT
Date: Fri, 16 Jul 2004 11:55:40 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>, Erich Schubert <erich@debian.org>,
   selinux@tycho.nsa.gov, bam@snoopy.apana.org.au
Subject: Re: SELinux Policy patches
Message-ID: <20040716105540.GD3097@lkcl.net>
References: <20040716002210.GA1081@wintermute.xmldesign.de> <200407161234.03434.russell@coker.com.au> <20040716081924.GB3097@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040716081924.GB3097@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jul 16, 2004 at 09:19:24AM +0100, Luke Kenneth Casson Leighton wrote:
> > > I have a couple of access violation with applications of
> > >   foo var_lib_t:dir search;
> > >   foo var_lib_t:lnk_file read;
> > > for example syslogd, inetd, postfix_masteri, staff_ssh_t.
> > > Should i allow these or use dontaudit, and should i submit patches for
> > > such? Is there a known reason for such behaviour?
> > 
> > What are they trying to access under /var/lib?
>  
>  i've seen this too - related to nsswitch iirc correctly.
 
 strace shows ssh-keygen doing this sort of thing:

	connect(3, {sa_family=AF_UNIX, path="/var/run/.nscd_socket"}, 110) = -1
	ENOENT (No such file or directory)
 
 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
