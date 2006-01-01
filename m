Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k022PBXf003624
	for <selinux@tycho.nsa.gov>; Sun, 1 Jan 2006 21:25:11 -0500 (EST)
Received: from e2.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k022P91Z010381
	for <selinux@tycho.nsa.gov>; Mon, 2 Jan 2006 02:25:09 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id k022P8F5006420
	for <selinux@tycho.nsa.gov>; Sun, 1 Jan 2006 21:25:08 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k022P8LT121344
	for <selinux@tycho.nsa.gov>; Sun, 1 Jan 2006 21:25:08 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k022P7FW008214
	for <selinux@tycho.nsa.gov>; Sun, 1 Jan 2006 21:25:08 -0500
Date: Sun, 1 Jan 2006 13:27:07 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: linux-security-module@wirex.com, "SELinux(NSA)" <selinux@tycho.nsa.gov>
Subject: Re: SELinux metadata protection
Message-ID: <20060101192707.GA19487@sergelap.austin.ibm.com>
References: <43B6C9E3.8020406@kaigai.gr.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43B6C9E3.8020406@kaigai.gr.jp>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting KaiGai Kohei (kaigai@kaigai.gr.jp):
> Hello,
> 
> Nowaday, I'm considering about a philosophical theme.
> 
> In my understanding, file-metadata includes _filename_ similar to filesize,
> update-timestamp, and so on. Most of permissions for reading metadata are
> defined as 'getattr' in SELinux.
> But permission for reading filename is defined as 'read' of parent directory,
> 'getattr' of each child-entries are not evaluated.
> 
> It seems a bit curious behavior for me. Why can an unauthorized process
> be allowed to know whether the file exists or not ?
> I think it's worthwhile to conceal the existence of files from unauthorized
> processes.
> 
> This patch enables to conceal the unauthorized files.
> [1/2] LSM_metadata_protection_v1.patch
>  - add security_file_readdir(), it's called when readdir() write each filename
>    to userspace.
>  - add security_inode_lookup(), it's called when filename is resolved by path_walk().
> 
> [2/2] SELinux_metadata_protection_v1.patch
>  - add checking 'getattr' permission on file_readdirand inode_lookup hooks.
> 
> Thanks, any comments please, and have a good year :)

Hmm, a question on behavior.

Let's say hallyn_t is allowed to write /var (var_t), but not to do
getattr on /var/secret_process_is_running (secret_t).  If hallyn_t
does ls /var/secret_process_is_running, he gets -ENOENT, but what
should he get if he does 'touch /var/secret_process_is_running'?
-EPERM obviously leaks information...

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
