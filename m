Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s624CIAN015632
 for <selinux@tycho.nsa.gov>; Wed, 2 Jul 2014 00:12:19 -0400
Received: by mail-pd0-f171.google.com with SMTP id fp1so11238675pdb.30
 for <selinux@tycho.nsa.gov>; Tue, 01 Jul 2014 21:11:57 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.90.202])
 by mx.google.com with ESMTPSA id ys1sm124400674pab.7.2014.07.01.21.11.52
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Tue, 01 Jul 2014 21:11:56 -0700 (PDT)
Message-ID: <53B385C9.7000904@gmail.com>
Date: Wed, 02 Jul 2014 09:38:41 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Weird un-audited denial on tmp_t
References: <d66c6965-1f79-42fe-8a91-359fd22e71f9@email.android.com>
In-Reply-To: <d66c6965-1f79-42fe-8a91-359fd22e71f9@email.android.com>
Content-Type: multipart/alternative;
 boundary="------------010105070501030409080500"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------010105070501030409080500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 07/01/14 22:43, David wrote:
> Sorry, I know this isn't fedora (CentOS 5 actually) but I believe this
> may be a more generic situation.
>
> I recently was trying to troubleshoot an issue where a process spawned
> off under the dovecot_t process type and needed to create files under /tmp
> (tmp_t).
>
> This wasn't obvious as there where no denial messages in audit for
> tmp_t.  Even using "semodule -DB" didn't show denial messages.  All I
> knew was the process was trying to read/write files and was getting
> access denied.  I just didn't know where or why.
>
> Eventually an strace on the process tree showed the access attempt to
> /tmp.  Since I knew policy would be required to create tmp types I went
> ahead and added tmp file transitions and appropriate supporting
> permissions around the new dovecot_tmp_t type.  This fixed the problem.
>
> What is surprising to me is that there were no denial messages related
> to tmp_t or dovecot_t.  Nothing, regardless of permissive vs enforcing,
> or semodule -DB set.
>
> Any clue as to why this wouldn't trigger a log message?
>
> This is a strict, not targeted policy, yes I know very old school.
>
> Thanks,
> David
>
> --
> selinux mailing list
> selinux@lists.fedoraproject.org
> https://admin.fedoraproject.org/mailman/listinfo/selinux

After you've removed all dontaudits, does seinfo shows any Dontaudit?

--------------010105070501030409080500
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 07/01/14 22:43, David wrote:<br>
    </div>
    <blockquote
      cite="mid:d66c6965-1f79-42fe-8a91-359fd22e71f9@email.android.com"
      type="cite">
      <pre wrap="">Sorry, I know this isn't fedora (CentOS 5 actually) but I believe this
may be a more generic situation.

I recently was trying to troubleshoot an issue where a process spawned
off under the dovecot_t process type and needed to create files under /tmp
(tmp_t).

This wasn't obvious as there where no denial messages in audit for
tmp_t.  Even using "semodule -DB" didn't show denial messages.  All I
knew was the process was trying to read/write files and was getting
access denied.  I just didn't know where or why.

Eventually an strace on the process tree showed the access attempt to
/tmp.  Since I knew policy would be required to create tmp types I went
ahead and added tmp file transitions and appropriate supporting
permissions around the new dovecot_tmp_t type.  This fixed the problem.

What is surprising to me is that there were no denial messages related
to tmp_t or dovecot_t.  Nothing, regardless of permissive vs enforcing,
or semodule -DB set.

Any clue as to why this wouldn't trigger a log message?

This is a strict, not targeted policy, yes I know very old school.

Thanks,
David

--
selinux mailing list
<a class="moz-txt-link-abbreviated" href="mailto:selinux@lists.fedoraproject.org">selinux@lists.fedoraproject.org</a>
<a class="moz-txt-link-freetext" href="https://admin.fedoraproject.org/mailman/listinfo/selinux">https://admin.fedoraproject.org/mailman/listinfo/selinux</a></pre>
    </blockquote>
    <br>
    After you've removed all dontaudits, does seinfo shows any
    Dontaudit?
    <meta http-equiv="content-type" content="text/html;
      charset=ISO-8859-1">
    <title></title>
    <meta name="generator" content="LibreOffice 4.2.3.3 (Linux)">
    <style type="text/css">
	<!--
		@page { margin: 0.79in }
		p { margin-bottom: 0.12in }
		p.western { font-family: "Calibri", sans-serif; font-size: 14pt }
		a:link { so-language: zxx }
	-->
	</style>
  </body>
</html>

--------------010105070501030409080500--
