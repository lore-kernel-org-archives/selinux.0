Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i36NVHRb005908
	for <selinux@tycho.nsa.gov>; Tue, 6 Apr 2004 19:31:17 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i36NVGmw021298
	for <selinux@tycho.nsa.gov>; Tue, 6 Apr 2004 23:31:16 GMT
Received: from smtp-2.llnl.gov (smtp-2.llnl.gov [128.115.250.82])
        by jazzband.ncsc.mil  with ESMTP id i36NVF4w021295 for <selinux@tycho.nsa.gov>; Tue, 6 Apr 2004 23:31:15 GMT
Received: from popcorn.llnl.gov (localhost [127.0.0.1])
	by smtp-2.llnl.gov (8.12.3p2-20030917/8.12.3/LLNL evision: 1.13 $) with ESMTP id i36NVDQq014704
	for <selinux@tycho.nsa.gov>; Tue, 6 Apr 2004 16:31:14 -0700 (PDT)
Received: from [128.115.96.64] (account shakespeare2 [128.115.96.64] verified)
  by popcorn.llnl.gov (CommuniGate Pro SMTP 4.0.6)
  with ESMTP id 37196874 for selinux@tycho.nsa.gov; Tue, 06 Apr 2004 16:31:13 -0700
Mime-Version: 1.0
Message-Id: <p06100503bc98ecccb8c1@[128.115.96.64]>
Date: Tue, 6 Apr 2004 16:31:12 -0700
To: selinux@tycho.nsa.gov
From: Mark Shakespeare <mshakes@llnl.gov>
Subject: Sepcut Relabel problem
Content-Type: multipart/alternative; boundary="============_-1130828223==_ma============"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--============_-1130828223==_ma============
Content-Type: text/plain; charset="us-ascii" ; format="flowed"

Trying to relabel file system from within Sepcut ( most current version )

getting a weird error....


couldn't open "/tmp/sepcut-zrqWs8Ew": no such file or directory
couldn't open "/tmp/sepcut-zrqWs8Ew": no such file or directory
     while executing
"::open $tmpfilename "RDONLY""
     (procedure "Sepct_Test::test_Policy" line 87)
     invoked from within
"Sepct_Test::test_Policy relabel"
     ("uplevel" body line 1)
     invoked from within
"uplevel \#0 $cmd"
     (procedure "Button::_release" line 18)
     invoked from within
"Button::_release .mainframe.frame.nb.fSepct_Test.rightf.relabel"
     (command bound to event)


Sepcut hangs....then no other X-based apps can run. A reboot clears things.

Any ideas?

I'am using the most recent versions of Policy.


								Mark


-- 
******************************************
* Mark Shakespeare			 *
* Engineering Computer Operations Team   *
* Lawrence Livermore National Laboratory *
* 7000 East Ave		L-130            *
* Livermore,Ca 94550			 *
* 925-423-9922	      mshakes@llnl.gov   *
******************************************
--============_-1130828223==_ma============
Content-Type: text/html; charset="us-ascii"

<!doctype html public "-//W3C//DTD W3 HTML//EN">
<html><head><style type="text/css"><!--
blockquote, dl, ul, ol, li { padding-top: 0 ; padding-bottom: 0 }
 --></style><title>Sepcut Relabel problem</title></head><body>
<div>Trying to relabel file system from within Sepcut ( most current
version )</div>
<div><br></div>
<div>getting a weird error....</div>
<div><br></div>
<div><br></div>
<div><font face="Times New Roman" size="+1" color="#000000">couldn't
open &quot;/tmp/sepcut-zrqWs8Ew&quot;: no such file or directory<br>
couldn't open &quot;/tmp/sepcut-zrqWs8Ew&quot;: no such file or
directory<br>
&nbsp;&nbsp;&nbsp; while executing<br>
&quot;::open $tmpfilename &quot;RDONLY&quot;&quot;<br>
&nbsp;&nbsp;&nbsp; (procedure &quot;Sepct_Test::test_Policy&quot; line
87)<br>
&nbsp;&nbsp;&nbsp; invoked from within<br>
&quot;Sepct_Test::test_Policy relabel&quot;<br>
&nbsp;&nbsp;&nbsp; (&quot;uplevel&quot; body line 1)<br>
&nbsp;&nbsp;&nbsp; invoked from within<br>
&quot;uplevel \#0 $cmd&quot;<br>
&nbsp;&nbsp;&nbsp; (procedure &quot;Button::_release&quot; line
18)<br>
&nbsp;&nbsp;&nbsp; invoked from within<br>
&quot;Button::_release
.mainframe.frame.nb.fSepct_Test.rightf.relabel&quot;<br>
&nbsp;&nbsp;&nbsp; (command bound to event)</font><br>
<font face="Times New Roman" size="+1" color="#000000"></font></div>
<div><br></div>
<div>Sepcut hangs....then no other X-based apps can run. A reboot
clears things.</div>
<div><br></div>
<div>Any ideas?</div>
<div><br></div>
<div>I'am using the most recent versions of Policy.</div>
<div><br></div>
<div><br></div>
<div><x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</x-tab><x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</x-tab><x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</x-tab><x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</x-tab><x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</x-tab><x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</x-tab><x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</x-tab><x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</x-tab>Mark</div>
<div><br></div>
<div>&nbsp;</div>
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
--============_-1130828223==_ma============--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
