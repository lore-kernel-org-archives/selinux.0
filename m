Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id WAA05199
	for <selinux@tycho.nsa.gov>; Sun, 18 Aug 2002 22:03:01 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id CAA21777
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 02:01:57 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id CAA21771
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 02:01:55 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brad Chapman <jabiru_croc@yahoo.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: psidfiles_init errors
Date: Mon, 19 Aug 2002 04:02:44 +0200
References: <20020819015459.26016.qmail@web40004.mail.yahoo.com>
In-Reply-To: <20020819015459.26016.qmail@web40004.mail.yahoo.com>
MIME-Version: 1.0
Message-Id: <20020819020245.495578922@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 19 Aug 2002 03:54, Brad Chapman wrote:
>       Could someone please explain the following errors?
>
> psidfiles_init:  invalid context system_u:object_r:dmesg_exec_t (psid 89).
> psidfiles_init:  invalid context system_u:object_r:xdm_log_t (psid 92).
> psidfiles_init:  invalid context system_u:object_r:minilogd_exec_t (psid
> 120). ...
> psidfiles_init:  invalid context system_u:object_r:writeable_t (psid 37).
> psidfiles_init:  invalid context system_u:object_r:mesg_exec_t (psid 47).
> psidfiles_init:  invalid context Brad:object_r:writeable_t (psid 62).
> psidfiles_init:  invalid context system_u:object_r:samba_t (psid 64).

These are file types that existed in old versions of the policy but which 
don't exist any more.  They still have entries in the ...security database 
because there's no code to clean them up (IMHO they should be removed when 
there are no files of that context on the file system any more).

To avoid the messages add the following to your policy:
type dummy_file_t alias { dmesg_exec_t xdm_log_t minilogd_exec_t ... };

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
