Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oB9ArHW0023616
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2010 05:53:17 -0500
Received: from out3.smtp.messagingengine.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id oB9ArGUX022253
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2010 10:53:16 GMT
From: Roberto Sassu <roberto.sassu@polito.it>
To: selinux@lists.fedoraproject.org
Subject: selinux policy for encrypted files
Date: Thu, 9 Dec 2010 11:48:17 +0100
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201012091148.18323.roberto.sassu@polito.it>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all

i want to write a policy for encrypted files.
In order to do this i created some new types which have the
name of the correspondent type used for non encrypted files,
with the prefix 'encrypted_'.
Then i need to define the policy for applications that need to
use these new types which is very similar to this defined
for original types, except that i want to take rules only
for the 'dir' and 'file' class.
What this the best way to define the policy? Do i have
to duplicate all required interfaces/templates or can i reuse
the existent code, for instance by adding a new parameter?

I will show an example of what i'm trying to define.

New type: encrypted_etc_t;

Example interface:

interface(`files_list_etc',`
	gen_require(`
		type etc_t;
	')

	allow $1 etc_t:dir list_dir_perms;
')


Added interface:

interface(`files_list_encrypted_etc',`
	gen_require(`
		type encrypted_etc_t;
	')

	allow $1 encrypted_etc_t:dir list_dir_perms;
')

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
