Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAMH0jIi006084
	for <selinux@tycho.nsa.gov>; Mon, 22 Nov 2004 12:00:46 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAMGxDm1019384
	for <selinux@tycho.nsa.gov>; Mon, 22 Nov 2004 16:59:16 GMT
Message-ID: <41A21B32.8040808@redhat.com>
Date: Mon, 22 Nov 2004 12:00:34 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Yuichi Nakamura <himainu-ynakam@miomio.jp>
CC: sds@epoch.ncsc.mil, selinux@tycho.nsa.gov
Subject: Re: idea: setfiles to exclude specific type
References: <200411221554.iAMFsPDM027086@mms-r01.iijmio.jp>
In-Reply-To: <200411221554.iAMFsPDM027086@mms-r01.iijmio.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Yuichi Nakamura wrote:

>Hello.
>
>I add setfiles "-x" option.
>I attach my idea in "setfiles.diff".
>
>-x option is used to exclude specified type.
>
>For example,
># setfiles file_contexts /home -x httpd_user_rw_t
>setfiles skips relabeling files that have "httpd_user_rw_t".
>
>The reason why this option is necessary is following.
>I heard that fixfiles.cron is removed, because unwanted alerts are displayed.
>In some case, types must be preserved.
>http://www.redhat.com/archives/fedora-selinux-list/2004-November/msg00061.html
>
>But I think fixfiles.cron is useful, and hope it is included again.
>Because integrity of label is critical for SELinux.
>
>I think to suppress unwanted alerts, 
>it is necessary to add new option in setfiles and modify fixfiles.
>
>Does it sound reasonable?
>
>---
>Yuichi Nakamura
>Japan SELinux Users Group(JSELUG)
>http://www.selinux.gr.jp/
>  
>
Is there any way we could get a list of "variable policy" from the 
loaded context?  Or should we write a file with this in it.

IE,  It would be nice to create an attribute (save_context???)  That we 
could assign to a file context, and have setfiles/restorcon ignore if a 
file is se to this context?    So httpd_???_context_rw_t, gpg_t, 
ssh_key_t, user_tmp_t and others could be ignored if setfiles comes upon 
them on a relabel or check?

I guess we could populate a context file via a grep during policy build.

Ideas?

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
