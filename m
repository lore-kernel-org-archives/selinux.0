Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA23852
	for <selinux@tycho.nsa.gov>; Wed, 7 Aug 2002 08:41:31 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA18862
	for <selinux@tycho.nsa.gov>; Wed, 7 Aug 2002 12:40:36 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id MAA18850
	for <selinux@tycho.nsa.gov>; Wed, 7 Aug 2002 12:40:31 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Frank Mayer" <mayerf@tresys.com>,
        "Samarth Sharma" <samarth7880@rediffmail.com>, <selinux@tycho.nsa.gov>
Subject: Re: adduser??
Date: Wed, 7 Aug 2002 14:41:11 +0200
References: <ACEHIKGIGFEDAIKEMMMIIEDHKFAA.mayerf@tresys.com>
In-Reply-To: <ACEHIKGIGFEDAIKEMMMIIEDHKFAA.mayerf@tresys.com>
MIME-Version: 1.0
Message-Id: <20020807124111.9FC8D2800@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 7 Aug 2002 14:36, Frank Mayer wrote:
> > Also you may want to change the file_context/types.fc to use the
> > sysadm_home_t for the home directory of the user in question and
> > use setfiles
> > to apply the change.
>
> I think I would use "chcon <user>:object_r:sysadm_hom_t" if you wanted to
> change the user's home directory.  Running setfiles seems like overkill.
>
> Of course one should also edit file_context/types.fc as suggested so that
> if setfiles is re-run at some future date, the appropriate labels are
> applied. What we're doing for labeling in install scripts for new stuff
> after the system has been installed is: 1) add, install, and load our
> policy updates, 2) use install -X or chcon to fix those labels we care
> about, and 3) change/add the appropriate *.fc files to make those labeling
> changes permanent in case setfiles is run again.

So do you have patches to adduser to use the correct contexts for files?

Currently I have the following contexts:
/home                           system_u:object_r:root_t
/home/[^/]*     -d              system_u:object_r:user_home_dir_t
/home/.*/.*                     system_u:object_r:user_home_t
/home/[^/]*/.ssh(|/.*)          system_u:object_r:user_home_ssh_t
/home/[^/]*/.gnupg(|/.*)          system_u:object_r:user_gpg_secret_t

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
