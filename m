Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA13665
	for <selinux@tycho.nsa.gov>; Sun, 24 Mar 2002 20:15:20 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id BAA13681
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 01:13:56 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id BAA13673
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 01:13:53 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Dale Amon <amon@vnl.com>
Subject: Re: Mix and Match 2: relabel problems
Date: Mon, 25 Mar 2002 01:31:51 +0100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <20020324154541.GA31389@vnl.com>
In-Reply-To: <20020324154541.GA31389@vnl.com>
MIME-Version: 1.0
Message-Id: <20020325011447.7E56B2398F@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 24 Mar 2002 16:45, Dale Amon wrote:
> However I'm still missing something in his policy, because when
>
> I relabel after the boot:
> > make verbose
>
> ./setfiles -v file_contexts `mount | awk '/ext[23]/{print $3}'`
> ./setfiles:  Running on a SELinux kernel, using new system calls
> ./setfiles:  read 352 specifications
> ./setfiles:  invalid context system_u:object_r:slapd_db_t on line number 65
> ./setfiles:  invalid context system_u:object_r:slapd_replog_t on line
> number 66 ./setfiles:  invalid context system_u:object_r:slapd_exec_t on
> line number 401 make: *** [verbose] Error 1
>
> I'm using the policy/ from Russell's selinux_2002031409-2_i386.deb dist in
> the lsm-2.4-selinux-2002031409.tgz base release. With minor twiddles of
> my own to make things work together.

The -2 release wasn't complete, it had some entries in file_contexts without 
a matching .te file.  You can comment out those entries, use the slapd.te 
file I mailed here, or wait for a -3 release (soon I hope).

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
