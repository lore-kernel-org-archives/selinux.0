Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l98E5kcQ018495
	for <selinux@tycho.nsa.gov>; Mon, 8 Oct 2007 10:05:46 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l98E5j4K022639
	for <selinux@tycho.nsa.gov>; Mon, 8 Oct 2007 14:05:45 GMT
Received: by py-out-1112.google.com with SMTP id u77so2874008pyb
        for <selinux@tycho.nsa.gov>; Mon, 08 Oct 2007 07:05:35 -0700 (PDT)
Message-ID: <9f066ee90710080658k52f592e5q68d6cd2b27cbd93b@mail.gmail.com>
Date: Mon, 8 Oct 2007 09:58:49 -0400
From: Mark <elihusmails@gmail.com>
To: selinux@tycho.nsa.gov
Subject: confining certain user to their home directory
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_40504_14235180.1191851929716"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_40504_14235180.1191851929716
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Is there a way to confine users to their home directory using CentOS 5?  I
have tried the steps Dan Walsh listed on his blog:

http://danwalsh.livejournal.com/10461.html

but could not get things to compile

make -f /usr/share/selinux/devel/Makefile
Compiling targeted guest module
/usr/bin/checkmodule:  loading policy configuration from tmp/guest.tmp
guest.te:150:ERROR 'syntax error' at token 'manage_dirs_pattern' on line
85533:
#line 150
        manage_dirs_pattern(privhome,{ guest_home_dir_t guest_home_t
},guest_home_t)
/usr/bin/checkmodule:  error(s) encountered while parsing configuration
make: *** [tmp/guest.mod] Error 1


What all can I do to get this working?


Thanks.

-- 
..Cheers
Mark

------=_Part_40504_14235180.1191851929716
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Is there a way to confine users to their home directory using CentOS 5?&nbsp; I have tried the steps Dan Walsh listed on his blog:<br><br><a href="http://danwalsh.livejournal.com/10461.html">http://danwalsh.livejournal.com/10461.html
</a><br><br>but could not get things to compile<br><br>make -f /usr/share/selinux/devel/Makefile<br>Compiling targeted guest module<br>/usr/bin/checkmodule:&nbsp; loading policy configuration from tmp/guest.tmp<br>guest.te:150:ERROR &#39;syntax error&#39; at token &#39;manage_dirs_pattern&#39; on line 85533:
<br>#line 150<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; manage_dirs_pattern(privhome,{ guest_home_dir_t guest_home_t },guest_home_t)<br>/usr/bin/checkmodule:&nbsp; error(s) encountered while parsing configuration<br>make: *** [tmp/guest.mod] Error 1<br><br>
<br clear="all">What all can I do to get this working?<br><br><br>Thanks.<br><br>-- <br>..Cheers<br>Mark

------=_Part_40504_14235180.1191851929716--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
