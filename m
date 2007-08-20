Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7K8HETP031264
	for <selinux@tycho.nsa.gov>; Mon, 20 Aug 2007 04:17:14 -0400
Received: from wa-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7K8HD1M001174
	for <selinux@tycho.nsa.gov>; Mon, 20 Aug 2007 08:17:14 GMT
Received: by wa-out-1112.google.com with SMTP id v27so782753wah
        for <selinux@tycho.nsa.gov>; Mon, 20 Aug 2007 01:17:13 -0700 (PDT)
Message-ID: <8c2dc7030708200117w26d86872kff135e63a1ec0548@mail.gmail.com>
Date: Mon, 20 Aug 2007 16:17:13 +0800
From: "Liu Jian" <gjk.liu@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Subject: why there is a only_changed_user in restorecon?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I wonder why there is special check on the only_changed_user in the
restorecon. After
'chcon -u systerm_u /home/user/file', the secruity label of the file
is changed from 'user_u:object_r:user_home_t' to
'system_u:object_r:user_home_t'. But 'restorecon /home/user/file' can
not restore its label to original.

'man restorecon', you can see:

...

-F Force reset of context to match file_context for customizable
files, or the user section, if it has changed.
...

Yes, we can 'restorcecon -F /home/user/file' get the original label


But why there is special check on the only_changed_user? any reason...

-- 

by Liu Jian
----------
email to: GJK.Liu@gmail.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
