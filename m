Date: Sun, 5 Aug 2007 17:36:28 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: setroubleshooter/sealert on central loghost?
To: Jan-Frode Myklebust <janfrode@tanso.net>, SELinux@tycho.nsa.gov
In-Reply-To: <slrnfbcedv.43r.mykleb@lc4eb8045376502.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <59794.43337.qm@web51507.mail.re2.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>but sealert doesn't show the hostname of the host that sent the
>AVC. Any ideas for how to get the "Host Name" field in the sealert
>browser to show the hostname ? 

Like I was saying, we are just starting to write the code that does this kind of
thing, so nothing anywhere expects it.

>What's the format sealert expects it on ?

The syntax for the field is likely to be node=computer. But its exact placement
and who adds it (auditd vs audispd) is not settled.

-Steve


       
____________________________________________________________________________________
Building a website is a piece of cake. Yahoo! Small Business gives you all the tools to get online.
http://smallbusiness.yahoo.com/webhosting 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
