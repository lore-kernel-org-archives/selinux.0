Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oA1B8PfT009057
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2010 07:08:44 -0400
Received: from mail119.messagelabs.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id oA15RjWU004019
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2010 05:27:46 GMT
Received: from il27exr03.cig.mot.com (il27exr03.mot.com [10.17.196.72])
	by motgate5.mot.com (8.14.3/8.14.3) with ESMTP id oA15RcOB020497
	for <selinux@tycho.nsa.gov>; Sun, 31 Oct 2010 22:27:38 -0700 (MST)
Received: from il27vts01 (il27vts01.cig.mot.com [10.17.196.85])
	by il27exr03.cig.mot.com (8.13.1/Vontu) with SMTP id oA15RcUZ011563
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2010 00:27:38 -0500 (CDT)
Received: from de01exm68.ds.mot.com (de01exm68.am.mot.com [10.176.8.24])
	by il27exr03.cig.mot.com (8.13.1/8.13.0) with ESMTP id oA15RbL9011559
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2010 00:27:37 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Format of  file_contexts file
Date: Mon, 1 Nov 2010 01:27:15 -0400
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D09C2E5F8@de01exm68.ds.mot.com>
References: <20100312205537.GA1091@us.ibm.com> <cfd18e0f1003132118y21bd71band2d07ae85c8d4c9@mail.gmail.com> <20100314053521.GA12410@us.ibm.com> 
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Stephen Smalley" <sds@epoch.ncsc.mil>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: "SELinux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi All,

My Linux system has a few product-specific directories like  /data,
/inactive,  /repl

The default selinux policy would obviously not know how to label these
directories the way I want, because these are not standard linux
directories. If I want to label these directories a certain way... For
example, suppose I want to label all the above directories as var_t,
can I simply add a few lines to the below two files, and then perform
relabel ? 

/etc/selinux/strict/contexts/files/file_contexts
/etc/selinux/strict/modules/active/file_contexts

- Is it okay to directly edit those files, or are the above two files
auto-generated ?
- If editing the files is okay, then is it okay to stick lines in
anywhere, or must I follow some kind of convention ?
- or is there a more recommended way to control how those
product-specific directories get labeled ?

- I have actually stuck some lines manually in the middle of the above
two files, and for the most part it seems to work. But every once in a
while, I see other directories not getting labeled correctly. Is it
because the contents of these files have to be in a certain order ? 

Thanks in advance for your help,

R.H.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
