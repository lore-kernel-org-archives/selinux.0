Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0LMtWRb004972
	for <selinux@tycho.nsa.gov>; Wed, 21 Jan 2004 17:55:32 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0LMsKxr000311
	for <selinux@tycho.nsa.gov>; Wed, 21 Jan 2004 22:54:20 GMT
Received: from smtp-4.llnl.gov (smtp-4.llnl.gov [128.115.41.84])
	by jazzswing.ncsc.mil  with ESMTP id i0LMsJYc000308
	for <selinux@tycho.nsa.gov>; Wed, 21 Jan 2004 22:54:19 GMT
Received: from popcorn.llnl.gov (localhost [127.0.0.1])
	by smtp-4.llnl.gov (8.12.3p2-20030917/8.12.3/LLNL evision: 1.13 $) with ESMTP id i0LMtPRa018837
	for <selinux@tycho.nsa.gov>; Wed, 21 Jan 2004 14:55:25 -0800 (PST)
Received: from [128.115.96.64] (account shakespeare2 [128.115.96.64] verified)
  by popcorn.llnl.gov (CommuniGate Pro SMTP 4.0.6)
  with ESMTP id 31875482 for selinux@tycho.nsa.gov; Wed, 21 Jan 2004 14:55:24 -0800
Mime-Version: 1.0
Message-Id: <p0602040cbc34b0d29bb3@[128.115.96.64]>
Date: Wed, 21 Jan 2004 14:55:23 -0800
To: selinux@tycho.nsa.gov
From: Mark Shakespeare <mshakes@llnl.gov>
Subject: sepcut is broken
Content-Type: multipart/alternative; boundary="============_-1137396772==_ma============"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--============_-1137396772==_ma============
Content-Type: text/plain; charset="us-ascii" ; format="flowed"

Just did a fresh install of Fedora core 1, and then ran Dan Walsh's
selUpgrade script.

Had a few conflicts to deal with....mostly glibc 2.3.3, tk 8.4,tcl 
8.4 and db4.2.52

Resolved conflicts...ran script again and it went ok.

Had to install bwidget manually.

Now sepcut is broken...error:page"pct_Test:text" does not exist...

There were many duplicate .te files in the 
/etc/security/selinux/src/policy/domains/program and unused....which 
were resolved.

seaudit works fine...so does apol and seuserx

Any help would be appreciated.

Thanks.
-- 
******************************************
* Mark Shakespeare			 *
* Engineering Computer Operations Team   *
* Lawrence Livermore National Laboratory *
* 7000 East Ave		L-130            *
* Livermore,Ca 94550			 *
* 925-423-9922	      mshakes@llnl.gov   *
******************************************
--============_-1137396772==_ma============
Content-Type: text/html; charset="us-ascii"

<!doctype html public "-//W3C//DTD W3 HTML//EN">
<html><head><style type="text/css"><!--
blockquote, dl, ul, ol, li { padding-top: 0 ; padding-bottom: 0 }
 --></style><title>sepcut is broken</title></head><body>
<div>Just did a fresh install of Fedora core 1, and then ran Dan
Walsh's</div>
<div>selUpgrade script.</div>
<div><br></div>
<div>Had a few conflicts to deal with....mostly glibc 2.3.3, tk
8.4,tcl 8.4 and db4.2.52</div>
<div><br></div>
<div>Resolved conflicts...ran script again and it went ok.</div>
<div><br></div>
<div>Had to install bwidget manually.</div>
<div><br></div>
<div><font size="+1" color="#FF0000">Now sepcut is
broken...error:page&quot;pct_Test:text&quot; does not
exist...</font></div>
<div><br></div>
<div>There were many duplicate .te files in the
/etc/security/selinux/src/policy/domains/program and unused....which
were resolved.</div>
<div><br></div>
<div>seaudit works fine...so does apol and seuserx</div>
<div><br></div>
<div>Any help would be appreciated.</div>
<div><br></div>
<div>Thanks.</div>
<x-sigsep><pre>-- 
</pre></x-sigsep>
<div>******************************************<br>
* Mark Shakespeare<x-tab>&nbsp;&nbsp;&nbsp;
</x-tab><x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</x-tab><x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </x-tab>
*<br>
* Engineering Computer Operations Team&nbsp;&nbsp; *<br>
* Lawrence Livermore National Laboratory *<br>
* 7000 East Ave<x-tab>&nbsp;&nbsp;
</x-tab><x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</x-tab
>L-130&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
*<br>
* Livermore,Ca 94550<x-tab>&nbsp;
</x-tab><x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</x-tab><x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </x-tab>
*<br>
* 925-423-9922<x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mshakes@llnl.gov&nbsp;&nbsp;
*<br>
******************************************</div>
</body>
</html>
--============_-1137396772==_ma============--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
