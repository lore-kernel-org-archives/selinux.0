Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAMHwPIi006516
	for <selinux@tycho.nsa.gov>; Mon, 22 Nov 2004 12:58:25 -0500 (EST)
Received: from mbox-o00.iijmio.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAMHwGOZ019400
	for <selinux@tycho.nsa.gov>; Mon, 22 Nov 2004 17:58:27 GMT
Message-Id: <200411221758.iAMHwDrU025847@mms-r00.iijmio.jp>
Date: Mon, 22 Nov 2004 12:58:00 -0500
From: Yuichi Nakamura <himainu-ynakam@miomio.jp>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: sds@epoch.ncsc.mil, selinux@tycho.nsa.gov, himainu-ynakam@miomio.jp
Subject: Re: idea: setfiles to exclude specific type
Content-Type: text/plain; charset=ISO-2022-JP
In-Reply-To: <41A21B32.8040808@redhat.com>
References: <41A21B32.8040808@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Daniel J Walsh wrote:
> Is there any way we could get a list of "variable policy" from the 
> loaded context?  Or should we write a file with this in it.
Yes, I think we have to prepare file where list is described.
fixfiles will read the file and pass the list to setfiles.

> IE,  It would be nice to create an attribute (save_context???)  That we 
> could assign to a file context, and have setfiles/restorcon ignore if a 
> file is se to this context?    So httpd_???_context_rw_t, gpg_t, 
> ssh_key_t, user_tmp_t and others could be ignored if setfiles comes upon 
> them on a relabel or check?
> I guess we could populate a context file via a grep during policy build.
That sounds a good idea.
I may be misunderstanding, to make sure, I will write flow.

In policy.conf,
type ssh_key_t, file_type, sysadmfile, save_context; 
type gpg_key_t, file_type, sysadmfile, save_context;
..etc are described.
When "make", 
types that have "save_context" is written in somewhere
(like, /etc/selinux/targeted|strict/save_contexts).
And fixfiles is executed with some option(like fixfiles -x)
it reads save_contexts file.
In fixfiles, setfiles will be executed like following,
setfiles file_contexts /  -x ssh_key_t -x gpg_key_t -x ....


---
Yuichi Nakamura
Japan SELinux Users Group(JSELUG)
　　http://www.selinux.gr.jp/



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
