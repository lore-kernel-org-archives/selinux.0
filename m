Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3JFTXSv028840
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 11:29:33 -0400
Received: from an-out-0708.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3JFTW9K011984
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 15:29:32 GMT
Received: by an-out-0708.google.com with SMTP id d33so524802and
        for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 08:29:31 -0700 (PDT)
Message-ID: <8b4cbe570704190829m67daa55di8c21a51408987b89@mail.gmail.com>
Date: Thu, 19 Apr 2007 11:29:30 -0400
From: "B Topscher" <bryan@jennandbryan.com>
To: selinux@tycho.nsa.gov
Subject: [BUG] Segfault on duplicate require of sensitivity
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_117326_21779093.1176996570622"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_117326_21779093.1176996570622
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

When I have sensitivity required in two different locations I get
segmentation faults when I try and load the module.  For example, because s0
and s15 are already declared on other files if I require them in the TE file
I get a segfault.  I looked in the module.tmp file that was created on build
and saw that s0 and s15 are declared somewhere.  However, if I comment out
my require in the TE file it loads the module fine.


if in the TE I have:

require {
      sensitivity s0;
}

function( domain_t )

and the IF I have

interface(`function',`
              gen_require(`
                          sensitivity s0;
                          ')
              .......
')

When I build and then semodule -i module.pp,  I get a segfault when
committing changes (according to semodule -v).

Thank you
Bryan

------=_Part_117326_21779093.1176996570622
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

When I have sensitivity required in two different locations I get segmentation faults when I try and load the module.&nbsp; For example, because s0 and s15 are already declared on other files if I require them in the TE file I get a segfault.&nbsp; I looked in the 
module.tmp file that was created on build and saw that s0 and s15 are declared somewhere.&nbsp; However, if I comment out my require in the TE file it loads the module fine.&nbsp; <br><br><br>if in the TE I have:<br><br>require { <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sensitivity s0;<br>}<br><br>function( domain_t )<br><br>and the IF I have <br><br>interface(`function&#39;,`<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gen_require(`<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sensitivity s0;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &#39;)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .......<br>&#39;)<br><br>When I build and then <span style="font-weight: bold;">semodule -i module.pp</span>,&nbsp; I get a segfault when committing changes (according to semodule -v).&nbsp; <br><br>Thank you<br>Bryan
<br>

------=_Part_117326_21779093.1176996570622--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
